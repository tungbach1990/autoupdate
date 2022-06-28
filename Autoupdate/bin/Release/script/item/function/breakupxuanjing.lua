
Require("\\script\\lib\\gift.lua");
Item.tbGift = Gift:New();
local tbGift = Item.tbGift;
tbGift.ITEM_CLASS = "xuanjing";
tbGift.LAYER = 3;
tbGift.NEEDLEVEL_MIN	= 10;	-- 至少要10级的玄晶才能拆
tbGift.NEEDLEVEL_MAX	= 12;	-- 12级以上的玄晶不能拆（目前玄晶等级最高12级）


function tbGift:OnOK(tbParam)
	local pItem = self:First();
	local tbLogItem = {}
	if not pItem then
		me.Msg("Bỏ Huyền Tinh khóa muốn tách vào")
		return 0;
	end
	
	while pItem do
		if pItem.szClass ~= self.ITEM_CLASS or pItem.nLevel < self.NEEDLEVEL_MIN
			or pItem.nLevel > self.NEEDLEVEL_MAX or pItem.IsBind() ~= 1 then
		   	me.Msg("Chỉ được bỏ Huyền Tinh khóa cấp 10 đến cấp 12 vào!");
		   	return 0;
		else
			if not tbLogItem[pItem.nLevel] then 
				tbLogItem[pItem.nLevel] = 0;
			end
			tbLogItem[pItem.nLevel] = tbLogItem[pItem.nLevel] + 1;
			pItem = self:Next();
		end
	end
	
	local pFind = self:First();
	local tbBreakUpItem = Item:ValueToItem(pFind.nValue, self.LAYER, 1);	-- 最后一个参数是标志位，表示是拆玄
	local nNum = 0;
	for nItemLevel, nItemNum in pairs(tbBreakUpItem) do
		nNum = nNum + nItemNum;
	end
	
	if me.CountFreeBagCell() < nNum then
		me.Msg(string.format("Hành trang không đủ chỗ trống, bạn cần %s ô trống.", nNum));
		return 0;
	end
	
	local nTimeType, nTime = pFind.GetTimeOut();
	if nTimeType and nTimeType == 0 and nTime > 0 then
		Dbg:WriteLog("breakupxuanjing",  me.szName, "Khấu trừ vật phẩm: ", pFind.szName, "Thời gian: "..os.date("%Y/%m/%d/%H/%M/00", nTime));
	elseif nTimeType and nTimeType == 1 and nTime > 0 then
		Dbg:WriteLog("breakupxuanjing",  me.szName, "Khấu trừ vật phẩm: ", pFind.szName, "Thời hạn còn: "..Lib:TimeDesc(nTime));
	else
		Dbg:WriteLog("breakupxuanjing",  me.szName, "Khấu trừ vật phẩm: ", pFind.szName);
	end
	
	if me.DelItem(pFind, Player.emKLOSEITEM_BREAKUP) ~= 1 then
		Dbg:WriteLog("breakupxuanjing",  me.szName, "Khấu trừ vật phẩm thất bại, vật phẩm cần khấu trừ là: ", pFind.szName);
		return 0;
	end
	
	local szLogMsg = "["..me.szName.."] Nhận được: Huyền Tinh cấp "; 
	for nItemLevel, nItemNum in pairs(tbBreakUpItem) do
		for i = 1, nItemNum do
			local pItem = me.AddItem(Item.SCRIPTITEM, 1, 114, nItemLevel);
			if nTimeType and nTime and nTime ~= 0 then
				if nTimeType == 0 then
					me.SetItemTimeout(pItem, os.date("%Y/%m/%d/%H/%M/00", nTime), 1);
				elseif nTimeType == 1 then
					me.SetItemTimeout(pItem, math.ceil(nTime / 60), 0);
				end
				pItem.Sync();
			end
		end
		szLogMsg = szLogMsg..nItemLevel.." - "..nItemNum.." viên";
	end
	
	if nTimeType and nTimeType == 0 and nTime > 0 then
		szLogMsg = szLogMsg.."Thời gian: "..os.date("%Y/%m/%d/%H/%M/00", nTime);
	elseif nTimeType and nTimeType == 1 and nTime > 0 then
		szLogMsg = szLogMsg.."Thời hạn còn: "..Lib:TimeDesc(nTime);
	end
	Dbg:WriteLog("breakupxuanjing", szLogMsg);
end

function tbGift:OnSwitch(pPickItem, pDropItem, nX, nY)
	if (not pDropItem) then
		return 1;
	end
	
	local pFind = self:First();
	if (pFind) then
		me.Msg("<color=red>1 lần chỉ được bỏ 1 Huyền Tinh khóa cấp 10 đến cấp 12 vào!<color>");
		return 0;
	end

	if pDropItem.szClass ~= self.ITEM_CLASS or pDropItem.nLevel < self.NEEDLEVEL_MIN 
		or pDropItem.nLevel > self.NEEDLEVEL_MAX or pDropItem.IsBind() ~= 1 then
		me.Msg("<color=red>Chỉ được bỏ Huyền Tinh khóa cấp 10 đến cấp 12 vào!<color>");
		return 0;
	end
	return	1;
end

function tbGift:OnUpdate()
	self._szTitle = "Tách Huyền Tinh";
	local pItem = self:First();
	if not pItem then
		self._szContent = "Bỏ Huyền Tinh cần tách vào. Chỉ được bỏ Huyền Tinh khóa cấp 10 đến cấp 12 vào.";
		return 0;
	end

	local pFind = self:First();
	local tbBreakUpItem = Item:ValueToItem(pFind.nValue, self.LAYER, 1);	-- 最后一个参数是标志位，表示是拆玄
	local nNum = 0;
	local szMsg = ""; 
	for i = 1, 12 do  
		if tbBreakUpItem[i] and tbBreakUpItem[i] > 0 then
			szMsg = szMsg.."    "..i.." - "..tbBreakUpItem[i].."\n";
			nNum = nNum + tbBreakUpItem[i];
		end
	end

	self._szContent = "Bạn có thể tách thành:\n<color=yellow>"..szMsg.."<color>Cần "..nNum.." ô trống.";
end
