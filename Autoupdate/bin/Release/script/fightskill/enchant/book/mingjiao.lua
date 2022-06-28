Require("\\script\\fightskill\\enchant\\enchant.lua");

local tb	= 
{
	liuxingchuiadd =
	{
		{
			RelatedSkillId = 198,
			magic = 
			{
				skill_attackradius = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,12}, {10, 120}, {11, 120}}},
				},
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10, -18*3}, {11, -18*3}}},
				},
				skill_mintimepercastonhorse_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10, -18*3}, {11, -18*3}}},
				},
			},
		},
		
		{
			RelatedSkillId = 791,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,5}, {10, 20}, {11, 21}}},
				},
				missile_range = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 3}, {11, 3}}},
					value3 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 3}, {11, 3}}},
				},
				missile_ablility = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,10}, {10, 100}, {11, 100}}},
					value2 = {SkillEnchant.OP_SET,  {{1,2}, {10, 2}}},
				},
			},
		},
	},
	
	yinyunziqiadd =
	{
		{
			RelatedSkillId = 207,
			magic = 
			{
				ignoreskill = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,5}, {10, 10}, {11, 11}}},
				},
			},
		},
		
		{
			RelatedSkillId = 210,
			magic = 
			{
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18*6}, {10, -18*15}, {11, -18*15}}},
				},
				skill_mintimepercastonhorse_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18*6}, {10, -18*15}, {11, -18*15}}},
				},
			},
		},
		
		{
			RelatedSkillId = 205,
			magic = 
			{
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18*0.5}, {5, -18*1}, {10, -18*1.5}, {11, -18*1.5}}},
				},
			},
		},
		
		{
			RelatedSkillId = 208,
			magic = 
			{
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18*0.5}, {5, -18*1}, {10, -18*1.5}, {11, -18*1.5}}},
				},
			},
		},
	
		{
			RelatedSkillId = 771,
			magic = 
			{
				fastlifereplenish_v = 
				{
					value1 = {SkillEnchant.OP_MUL, {{1,10}, {10, 100}, {11, 105}}},
				},
			},
		},
		
		{
			RelatedSkillId = 770,
			magic = 
			{
				fastmanareplenish_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-100}, {10, -300}, {11, -315}}},
				},
			},
		},
	},
	muyeyingyangadd =
	{
		{
			RelatedSkillId = 205,
			magic = 
			{
				state_fixed_attack = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,1}, {10, 5}, {11, 5}}},
					value2 = {SkillEnchant.OP_ADD, {{1,18*1.5}, {10, 18*1.5}}},
				},
			},
		},
		
		{
			RelatedSkillId = 208,
			magic = 
			{
				state_fixed_attack = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,3}, {10, 25}, {11, 26}}},
					value2 = {SkillEnchant.OP_ADD, {{1,18*1.5}, {10, 18*1.5}}},
				},
			},
		},
		{
			RelatedSkillId = 248,
			magic = 
			{
				state_fixed_attack = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,3}, {10, 25}, {11, 26}}},
					value2 = {SkillEnchant.OP_ADD, {{1,18*1.5}, {10, 18*1.5}}},
				},
			},
		},
		{
			RelatedSkillId = 211,
			magic = 
			{
				state_fixed_attack = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,1}, {10, 10}, {11, 11}}},
					value2 = {SkillEnchant.OP_ADD, {{1,18*1.5}, {10, 18*1.5}}},
				},
			},
		},
	},
	jianming120add =
	{
		{
			RelatedSkillId = 205,
			magic = 
			{
				missile_range = 
				{
					value3 = {SkillEnchant.OP_ADD, {{1,1}, {10, 2}, {11, 2}}},
				},
			},
		},
		{
			RelatedSkillId = 248,
			magic = 
			{
				missile_range = 
				{
					value3 = {SkillEnchant.OP_ADD, {{1,1}, {10, 2}, {11, 2}}},
				},
			},
		},
		{
			RelatedSkillId = 211,
			magic = 
			{
				missile_range = 
				{
					value3 = {SkillEnchant.OP_ADD, {{1,1}, {10, 2}, {11, 2}}},
				},
			},
		},
	},
};


SkillEnchant:AddBooksInfo(tb)
