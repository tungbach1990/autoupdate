
-- 箱

------------------------------------------------------------------------------------------
-- initialize

local tbXiang = Item:GetClass("xiang");

------------------------------------------------------------------------------------------
-- public

-- 箱子GenInfo各意义参数索引
local PARAM_IDX_GENRE		= 1;
local PARAM_IDX_DETAILTYPE	= 2;
local PARAM_IDX_PARTICULAR	= 3;
local PARAM_IDX_LEVEL		= 4;
local PARAM_IDX_SERIES		= 5;
local PARAM_IDX_NUM			= 6;
local PARAM_IDX_BIND		= 7;

-- 获得最大物品数
function tbXiang:GetMaxItemCount(pItem)
	return pItem.GetExtParam(PARAM_IDX_NUM)
end

function tbXiang:InitGenInfo()
	return	{ it.GetExtParam(PARAM_IDX_NUM) };
end

tbXiang.tbCanPutBack = {[241]=1,[242]=1,[243]=1,[352]=1,[353]=1,[354]=1};

-- 可否把药放回去
-- 可以：1
-- 不可以：0
function tbXiang:CanPutBack(pItem)
	if not pItem then
		return 0;
	end
		
	if self.tbCanPutBack[pItem.nParticular] then
		return 1;
	else
		return 0;
	end
end
-- 返回值：	0不删除、1删除
function tbXiang:OnUse()

	-- modify by zhangjinpin@kingsoft
	--if it.nParticular < 241 or it.nParticular > 243 then
		--return self:OnUseGet(it.dwId);
	--end
	
	if self:CanPutBack(it) == 0 then
		return self:OnUseGet(it.dwId);
	end

	local tbOpt = {
		{"Lấy thuốc ra", self.OnUseGet, self, it.dwId},
		{"Bỏ thuốc vào", self.OnUsePut, self, it.dwId},
		{"Để ta suy nghĩ lại"},
	}
	
	Dialog:Say("Bạn đã mở rương thuốc, muốn làm gì?", tbOpt);
	return	0;
end

function tbXiang:OnUseGet(nItemId)
	
	local pItem = KItem.GetObjById(nItemId);
	
	if not pItem then
		return 0;
	end
	
	-- 保存箱子的Id
	local tbTmpTask = me.GetTempTable("Item");
	--tbTmpTask.pItemXiang = pItem;
	tbTmpTask.dwId 		 = pItem.dwId;
	-- 计算最多取出数量
	local nMaxTakeOutCount = pItem.GetGenInfo(1);
	local nGenre 	  = pItem.GetExtParam(PARAM_IDX_GENRE);
	local nDetail 	  = pItem.GetExtParam(PARAM_IDX_DETAILTYPE);
	local nParticular = pItem.GetExtParam(PARAM_IDX_PARTICULAR);
	local nLevel	  = pItem.GetExtParam(PARAM_IDX_LEVEL);
	local nSeries	  = pItem.GetExtParam(PARAM_IDX_SERIES);
	local tbBaseProp = KItem.GetItemBaseProp(nGenre, nDetail, nParticular, nLevel);
	
	if not tbBaseProp then
		return	0;
	end

	local nFreeItemCount = me.CalcFreeItemCountInBags(
		nGenre,
		nDetail,
		nParticular,
		nLevel,
		nSeries,
		KItem.IsItemBindByBindType(tbBaseProp.nBindType)
	);
	local tbTimeOut = me.GetItemAbsTimeout(pItem);
	if tbTimeOut then
		nFreeItemCount = me.CountFreeBagCell();
	end	
	if (nFreeItemCount < nMaxTakeOutCount) then
		nMaxTakeOutCount = nFreeItemCount;
	end
	
	-- 启动进度条
	local tbBreakEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SIT,
		Player.ProcessBreakEvent.emEVENT_RIDE,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_CHANGEEQUIP,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,		
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_REVIVE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
	}
	GeneralProcess:StartProcess("Đang mở...", 10 * Env.GAME_FPS, {self.OnUseAskCount, self, nMaxTakeOutCount}, nil, tbBreakEvent);
	return 0;
end

function tbXiang:OnUseAskCount(nMaxTakeOutCount)
	Dialog:AskNumber("Nhập số lượng lấy: ", nMaxTakeOutCount, self.OnUseTakeOut, self);
end

function tbXiang:OnUseTakeOut(nTakeOutCount)

	local tbTmpTask = me.GetTempTable("Item");
	local nItemId = tbTmpTask.dwId;
	local pItem = KItem.GetObjById(nItemId);
	if (pItem == nil or pItem.szClass ~= "xiang") then
		return;
	end
	
	if me.IsHaveItemInBags(pItem) ~= 1 then
		return;
	end
	
	if not tonumber(nTakeOutCount) or nTakeOutCount <= 0 then
		return;
	end
	
 	 local nCanUse, szMsg = Item:CheckIsUseAtMap(me.nMapId, pItem.dwId);
	if nCanUse ~= 1 then
		me.Msg(szMsg);
		return;
	end
	local tbTimeOut = me.GetItemAbsTimeout(pItem);
	
	-- 备份箱里物品的Id先，因为箱可能会被删除
	local nElemGenre 		= pItem.GetExtParam(PARAM_IDX_GENRE);
	local nElemDetailType 	= pItem.GetExtParam(PARAM_IDX_DETAILTYPE);
	local nElemParticular 	= pItem.GetExtParam(PARAM_IDX_PARTICULAR);
	local nElemLevel 		= pItem.GetExtParam(PARAM_IDX_LEVEL);
	local nElemSeries 		= pItem.GetExtParam(PARAM_IDX_SERIES);
	local nElemBind			= pItem.GetExtParam(PARAM_IDX_BIND);
	
	if nElemBind == 0 then
		nElemBind = pItem.IsBind();
	end
	
	-- 计算取出数量
	local nElemCount = pItem.GetGenInfo(1);
	local nMaxTakeOutCount = pItem.GetGenInfo(1);
	local nFreeItemCount = me.CalcFreeItemCountInBags(
		pItem.GetExtParam(PARAM_IDX_GENRE),
		pItem.GetExtParam(PARAM_IDX_DETAILTYPE),
		pItem.GetExtParam(PARAM_IDX_PARTICULAR),
		pItem.GetExtParam(PARAM_IDX_LEVEL),
		pItem.GetExtParam(PARAM_IDX_SERIES),
		nElemBind
	);
	
	if tbTimeOut then
		if me.CountFreeBagCell() < nTakeOutCount then
			me.Msg(string.format("Túi đầy, cần %s ô trống.", nTakeOutCount));
			return 0;
		end
	end
	if (nFreeItemCount < nMaxTakeOutCount) then
		nMaxTakeOutCount = nFreeItemCount;
	end
	if (nTakeOutCount > nMaxTakeOutCount) then
		nTakeOutCount = nMaxTakeOutCount;
	end
	
	local nRemainCount = nElemCount - nTakeOutCount;

	-- 设置箱物品剩余数量或者删除
	if (nRemainCount > 0) then
		pItem.SetGenInfo(1, nRemainCount);
		pItem.Sync();
	else
		if (me.DelItem(pItem, Player.emKLOSEITEM_USE) ~= 1) then
			return;
		end
	end
	
	-- 增加箱里物品
	for i = 1, nTakeOutCount do
		local tbInfo = {nSeries = nElemSeries, bForceBind = nElemBind};
		if tbTimeOut then
			tbInfo.bTimeOut = 1;
		end
		local pIt = me.AddItemEx(nElemGenre, nElemDetailType, nElemParticular, nElemLevel, tbInfo);
		if (tbTimeOut and pIt) then
			local szTime = string.format("%02d/%02d/%02d/%02d/%02d/10", 			
					tbTimeOut[1],
					tbTimeOut[2],
					tbTimeOut[3],
					tbTimeOut[4],
					tbTimeOut[5]);
			me.SetItemTimeout(pIt, szTime);
			pIt.Sync()
		end
	end
end

function tbXiang:GetTip(nState)
	local szTip = "";
	szTip = szTip.."Rương có <color=yellow>"..KItem.GetNameById(it.GetExtParam(PARAM_IDX_GENRE), it.GetExtParam(PARAM_IDX_DETAILTYPE), it.GetExtParam(PARAM_IDX_PARTICULAR), it.GetExtParam(PARAM_IDX_LEVEL)).."<color>, <color=yellow>Chuột phải<color> để lấy vật phẩm ra.\n";
	szTip = szTip.."Trong rương còn <color=green>"..it.GetGenInfo(1).."<color>";
	return	szTip;
end

-- UNDONE: Fanghao_Wu	临时代码，将药箱内药品数量*1.5，2008-9-1后删除！！！
function tbXiang:OnLoaded()
	if (it.nParticular < 28 or it.nParticular > 42) then
		return
	end
	local nFixStartTime = Lib:GetDate2Time(200807220800);
	if (it.dwGenTime < nFixStartTime and it.GetGenInfo(2) == 0) then
		local nElemCount = it.GetGenInfo(1);
		it.SetGenInfo(1, nElemCount * 1.5);
		it.SetGenInfo(2, nElemCount);
		it.Sync();
	end
end

function tbXiang:GetChangeable(pItem)
	if pItem.nMakeCost > 0 and pItem.IsBind() ~= 1 and pItem.GetExtParam(PARAM_IDX_NUM) == pItem.GetGenInfo(1) then
		return 1;
	else
		return 0;
	end
end

function tbXiang:OnCheckUsePutDel(nItemId, nDelCount)
	local pItem = KItem.GetObjById(nItemId);
	
	if not pItem then
		return 0;
	end
	local nType, nTime = pItem.GetTimeOut();
	
	--if pItem.nParticular < 241 or pItem.nParticular > 243 then
		--return 0;
	--end
	
	if self:CanPutBack(pItem) == 0 then
		return 0;
	end
	
	local nXiangCount = pItem.GetGenInfo(1);
	
	if not nXiangCount or nXiangCount >= self:GetMaxItemCount(pItem) then
		me.Msg("Rương thuốc đã đầy, không thể cho thêm thuốc vào.");
		return 0;
	end
	
	local nBind = pItem.IsBind();
	local tbFind = me.FindItemInBags(
		pItem.GetExtParam(PARAM_IDX_GENRE),
		pItem.GetExtParam(PARAM_IDX_DETAILTYPE),
		pItem.GetExtParam(PARAM_IDX_PARTICULAR),
		pItem.GetExtParam(PARAM_IDX_LEVEL),
		pItem.GetExtParam(PARAM_IDX_SERIES)
	);
	local nBagCount = 0;
	for _, tbItem in pairs(tbFind) do
		local pItem1 = tbItem.pItem;
		local nNeedItem = 1;
		local nType1, nTime1 = pItem1.GetTimeOut();
		
		if pItem1.IsBind() == nBind and nType1 == nType and 
			( (nTime > 0 and math.abs(nTime1 - nTime) <= 60) or nTime == nTime1 ) then
			if nDelCount and nDelCount > 0 and nBagCount < nDelCount then
				me.DelItem(pItem1);
			end
			nBagCount = nBagCount + 1;
		end
	end

	if not nBagCount or nBagCount <= 0 then
		me.Msg("Túi bạn không có loại thuốc này.");
		return 0;
	end
	local nMaxPutCount = nBagCount;
	
	if nMaxPutCount + nXiangCount > self:GetMaxItemCount(pItem) then
		nMaxPutCount = self:GetMaxItemCount(pItem) - nXiangCount;
	end
	return nMaxPutCount;
end

function tbXiang:OnUsePut(nItemId)
	
	local nMaxPutCount = self:OnCheckUsePutDel(nItemId);
	
	if nMaxPutCount <= 0 then
		return;
	end
		
	Dialog:AskNumber("Nhập số lượng bỏ vào: ", nMaxPutCount, self.OnUsePutExec, self, nItemId);
end

function tbXiang:OnUsePutExec(nItemId, nPutCount)
	
	local pItem = KItem.GetObjById(nItemId);
	
	if not pItem then
		return;
	end
	
	local nMaxPutCount = self:OnCheckUsePutDel(nItemId);
	if nMaxPutCount <= 0 or nMaxPutCount < nPutCount then
		return;
	end
	
	self:OnCheckUsePutDel(nItemId, nPutCount);
	
	local nXiangCount = pItem.GetGenInfo(1);
	pItem.SetGenInfo(1, nXiangCount + nPutCount);
	pItem.Sync();
end


