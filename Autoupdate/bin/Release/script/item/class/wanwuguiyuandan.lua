local tbItem 	= Item:GetClass("wanwuguiyuandan");
tbItem.nDuration	= Env.GAME_FPS * 60 * 60;


function tbItem:OnUse()
	me.AddSkillState(385, 10, 2, self.nDuration, 1, 0, 1);
	me.AddSkillState(386, 10, 2, self.nDuration, 1, 0, 1);
	me.AddSkillState(387, 10, 2, self.nDuration, 1, 0, 1);
	if GLOBAL_AGENT then
		me.SetTask(Player.ACROSS_TSKGROUPID, Player.ACROSS_TSKID_USE_TIME, GetTime());
		me.SetTask(Player.ACROSS_TSKGROUPID, Player.ACROSS_TSKID_TIME_OUT, tbItem.nDuration / Env.GAME_FPS);
		me.SetTask(Player.ACROSS_TSKGROUPID, Player.ACROSS_TSKID_PRICE, it.nPrice);
	end
	return 1;
end


function tbItem:GetTip()
	local szTip = "";
	szTip	= szTip..FightSkill:GetSkillItemTip(385, 10) .. "\n";
	szTip	= szTip..FightSkill:GetSkillItemTip(386, 10) .. "\n";
	szTip	= szTip..FightSkill:GetSkillItemTip(387, 10) .. "\n";
	return szTip;
end
