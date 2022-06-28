Require("\\script\\fightskill\\enchant\\enchant.lua");

local tb	= 
{
	pijingzhanjiadd =
	{
		{
			RelatedSkillId = 41,
			magic = 
			{
				skill_attackradius = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,25}, {10, 250}, {12, 275}}},
				},
				skill_param1_v = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,2}, {10, 18}, {11, 18}}},
				},
			},
		},
	},
};


SkillEnchant:AddBooksInfo(tb)
