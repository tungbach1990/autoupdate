-------------------------------------------------------------------
--Describe:	增加武林大会专用绑银道具

local tbBangYin = Item:GetClass("bangyin");

function tbBangYin:OnUse()
	local nValue = it.GetExtParam(1);
	if nValue <= 0 then
		return 0;
	end
	local nCurrentMoney = KGCPlayer.OptGetTask(me.nId, KGCPlayer.TSK_CURRENCY_MONEY);
	if nCurrentMoney + nValue <= me.GetMaxCarryMoney() then
		GCExcute{"Player:Nor_DataSync_GC", me.szName, nValue}
		me.Msg("Bạn nhận được "..nValue.." bạc");
	else
		me.Msg("Không thể sử dụng đạo cụ, hãy thử lại sau.")
	end
	return 1;
end