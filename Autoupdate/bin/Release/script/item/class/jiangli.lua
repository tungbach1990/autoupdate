-------------------------------------------------------------------
--Describe:	增加奖励基金道具

local tbJiangLi = Item:GetClass("jiangli");
tbJiangLi.ADD_GREAT_BOUNS = 1000000;
function tbJiangLi:OnUse()
	local pTong = KTong.GetTong(me.dwTongId);
	if not pTong then
		me.Msg("Bạn chưa gia nhập bang hội, không thể sử dụng đạo cụ.");
		return 0;
	end
	if Tong:AddGreatBonus_GS(me.dwTongId, tbJiangLi.ADD_GREAT_BOUNS) == 0 then
		me.Msg("Quỹ thưởng của bang bạn đã quá giới hạn.");
		return 0;
	end
	me.Msg("Quỹ thưởng của bang bạn tăng <color=yellow>"..(tbJiangLi.ADD_GREAT_BOUNS/10000).." lượng <color>");
	KTong.Msg2Tong(me.dwTongId, me.szName.."Tăng ưu đãi bang lên <color=green>"..(tbJiangLi.ADD_GREAT_BOUNS/10000).." lượng<color>");
	return 1;
end
