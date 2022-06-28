Require("\\script\\fightskill\\enchant\\enchant.lua");

local tb	= 
{
	baibuchuanyangadd =
	{
		{
			RelatedSkillId = 216,
			magic = 
			{
				skill_attackradius = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,48}, {10, 200}, {11, 220}}},
				},
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10,-18*3}, {10,-18*3}}},
				},
			},
		},
		
		{
			RelatedSkillId = 237,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,8}, {10, 35}, {11, 39}}},
				},
			},
		},
	},
	
	baihongguanriadd =
	{
		{
			RelatedSkillId = 226,
			magic = 
			{
				missile_range = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 1}}},
					value3 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 1}}},
				},
				missile_ablility = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,14}, {10, 100}, {11, 100}}},
					value2 = {SkillEnchant.OP_SET,  {{1,0}, {10, 0}}},
				},
			},
		},
		
		{
			RelatedSkillId = 229,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,6}, {10, 15}, {11, 15}}},
				},
				missile_ablility = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,14}, {10, 100}, {11, 100}}},
					value2 = {SkillEnchant.OP_SET,  {{1,2}, {10, 2}}},
				},	
			},
		},
	},
};


SkillEnchant:AddBooksInfo(tb)
