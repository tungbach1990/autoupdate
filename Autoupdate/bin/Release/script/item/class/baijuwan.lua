-- �ļ�������baijuwan.lua
-- �����ߡ���FanZai
-- ����ʱ�䣺2007-12-25 09:14:32
-- �ļ�˵�����׾���


local tbItem 	= Item:GetClass("baijuwan");

function tbItem:OnUse()
	Player.tbOffline:OnCastCoin(me, it.nLevel, 1, 1);
	return 1;
end
