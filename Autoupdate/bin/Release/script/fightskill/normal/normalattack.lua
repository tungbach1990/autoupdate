local tb	= {
	normalattack={
		physicsenhance_p={{{1,0},{2,0}}},
	},
	goldnormalattack={
		physicsenhance_p={{{1,0},{2,0}}},
		seriesdamage_r={{{1,0},{2,65},{10,265},{11,265}}},
		skill_deadlystrike_r={{{1,212},{20,212}}},
		state_hurt_attack={{{1,5},{2,10},{10,15}},{{1,18*1},{10,18*1}}},
	},
	woodnormalattack={
		physicsenhance_p={{{1,0},{2,0}}},
		seriesdamage_r={{{1,0},{2,65},{10,265},{11,265}}},
		skill_deadlystrike_r={{{1,212},{20,212}}},
		state_weak_attack={{{1,5},{2,10},{10,15}},{{1,18*3},{10,18*3}}},
	},
	waternormalattack={
		physicsenhance_p={{{1,0},{2,0}}},
		seriesdamage_r={{{1,0},{2,65},{10,265},{11,265}}},
		skill_deadlystrike_r={{{1,212},{20,212}}},
		state_slowall_attack={{{1,5},{2,10},{10,15}},{{1,18*2},{10,18*2}}},
	},
	firenormalattack={
		physicsenhance_p={{{1,0},{2,0}}},
		seriesdamage_r={{{1,0},{2,65},{10,265},{11,265}}},
		skill_deadlystrike_r={{{1,212},{20,212}}},
		state_burn_attack={{{1,5},{2,10},{10,15}},{{1,18*3},{10,18*3}}},
	},
	earthnormalattack={
		physicsenhance_p={{{1,0},{2,0}}},
		seriesdamage_r={{{1,0},{2,65},{10,265},{11,265}}},
		skill_deadlystrike_r={{{1,212},{20,212}}},
		state_stun_attack={{{1,5},{2,10},{10,15}},{{1,18*1},{10,18*1}}},
	},
	testkill={
		physicsdamage_v={
			[1]={{1,200000},{2,300000}},
			[3]={{1,200000},{2,300000}}
		},
		poisondamage_v={{{1,200000},{2,300000}},{{1,9*10},{2,9*10}}},
		colddamage_v={
			[1]={{1,200000},{2,300000}},
			[3]={{1,200000},{2,300000}}
		},
		firedamage_v={
			[1]={{1,200000},{2,300000}},
			[3]={{1,200000},{2,300000}}
		},
		lightingdamage_v={
			[1]={{1,200000},{2,300000}},
			[3]={{1,200000},{2,300000}}
		},
	},
}

FightSkill:AddMagicData(tb)
