local tb	= {
	wuxingzhen={
		lifemax_p=			{{{1,1},{5,5}}},
		expenhance_p=		{{{1,1},{5,5}}},
		lucky_v=			{{{1,1},{5,5}}},
		manareplenish_v=	{{{1,2},{5,10}}},
	},
	zhenfa1_5_n={
		lifemax_p=			{{{1,5},{5,25}}},
		manamax_p=			{{{1,5},{5,25}}},
		lifereplenish_p=	{{{1,2},{5,10}}},
		manareplenish_p=	{{{1,2},{5,10}}},
		adddefense_v=		{{{1,30},{5,150}}},
	},
	zhenfa1_f={
		state_hurt_resistrate=	{{{1,15},{5,75}}},
		damage_physics_resist=	{{{1,16},{5,80}}},
	},
	zhenfa2_f={
		state_weak_resistrate=	{{{1,15},{5,75}}},
		damage_physics_resist=	{{{1,8},{5,40}}},
		damage_poison_resist=	{{{1,10},{5,50}}},
	},
	zhenfa3_f={
		state_slowall_resistrate=	{{{1,15},{5,75}}},
		damage_physics_resist=		{{{1,8},{5,40}}},
		damage_cold_resist=			{{{1,10},{5,50}}},
	},
	zhenfa4_f={
		state_burn_resistrate=	{{{1,15},{5,75}}},
		damage_physics_resist=	{{{1,8},{5,40}}},
		damage_fire_resist=		{{{1,10},{5,50}}},
	},
	zhenfa5_f={
		state_stun_resistrate=	{{{1,15},{5,75}}},
		damage_physics_resist=	{{{1,8},{5,40}}},
		damage_light_resist=	{{{1,10},{5,50}}},
	},
	zhenfa6_n={
		skilldamageptrim=		{{{1,1},{5,5}}},
		skillselfdamagetrim=	{{{1,1},{5,5}}},
		ignoredefenseenhance_v=	{{{1,30},{5,150}}},
	},
	zhenfa6_f={
		state_weak_attackrate=		{{{1,15},{5,75}}},
		state_stun_attackrate=		{{{1,15},{5,75}}},
		state_burn_attackrate=		{{{1,15},{5,75}}},
		state_hurt_attackrate=		{{{1,15},{5,75}}},
		state_slowall_attackrate=	{{{1,15},{5,75}}},
	},
	zhenfa7_n={
		deadlystrikedamageenhance_p={{{1,3},{5,15}}},
	},
	zhenfa7_f={
		deadlystrikedamageenhance_p={{{1,3},{5,15}}},
	},
	zhenfa8_n={
		defencedeadlystrikedamagetrim={{{1,3},{5,15}}},
	},
	zhenfa8_f={
		defencedeadlystrikedamagetrim={{{1,3},{5,15}}},
	},
	zhenfa9_n={
		rangedamagereturn_p={{{1,2},{5,10}}},
	},
	zhenfa9_f={
		rangedamagereturn_p={{{1,3},{5,15}}},
	},
	zhenfa10_n={
		damage_return_receive_p={{{1,-2},{5,-10}}},
	},
	zhenfa10_f={
		damage_return_receive_p={{{1,-4},{5,-20}}},
	},
	baihuazhen={
		lucky_v={{{1,5},{2,10},{55,275},{56,275}}},
	},

	zhenfa11_n={
		ignoreskill={{{1,1},{5,7}},0,{{1,2},{2,2}}},
	},
	zhenfa11_f={
		ignoreskill={{{1,1},{5,8}},0,{{1,2},{2,2}}},
	},
	zhenfa12_n={
		ignoreskill={{{1,1},{5,7}},0,{{1,4},{2,4}}},
	},
	zhenfa12_f={
		ignoreskill={{{1,1},{5,8}},0,{{1,4},{2,4}}},
	},
	zhenfa13_n={
		steallifeenhance_p={{{1,1},{5,5}},{{1,100},{5,100}}},
		npcdamageadded={{{1,-15},{5,-15}}},
	},
	zhenfa13_f={
		steallifeenhance_p={{{1,1},{5,5}},{{1,100},{5,100}}},
		npcdamageadded={{{1,-15},{5,-15}}},
	},
	zhenfa14_n={
		stealmanaenhance_p={{{1,1},{5,5}},{{1,100},{5,100}}},
		npcdamageadded={{{1,-15},{5,-15}}},
	},
	zhenfa14_f={
		stealmanaenhance_p={{{1,1},{5,5}},{{1,100},{5,100}}},
		npcdamageadded={{{1,-15},{5,-15}}},
	},
	zhenfa15_n={
		state_hurt_attacktime		={{{1,15},{5,150}}},
		state_weak_attacktime		={{{1,15},{5,150}}},
		state_slowall_attacktime	={{{1,15},{5,150}}},
		state_burn_attacktime		={{{1,15},{5,150}}},
		state_stun_attacktime		={{{1,15},{5,150}}},
	},
	zhenfa15_f={
		state_fixed_attacktime		={{{1,20},{5,200}}},
		state_palsy_attacktime		={{{1,20},{5,200}}},
		state_freeze_attacktime		={{{1,20},{5,200}}},
		state_confuse_attacktime	={{{1,20},{5,200}}},
		state_knock_attacktime		={{{1,20},{5,200}}},
	},
	zhenfa16_n={
		strength_v		={{{1,6},{5,65}}},
		dexterity_v		={{{1,6},{5,65}}},
		vitality_v		={{{1,6},{5,65}}},
		energy_v		={{{1,6},{5,65}}},
	},
	zhenfa16_f={
		strength_v		={{{1,6},{5,65}}},
		dexterity_v		={{{1,6},{5,65}}},
		vitality_v		={{{1,6},{5,65}}},
		energy_v		={{{1,6},{5,65}}},
	},
	zhenfa17_n={
		skilldamageptrim		={{{1,2},{5,15}}},
		skillselfdamagetrim		={{{1,2},{5,15}}},
		redeivedamage_dec_p2	={{{1,-10},{5,-10}}},
	},
	zhenfa17_f={
		skilldamageptrim		={{{1,2},{5,10}}},
		skillselfdamagetrim		={{{1,2},{5,10}}},
		redeivedamage_dec_p2	={{{1,-10},{5,-10}}},
	},
	zhenfa18_n={
		deadlystrikeenhance_r={{{1,30},{5,150}}},
		defencedeadlystrikedamagetrim={{{1,-3},{5,-15}}},
	},
	zhenfa18_f={
		deadlystrikeenhance_r={{{1,30},{5,150}}},
		defencedeadlystrikedamagetrim={{{1,-3},{5,-15}}},
	},
}

FightSkill:AddMagicData(tb)
