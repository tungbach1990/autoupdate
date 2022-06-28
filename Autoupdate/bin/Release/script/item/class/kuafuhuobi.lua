-------------------------------------------------------------------
--Describe:	增加武林大会专用绑银道具

local tbKuaFuHuoBi = Item:GetClass("kuafuhuobi");

function tbKuaFuHuoBi:OnUse()
	local nValue = it.GetExtParam(1);
	if nValue <= 0 then
		return 0;
	end
	if GLOBAL_AGENT then
		me.Msg("Xin lỗi, hiện giờ không thể sử dụng đạo cụ này.")
		return 0;
	end
	local nCurrentMoney = KGCPlayer.OptGetTask(me.nId, KGCPlayer.TSK_CURRENCY_MONEY);
	if nCurrentMoney + nValue <= me.GetMaxCarryMoney() then
		GCExcute{"Player:Nor_DataSync_GC", me.szName, nValue}
		me.Msg("Tăng thành công "..nValue.."");
		return 1;
	else
		me.Msg("Xin lỗi, hiện giờ không thể sử dụng đạo cụ này.")
		return 0;
	end
end
