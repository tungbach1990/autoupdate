

local nScriptVersion = Item.IVER_nEquipEnhance;

local ENHITEM_CLASS 			= "xuanjing";	-- 强化道具类型：玄晶
local PEEL_ITEM = { nGenre = Item.SCRIPTITEM, nDetail = 1, nParticular = 1 };	-- 玄晶


local function CheckEnhItem(pEquip, tbEnhItem, nMoneyType)		-- 服务端检查装备和玄晶的合法性

	if (not pEquip) or (pEquip.IsEquip() ~= 1) or (pEquip.IsWhite() == 1) then
		return 0;			-- 非装备或白色装备不能强化
	end

	if (pEquip.nDetail < Item.MIN_COMMON_EQUIP) or (pEquip.nDetail > Item.MAX_COMMON_EQUIP) then
		return 0;			-- 非可强化类型装备不能强化
	end

	if (pEquip.nEnhTimes >= Item:CalcMaxEnhanceTimes(pEquip)) then
		return 0;			-- 已强化到最高级则不能强化
	end

	if (#tbEnhItem <= 0) then
		return 0;			-- 没有玄晶
	end

	if pEquip.GetLockIntervale() > 0 and nMoneyType == Item.BIND_MONEY then
		return 0;
	end
	
	for _, pEnhItem in ipairs(tbEnhItem) do
		if (not pEnhItem) or (pEnhItem.szClass ~= ENHITEM_CLASS) then
			return 0;		-- 不是玄晶
		end
		
		if (pEquip.GetLockIntervale() > 0) and pEnhItem.IsBind() == 1 then
			return 0;
		end
	end

	return 1;

end

local function CheckPeelItem(pEquip)		-- 服务端检查装备和玄晶的合法性

	if (not pEquip) or (pEquip.IsEquip() ~= 1) or (pEquip.IsWhite() == 1) then
		return 0;			-- 非装备或白色装备不能剥离
	end

	if (pEquip.nDetail < Item.MIN_COMMON_EQUIP) or (pEquip.nDetail > Item.MAX_COMMON_EQUIP) then
		return 0;			-- 非可强化类型装备不能剥离
	end

	if (pEquip.nEnhTimes <= 0) then
		return	0;			-- 未强化过装备不能剥离
	end

	return 1;

end



Item.TASK_PEEL_APPLY_GID = 	2085;	-- 高强化装备剥离申请任务变量
Item.TASK_PEEL_APPLY_TIME = 1;		-- 申请高强化剥离的时间
Item.VALID_PEEL_TIME = 30 * 60;	-- 有效的剥离时间
Item.MAX_PEEL_TIME = 60 * 60;	-- 完整的申请到消失时间

function Item:ApplyPeelHighEquipSure()
	me.SetTask(self.TASK_PEEL_APPLY_GID, self.TASK_PEEL_APPLY_TIME, GetTime());
	me.AddSkillState(1358, 1, 2, self.MAX_PEEL_TIME * Env.GAME_FPS, 1, 0, 1);
	me.Msg("Xin tách trang bị cường hóa cao thành công.");
end

function Item:CancelPeelHighEquipSure()
	me.SetTask(self.TASK_PEEL_APPLY_GID, self.TASK_PEEL_APPLY_TIME, 0);
	me.RemoveSkillState(1358);
	me.Msg("Đã hủy xin tách trang bị.");
end

function Item:CheckApplyPeelState()
	
	local nTime = me.GetTask(Item.TASK_PEEL_APPLY_GID, Item.TASK_PEEL_APPLY_TIME);

	if nTime == 0 then	-- 显示申请选项
		return 0;
	else
		local nDiffTime = GetTime() - nTime;
		
		if nDiffTime < 0 then
			return 0;
			
		elseif nDiffTime <= Item.MAX_PEEL_TIME then	
			return 1;
			
		elseif nDiffTime > Item.MAX_PEEL_TIME then
			return 0;
		end
	end
end

 
function Item:GetJbPrice() 		-- 获取金币汇率
	local nJbPrice = 0;
	if (MODULE_GAMECLIENT) then
		nJbPrice = JbExchange.nAvgPrice;
	elseif (MODULE_GAMESERVER) then
		nJbPrice = KJbExchange.GetPrvAvgPrice(); -- 获取前一周的汇率
	end
	nJbPrice = math.max(50, nJbPrice);
	nJbPrice = math.min(200, nJbPrice);
	return nJbPrice / 100;
end

function Item:Enhance(pEquip, tbEnhItem, nMoneyType, nParam)	-- 程序接口：服务端执行装备强化

	if CheckEnhItem(pEquip, tbEnhItem, nMoneyType) ~= 1 then
		return -1;
	end

	local nIbValue = 0;
	
	local nProb, nMoney, bBind, szLog, nValue, nTrueProb = Item:CalcEnhanceProb(pEquip, tbEnhItem, nMoneyType);
	
	if nProb < 10 then
		me.Msg("Xác suất thành công quá thấp, không thể cường hóa.");
		return -1;
	elseif (nTrueProb > 120 and nValue > 16796) then
		me.Msg("Huyền Tinh đặt vào quá nhiều, xin đừng lãng phí.");
		return -1;
	elseif (nMoneyType == Item.NORMAL_MONEY and me.CostMoney(nMoney, Player.emKPAY_ENHANCE) ~= 1) then	-- 扣除金钱
		me.Msg("Không đủ bạc, không thể cường hóa!");
		return -1;
	elseif (nMoneyType == Item.BIND_MONEY and me.CostBindMoney(nMoney, Player.emKBINDMONEY_COST_ENHANCE) ~= 1) then
		me.Msg("Không đủ bạc khóa, không thể cường hóa!");
		return -1;
	elseif (nMoneyType ~= Item.NORMAL_MONEY)and (nMoneyType ~= Item.BIND_MONEY) then
		return -1;
	end
	
	if nMoneyType == Item.NORMAL_MONEY then
		KStatLog.ModifyAdd("jxb", "[Tiêu hao] Cường hóa trang bị", "Tổng", nMoney);
	end
	
	if nMoneyType == Item.BIND_MONEY then
		KStatLog.ModifyAdd("bindjxb", "[Tiêu hao] Cường hóa trang bị", "Tổng", nMoney);
	end
	
	local szSucc = "Tỷ lệ thành công: "..nProb.."%%";
	Dbg:WriteLog("Enhance", "Tên nhân vật:"..me.szName, "Tài khoản:"..me.szAccount, "Nguyên liệu: "..szLog, szSucc, "Client tính xác suất thành công:"..nParam.."%%");
	
	if nParam > nProb and self.__OPEN_ENHANCE_LIMIT == 1 then
		me.Msg("Xác suất thành công mà client hiển thị có lỗi, để tránh tổn thất không đáng có, cấm thao tác cường hóa, nhanh chóng liên hệ với nhà cung cấp.");
		return -1;
	end
	
	for i = 1, #tbEnhItem do
		if tbEnhItem[i].nBuyPrice > 0 then -- Ib玄晶或者从Ib玄晶合成而来
			nIbValue = nIbValue + tbEnhItem[i].nBuyPrice;
		end
		
		local szItemName = tbEnhItem[i].szName;
		local nRet = me.DelItem(tbEnhItem[i], Player.emKLOSEITEM_TYPE_ENHANCE);		-- 扣除玄晶
		if nRet ~= 1 then
			Dbg:WriteLog("Enhance", "Tên nhân vật:"..me.szName, "Tài khoản:"..me.szAccount, "Trừ "..szItemName.."Thất bại");
			return 0;
		end
	end

	if pEquip.IsBind() ~= 1 then
		pEquip.nBuyPrice = pEquip.nBuyPrice + nIbValue;
	else
		Spreader:AddConsume(nIbValue);
	end

	local szTypeName = "";
	local szMsg = "";
	if (pEquip.nEnhTimes >= 11) then
		szTypeName = Item.EQUIPPOS_NAME[KItem.EquipType2EquipPos(pEquip.nDetail)];
		szMsg = "Hảo hữu của bạn ["..me.szName.."] với "..nProb.."% đem "..szTypeName;
	end
	
	if (MathRandom(100) > nProb) then
		Dbg:WriteLog("Enhance", "Tên nhân vật:"..me.szName, "Tài khoản:"..me.szAccount, "Cường hóa thất bại");
		if (pEquip.nEnhTimes >= 11) then
			me.SendMsgToFriend(szMsg.."Cường hóa +"..pEquip.nEnhTimes + 1 .. " thất bại, thật đáng tiếc!");
			Player:SendMsgToKinOrTong(me, "Với xác suất "..nProb.."% đem "..szTypeName.."Cường hóa +"..pEquip.nEnhTimes + 1 .. " thất bại, thật đáng tiếc!", 0);
		end
		return 0;
	end	
	
	local nRet = pEquip.Regenerate(
		pEquip.nGenre,
		pEquip.nDetail,
		pEquip.nParticular,
		pEquip.nLevel,
		pEquip.nSeries,
		pEquip.nEnhTimes + 1,			-- 强化次数加一
		pEquip.nLucky,
		pEquip.GetGenInfo(),
		0,
		pEquip.dwRandSeed,
		0
	);

	if (1 ~= nRet) then
		Dbg:WriteLog("Enhance", "Tên nhân vật:"..me.szName, "Tài khoản:"..me.szAccount, "Regenerate thất bại")
		
		if (pEquip.nEnhTimes >= 11) then
			me.SendMsgToFriend(szMsg.."Cường hóa +"..pEquip.nEnhTimes + 1 .. " thất bại, thật đáng tiếc!");
			Player:SendMsgToKinOrTong(me, " đem "..szTypeName.."Cường hóa +"..pEquip.nEnhTimes + 1 .. " thất bại, thật đáng tiếc!", 0);
		end
		return 0;
	end
	
	if (pEquip.nEnhTimes >= 12) then
		me.SendMsgToFriend("Hảo hữu của bạn ["..me.szName.."] với "..nProb.."% đem "..szTypeName.." cường hóa +"..pEquip.nEnhTimes..".");
		Player:SendMsgToKinOrTong(me, "Với xác suất "..nProb.."% đem "..szTypeName.." cường hóa +"..pEquip.nEnhTimes..".", 0);
	end
	
	Dbg:WriteLog("Enhance", "Tên nhân vật:"..me.szName, "Tài khoản:"..me.szAccount, "Cường hóa thành công")
	if bBind == 1 then
		pEquip.Bind(1);					-- 强制绑定装备
		Spreader:OnItemBound(pEquip);
	end
	
	return 1;
end

function Item:Peel(pEquip, nParam)		-- 程序接口：服务端执行玄晶剥离

	if CheckPeelItem(pEquip) ~= 1 then
		return -1;
	end

	local tbPeelItem, nMoney, bBind, nPeelValue = Item:CalcPeelItem(pEquip);
	
	if (not tbPeelItem) then
		return -1;
	end

	local nCheckNum = 0;
	for nX, nY in pairs(tbPeelItem) do
		nCheckNum = nCheckNum + 1;
	end
	if nCheckNum == 0 then
		me.Msg("Giá trị trang bị quá thấp, không thể tách lấy Huyền tinh!");
		return -1;
	end
	
	if me.GetMaxCarryMoney() < me.GetBindMoney() + nMoney then
		me.Msg("Số bạc khóa bạn đem theo đã vượt mức quy định.");
		return -1;
	end

	local tbItemBag = {};	-- 判断空间是否够
	for nLevel, nNum in pairs(tbPeelItem) do
		local tbItem =
		{
			nGenre		= PEEL_ITEM.nGenre,
			nDetail 	= PEEL_ITEM.nDetail,
			nParticular	= PEEL_ITEM.nParticular,
			nLevel		= nLevel,
			nSeries		= Env.SERIES_NONE,
			bBind		= 1,
			nCount		= nNum,
		};
		table.insert(tbItemBag, tbItem);
	end

	if me.CanAddItemIntoBag(unpack(tbItemBag)) ~= 1 then
		me.Msg("Túi của bạn không chứa nổi vật phẩm sau khi tách rời, sắp xếp lại hãy tách!");
		return -1;
	end
	
	local nCurrEnhTimes = pEquip.nEnhTimes;
	
	if nCurrEnhTimes >= 12 then
		
		local nTime = me.GetTask(self.TASK_PEEL_APPLY_GID, self.TASK_PEEL_APPLY_TIME);
		
		if nTime <= 0 then
			me.Msg("Đến chỗ Dã Luyện Đại Sư xin tách trang bị cường hóa cao");
			Dialog:SendBlackBoardMsg(me, "Đến chỗ Dã Luyện Đại Sư xin tách trang bị cường hóa cao.");
			return -1;
		
		else
			local nDiffTime = GetTime() - nTime;
			
			if nDiffTime <= 0 then 
				return -1;
				
			elseif nDiffTime <= self.VALID_PEEL_TIME then
				me.Msg("Chưa đến thời gian tách, xin hãy đợi.");
				Dialog:SendBlackBoardMsg(me, "Chưa đến thời gian tách, xin hãy đợi.");
				return -1;
				
			elseif nDiffTime >= self.MAX_PEEL_TIME then
				me.Msg("Xin tách lần trước của bạn đã quá hạn, hãy xin lại.");
				Dialog:SendBlackBoardMsg(me, "Xin tách lần trước của bạn đã quá hạn, hãy xin lại.");
				me.SetTask(self.TASK_PEEL_APPLY_GID, self.TASK_PEEL_APPLY_TIME, 0);
				return -1;
			end
		end
	end
	
	local nLastEnhTimes = pEquip.nEnhTimes;
	local nRet = pEquip.Regenerate(
		pEquip.nGenre,
		pEquip.nDetail,
		pEquip.nParticular,
		pEquip.nLevel,
		pEquip.nSeries,
		0,			-- 变成未强化状态
		pEquip.nLucky,
		pEquip.GetGenInfo(),
		0,
		pEquip.dwRandSeed,
		0
	);

	if (1 ~= nRet) then
		return 0;
	end

	if bBind == 1 then
		pEquip.Bind(1);					-- 强制绑定装备
	end

	for nLevel, nNum in pairs(tbPeelItem) do
		for i = 1, nNum do
			local pItem = me.AddItemEx(PEEL_ITEM.nGenre, PEEL_ITEM.nDetail, PEEL_ITEM.nParticular, nLevel, {bForceBind = 1}, 
				Player.emKITEMLOG_TYPE_UNENHANCE);	-- 获得玄晶
		end
	end
	

	me.AddBindMoney(nMoney, Player.emKBINDMONEY_ADD_PEEL);
	KStatLog.ModifyAdd("bindjxb", "[Nơi] Tách trang bị", "Tổng", nMoney);
	PlayerHonor:AddConsumeValue(me, math.floor(nPeelValue * 10 / 100), "peel");
	
	if nCurrEnhTimes >= 12 then
		me.SetTask(self.TASK_PEEL_APPLY_GID, self.TASK_PEEL_APPLY_TIME, 0);
		me.RemoveSkillState(1358);
	end
	
	return 1;
end

function Item:CalcPeelItem(pEquip) 		-- 计算玄晶剥离，客户端与服务端共用

	local tbSetting = Item:GetExternSetting("value", pEquip.nVersion);
	if (not tbSetting) then
		return;
	end

	local bBind = 0;
	if pEquip.IsBind() == 1 then
		bBind = 1;
	end

	local nEnhTimes = pEquip.nEnhTimes;
	local nPeelValue = 0;

	repeat
		local nEnhValue = tbSetting.m_tbEnhanceValue[nEnhTimes] or 0;
		nPeelValue = nPeelValue + nEnhValue;
		nEnhTimes = nEnhTimes - 1;
	until (nEnhTimes <= 0);

	if (nPeelValue <= 0) then
		return;
	end
	
	if pEquip.nStrengthen == 1 then
		nPeelValue = nPeelValue + tbSetting.m_tbStrengthenValue[pEquip.nEnhTimes];
	end
	
	local nTypeRate = (tbSetting.m_tbEquipTypeRate[pEquip.nDetail] or 100) / 100;
	nPeelValue      = nPeelValue * nTypeRate;
	
	local nEnhLevel = pEquip.nEnhTimes;
	local nMoney = 0;
	if nEnhLevel >= 12 and nEnhLevel <= 13 then
		nMoney = math.floor(nPeelValue * self.PEEL_RESTORE_RATE_12);
	elseif nEnhLevel >= 14 and nEnhLevel <= 16 then
		nMoney = math.floor(nPeelValue * self.PEEL_RESTORE_RATE_14);
	end

	local nPeels = math.floor(nPeelValue * 0.8);
	local tbPeelItem = {};

	tbPeelItem = Item:ValueToItem(nPeels, 4);
	
	return tbPeelItem, nMoney, bBind, nPeelValue;
end



function Item:ValueToItem(nValue, nProductNum, bBreakUpXuan)
	
	local tbItemValue = {};
	local tbItem = {};
	bBreakUpXuan = bBreakUpXuan or 0;	-- 默认为其它操作
	
	for nLevel = 1, 12 do
		local tbBaseProp = KItem.GetItemBaseProp(PEEL_ITEM.nGenre, PEEL_ITEM.nDetail, PEEL_ITEM.nParticular, nLevel);
		if tbBaseProp then
		   tbItemValue[nLevel] = tbBaseProp.nValue;
		end
	end
	
	for nCount = 1, nProductNum do				--最多精确计算到nProductNum种等级的玄晶
		for nLevel = 12, 1, -1 do				--对1～12种等级的玄晶进行计算
			if tbItemValue[nLevel] and (nValue / tbItemValue[nLevel]) >= 1 then
				local nNum = math.floor(nValue / tbItemValue[nLevel])
				
				if nNum > 1 or (nLevel < 11 and bBreakUpXuan == 0) then	 -- 10级以上的玄晶都可拆分
					tbItem[nLevel] = nNum;
					nValue = math.mod(nValue, tbItemValue[nLevel]);
					break;
				end
			end
		end
		if ((nValue / tbItemValue[1]) < 1) or (nValue == 0) then
			break;
		end
	end

	return tbItem;
end


function Item:ValueToItemAndMoney(nValue)
	local tbItemValue = {};
	local tbItem = {};
	
	for nLevel = 1, 12 do
		local tbBaseProp = KItem.GetItemBaseProp(PEEL_ITEM.nGenre, PEEL_ITEM.nDetail, PEEL_ITEM.nParticular, nLevel);
		if tbBaseProp then
		   tbItemValue[nLevel] = tbBaseProp.nValue;
		end
	end
	
	for nLevel = 12, 1, -1 do				--对1～12种等级的玄晶进行计算
		if (nValue / tbItemValue[nLevel]) >= 1 then
			tbItem[nLevel] = math.floor(nValue / tbItemValue[nLevel]);
			nValue = math.mod(nValue, tbItemValue[nLevel]);
			return tbItem, nLevel, nValue; 
		end
	end	
	return tbItem, 0, nValue;
end


function Item:CalcEnhanceProb(pEquip, tbEnhItem, nMoneyType)	-- 计算强化成功率，客户端与服务端共用
  	local tbSetting = Item:GetExternSetting("value", pEquip.nVersion);
	if (not tbSetting) then
		return	0;
	end
	local nEnhItemVal = 0;
	local bBind       = 0;
	local tbCalcuate  = {};
	for _, pEnhItem in ipairs(tbEnhItem) do
		nEnhItemVal = nEnhItemVal + pEnhItem.nValue;
		if (pEnhItem.IsBind() == 1) then
			bBind = 1;		-- 如果有绑定的玄晶则要绑定装备
		end
		local szName = pEnhItem.szName
		if not tbCalcuate[szName] then
			tbCalcuate[szName] = 0;
		end
		tbCalcuate[szName] = tbCalcuate[szName] + 1;
	end		-- 计算所有玄晶的价值总和

	local szLog = ""
	if MODULE_GAMESERVER then
		for szName, nCount in pairs(tbCalcuate) do
			szLog = szLog..szName..nCount..", ";
		end
	end
	
	local nProb, nMoney, nTrueProb = Item:CalcProb(pEquip, nEnhItemVal, Item.ENHANCE_MODE_ENHANCE);
	if not nMoney then
		return	0;
	end
	
	if nMoneyType == Item.BIND_MONEY then
		bBind = 1;
	end
	if (bBind == 1) and (pEquip.IsBind() == 1) then
		bBind = 0;			-- 如果是已绑定装备则不需要再绑
	end
	
	return	nProb, nMoney, bBind, szLog, nEnhItemVal, nTrueProb;
end

function Item:CalcMaxEnhanceTimes(pEquip)	-- 计算一个可强化装备能强化的次数(最大强化等级)
	if (not pEquip) then
		return 0;
	end
	local nLevel = pEquip.nLevel;
	if nScriptVersion == 1 then
		if (nLevel <= 3) then
			return 4;					-- 1~3级可强化4次
		elseif (nLevel <= 6) then
			return 8;					-- 4~6级可强化8次
		elseif (nLevel <= 9) then		
			return 12;					-- 7~9级可强化12次
		elseif (nLevel > 9) and (pEquip.nRefineLevel >= 1) then-- 炼化1级的才能强16
			return 16;		
		else
			return 14;		
		end
	else
		if (nLevel <= 3) then
			return 4;					-- 1~3级可强化4次
		elseif (nLevel <= 6) then
			return 8;					-- 4~6级可强化8次
		elseif (nLevel <= 9) then		
			return 12;					-- 7~9级可强化12次
		else
			return 16;					-- 10级可强化16次
		end
	end
end

