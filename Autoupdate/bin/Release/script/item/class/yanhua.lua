
-- �̻�
-- ���ã��Ҽ����ʹ�ã��ɷų��������̻�
local tbItem 		= Item:GetClass("yanhua");
tbItem.nCastSkillId 	=  307;

function tbItem:OnUse()
	me.CastSkill(self.nCastSkillId, 1, -1, me.GetNpc().nIndex);
	return 1;
end
