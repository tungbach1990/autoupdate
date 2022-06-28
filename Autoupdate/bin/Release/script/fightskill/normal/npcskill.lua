local tb	= {
	npc_stunatack={--定点晕眩攻击
		state_stun_attack={{{1,0},{20,100}},{{1,18},{20,27}}},
	},
	
	npc_stunatack2={--定点晕眩攻击
		state_stun_attack={{{1,1000},{20,1000}},{{1,18},{20,18*6}}}, --最长可晕4秒
	},
	
	npc_stunatack3={--定点晕眩攻击
		state_stun_attack={{{1,100},{20,1000}},{{1,18*4},{20,18*4}}}, --长时间眩晕
	},

	npc_yuxueyin={--影子武士隐身技能
		hide={0,{{1,5*18},{20,90*18}}, 1},
	},

	npc_duanhunci={--断魂刺,通用
		state_fixed_attack={{{1,100},{20,100}},{{1,18*2},{20,18*2}}},
		},
	npc_shizihou={ --狮子吼
		state_fixed_attack={{{1,10},{10,100},{20,100}},{{1,18*3},{20,18*3}}},
	},
	npc_weakenstaticshield={ --一定时间内降低化解伤害点数
		dynamicmagicshield_v={{{1,-500},{10,-500}}},
		skill_statetime={{{1,18*120},{19,18*120},{20,-1}}}
	},
	npc_silence_ignore={ --一定时间内免疫沉默
		damage_return_receive_p={{{1,-1000},{10,-45}}},
		skill_statetime={{{1,18*120},{19,18*120},{20,-1}}}
	},
	npc_silence_attack={ --沉默
		meleedamagereturn_p={{{1,500},{20,300}}},
		rangedamagereturn_p={{{1,500},{20,300}}},
		poisondamagereturn_p={{{1,500},{10,500}}},
		skill_statetime={{{1,18},{19,18},{20,18}}},
	},
	npc_moyinshipo={ --魔音噬魄
		state_confuse_attack={{{1,100},{20,100}},{{1,18*8},{20,18*8}}},
	},
	npc_delayhideandstun={--隐身且晕眩防止立刻现形
		hide={0,{{1,5*18},{10,30*18},{20,30*18},{21,30*18}}, 1},
		state_stun_attack={{{1,100},{10,100}},{{1,18*5},{10,18*5}}},
		},
	npc_leidongjiutian={ --雷动九天
		skill_deadlystrike_r={{{1,212},{20,212}}},
		seriesdamage_r={{{1,250},{20,250},{21,250}}},
		state_stun_attack={{{1,30},{10,30},{20,30}},{{1,36},{20,36}}},
		missile_hitcount={{{1,9},{10,9},{20,9},{21,9}}},
	},
	npc_jiancui120={ --冰心玉棱
		autoskill={{{1,63},{2,63}},{{1,1},{20,20}}},
	},
	npc_liumaishenjian_child5={--六脉神剑第6剑,会心
		seriesdamage_r={{{1,250},{20,250},{21,250}}},
		skill_deadlystrike_r={{{1,1900},{20,1900}}},
		},
	npc_luanhuanji_child2={--乱环击主技能及扩散子弹
		seriesdamage_r={{{1,250},{20,250},{21,250}}},
		state_knock_attack={{{1,50},{10,50},{20,50}},{{1,10},{10,10},{20,10}},{{1,32},{2,32}}},
		skill_deadlystrike_r={{{1,212},{20,212}}},
		},
	npc_tianzhujuedao={--天竺绝刀,碰撞次数
		seriesdamage_r={{{1,250},{20,250},{21,250}}},
		state_hurt_attack={{{1,10},{10,20}},{{1,18},{20,18}}},
		skill_deadlystrike_r={{{1,212},{20,212}}},
		missile_hitcount={{{1,99},{10,99},{20,99},{21,99}}},
		},
	npc_longzhanyuye={--龙战于野,missrate
		seriesdamage_r={{{1,250},{20,250},{21,250}}},
		skill_deadlystrike_r={{{1,212},{20,212}}},
		missile_missrate={{{1,90},{2,90}}},
		skill_deadlystrike_r={{{1,212},{20,212}}},
		},
	npc_xiaofengsanlianji={--啸风三连击,碰撞次数
		seriesdamage_r={{{1,250},{20,250},{21,250}}},
		state_stun_attack={{{1,10},{10,10}},{{1,18},{20,18}}},
		skill_deadlystrike_r={{{1,212},{20,212}}},
		missile_hitcount={{{1,99},{10,99},{20,99},{21,99}}},
		skill_deadlystrike_r={{{1,212},{20,212}}},
		},
	npc_miyingzong_child={	--迷影纵后增加攻速
		castspeed_v={{{1,10},{10,100}}},
		attackspeed_v={{{1,10},{10,100}}},
		skill_statetime={{{1,2*18},{2,2*18}}},
	},
	npc_criatk={	--技能会心几率
		skill_deadlystrike_r={{{1,999999},{20,999999}}},
	},

	npc_addskillstate={	--提高技能五行效果概率
		state_weak_attackrate={{{1,10},{20,2000}}},
		state_stun_attackrate={{{1,10},{20,2000}}},
		state_burn_attackrate={{{1,10},{20,2000}}},
		state_hurt_attackrate={{{1,10},{20,2000}}},
		state_slowall_attackrate={{{1,10},{20,2000}}},
	},
	npc_addrunspeed={	--提高移动速度
		fastwalkrun_p={{{1,10},{2,20}}},
	},
	npc_decrunspeed={	--提高移动速度
		fastwalkrun_p={{{1,-10},{2,-20}}},
	},
	npc_dmgmaxhp= { --按最大比例减血，每级5%
		reducepercentonmaxhp_p={{{1,5},{20,100}},{{1,0},{10,0}},{{1,0},{10,0}}},
	},
	npc_dmgmaxmp= { --按最大比例减蓝，每级5%
		reducepercentonmaxhp_p={{{1,0},{10,0}},{{1,5},{20,100}},{{1,0},{10,0}}},
	},
	npc_dmgmaxsp= { --按最大比例减体，每级5%
		reducepercentonmaxhp_p={{{1,0},{10,0}},{{1,0},{10,0}},{{1,5},{20,100}}},
	},
	npc_dmgcurhp= { --按当前比例减血，每级5%
		reducepercentoncurhp_p={{{1,5},{20,100}},{{1,0},{10,0}},{{1,0},{10,0}}},
	},
	npc_dmgcurmp= { --按当前比例减蓝，每级5%
		reducepercentoncurhp_p={{{1,0},{10,0}},{{1,5},{20,100}},{{1,0},{10,0}}},
	},
	npc_dmgcursp= { --按当前比例减体，每级5%
		reducepercentoncurhp_p={{{1,0},{10,0}},{{1,0},{10,0}},{{1,5},{20,100}}},
	},
	npc_dmgmaxhp2= { --按最大比例减血，每级1%
		reducepercentonmaxhp_p={{{1,1},{20,20}},{{1,0},{10,0}},{{1,0},{10,0}}},
	},
	npc_atkdelay={	--每级动作1次,子弹数表示延迟时间
		skill_missilenum_v={{{1,1},{10,10}}},
	},
	npc_atkdelaykeephide={	--每级动作1次,子弹数表示延迟时间,不会显隐
		keephide={1},
		skill_missilenum_v={{{1,1},{10,10}}},
	},
	npc_defstate={	--防御状态_1-10级减少受到的伤害10-100%
		dynamicmagicshield_v={{{1,9999999},{10,9999999}},{{1,10},{10,100}}},
		posionweaken={{{1,9999999},{10,9999999}},{{1,10},{10,100}}},
	},
	npc_defstate2={	--防御状态_1-10级减少受到的伤害5-50%
		dynamicmagicshield_v={{{1,9999999},{10,9999999}},{{1,5},{10,50}}},
		posionweaken={{{1,9999999},{10,9999999}},{{1,5},{10,50}}},
	},
	npc_ignore_sp={	--闪避对npc无效技能
		ignoreskill={{{1,100},{10,100}},0,{{1,8},{2,8}}},
	},
	npc_atkspeedup={	--增加攻击速度，1到10级增加10到100的内外功攻击速度
		castspeed_v={{{1,10},{10,100}}},
		attackspeed_v={{{1,10},{10,100}}},
	},
	npc_atkspeeddown={	--减少攻击速度，1到10级减少10到100的内外功攻击速度
		castspeed_v={{{1,-10},{10,-100}}},
		attackspeed_v={{{1,-10},{10,-100}}},
	},
	npc_atkstate={	--增加攻击力，1到10级增加10%到100%的技能发挥基础攻击力
		skilldamageptrim={{{1,10},{10,100}}},
		skillselfdamagetrim={{{1,10},{10,100}}},
	},
	npc_atkstate2={	--增加攻击力，1到10级增加5%到50%的技能发挥基础攻击力
		skilldamageptrim={{{1,5},{10,50}}},
		skillselfdamagetrim={{{1,5},{10,50}}},
	},
	npc_atkstatesup={	--增加攻击力，1到10级增加10%到100%的技能发挥基础攻击力,并可叠加
		skilldamageptrim={{{1,10},{10,100}}},
		skillselfdamagetrim={{{1,10},{10,100}}},
		superposemagic={{{1,10},{2,10}}},
	},
	npc_cristate2={	--增加会心_1-19级增加会心率5%-95%
		deadlystrikeenhance_r={{	{1,100},{2,211},{3,335},{4,475},{5,633},{6,814},{7,1023},{8,1266},{9,1554},{10,1900},
									{11,2322},{12,2850},{13,3528},{14,4433},{15,5700},{16,7600},{17,10766},{18,17100},{19,36100},{20,36100}}},
	},
	npc_criskill={	--增加会心_1-19级增加会心率5%-95%
		skill_deadlystrike_r={{	{1,100},{2,211},{3,335},{4,475},{5,633},{6,814},{7,1023},{8,1266},{9,1554},{10,1900},
									{11,2322},{12,2850},{13,3528},{14,4433},{15,5700},{16,7600},{17,10766},{18,17100},{19,36100},{20,36100}}},
	},
	npc_reduceatk={	--攻击状态_1-10级减少攻速10-100
		castspeed_v={{{1,-10},{10,-100}}},
		attackspeed_v={{{1,-10},{10,-100}}},
		skill_statetime={{{1,15*18},{2,15*18}}},
	},
	npc_reduceatk2={	--攻击状态_1-10级减少攻击10-100
		skilldamageptrim={{{1,-10},{10,-100}}},
		skillselfdamagetrim={{{1,-10},{10,-100}}},
	},
	npc_liuyangrongxuegong={ --六阳融雪功
		autoskill={{{1,23},{2,23}},{{1,1},{20,20}}},
		skill_statetime={{{1,300*18},{2,300*18}}},
	},
	npc_liuyangrongxuegong_child={--六阳融雪功子
		fastmanareplenish_v={{{1,-50},{2,-100},}},
		skill_statetime={{{1,3*18},{2,3*18}}},
		},
	npc_zuowang={ --变身用坐忘,1-10级增加10%到100%的内力抵消伤害
		manashield_p={{{1,10},{10,100}}},
	},
	npc_tusha={ --可以攻击敌人,但不会被攻击
		defense_state={1},
		prop_invincibility={1},
	},
	npc_dmgadd={	--增加目标受到的伤害百分比
		redeivedamage_dec_p2={{{1,-5},{2,-10}}},
	},
	npc_dmgadd2={	--增加目标受到的伤害百分比,可叠加
		redeivedamage_dec_p2={{{1,-5},{2,-10}}},
		superposemagic={{{1,99},{2,99}}},
	},
	npc_recdmgdec_p={ --减少受到的伤害,每级5%,5%到100%
		redeivedamage_dec_p2={{{1,5},{20,100}}},
	},
	npc_wudi={	--无敌啊无敌
		prop_invincibility={1},
	},
	npc_decdmg={ --减少目标攻击力,5%到100%,每级5%
		skilldamageptrim={{{1,-5},{20,-100}}},
		skillselfdamagetrim={{{1,-5},{20,-100}}},
	},
	npc_float={ --浮空
		state_float_attack={{{1,100},{10,100}},{{1,18*1},{10,18*10}}},
	},
	npc_palsy={ --麻痹
		state_palsy_attack={{{1,100},{10,100}},{{1,18*1},{10,18*10}}},
	},
	xoyo_toutianhuanri={ --偷天换日_20
		fastmanareplenish_v={{{1,-750},{20,-750},{21,-750}}},
		skill_statetime={{{1,18*10},{20,18*10},{21,18*10}}},
	},
	xoyo_toutianhuanri_self={ --偷天换日_自身
		fastlifereplenish_v={{{1,5000},{20,100000}}},
		skill_statetime={{{1,18*10},{20,18*10},{21,18*10}}}
	},
	xoyo_lingboweibu={ --凌波微步_20
		ignoreskill={{{1,5},{20,100}},0,{{1,3},{2,3}}},
		skill_statetime={{{1,18*15},{20,18*15}}},
		movewithshadow={1},
	},
	xoyo_rebound={--反弹
		rangedamagereturn_p={{{1,10},{10,100}}},
		meleedamagereturn_p={{{1,10},{10,100}}},
		poisondamagereturn_p={{{1,10},{10,100}}},
	},
	xoyo_ignore1={--免疫外功攻击
		ignoreskill={{{1,5},{20,100}},0,{{1,4},{2,4}}},
		skill_statetime={{{1,-1},{20,-1}}},
	},
	xoyo_ignore2={--免疫内功攻击
		ignoreskill={{{1,5},{20,100}},0,{{1,2},{2,2}}},
		skill_statetime={{{1,-1},{20,-1}}},
	},
	xoyo_jibing={--持续掉血
		fastlifereplenish_v={{{1,-100},{20,-2000}}},
		magicdamage_v={
			[1]={{1,1},{2,1},{3,1},{4,1}},
			[3]={{1,1},{2,1},{3,1},{4,1}}
		},
		skill_statetime={{{1,9},{20,9}}},
	},
	npc_decspeed= { --减速技能
		fastwalkrun_p={{{1,-10},{10,-100}}},
	},
	snowman_freeze={ --必中冰冻
		appenddamage_p= {{{1,0},{2,0}}},
		state_freeze_attack={{{1,1000},{2,1000}},{{1,18*2.5},{2,18*2.5}}},
	},
	xoyo_specialknock={ --强效击退
		state_knock_attack={{{1,9999},{10,9999}},{{1,25},{10,25}},{{1,32},{2,32}}},
	},
	xoyo_specialdrag={ --强效拉回
		state_drag_attack={{{1,9999},{10,9999}},{{1,25},{10,25}},{{1,32},{2,32}}},
	},
	xoyo_specialdrag2missile={ --强效拉回
		state_drag_attack={{{1,9999},{10,9999}},{{1,25},{10,25}},{{1,32},{2,32}}},
		missile_drag={1},
	},
	xoyo_hideandrun={--隐身跑速提高
		hide={0,{{1,5*18},{2,5*18}}, 1},
	},
	xoyo_hideandrun_child={--隐身跑速提高
		fastwalkrun_p={{{1,100},{2,100}}},
	},
	xoyo_redstamina={--抽体力
		faststaminareplenish_v={{{1,-9999},{2,-9999}}},
	},
	npc_specialfixed={--强效定身
		state_fixed_attack={{{1,1000},{20,1000}},{{1,18},{20,18*10}}},
	},
	xoyo_callnpc01={ --召唤npc
		missile_callnpc={	--npcid*65536+nLevel
			{	
				{ 1,7304 * 65536 + 120},		--无敌npc，自带无形蛊,无敌
				{ 2,7330 * 65536 + 120},		--无敌npc，自带无形蛊
			},
			{{ 1,5*18*60},{ 2,5*18*60}},	--npc生存时间,0为无限
			{{ 1,5*18*60},{ 2,5*18*60}},	--npcseries
		},
		skill_missilenum_v={	--用子弹数来设置召唤npc的数量
			{	{ 1,4},
				{ 2,1},
			}
		},
	},
	xoyo_dmgaura_state={--定身光环autoskill
		autoskill={{{1,78},{2,78}},{{1,1},{20,20}}},
		defense_state={1},
		prop_invincibility = {1},
		state_confuse_attack={{{1,10},{20,10}},{{1,18*2},{20,18*2}}},
		defense_state={1},
		skill_statetime={{{1,-1},{20,-1}}},
	},  
	xoyo_fixaura_state={--定身光环autoskill
		autoskill={{{1,79},{2,79}},{{1,1},{20,20}}},
		skill_statetime={{{1,-1},{20,-1}}},
	},  
	xoyo_fixaura={--定身光环
		locked_state ={--是否不能移动,使用技能,使用物品
			[1] = {{1,1},{10,1}},
			[2] = {{1,0},{10,0}},
			[3] = {{1,0},{10,0}},
			},
	}, 
	xoyo_wohen={--我恨
		locked_state ={--是否不能移动,使用技能,使用物品
			[1] = {{1,1},{10,1}},
			[2] = {{1,0},{10,0}},
			[3] = {{1,0},{10,0}},
			},
	}, 
	xoyo_reduceatk={	--攻击状态_1-10级减少攻速10-100
		castspeed_v={{{1,-10},{10,-100}}},
		attackspeed_v={{{1,-10},{10,-100}}},
		fastwalkrun_v={{{1,-10},{10,-100}}},
	},
	boss_yuanjun={ --愿君多采撷
		autoskill={{{1,89},{2,89}},{{1,1},{20,20}}},
		skill_statetime={{{1,10*18},{20,10*18}}},
	},
	boss_xiangsi={ --此物最相思
		autoskill={{{1,90},{2,90}},{{1,1},{20,20}}},
		skill_statetime={{{1,10*18},{20,10*18}}},
	},
	roujian_wuhen={ --柔剑_无痕
		autoskill={{{1,91},{2,91}},{{1,1},{20,20}}},
		skill_statetime={{{1,18*1.5},{20,18*1.5}}},
	},
	zhuorezuzhou={ --火逢春_灼热诅咒,增加受到的火攻伤害
		damage_fire_receive_p={{{1,30},{10,30}}},
	},
	npc_lifeup={ --增加血量
		life_v={{{1,5000000},{10,5000000}}},
	},
	remove_decdmgreceive= { --去除金钟罩效果
		removestate={{{1,2032},{2,2032}}},
	},
	yinyufeifei={ --feifei
		autoskill={{{1,86},{2,86}},{{1,1},{20,20}}},
	},
	npc_feifei= { --雨霏霏
		reducepercentoncurhp_p={{{1,5},{20,100}},{{1,5},{20,100}},{{1,5},{20,100}}},
	},
	npc_addlife_p= { --增加生命上限
		lifemax_p={{{1,5},{20,100}}},
	},
	npc_declife_p= { --增加生命上限
		lifemax_p={{{1,-5},{20,-100}}},
	},
	npc_chun={ --春
		autoskill={{{1,86},{2,86}},{{1,4},{20,4}}},
	},
	npc_chun_xia= { --春去夏来
		removestate={{{1,2187},{2,2189},{3,2190},{4,2191}}},
	},
	xoyo_jumpaddcost= { --增加轻功耗体
		addenchant={32, {{1,1}, {2, 2}}},
	},
	xoyo_wuhen= { --无痕
		autoskill={{{1,91},{2,91}},{{1,1},{20,20}}},
	},
	liedizhan={ --裂地斩
		autoskill={{{1,88},{2,88}},{{1,1},{20,20}}},
	},

	npc_sectorarrow={--野人猎手扇形箭攻击
		state_knock_attack={{{1,33},{10,33},{11,33}},{{1,3},{10,2},{11,2}},{{1,32},{2,32}}},
		skill_deadlystrike_r={{{1,212},{20,212}}},
		},
	npc_cri={ --提高会心
		deadlystrikeenhance_r={{{1,100},{2,212},{10,1900},{11,9999}}},
		skill_statetime={{{1,300*18},{10,300*18},{12,300*18}}}
	},
	npc_callnpc={ --召唤小兵
		missile_callnpc={	
			{	--npcid*65536+nLevel
				{ 1,4007 * 65536 + 85},		--喽啰
				{ 2,4001 * 65536 + 85},		--监工
				{ 3,4003 * 65536 + 75},		--工匠
			},
			{	--npc生存时间,0为无限
				{ 1,18*180},
				{ 2,18*180}	
			},
			{	--npcseries
				{1,-1},
				{9,-1}
			},
		},
		skill_missilenum_v={	--用子弹数来设置召唤npc的数量
			{	{ 1,3},    --喽啰
				{ 2,3},    --监工
				{ 3,3},    --工匠
			}
		},
	},
	npc_shichengliulong={ --时乘六龙_10
		autoskill={{{1,22},{2,22}},{{1,1},{10,10}}},
		skill_statetime={{{1,30*18},{10,30*18},{11,30*18}}},
	},
	npc_shichengliulong_child={ --时乘六龙子
		appenddamage_p= {{{1,10},{10,100}}},
		seriesdamage_r={{{1,250},{10,250},{11,250}}},
		skill_deadlystrike_r={{{1,212},{20,212}}},
	},
	boss_removestate={ --清除指定技能状态
		removestate={{{1,999},{2,1332},{3,1865},{4,1887}}},
	},
	jy_bingdong={ --即死
		locked_state ={--是否不能移动,使用技能,使用物品
			[1] = {{1,1},{10,1}},
			[2] = {{1,1},{10,1}},
			[3] = {{1,0},{10,0}},
			},
		autoskill={{{1,80},{2,80}},{{1,1},{10,10}}},
	},
	jy_bingdong_child2={ --即死召唤npc
		missile_callnpc={
			{	--npcid*65536+nLevel
				{ 1,7324 * 65536 + 85},		--冰块
				{ 2,7324 * 65536 + 85},		--冰块
			},
			{	--npc生存时间,0为无限
				{ 1,18*300},
				{ 2,18*300}
			},
			{	--npcseries
				{1,-1},
				{9,-1}
			},
		},
		skill_missilenum_v={	--用子弹数来设置召唤npc的数量
			{	{ 1,1},    --冰块
				{ 2,1},    --冰块
			}
		},
	},
	jy_callfiresnake={ --召唤火蛇
		missile_callnpc={
			{	--npcid*65536+nLevel
				{ 1,7326 * 65536 + 95},		--无敌npc，自带无形蛊,无敌
				{ 2,7327 * 65536 + 95},		--无敌npc，自带无形蛊
			},
			{	--npc生存时间,0为无限
				{ 1,18*15},
				{ 2,18*75}
			},
			{	--npcseries
				{ 1,-1},
				{ 2,-1}
			},
		},
		skill_missilenum_v={	--用子弹数来设置召唤npc的数量
			{	{ 1,1},
				{ 2,1},
			}
		},
	},
	jy_deathremovestate={ --死亡解除npcbuff
		autoskill={{{1,81},{2,81}},{{1,1},{10,10}}},
	},
	jy_mogu_child={ --死亡解除npcbuff
		prop_invincibility={1},
		state_knock_attack={{{1,1000},{10,1000}},{{1,17},{10,17}},{{1,20},{2,20}}},
	},
	jy_firesnake_state={--火蛇自动伤害
		autoskill={{{1,83},{2,83}},{{1,1},{20,20}}},
		defense_state={1},
		prop_invincibility={1},
	},  
	jy_fireflower_state={--冥火
		autoskill={{{1,84},{2,84}},{{1,1},{20,20}}},
		defense_state={1},
		prop_invincibility={1},
	},  
	jy_hurryrun_state={--积极奔跑
		autoskill={{{1,85},{2,85}},{{1,1},{20,20}}},
	},  
	ll_dmgaura_state={--小怪自动伤害
		autoskill={{{1,82},{2,82}},{{1,1},{20,20}}},
		ignoredebuff={{{1,32767},{2,32767}}},
		skill_statetime={{{1,-1},{20,-1}}},
	}, 
	ll_fukong={--浮空
		state_float_attack={{{1,1000},{2,1000}},{{1,9},{2,9*2}}},
	},
	
	shitu_ignore={--免疫所有攻击
		ignoreskill={{{1,5},{20,100}},0,{{1,3},{2,3}}},
		skill_statetime={{{1,-1},{20,-1}}},
	},
	npc_autohide={ --自动隐身
		autoskill={{{1,30},{2,30}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	cbt_huanyingzhuihunqiang={ --幻影追魂枪
		state_drag_attack={{{1,1000},{10,1000}},{{1,25},{10,25}},{{1,32},{2,32}}},
	},
	cbt_huanyingzhuihunqiang_child={ --幻影追魂枪子子
		fastwalkrun_p={{{1,-30},{10,-30}}},
		skill_statetime={{{1,18*4},{10,18*4}}}
	},
	cbt_moyinshipo={ --魔音噬魄,1级为高级藏宝图用,2级为80-90级任务用
		state_confuse_attack={{{1,100},{20,100}},{{1,18*3},{2,18*5},{20,18*3}}},
	},
	cbt_dongjie={--90级藏宝图小怪冻结冰爆
		state_freeze_attack={{{1,100},{2,50}},{{1,18*1},{2,18*1}}},
		skill_deadlystrike_r={{{1,212},{20,212}}},
	},
	cbt_fastlifereplenish={	--全屏回血光环,10级以后做逍遥谷全屏回血光环用
		fastlifereplenish_v={{{1,10000},{2,3000},{3,3000},{4,20000},{10,20000},{11,38},{12,150},{13,360},{14,550},{15,732},{16,1025},{20,3000}}},
	},
	cbt_injuredadd={ --副本难度debuff,受伤害增加
		redeivedamage_dec_p=	{{{1,-10},{2,-20}}},
	},
	npc_battlefieldaura={
		lifereplenish_p={{{1,50},{2,50}}},
		manareplenish_p={{{1,50},{2,50}}},
		damage_all_resist={{{1,150},{20,150},{21,150}}},
	},
	songjin_transmutation={ --变身技能
		domainchangeself={{{1,2524},{2,2524}},{{1,80},{2,90}}},
		adddomainskill1={{{1,1161},{10,1161}},{{1,20},{20,20}}},
		skill_statetime={{{1,18*60*30},{10,18*60*30},{11,18*60*30}}},
	},
	battlejump={	--宋金轻功
		skill_attackradius={{{1,300},{20,640},{21,640}}},
	},
	battle_yuanshenwushi={ --新宋金变身技能
		domainchangeself={{{1,7025},{9,7033},{10,7033}},{{1,120},{2,120}}},
		adddomainskill1={{{1,1632},{2,1632}},{{1,10},{2,10}}},
		adddomainskill2={{{1,1634},{2,1634}},{{1,20},{2,20}}},
		adddomainskill3={{{1,1639},{2,1639}},{{1,10},{2,10}}},
		skill_statetime={{{1,18*60*5},{2,18*60*5}}},
	},
	battle_yuanshenwushi2={ --新宋金变身技能
		{szMagicName = "allskill_v", tbValue = {10, 0, 1638}},
		{szMagicName = "skill_statetime", tbValue = {{{1,18*60*5},{2,18*60*5}}}},
	},
	battle_seriesattack_50={ --附带5种五行效果
		appenddamage_p={{{1,0},{10,0}}},
		physicsdamage_v={{{1,6000*0.5},{10,6000*0.5}},0,{{1,6000*0.5},{10,6000*0.5}}},--内功系攻击专用普攻伤害...physicsenhance_v有bug
		poisondamage_v={{{1,600*0.5},{10,600*0.5}},{{1,9*9},{20,9*9}}},
		colddamage_v={{{1,6000*0.5},{10,6000*0.5}},0,{{1,6000*0.5},{10,6000*0.5}}},
		firedamage_v={{{1,6000*0.5},{10,6000*0.5}},0,{{1,6000*0.5},{10,6000*0.5}}},
		lightingdamage_v={{{1,6000*0.5},{10,6000*0.5}},0,{{1,6000*0.5},{10,6000*0.5}}},
		state_stun_attack={{{1,2},{10,10}},{{1,18*1},{20,18*1}}},
		state_hurt_attack={{{1,2},{10,10}},{{1,18*1},{20,18*1}}},
		state_weak_attack={{{1,2},{10,10}},{{1,18*3},{20,18*3}}},
		state_burn_attack={{{1,2},{10,10}},{{1,18*3},{20,18*3}}},
		state_slowall_attack={{{1,2},{10,10}},{{1,18*2.5},{20,18*2.5}}},
	},
	battle_seriesattack_25={ --附带5种五行效果
		appenddamage_p={{{1,0},{10,0}}},
		physicsdamage_v={{{1,6000*0.25},{10,6000*0.25}},0,{{1,6000*0.25},{10,6000*0.25}}},
		poisondamage_v={{{1,600*0.25},{10,600*0.25}},{{1,9*9},{20,9*9}}},
		colddamage_v={{{1,6000*0.25},{10,6000*0.25}},0,{{1,6000*0.25},{10,6000*0.25}}},
		firedamage_v={{{1,6000*0.25},{10,6000*0.25}},0,{{1,6000*0.25},{10,6000*0.25}}},
		lightingdamage_v={{{1,6000*0.25},{10,6000*0.25}},0,{{1,6000*0.25},{10,6000*0.25}}},
		state_stun_attack={{{1,2},{10,20}},{{1,18*1},{20,18*1}}},
		state_hurt_attack={{{1,2},{10,20}},{{1,18*1},{20,18*1}}},
		state_weak_attack={{{1,2},{10,20}},{{1,18*3},{20,18*3}}},
		state_burn_attack={{{1,2},{10,20}},{{1,18*3},{20,18*3}}},
		state_slowall_attack={{{1,2},{10,20}},{{1,18*2.5},{20,18*2.5}}},
	},
	battle_tansaura={
		lifereplenish_p={{{1,100},{2,100}}},
		manareplenish_p={{{1,100},{2,100}}},
		deadlystrikeenhance_r={{{1,634},{2,634}}},
		deadlystrikedamageenhance_p={{{1,120},{2,120}}},
		defencedeadlystrikedamagetrim={{{1,120},{2,120}}},
		ignoredebuff = {{{1,32767},{10,32767}}},
		attackspeed_v={{{1,80},{10,80}}},
		castspeed_v={{{1,80},{10,80}}},
	},
	battle_dash3={	--宋金变身多段冲刺
		appenddamage_p={{{1,0},{10,0}}},
		physicsdamage_v={{{1,6000*0.67},{10,6000*0.67}},0,{{1,6000*0.67},{10,6000*0.67}}},
		poisondamage_v={{{1,600*0.67},{10,600*0.67}},{{1,9*9},{20,9*9}}},
		colddamage_v={{{1,6000*0.67},{10,6000*0.67}},0,{{1,6000*0.67},{10,6000*0.67}}},
		firedamage_v={{{1,6000*0.67},{10,6000*0.67}},0,{{1,6000*0.67},{10,6000*0.67}}},
		lightingdamage_v={{{1,6000*0.67},{10,6000*0.67}},0,{{1,6000*0.67},{10,6000*0.67}}},
		state_knock_attack={{{1,65},{10,100},{11,100}},{{1,6},{10,20},{11,21}},{{1,32},{2,32}}},
		state_fixed_attack={{{1,65},{10,100},{11,100}},{{1,18*2.5},{10,18*2.5}}},
		missile_hitcount={{{1,3},{10,10},{12,10}}},
	},
	npc_laniate={	--使目标持续掉血
		fastlifereplenish_v={{{1,-50},{2,-100}}},
	},
	npc_firewallknockback={ --火墙击退
		state_knock_attack={{{1,100},{2,100}},{{1,4},{2,4}},{{1,32},{2,32}}},
		skill_deadlystrike_r={{{1,212},{20,212}}},
	},

	npc_disguise_part_base={ --改变外观
		disguise_part_base={{{1,1},{2,2}},{{1,5},{2,5}},{{1,1},{2,1}}},
		skill_statetime={{{1,18*15*60},{2,18*15*60}}},
	},

	dispute_transmutation={ --变身技能
		domainchangeself={{{1, 3402},{4,3402},{5,3403},{8,3403},{9,3404},{12,3404},},{{1,85},{4,115},{5,85},{8,115},{9,85},{12,115}}},
		adddomainskill1={{{1,1155},{12,1155}},{{1,1},{12,12}}},
		adddomainskill2={{{1,1156},{12,1156}},{{1,1},{12,12}}},
		skill_statetime={{{1,18*60*30},{10,18*60*30},{11,18*60*30}}},
	},
	domainskill1={	--利刃冲击1155
		physicsdamage_v={
			[1]={{1,6000*0.1*0.9},{2,7000*0.1*0.9},{3,9000*0.1*0.9},{4,9500*0.1*0.9},{5,6500*0.1*0.9},{6,7500*0.1*0.9},{7,9500*0.1*0.9},{8,10750*0.1*0.9},{9,7000*0.1*0.9},{10,8000*0.1*0.9},{11,10000*0.1*0.9},{12,12000*0.1*0.9}},
			[3]={{1,6000*0.1*1.1},{2,7000*0.1*1.1},{3,9000*0.1*1.1},{4,9500*0.1*1.1},{5,6500*0.1*1.1},{6,7500*0.1*1.1},{7,9500*0.1*1.1},{8,10750*0.1*1.1},{9,7000*0.1*1.1},{10,8000*0.1*1.1},{11,10000*0.1*1.1},{12,12000*0.1*1.1}},
		},
		poisondamage_v={{{1,6000*0.1},{2,7000*0.1},{3,9000*0.1},{4,9500*0.1},{5,6500*0.1},{6,7500*0.1},{7,9500*0.1},{8,10750*0.1},{9,7000*0.1},{10,8000*0.1},{11,10000*0.1},{12,12000*0.1}},},
		colddamage_v={
			[1]={{1,6000*0.1*0.9},{2,7000*0.1*0.9},{3,9000*0.1*0.9},{4,9500*0.1*0.9},{5,6500*0.1*0.9},{6,7500*0.1*0.9},{7,9500*0.1*0.9},{8,10750*0.1*0.9},{9,7000*0.1*0.9},{10,8000*0.1*0.9},{11,10000*0.1*0.9},{12,12000*0.1*0.9}},
			[3]={{1,6000*0.1*1.1},{2,7000*0.1*1.1},{3,9000*0.1*1.1},{4,9500*0.1*1.1},{5,6500*0.1*1.1},{6,7500*0.1*1.1},{7,9500*0.1*1.1},{8,10750*0.1*1.1},{9,7000*0.1*1.1},{10,8000*0.1*1.1},{11,10000*0.1*1.1},{12,12000*0.1*1.1}},
		},
		firedamage_v={
			[1]={{1,6000*0.1*0.9},{2,7000*0.1*0.9},{3,9000*0.1*0.9},{4,9500*0.1*0.9},{5,6500*0.1*0.9},{6,7500*0.1*0.9},{7,9500*0.1*0.9},{8,10750*0.1*0.9},{9,7000*0.1*0.9},{10,8000*0.1*0.9},{11,10000*0.1*0.9},{12,12000*0.1*0.9}},
			[3]={{1,6000*0.1*1.1},{2,7000*0.1*1.1},{3,9000*0.1*1.1},{4,9500*0.1*1.1},{5,6500*0.1*1.1},{6,7500*0.1*1.1},{7,9500*0.1*1.1},{8,10750*0.1*1.1},{9,7000*0.1*1.1},{10,8000*0.1*1.1},{11,10000*0.1*1.1},{12,12000*0.1*1.1}},
		},
		lightingdamage_v={
			[1]={{1,6000*0.1*0.9},{2,7000*0.1*0.9},{3,9000*0.1*0.9},{4,9500*0.1*0.9},{5,6500*0.1*0.9},{6,7500*0.1*0.9},{7,9500*0.1*0.9},{8,10750*0.1*0.9},{9,7000*0.1*0.9},{10,8000*0.1*0.9},{11,10000*0.1*0.9},{12,12000*0.1*0.9}},
			[3]={{1,6000*0.1*1.1},{2,7000*0.1*1.1},{3,9000*0.1*1.1},{4,9500*0.1*1.1},{5,6500*0.1*1.1},{6,7500*0.1*1.1},{7,9500*0.1*1.1},{8,10750*0.1*1.1},{9,7000*0.1*1.1},{10,8000*0.1*1.1},{11,10000*0.1*1.1},{12,12000*0.1*1.1}},
		},
		skill_deadlystrike_r={{{1,215},{20,215}}},
	},
	domainskill2={	--横扫千军1156
		physicsdamage_v={
			[1]={{1,6000*0.2*0.9},{2,7000*0.2*0.9},{3,9000*0.2*0.9},{4,9500*0.2*0.9},{5,6500*0.2*0.9},{6,7500*0.2*0.9},{7,9500*0.2*0.9},{8,10750*0.2*0.9},{9,7000*0.2*0.9},{10,8000*0.2*0.9},{11,10000*0.2*0.9},{12,12000*0.2*0.9}},
			[3]={{1,6000*0.2*1.1},{2,7000*0.2*1.1},{3,9000*0.2*1.1},{4,9500*0.2*1.1},{5,6500*0.2*1.1},{6,7500*0.2*1.1},{7,9500*0.2*1.1},{8,10750*0.2*1.1},{9,7000*0.2*1.1},{10,8000*0.2*1.1},{11,10000*0.2*1.1},{12,12000*0.2*1.1}},
		},
		poisondamage_v={{{1,6000*0.2},{2,7000*0.2},{3,9000*0.2},{4,9500*0.2},{5,6500*0.2},{6,7500*0.2},{7,9500*0.2},{8,10750*0.2},{9,7000*0.2},{10,8000*0.2},{11,10000*0.2},{12,12000*0.2}},},
		colddamage_v={
			[1]={{1,6000*0.2*0.9},{2,7000*0.2*0.9},{3,9000*0.2*0.9},{4,9500*0.2*0.9},{5,6500*0.2*0.9},{6,7500*0.2*0.9},{7,9500*0.2*0.9},{8,10750*0.2*0.9},{9,7000*0.2*0.9},{10,8000*0.2*0.9},{11,10000*0.2*0.9},{12,12000*0.2*0.9}},
			[3]={{1,6000*0.2*1.1},{2,7000*0.2*1.1},{3,9000*0.2*1.1},{4,9500*0.2*1.1},{5,6500*0.2*1.1},{6,7500*0.2*1.1},{7,9500*0.2*1.1},{8,10750*0.2*1.1},{9,7000*0.2*1.1},{10,8000*0.2*1.1},{11,10000*0.2*1.1},{12,12000*0.2*1.1}},
		},
		firedamage_v={
			[1]={{1,6000*0.2*0.9},{2,7000*0.2*0.9},{3,9000*0.2*0.9},{4,9500*0.2*0.9},{5,6500*0.2*0.9},{6,7500*0.2*0.9},{7,9500*0.2*0.9},{8,10750*0.2*0.9},{9,7000*0.2*0.9},{10,8000*0.2*0.9},{11,10000*0.2*0.9},{12,12000*0.2*0.9}},
			[3]={{1,6000*0.2*1.1},{2,7000*0.2*1.1},{3,9000*0.2*1.1},{4,9500*0.2*1.1},{5,6500*0.2*1.1},{6,7500*0.2*1.1},{7,9500*0.2*1.1},{8,10750*0.2*1.1},{9,7000*0.2*1.1},{10,8000*0.2*1.1},{11,10000*0.2*1.1},{12,12000*0.2*1.1}},
		},
		lightingdamage_v={
			[1]={{1,6000*0.2*0.9},{2,7000*0.2*0.9},{3,9000*0.2*0.9},{4,9500*0.2*0.9},{5,6500*0.2*0.9},{6,7500*0.2*0.9},{7,9500*0.2*0.9},{8,10750*0.2*0.9},{9,7000*0.2*0.9},{10,8000*0.2*0.9},{11,10000*0.2*0.9},{12,12000*0.2*0.9}},
			[3]={{1,6000*0.2*1.1},{2,7000*0.2*1.1},{3,9000*0.2*1.1},{4,9500*0.2*1.1},{5,6500*0.2*1.1},{6,7500*0.2*1.1},{7,9500*0.2*1.1},{8,10750*0.2*1.1},{9,7000*0.2*1.1},{10,8000*0.2*1.1},{11,10000*0.2*1.1},{12,12000*0.2*1.1}},
		},
		skill_deadlystrike_r={{{1,215},{20,215}}},
	},
	xiakedao_toushiche={	--侠客岛投石车
		firedamage_v={
			[1]={{1,8000},{2,8000}},
			[3]={{1,8000},{2,8000}},
		},
	},
	hpandrisadd_vn={ -- 越南宋金新服buff
		damage_all_resist={{{1,30},{20,30}}},
		lifemax_v=	{{{1,400},{20,400}}},
	}
}

FightSkill:AddMagicData(tb)

local tbSkill	= FightSkill:GetClass("jy_bingdong");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};	
	local szMsg = "";
	szMsg = szMsg.."Mỗi <color=gold>"..FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime).." giây<color> khiến kẻ địch lân cận chịu trạng thái:\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	return szMsg;
end

local tbSkill	= FightSkill:GetClass("jy_deathremovestate");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};	
	local szMsg = "";
	szMsg = szMsg.."Khi trọng thương khiến kẻ địch xung quanh chịu trạng thái:\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	return szMsg;
end

local tbSkill	= FightSkill:GetClass("jy_firesnake_state");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};	
	local szMsg = "";
	szMsg = szMsg.."Mỗi <color=gold>"..FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime).." giây<color> tự thi triển kỹ năng:\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	return szMsg;
end

local tbSkill	= FightSkill:GetClass("jy_fireflower_state");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};	
	local szMsg = "";
	szMsg = szMsg.."Mỗi <color=gold>"..FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime).." giây<color> tự thi triển kỹ năng:\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	return szMsg;
end


local tbSkill	= FightSkill:GetClass("jy_hurryrun_state");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};	
	local szMsg = "";
	szMsg = szMsg.."Mỗi <color=gold>"..FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime).." giây<color> gây ra Hỏa Trận ở vị trí của bản thân\n";
	szMsg = szMsg.."Hỏa Trận sau <color=Gold>5 giây<color> sẽ nổ và tự thi triển kỹ năng:\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	return szMsg;
end

local tbSkill	= FightSkill:GetClass("boss_yuanjun");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};	
	local szMsg = "";
	szMsg = szMsg.."Mỗi giây tự thi triển trạng thái:\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	return szMsg;
end

local tbSkill	= FightSkill:GetClass("boss_xiangsi");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};	
	local szMsg = "";
	szMsg = szMsg.."Mỗi giây thi triển với đồng đội xung quanh trạng thái:\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	return szMsg;
end

local tbSkill	= FightSkill:GetClass("xoyo_wuhen");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};	
	local szMsg = "";
	szMsg = szMsg.."Sau 2 giây thi triển với đồng đội xung quanh trạng thái:\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	return szMsg;
end

local tbSkill	= FightSkill:GetClass("npc_chun");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};	
	local szMsg = "";
	szMsg = szMsg.."Tự thi triển trạng thái:\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	return szMsg;
end

local tbSkill	= FightSkill:GetClass("yinyufeifei");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};	
	local szMsg = "";
	szMsg = szMsg.."Mỗi giây nhận được trạng thái:\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	return szMsg;
end

local tbSkill	= FightSkill:GetClass("liedizhan");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};	
	local szMsg = "";
	szMsg = szMsg.."Mỗi giây nhận được trạng thái:\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	return szMsg;
end
