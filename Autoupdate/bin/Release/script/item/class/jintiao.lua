
local tbItem = Item:GetClass("jintiao");
tbItem.GETMONEY = 
{
	[1] = {150000, 200000},
	[2] = {1500000, 2000000},
};
tbItem.ExReturnBindMoney = 0; --返还获得绑银的百分比绑银
function tbItem:OnUse()
	local nGetMoney = self.GETMONEY[it.nLevel][1];
	local nGetBindMoney = self.GETMONEY[it.nLevel][2];

	local szMsg = string.format("Sử dụng <color=yellow>%s<color> có thể đổi được：\n\n    <color=yellow>%s bạc thường<color>\n  hoặc  <color=yellow>%s bạc khóa<color>\n\n, Bạn muốn đổi loại gì ?", it.szName, nGetMoney, nGetBindMoney);
	local tbOpt = {
		{"Đổi lấy bạc thường", self.SureUse, self, it, 1},
		{"Đổi lấy bạc khóa", self.SureUse, self, it, 2},
		{"Để ta xem lại"},
	}
	Dialog:Say(szMsg, tbOpt);
	return 0;
end

function tbItem:SureUse(pItem, nType, nSure)
	if not pItem then
		return
	end
	local szItemName = pItem.szName;
	local nIbValue = pItem.nBuyPrice;
	local nGetMoney = self.GETMONEY[pItem.nLevel][nType];
	local nGetBindMoney = self.GETMONEY[pItem.nLevel][2];
	local szType = "bạc thường";
	if nType == 2 then
		szType = "bạc khóa";
	end
	if not nSure then
		local szMsg = string.format("Bạn muốn đổi lấy <color=yellow>%s %s<color> chứ ?", nGetMoney, szType);
		local tbOpt = {
			{"Ta đồng ý", self.SureUse, self, pItem, nType, 1},
			{"Để ta xem lại"},
		};
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	if nType == 1 then
		if me.nCashMoney + nGetMoney > me.GetMaxCarryMoney() then
			me.Msg("Số tiền mang theo vượt quá giới hạn qui định, vui lòng thử lại.");
			return 0;
		end
	else
		if me.GetBindMoney() + nGetMoney + math.floor(self.ExReturnBindMoney * nGetBindMoney / 100) > me.GetMaxCarryMoney() then
			me.Msg("Số tiền mang theo vượt quá giới hạn qui định, vui lòng thử lại.");
			return 0;
		end
	end

	if me.DelItem(pItem, Player.emKLOSEITEM_JINTIAO) ~= 1 then
		Dbg:WriteLog(me.szName, "Del Item:", szItemName, "Không");
		return 0;
	end
	if self.ExReturnBindMoney > 0 then
		me.AddBindMoney(math.floor(self.ExReturnBindMoney * nGetBindMoney / 100), Player.emKBINDMONEY_ADD_JITIAO);
		KStatLog.ModifyAdd("bindjxb", "[产出]金条开出", "总量", math.floor(self.ExReturnBindMoney * nGetBindMoney / 100));	
	end

	local szMoneyType = "bạc thường";
	if nType == 1 then
		me.Earn(nGetMoney, Player.emKEARN_TASK_JITIAO);
		Dbg:WriteLog(me.szName, "Use Item:", szItemName, "GetMoney:", nGetMoney);
		KStatLog.ModifyAdd("jxb", "[产出]金条开出", "总量", nGetMoney);	
	else
		szMoneyType = "bạc khóa"..szMoneyType;
		me.AddBindMoney(nGetMoney, Player.emKBINDMONEY_ADD_JITIAO);
		Spreader:AddConsume(nIbValue);
		KStatLog.ModifyAdd("bindjxb", "[产出]金条开出", "总量", nGetMoney);			
	end

	Dbg:WriteLog("use jintiao", me.szAccount, me.szName,  string.format("Sử dụng %s nhận được %d%s", szItemName, nGetMoney, szMoneyType));
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("%s sử dụng %s nhận được %d%s", me.szName, szItemName, nGetMoney, szMoneyType));
end
