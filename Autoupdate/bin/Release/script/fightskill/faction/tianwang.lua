Require("\\script\\fightskill\\fightskill.lua")
local tb	= {
	huifengluoyan={ --回风落雁_20
		appenddamage_p= {{{1,50},{20,50},{21,50*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,10},{10,100},{20,200},{21,200*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,30*0.9},{10,165*1.1},{20,315*0.9},{21,315*FightSkill.tbParam.nSadd1*0.9}},
			[3]={{1,30*1.1},{10,165*1.1},{20,315*1.1},{21,315*FightSkill.tbParam.nSadd1*1.1}}
			},
		skill_cost_v={{{1,2},{20,20},{21,20}}},
		state_hurt_attack={{{1,15},{10,30},{20,35}},{{1,18},{20,18}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
		addskilldamagep={43, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={44, {{1,2},{20,30},{21,35}}},
		addskilldamagep3={47, {{1,2},{20,10},{21,12}},1},
		addskilldamagep4={48, {{1,2},{20,10},{21,12}}},
	},
	tianwangqiangfa={ --天王枪法_10
		addphysicsdamage_p={{{1,5},{10,165},{12,198}}},
		attackratingenhance_p={{{1,50},{10,135},{12,162}}},
		deadlystrikeenhance_r={{{1,30},{10,50},{11,55}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	duanhunci={ --断魂刺_10
		state_fixed_attack={{{1,35},{10,85},{12,90}},{{1,18*2},{20,18*2}}},
		state_hurt_attack={{{1,27},{10,54},{11,56}},{{1,18},{20,18}}},
		missile_hitcount={{{1,3},{10,3},{11,4},{12,4}}},
		skill_cost_v={{{1,20},{10,50},{11,50}}},
		skill_attackradius={550},
		skill_param1_v={32},
	},
	yangguansandie={ --阳关三叠_20
		appenddamage_p= {{{1,50},{20,50},{21,50*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,10},{10,100},{20,182},{21,182*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,300*0.9},{10,390*0.9},{20,490*0.9},{21,490*FightSkill.tbParam.nSadd1*0.9}},
			[3]={{1,300*1.1},{10,390*1.1},{20,490*1.1},{21,490*FightSkill.tbParam.nSadd1*1.1}}
			},
		skill_cost_v={{{1,20},{20,50},{21,50}}},
		state_hurt_attack={{{1,15},{10,35},{20,40},{21,41}},{{1,18},{20,18}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		addskilldamagep={47, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={48, {{1,2},{20,30},{21,35}}},
	},
	jingxinjue={ --静心诀_10
		lifemax_p={{{1,10},{20,80},{21,82}}},
		poisontimereduce_p={{{1,5},{20,30},{23,35}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	jingleipotian={ --惊雷破天_10
		autoskill={{{1,10},{2,10}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	jingleipotian_child={ --惊雷破天子
		prop_invincibility={1},
		skill_statetime={{{1,18*2},{10,18*2},{11,18*2}}},
	},
	jingleipotian_child2={ --惊雷破天子子
		deadlystrikeenhance_r={{{1,50},{10,140},{11,160}}},
		state_hurt_attackrate={{{1,15},{10,50},{11,50}}},
		skill_statetime={{{1,18*3},{10,18*15},{11,18*15}}},
	},
	tianwangzhanyi={ --天王战意_20
		addphysicsdamage_p={{{1,25},{20,210},{21,219}}},
		deadlystrikeenhance_r={{{1,10},{20,50},{21,55}}},
		state_hurt_attackrate={{{1,15},{20,80},{23,90}}},
		skill_cost_v={{{1,300},{20,500},{21,500}}},
		skill_statetime={{{1,18*180},{20,18*300}}},
	},
	tianwangzhanyi_ally={ --天王战意_20
		addphysicsdamage_p={{{1,15},{20,60},{21,63}}},
		deadlystrikeenhance_r={{{1,10},{20,30},{21,33}}},
		state_hurt_attackrate={{{1,10},{20,45},{23,49}}},
		skill_statetime={{{1,18*180},{20,18*300}}},
	},
	zhuixingzhuyue={ --追星逐月
		appenddamage_p= {{{1,80*FightSkill.tbParam.nS1},{10,80},{20,80*FightSkill.tbParam.nS20},{21,80*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,120*FightSkill.tbParam.nS1},{10,120},{20,120*FightSkill.tbParam.nS20},{21,120*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,660*0.9*FightSkill.tbParam.nS1},{10,660*0.9},{20,660*0.9*FightSkill.tbParam.nS20},{21,660*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,660*1.1*FightSkill.tbParam.nS1},{10,660*1.1},{20,660*1.1*FightSkill.tbParam.nS20},{21,660*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,22},{20,45},{21,45}}},
		state_hurt_attack={{{1,15},{10,25},{20,30}},{{1,18},{20,18}}},
		missile_hitcount={{{1,3},{20,3}}},
	},
	tiangangzhanqi={ --天罡战气
		state_weak_resistrate={{{1,10},{10,100},{20,150}}},
		lifereplenish_p={{{1,5},{20,20},{21,21}}},
		attackratingenhance_p={{{1,50},{20,100}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	xuezhanbafang={ --血战八方
		skilldamageptrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		skillselfdamagetrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		state_hurt_attacktime={{{1,10},{10,80}}},
		state_weak_resisttime={{{1,10},{10,120}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},

	pijingzhanji={ --中级秘籍：披荆斩棘
		addenchant={14, {{1,1}, {2, 2}}},
		addstartskill={41, 1224, {{1,1}, {10, 10}}},
		skill_skillexp_v=FightSkill.tbParam.tbMidBookSkillExp,
		skill_statetime={{{1,-1},{2,-1}}},
	},
	pijingzhanji_child={ --中级秘籍：披荆斩棘
		state_hurt_ignore={1},
		state_slowall_ignore={1},
		state_stun_ignore={1},
		state_fixed_ignore={1},
		skill_statetime={{{1,18},{2,18}}},
	},
	pijingzhanji_child2={ --中级秘籍：乘风破浪子
		missile_missrate={{{1,50},{2,50}}},
		ignoreskill={{{1,100},{2,100}},0,{{1,5},{2,5}}},
		skill_statetime={{{1,18},{2,18}}},
	},
	benleizuanlongqiang={ --奔雷钻龙枪_10
		appenddamage_p= {{{1,100*0.7*1.0},{10,100*1.0},{11,100*FightSkill.tbParam.nSadd1*1.0}}},
		physicsenhance_p={{{1,150*0.7*1.0},{10,150*1.0},{11,150*FightSkill.tbParam.nSadd1*1.0}}},
		physicsdamage_v={
			[1]={{1,375*0.9*0.7*1.0},{10,375*0.9*1.0},{11,375*0.9*FightSkill.tbParam.nSadd1*1.0}},
			[3]={{1,375*1.1*0.7*1.0},{10,375*1.1*1.0},{11,375*1.1*FightSkill.tbParam.nSadd1*1.0}}
			},
		seriesdamage_r={{{1,250},{10,250},{11,250}}},
		state_hurt_attack={{{1,15},{10,60},{11,63}},{{1,18},{10,18}}},
		missile_hitcount={{{1,11},{10,11}}},
		runattack_damageadded={{{1,-10},{10,-10}}},

		skill_missilenum_v={{{1,5},{10,10},{11,10}},1},
		skill_mintimepercast_v={{{1,20*18},{10,20*18}}},
		skill_cost_v={{{1,180},{10,180},{11,180}}},
	},
	benleizuanlongqiang2={ --奔雷钻龙枪_10
		appenddamage_p= {{{1,100*0.7*1.0},{10,100*1.0},{11,100*FightSkill.tbParam.nSadd1*1.0}}},
		physicsenhance_p={{{1,150*0.7*1.0},{10,150*1.0},{11,150*FightSkill.tbParam.nSadd1*1.0}}},
		physicsdamage_v={
			[1]={{1,375*0.9*0.7*1.0},{10,375*0.9*1.0},{11,375*0.9*FightSkill.tbParam.nSadd1*1.0}},
			[3]={{1,375*1.1*0.7*1.0},{10,375*1.1*1.0},{11,375*1.1*FightSkill.tbParam.nSadd1*1.0}}
			},
		seriesdamage_r={{{1,250},{10,250},{11,250}}},
		state_hurt_attack={{{1,15},{10,60},{11,63}},{{1,18},{10,18}}},
		missile_hitcount={{{1,11},{10,11}}},
		runattack_damageadded={{{1,-10},{10,-10}}},
	},
	benleizuanlongqiang_child={ --奔雷钻龙枪免疫
		--ignoredebuff={{{1,32767},{2,32767}}},
		--redeivedamage_dec_p2={{{1,300},{10,300}}},
		skill_statetime={{{1,18*1},{2,18*1}}},
	},
	qiangtianadvancedbook={ --枪天高级秘籍_10
		autoskill={{{1,43},{2,43}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	qiangtianadvancedbook_child={ --枪天高级秘籍_10
		skilldamageptrim		={{{1,1},{10,2},{11,2}}},
		skillselfdamagetrim		={{{1,1},{10,2},{11,2}}},
		superposemagic={{{1,9},{10,36},{11,38}}},
		skill_statetime={{{1,5*18},{10,5*18},{12,5.5*18}}},
	},
	qiangtian120={ --枪天120_10
		state_hurt_ignore={1},
		state_weak_ignore={1},
		state_slowall_ignore={1},
		state_stun_ignore={1},
		skill_statetime={{{1,6*18},{10,15*18},{11,16*18}}},
		skill_cost_v={{{1,500},{10,500}}},
		skill_mintimepercast_v={{{1,45*18},{10,45*18}}},
		skill_mintimepercastonhorse_v={{{1,45*18},{10,45*18}}},
	},
	qiangtian120_child={ --枪天120_子_10
		state_hurt_ignore={1},
		state_weak_ignore={1},
		state_slowall_ignore={1},
		state_stun_ignore={1},
		skill_statetime={{{1,2*18},{10,2*18},{11,2*18}}},
	},
	xingyunjue={ --行云诀_20
		appenddamage_p= {{{1,80},{20,80},{21,80*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,5},{10,50},{20,100},{21,100*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,50*0.9},{10,140*0.9},{20,240*0.9},{21,240*FightSkill.tbParam.nSadd1*0.9}},
			[3]={{1,50*1.1},{10,140*1.1},{20,240*1.1},{21,240*FightSkill.tbParam.nSadd1*1.1}}
			},
		skill_cost_v={{{1,2},{20,20},{21,20}}},
		state_hurt_attack={{{1,15},{10,20},{20,25},{21,25},{22,26}},{{1,18},{20,18}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
		addskilldamagep={53, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={54, {{1,2},{20,30},{21,35}}},
		addskilldamagep3={56, {{1,2},{20,10},{21,12}},1},
		addskilldamagep4={57, {{1,2},{20,10},{21,12}}},
	},
	tianwangchuifa={ --天王锤法_10
		addphysicsdamage_p={{{1,5},{10,145},{12,174}}},
		attackratingenhance_p={{{1,50},{10,200},{11,220}}},
		deadlystrikeenhance_r={{{1,30},{10,50},{11,55}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	jingxinshu={ --静心术_20
		lifemax_p={{{1,10},{20,80},{21,82}}},
		poisontimereduce_p={{{1,5},{20,30},{23,35}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	zhuifengjue={ --追风诀_20
		appenddamage_p= {{{1,75},{20,75},{21,75*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,5},{10,68},{20,128},{21,128*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,150*0.9},{10,195*0.9},{20,245*0.9},{21,245*FightSkill.tbParam.nSadd1*0.9}},
			[3]={{1,150*1.1},{10,195*1.1},{20,245*1.1},{21,245*FightSkill.tbParam.nSadd1*1.1}}
			},
		skill_cost_v={{{1,20},{20,50},{21,50}}},
		state_hurt_attack={{{1,15},{10,20},{20,25},{21,25},{22,26}},{{1,18},{20,18}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		addskilldamagep={56, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={57, {{1,2},{20,30},{21,35}}},
	},
	tianwangbensheng={ --天王本生_10
		autoskill={{{1,11},{2,11}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	tianwangbensheng_child={ --天王本生子
		prop_invincibility={1},
		removestate={{{1,800},{2,800}}},
		skill_statetime={{{1,18*2},{10,18*2},{11,18*2}}},
	},
	jinzhongzhao={ --金钟罩_20
		damage_physics_resist={{{1,10},{10,50},{20,150},{21,157}}},
		damage_poison_resist={{{1,10},{10,50},{20,150},{21,157}}},
		damage_cold_resist={{{1,10},{10,50},{20,150},{21,157}}},
		damage_light_resist={{{1,10},{10,50},{20,150},{21,157}}},
		state_hurt_attackrate={{{1,10},{20,80},{21,84}}},
		skill_cost_v={{{1,300},{20,500},{21,500}}},
		skill_statetime={{{1,18*60*1.5},{20,18*60*3},{21,18*60*3}}},
	},
	jinzhongzhao_ally={ --金钟罩_20
		damage_physics_resist={{{1,10},{10,30},{20,60},{21,63}}},
		damage_poison_resist={{{1,10},{10,30},{20,60},{21,63}}},
		damage_cold_resist={{{1,10},{10,30},{20,60},{21,63}}},
		damage_light_resist={{{1,10},{10,30},{20,60},{21,63}}},
		skill_statetime={{{1,18*60*1.5},{20,18*60*3},{21,18*60*3}}},
	},
	chenglongjue={ --乘龙诀_20
		appenddamage_p= {{{1,65*FightSkill.tbParam.nS1},{10,65},{20,65*FightSkill.tbParam.nS20},{21,65*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,100*FightSkill.tbParam.nS1},{10,100},{20,100*FightSkill.tbParam.nS20},{21,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,250*0.9*FightSkill.tbParam.nS1},{10,250*0.9},{20,250*0.9*FightSkill.tbParam.nS20},{21,250*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,250*1.1*FightSkill.tbParam.nS1},{10,250*1.1},{20,250*1.1*FightSkill.tbParam.nS20},{21,250*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		skill_cost_v={{{1,22},{20,45},{21,45}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_hurt_attack={{{1,15},{10,25},{20,35}},{{1,18},{20,18}}},
		missile_hitcount={{{1,4},{20,4}}},
	},
	daoxutian={ --倒虚天_20
		state_weak_resistrate={{{1,10},{10,100},{20,150}}},
		lifereplenish_p={{{1,5},{20,25},{21,26}}},
		ignoredefenseenhance_v={{{1,50},{10,200},{20,250}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	bumieshayi={ --不灭杀意_10
		skilldamageptrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		skillselfdamagetrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		state_hurt_attacktime={{{1,10},{10,80}}},
		state_weak_resisttime={{{1,10},{10,120}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},

	zhanlongjue={ --斩龙诀_10
		autoskill={{{1,65},{2,65}},{{1,1},{10,10}}},
		addedwith_enemycount={{{1,1183},{10,1183}},{{1,3},{10,10},{11,11}}, {{1,1600},{10,1600}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	zhanlongjue_child={ --斩龙诀子_10
		damage_all_resist={{{1,10},{2,10}}},
		allseriesstateresistrate={{{1,26},{2,26}}},
		state_fixed_resistrate={{{1,26},{2,26}}},
		deadlystrikeenhance_r={{{1,24},{2,24}}},
		addphysicsdamage_p={{{1,20},{2,20}}},
		skill_statetime={{{1,18*2.5},{2,18*2.5}}},
	},
	zhanlongjue_child2={ --斩龙诀子_10
		decautoskillcdtime={260,11,{{1,18*45},{10,18*45}}},
		skill_statetime={{{1,60*18},{10,60*18},{11,60*18}}},
	},

	chuitianadvancedbook={ --锤天高级秘籍_10
		autoskill={{{1,48},{2,48}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	chuitianadvancedbook_child={ --锤天高级秘籍_10
		skilldamageptrim		={{{1,1},{10,10},{11,11}}},
		skillselfdamagetrim		={{{1,1},{10,10},{11,11}}},
		superposemagic={{{1,2},{10,10},{11,10}}},
		skill_statetime={{{1,6.5*18},{2,6.5*18}}},
	},
	chuitian120={ --锤天120_10
		skilldamageptrim		={{{1,5},{10,30},{11,35}}},
		skillselfdamagetrim		={{{1,5},{10,30},{11,35}}},
		lifemax_p={{{1,10},{10,50},{11,55}}},
		poisontimereduce_p={{{1,5},{10,30},{13,35}}},
		state_hurt_attacktime={{{1,10},{10,80}}},
		state_weak_resisttime={{{1,10},{10,120}}},
	},
	chuitian120_team={ --锤天120_队友_10
		skilldamageptrim		={{{1,2},{10,15},{11,16}}},
		skillselfdamagetrim		={{{1,2},{10,15},{11,16}}},
		lifemax_p={{{1,5},{10,25},{11,27}}},
		poisontimereduce_p={{{1,2},{10,15},{13,20}}},
		state_hurt_attacktime={{{1,5},{10,40}}},
		state_weak_resisttime={{{1,4},{10,40}}},
	},
}

FightSkill:AddMagicData(tb)

local tbSkill	= FightSkill:GetClass("jingleipotian");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbCCInfo	= KFightSkill.GetSkillInfo(tbChildInfo.tbEvent.nStartSkillId, tbChildInfo.tbEvent.nLevel);
	local szMsg	= string.format("Khi sinh lực giảm xuống 25%%, xác suất thi triển: <color=gold>%d%%<color>\nKhông thọ thương, duy trì <color=Gold>%s giây<color>\nChí mạng <color=gold>tăng %s<color>\nXác suất tạo thọ thương <color=gold> tăng %s<color>, duy trì <color=gold>%s giây<color>\nThời gian giãn cách: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		FightSkill:Frame2Sec(tbChildInfo.nStateTime),
		tbCCInfo.tbWholeMagic["deadlystrikeenhance_r"][1],
		tbCCInfo.tbWholeMagic["state_hurt_attackrate"][1],
		FightSkill:Frame2Sec(tbCCInfo.nStateTime),
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("tianwangbensheng");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local nPerCastTime = (tbAutoInfo.nPerCastTime - KFightSkill.GetAutoSkillCDTimeAddition(tbSkillInfo.nId, tbAutoInfo.nId));
	if (nPerCastTime < 0) then
		nPerCastTime = 0;
	end
	local szMsg	= string.format("Khi sinh lực giảm xuống 25%%, xác suất thi triển: <color=gold>%d%%<color>\nKhông thọ thương, duy trì <color=Gold>%s giây<color>\nThời gian giãn cách: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		FightSkill:Frame2Sec(tbChildInfo.nStateTime),
		FightSkill:Frame2Sec(nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("qiangtianadvancedbook");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg = ""
	local tbMsg = {};
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0)
	szMsg = szMsg.."Đánh trúng tự động cộng dồn trạng thái:\n";
	szMsg = szMsg.."    ".."<color=green>Liên Hoàn Đoạt Mệnh<color>\n";
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("chuitianadvancedbook");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg = ""
	local tbMsg = {};
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0)
	szMsg = szMsg.."Bị đánh tự động cộng dồn trạng thái:\n";
	szMsg = szMsg.."    ".."<color=green>Càn Khôn Đảo Huyền<color>\n";
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	szMsg = szMsg.."\nGiãn cách thi triển: <color=Gold>"..FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime).." giây<color>";
	return szMsg;
end;

local tbSkill = FightSkill:GetClass("qiangtian120")

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local szMsg = "Ở trạng thái này, đồng đội xung quanh cũng nhận được hiệu quả miễn dịch";
	return szMsg;
end

local tbSkill = FightSkill:GetClass("zhanlongjue")

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg = ""
	if tbAutoInfo.nPercent >= 1 then
		szMsg = szMsg.."Bị đánh trúng có <color=Gold>"..tbAutoInfo.nPercent.."%<color> nhận được hiệu quả:\n"
		local tbMsg = {};
		FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0)
		for i=1, #tbMsg do
			szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
		end
	end
	return szMsg;
end
