

local tbItem 	= Item:GetClass("modaoshi");
tbItem.nDuration	= Env.GAME_FPS * 60 * 60;


function tbItem:OnUse()
	me.AddSkillState(387, it.nLevel, 2, self.nDuration, 1, 0, 1);
	
	return 1;
end

function tbItem:GetTip()
	return FightSkill:GetSkillItemTip(387, it.nLevel);
end
