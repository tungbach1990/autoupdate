
FightSkill.MAGIC_INVALID		= 0;		-- 无效的魔法属性ID
FightSkill.MAGIC_VALUE_NUM		= 3;		-- 魔法属性参数个数

FightSkill.COSTTYPE_MANA		= 0;
FightSkill.COSTTYPE_STAMINA		= 1;
FightSkill.COSTTYPE_LIFE		= 2;

FightSkill.COSTTYPE_NAME =
{
	[FightSkill.COSTTYPE_MANA]		= "Nội lực",
	[FightSkill.COSTTYPE_STAMINA]	= "Thể lực",
	[FightSkill.COSTTYPE_LIFE]		= "Sinh lực",
};

FightSkill.AUTOTYPE_REPLY	= 1;
FightSkill.AUTOTYPE_ATTACK	= 2;
FightSkill.AUTOTYPE_YELLOW	= 3;
FightSkill.AUTOTYPE_RED		= 4;
FightSkill.AUTOTYPE_DEATH	= 5;
FightSkill.AUTOTYPE_TIMER	= 6;

FightSkill.AUTOTYPE_NAME =
{
	[FightSkill.AUTOTYPE_REPLY]		= "Bị tấn công",
	[FightSkill.AUTOTYPE_ATTACK]	= "Đánh chính xác",
	[FightSkill.AUTOTYPE_YELLOW]	= "Máu vàng",
	[FightSkill.AUTOTYPE_RED]		= "Máu đỏ",
	[FightSkill.AUTOTYPE_DEATH]		= "Tử vong",
	[FightSkill.AUTOTYPE_TIMER]		= "Định giờ",
};

FightSkill.NeiGong			= 1;
FightSkill.WaiGong			= 2;

FightSkill.tbAngerSkill	= {
		[0] = 281;
		[1] = 283;
		[2] = 285;
		[3] = 287;
		[4] = 289;
		[5] = 291;
	};
	
FightSkill.USESKILL_FAILED = 
		{
			emFIGHTSKILL_USEFAILED_NONE 		= 0,
			emFIGHTSKILL_USEFAILED_NOSKILL		= 1,		-- 不存在此技能
			emFIGHTSKILL_USEFAILED_NOHAVE		= 2,		-- 不拥有此技能
			emFIGHTSKILL_USEFAILED_NOTARGET		= 3,		-- 没有目标
			emFIGHTSKILL_USEFAILED_NOMANA		= 4,		-- 没有蓝
			emFIGHTSKILL_USEFAILED_FIGHTSTATEERR= 5,		-- 战斗状态不对
			emFIGHTSKILL_USEFAILED_FACTIONERR	= 6,		-- 门派不对
			emFIGHTSKILL_USEFAILED_ROUTEERR		= 7,		-- 路线不对
			emFIGHTSKILL_USEFAILED_WEAPONERR	= 8,		-- 武器不对
			emFIGHTSKILL_USEFAILED_TARGERERR	= 9,		-- 目标不对
			emFIGHTSKILL_USEFAILED_DOMAINERR	= 10,		-- 不是变身后拥有的技能
			emFIGHTSKILL_USEFAILED_RIDESTATEERR	= 11,		-- 骑马状态不对
			emFIGHTSKILL_USEFAILED_ANGERLIMIT	= 12,		-- 怒气技能限制
			emFIGHTSKILL_USEFAILED_FORBITSKILL	= 13,		-- 处于禁止释放技能
			emFIGHTSKILL_USEFAILED_FORBITMOVE	= 14,		-- 处于禁止移动
			emFIGHTSKILL_USEFAILED_CDERR		= 15,		-- CD时间未到
			emFIGHTSKILL_USEFAILED_RADIUSERR	= 16,		-- 距离太远
			emFIGHTSKILL_USEFAILED_NOSTEAL		= 17,		-- 没有可以偷取的技能，偷取失败
			emFIGHTSKILL_USEFAILED_PKVALUE		= 18,		-- PK值过高
			emFIGHTSKILL_USEFAILED_ALL			= 19,				
		};
