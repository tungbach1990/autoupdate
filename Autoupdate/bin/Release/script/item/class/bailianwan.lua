-------------------------------------------------------
-- �ļ�������bailianwan.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-09-04 12:00:21
-- �ļ�������
-------------------------------------------------------

local tbItem = Item:GetClass("bailianwan");
tbItem.nDuration = Env.GAME_FPS * 60 * 60;

function tbItem:OnUse()
	me.AddSkillState(385, 8, 2, self.nDuration, 1, 0, 1);
	me.AddSkillState(386, 8, 2, self.nDuration, 1, 0, 1);
	me.AddSkillState(387, 8, 2, self.nDuration, 1, 0, 1);
	if GLOBAL_AGENT then
		me.SetTask(Player.ACROSS_TSKGROUPID, Player.ACROSS_TSKID_USE_TIME, GetTime());
		me.SetTask(Player.ACROSS_TSKGROUPID, Player.ACROSS_TSKID_TIME_OUT, tbItem.nDuration / Env.GAME_FPS);
		me.SetTask(Player.ACROSS_TSKGROUPID, Player.ACROSS_TSKID_PRICE, it.nPrice);
	end
	return 1;
end

function tbItem:GetTip()
	local szTip = "";
	szTip = szTip..FightSkill:GetSkillItemTip(385, 8) .. "\n";
	szTip = szTip..FightSkill:GetSkillItemTip(386, 8) .. "\n";
	szTip = szTip..FightSkill:GetSkillItemTip(387, 8) .. "\n";
	return szTip;
end
