Require("\\script\\fightskill\\enchant\\enchant.lua");

local tb	= 
{
	liangyizhenqiadd =
	{
		{
			RelatedSkillId = 178,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,2}, {10, 6}, {11, 6}}},
				},
			},
		},
		
		{
			RelatedSkillId = 181,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,2}, {10, 6}, {11, 6}}},
				},
			},
		},
	},
	
	huasuiwuyiadd =
	{
		{
			RelatedSkillId = 188,
			magic = 
			{
				missile_range = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,2}, {10, 4}, {11, 4}}},
					value3 = {SkillEnchant.OP_ADD, {{1,2}, {10, 4}, {11, 4}}},
				},
			},
		},
		{
			RelatedSkillId = 190,
			magic = 
			{
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,-9}, {10, -18}, {11, -18}}},
				},
			},
		},
		
		{
			RelatedSkillId = 699,
			magic = 
			{
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10, -18*10}, {11, -18*10}}},
				},
				skill_mintimepercastonhorse_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10, -18*10}, {11, -18*10}}},
				},
			},
		},
		
		{
			RelatedSkillId = 234,
			magic = 
			{
				missile_range = 
				{
					value3 = {SkillEnchant.OP_ADD, {{1,1}, {10, 2}, {11, 2}}},
				},
			},
		},
	},

	leitingjue_selfadd =
	{
		{
			RelatedSkillId = 234,
			magic = 
			{
				appenddamage_p = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,10}, {10, 55},{14,66}}},
				},
			},
		},
	},
};


SkillEnchant:AddBooksInfo(tb)
