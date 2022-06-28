

local tbAnimal	= Npc:GetClass("animal");

function tbAnimal:OnDialog()
	me.Msg("Unbelievable!!!");	-- 战斗Npc，不会发生对话吧？
end;

function tbAnimal:OnDeath(pNpcKiller)
end;

