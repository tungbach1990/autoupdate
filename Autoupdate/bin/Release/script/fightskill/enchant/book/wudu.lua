Require("\\script\\fightskill\\enchant\\enchant.lua");

local tb	= 
{
	huaxuejiemaiadd =
	{
		
		{
			RelatedSkillId = 78,--无形蛊
			magic = 
			{
				fastmanareplenish_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-30},{10,-75},{14,-90}}},
				},
			},
		},
	},
	
	zhuifengdujiadd =
	{
		{
			RelatedSkillId = 273,--驱毒术_子
			magic = 
			{
				missile_range = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,2}, {10, 4}, {11, 4}}},
					value3 = {SkillEnchant.OP_ADD,  {{1,2}, {10, 4}, {11, 4}}},
				},
			},
		},
		
	},
	zhangduadvancedbookadd =
	{
		{
			RelatedSkillId = 93,--阴风蚀骨
			magic = 
			{
				missile_range = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 3}, {11, 3}}},
					value3 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 3}, {11, 3}}},
				},
			},
		},
		
		{
			RelatedSkillId = 94,--天罡毒手
			magic = 
			{
				missile_range = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 1}, {11, 1}}},
					value3 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 1}, {11, 1}}},
				},
			},
		},
	},
};


SkillEnchant:AddBooksInfo(tb)
