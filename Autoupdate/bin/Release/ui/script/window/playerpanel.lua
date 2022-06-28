
local tbPlayerPanel = Ui:GetClass("playerpanel");
local tbObject		= Ui.tbLogic.tbObject;
local tbMouse		= Ui.tbLogic.tbMouse;
local tbPreViewMgr	= Ui.tbLogic.tbPreViewMgr;
local tbTempData	= Ui.tbLogic.tbTempData;

local HISTORY_PAGE_NORMAL	= 1;
local HISTORY_PAGE_TASK		= 2;
local HISTORY_PAGE_COMBAT	= 3;

local IS_RESET_ATTRIB_TASK	= { 2, 1 };		-- 记录玩家是否洗过点的任务变量

local szOldName = "";
local szOldBlogMonicker = "";
local szOldFaction = "";
local szOldBlogTag = ""; 
local szOldLike = ""; 
local szOldBlogBlog = ""; 
local szOldDianDi = "";
local szOldCity = "";
local nOldSex = 0;
local nOldBlogBirthday = 0;
local nOldMarriageType = 0; 
local nOldOnlineTime = 0; 
local nOldFriendOnly = 0;

local PAGESET_MAIN			= "PageSetMain";			-- 主角属性左侧页表
local PAGE_BASIC			= "PageBasic";				-- 主角基础属性页
local PAGE_REPUTE			= "PageRepute";				-- 主角声望页
local PAGE_TITLE			= "PageTitle";				-- 主角称号页
local PAGE_HISTORY			= "PageHistory";			-- 主角历程页
local PAGE_EDITBLOG			= "BtnEditBlog";
local PAGE_TULINH			= "BtnTuLinh";
local PAGE_DONGHANH			= "BtnDongHanh";
local BTN_CLOSE				= "BtnClose";				-- 主窗口关闭按钮
local BTN_SWITCH			= "BtnSwitch";				-- 五行装备切换按钮
local BTN_BASIC_ASSAUTO		= "BtnBasicAssignAuto";		-- 基础属性页：潜能自动分配按钮
local BTN_BASIC_ASSOK		= "BtnBasicAssignOK";		-- 基础属性页：潜能分配确认按钮
local BTN_BASIC_ASSCANCEL	= "BtnBasicAssignCancel";	-- 基础属性页：潜能分配取消按钮
local BTN_BASIC_INCSTR		= "BtnBasicIncStr";			-- 基础属性页：力量分配递增按钮
local BTN_BASIC_DECSTR		= "BtnBasicDecStr";			-- 基础属性页：力量分配递减按钮
local BTN_BASIC_INCDEX		= "BtnBasicIncDex";			-- 基础属性页：身法分配递增按钮
local BTN_BASIC_DECDEX		= "BtnBasicDecDex";			-- 基础属性页：身法分配递减按钮
local BTN_BASIC_INCVIT		= "BtnBasicIncVit";			-- 基础属性页：外功分配递增按钮
local BTN_BASIC_DECVIT		= "BtnBasicDecVit";			-- 基础属性页：外功分配递减按钮
local BTN_BASIC_INCENG		= "BtnBasicIncEng";			-- 基础属性页：内功分配递增按钮
local BTN_BASIC_DECENG		= "BtnBasicDecEng";			-- 基础属性页：内功分配递减按钮
local BTN_SEL_PORTRAIT		= "BtnSelPortrait";			-- 基础属性页：主角头像
local IMG_PLAYER_PORTRAIT	= "ImgPortrait";			-- 基础属性页：主角头像
local IMG_BEBI	= "ImgBeBi";			-- 基础属性页：主角头像
local IMG_NHAN_CUOI	= "ImgRingWedding";			-- 基础属性页：主角头像
local IMG_TULINH_VKHI	= "ImgVKhiTuLinh";			-- 基础属性页：主角头像
local IMG_TULINH_YPHUC	= "ImgAoTuLinh";			-- 基础属性页：主角头像
local IMG_TULINH_NHAN	= "ImgNhanTuLinh";			-- 基础属性页：主角头像
local IMG_TULINH_TAY	= "ImgTayTuLinh";			-- 基础属性页：主角头像
local IMG_TULINH_PHU	= "ImgPhuTuLinh";			-- 基础属性页：主角头像
local IMG_TULINH_LIEN	= "ImgLienTuLinh";			-- 基础属性页：主角头像
local IMG_TULINH_LUNG	= "ImgLungTuLinh";			-- 基础属性页：主角头像
local IMG_TULINH_GIAY	= "ImgGiayTuLinh";			-- 基础属性页：主角头像
local IMG_TULINH_BOI	= "ImgBoiTuLinh";			-- 基础属性页：主角头像
local IMG_TULINH_MU	= "ImgMuTuLinh";			-- 基础属性页：主角头像
local IMG_PLAYER_BAOCHAUNON	= "ImgBaoChauNon";	
local IMG_PLAYER_BAOCHAUAO	= "ImgBaoChauAo";	
local IMG_PLAYER_BAOCHAULUNG	= "ImgBaoChauLung";	
local IMG_PLAYER_BAOCHAUTAY	= "ImgBaoChauTay";	
local IMG_PLAYER_BAOCHAUGIAY	= "ImgBaoChauGiay";	
local IMG_PLAYER_BAOCHAUVKHI	= "ImgBaoChauVKhi";	
local IMG_PLAYER_BAOCHAULIEN	= "ImgBaoChauLien";	
local IMG_PLAYER_BAOCHAUNHAN	= "ImgBaoChauNhan";	
local IMG_PLAYER_BAOCHAUBOI	= "ImgBaoChauBoi";	
local IMG_PLAYER_BAOCHAUPHU	= "ImgBaoChauPhu";
local BTN_ACTIVE_TITLE		= "BtnActiveTitle";			-- 称号页面：激活页面按钮
local BTN_INACTIVE_TITLE	= "BtnInactiveTitle";		-- 称号页面：取下页面按钮
local BTN_EQUIP_PAGE		= "BtnEquipPage";			-- 装备视图：换页按钮
local BTN_SWITCH_EQUIP		= "BtnSwitchEquip";			-- 装备视图：确认切换
local EDIT_BASIC_STR		= "EdtBasicStr";			-- 基础属性页：主角力量编辑框
local EDIT_BASIC_DEX		= "EdtBasicDex";			-- 基础属性页：主角身法编辑框
local EDIT_BASIC_VIT		= "EdtBasicVit";			-- 基础属性页：主角外功编辑框
local EDIT_BASIC_ENG		= "EdtBasicEng";			-- 基础属性页：主角内功编辑框
local TEXT_BASIC_NAME		= "TxtBasicName";			-- 基础属性页：主角名字
local EDIT_BASIC_NAME		= "EdtBasicName";			-- 基础属性页：主角名字
local TEXT_BEBI_LEVEL		= "TxtLevelBeBi";			-- 基础属性页：主角名字
local TEXT_TONGSKILL_TANCONG		= "TxtKyNangTC";			-- 基础属性页：主角名字
local TEXT_TONGSKILL_SINHLUC		= "TxtKyNangSL";			-- 基础属性页：主角名字
local TEXT_TONGSKILL_PHONGTHU		= "TxtKyNangPT";			-- 基础属性页：主角名字
local TEXT_TONGSKILL_NETRANH		= "TxtKyNangNT";			-- 基础属性页：主角名字
local TEXT_TONGSKILL_BOQUANT		= "TxtKyNangBQNT";			-- 基础属性页：主角名字
local TEXT_TAMPHAP_THIENTHUONG		= "TxtThienThuong";			-- 基础属性页：主角名字
local TEXT_TAMPHAP_THIENUY		= "TxtThienUy";			-- 基础属性页：主角名字
local TEXT_TAMPHAP_THIENDUNG		= "TxtThienDung";			-- 基础属性页：主角名字
local TEXT_TAMPHAP_THIENHUNG		= "TxtThienHung";			-- 基础属性页：主角名字
local TEXT_TAMPHAP_THIENMANH		= "TxtThienManh";			-- 基础属性页：主角名字
local TEXT_TAMPHAP_THIENSAT		= "TxtThienSat";			-- 基础属性页：主角名字
local TEXT_TAMPHAP_THIENCANH		= "TxtThienCanh";			-- 基础属性页：主角名字
local IMG_TAMPHAP_THIENTHUONG		= "ImgThienThuong";			-- 基础属性页：主角名字
local TEXT_TAMPHAP_DIAXICH		= "TxtDiaXich";			-- 基础属性页：主角名字
local TEXT_TAMPHAP_DIANGUY		= "TxtDiaNguy";			-- 基础属性页：主角名字
local TEXT_TAMPHAP_DIABANG		= "TxtDiaBang";			-- 基础属性页：主角名字
local TEXT_TAMPHAP_DIABICH		= "TxtDiaBich";			-- 基础属性页：主角名字
local TEXT_TAMPHAP_DIAPHUC		= "TxtDiaPhuc";			-- 基础属性页：主角名字
local TEXT_TAMPHAP_DIALINH		= "TxtDiaLinh";			-- 基础属性页：主角名字
local TEXT_TAMPHAP_DIASAT		= "TxtDiaSat";			-- 基础属性页：主角名字
local TEXT_KINHMACH_HUYET1		= "TxtKinhMachHuyet1";			-- 基础属性页：主角名字
local TEXT_KINHMACH_HUYET2		= "TxtKinhMachHuyet2";			-- 基础属性页：主角名字
local TEXT_KINHMACH_HUYET3		= "TxtKinhMachHuyet3";			-- 基础属性页：主角名字
local TEXT_KINHMACH_HUYET4		= "TxtKinhMachHuyet4";			-- 基础属性页：主角名字
local TEXT_KINHMACH_HUYET5		= "TxtKinhMachHuyet5";			-- 基础属性页：主角名字
local TEXT_KINHMACH_HUYET6		= "TxtKinhMachHuyet6";			-- 基础属性页：主角名字
local TEXT_KINHMACH_HUYET7		= "TxtKinhMachHuyet7";			-- 基础属性页：主角名字
local TEXT_KINHMACH_HUYET8		= "TxtKinhMachHuyet8";			-- 基础属性页：主角名字
local TEXT_KINHMACH_HUYET9		= "TxtKinhMachHuyet9";			-- 基础属性页：主角名字
local TEXT_KINHMACH_HUYET10		= "TxtKinhMachHuyet10";			-- 基础属性页：主角名字
local TEXT_KINHMACH_HUYET11		= "TxtKinhMachHuyet11";			-- 基础属性页：主角名字
local TEXT_KINHMACH_HUYET12		= "TxtKinhMachHuyet12";			-- 基础属性页：主角名字
local TEXT_KINHMACH_HUYET13		= "TxtKinhMachHuyet13";			-- 基础属性页：主角名字
local TEXT_KINHMACH_HUYET14		= "TxtKinhMachHuyet14";			-- 基础属性页：主角名字
local TEXT_KINHMACH_HUYET15		= "TxtKinhMachHuyet15";			-- 基础属性页：主角名字
local TEXT_TULINH_LEVEL		= "TxtInfoCapTLinh";			-- 基础属性页：主角名字
local TEXT_BASIC_SERIES		= "TxtBasicSeries";			-- 基础属性页：主角五行
local TEXT_BASIC_LEVEL		= "TxtBasicLevel";			-- 基础属性页：主角等级
local TEXT_BASIC_FACTION	= "TxtBasicFaction";		-- 基础属性页：主角门派
local TEXT_BASIC_PKVALUE	= "TxtBasicPKValue";		-- 基础属性页：主角恶名值
local TEXT_BASIC_EXP		= "TxtBasicExp";			-- 基础属性页：主角经验值
local TEXT_BASIC_LIFE		= "TxtBasicLife";			-- 基础属性页：主角生命值
local TEXT_BASIC_MANA		= "TxtBasicMana";			-- 基础属性页：主角内力值
local TEXT_BASIC_STAMINA	= "TxtBasicStamina";		-- 基础属性页：主角体力值
local TEXT_BASIC_GTP		= "TxtBasicGTP";			-- 基础属性页：主角活力值
local TEXT_BASIC_MKP		= "TxtBasicMKP";			-- 基础属性页：主角精力值
local TEXT_BASIC_GR			= "TxtBasicGeneralResist";	-- 基础属性页：主角普防值
local TEXT_BASIC_PR			= "TxtBasicPoisonResist";	-- 基础属性页：主角毒防值
local TEXT_BASIC_CR			= "TxtBasicColdResist";		-- 基础属性页：主角冰防值
local TEXT_BASIC_FR			= "TxtBasicFireResist";		-- 基础属性页：主角火防值
local TEXT_BASIC_LR			= "TxtBasicLightResist";	-- 基础属性页：主角雷防值
local TEXT_BASIC_LDAMAGE	= "TxtBasicLeftDamage";		-- 基础属性页：主角左键攻击
local TEXT_BASIC_RDAMAGE	= "TxtBasicRightDamage";	-- 基础属性页：主角右键攻击
local TEXT_BASIC_AR			= "TxtBasicAttackRate";		-- 基础属性页：主角命中率
local TEXT_BASIC_AS			= "TxtBasicAttackSpeed";	-- 基础属性页：主角攻击速度
local TEXT_BASIC_DEFENSE	= "TxtBasicDefense";		-- 基础属性页：主角闪避率
local TEXT_BASIC_RUNSPEED	= "TxtBasicRunSpeed";		-- 基础属性页：主角跑动速度
local TEXT_BASIC_STR		= "TxtBasicStrength";		-- 基础属性页：主角力量值
local TEXT_BASIC_DEX		= "TxtBasicDexterity";		-- 基础属性页：主角身法值
local TEXT_BASIC_VIT		= "TxtBasicVitality";		-- 基础属性页：主角外功值
local TEXT_BASIC_ENG		= "TxtBasicEnergy";			-- 基础属性页：主角内功值
local TEXT_BASIC_REMAIN		= "TxtBasicRemain";			-- 基础属性页：主角剩余潜能点
local TEXT_REPUTE_NAME		= "TxtReputeName";			-- 声望页面：主角名字
local TEXT_TITLE_NAME		= "TxtTitleName";			-- 称号页面：主角名字
local TEXT_TITLE_DESCRIBE	= "TxtDescribeTitle";		-- 称号页面：称号描述
local TEXT_HISTROY_NAME		= "TxtHistroyName";			-- 历程页面：主角名字
local TEXT_HISTROY			= "TxtHistroy";
local BTN_HONOR 			= "BtnHistory";				-- 荣誉界面
local OUTLOOK_REPUTE		= "OutLookRepute";			-- 声望界面：声望列表
local OUTLOOK_TITLE 		= "OutLookTitle";			-- 称号页面：称号列表
local OUTLOOK_HISTORY		= "OutLookHistory";			-- 荣誉界面：荣誉列表
local OBJ_EQUIP_PREVIEW		= "ObjPreview";
local OBJ_EQUIP_PREVIEW1		= "ObjPreview1";
local BTN_BLOGCLOSE			= "BtnEditBlogCancel";
local BTN_FIGHTPOWER		= "BtnFightPower";          -- 战斗力界面
local IMG_PLAYER_TIEUBAOBOI	= "ImgTieuBaoBoi";		
local IMG_PLAYER_LVTIEUBAOBOI	= "ImgLvTieuBaoBoi";		
local TEXT_TIEUBAOBOI_OPT		= "TxtOptTieuBaoBoi";			-- 声望页面：主角名字

local MARRIAGE_TYPE = {"Độc thân", "Đã kết hôn"};
local SEX_TYPE		= {"Nam", "Nữ"};
local SERIES_NAME	= {"Kim", "Mộc", "Thủy", "Hỏa", "Thổ"};

local YEAR={
"2008",
"2007",
"2006",
"2005",
"2004",
"2003",
"2002",
"2001",
"2000",
"1999",
"1998",
"1997",
"1996",
"1995",
"1994",
"1993",
"1992",
"1991",
"1990",
"1989",
"1988",
"1987",
"1986",
"1985",
"1984",
"1983",
"1982",
"1981",
"1980",
"Trước 80"
};

local MONTH={
"1",
"2",
"3",
"4",
"5",
"6",
"7",
"8",
"9",
"10",
"11",
"12"
};

local DAY={
"1",
"2",
"3",
"4",
"5",
"6",
"7",
"8",
"9",
"10",
"11",
"12",
"13",
"14",
"15",
"16",
"17",
"18",
"19",
"20",
"21",
"22",
"23",
"24",
"25",
"26",
"27",
"28",
"29",
"30",
"31"
};

local EDT_EDITBLOGNAME				= "EdtEditBlogName";
local EDT_EDITBLOGMONICKER		= "EdtEditBlogMonicker";
local EDT_EDITBLOGOCCUPATION	= "EdtEditBlogOccupation";
local CMB_EDITBLOGSEX					= "ComboBoxEdtEditBlogSex";
local EDT_EDITBLOGTAG					= "EdtEditBlogTag";
local BTN_EDITBLOGFRIENDONLY	= "BtnEditBlogFriendOnly";
local EDT_EDITBLOGBIRTHDAY		= "EdtEditBlogBirthday";
local EDT_EDITBLOGCITY				= "EdtEditBlogCity";
local CMB_EDITBLOGMARRIAGE		= "ComboBoxFatherEditBlog";
local EDT_EDITBLOGLIKE				= "EdtEditBlogLike";
local BTN_EDITBLOGEditBLOG		= "BtnEditBlogEditBlog";
local EDT_EDITBLOGEditBLOG		= "EdtEditBlogEditBlog";
local EDT_EDITBLOGDIANDI			= "EdtEditBlogDianDi";
local BTN_EDITBLOGLINGCHEN		= "BtnEditBlogLingchen";
local BTN_EDITBLOGSHANGWU			= "BtnEditBlogShangwu";
local BTN_EDITBLOGZHONGWU			= "BtnEditBlogZhongwu";
local BTN_EDITBLOGXIAWU			  = "BtnEditBlogXiawu";
local BTN_EDITBLOGWANSHANG		= "BtnEditBlogWanshang";
local BTN_EDITBLOGWUYE			  = "BtnEditBlogWuye";
local	BTN_EDITBLOGSAVE				= "BtnEditBlogSave";
local	CMB_YEAR								= "ComboBoxYearEditBlog";
local	CMB_MONTH								= "ComboBoxMonthEditBlog";
local	CMB_DATE								= "ComboBoxDateEditBlog";


local SELF_EQUIPMENT = 			-- 装备控件表
{
	{ Item.EQUIPPOS_HEAD,		"ObjHead",		"ImgHead"		},
	{ Item.EQUIPPOS_BODY,		"ObjBody",		"ImgBody"		},
	{ Item.EQUIPPOS_BELT,		"ObjBelt",		"ImgBelt"		},
	{ Item.EQUIPPOS_WEAPON,		"ObjWeapon",	"ImgWeapon"		},
	{ Item.EQUIPPOS_FOOT,		"ObjFoot",		"ImgFoot"		},
	{ Item.EQUIPPOS_CUFF,		"ObjCuff",		"ImgCuff"		},
	{ Item.EQUIPPOS_AMULET,		"ObjAmulet",	"ImgAmulet"		},
	{ Item.EQUIPPOS_RING,		"ObjRing",		"ImgRing"		},
	{ Item.EQUIPPOS_NECKLACE,	"ObjNecklace",	"ImgNecklace"	},
	{ Item.EQUIPPOS_PENDANT,	"ObjPendant",	"ImgPendant"	},
	{ Item.EQUIPPOS_HORSE,		"ObjHorse",		"ImgHorse"		},
	{ Item.EQUIPPOS_MASK,		"ObjMask",		"ImgMask"		},
	{ Item.EQUIPPOS_BOOK,		"ObjBook",		"ImgBook"		},
	{ Item.EQUIPPOS_ZHEN,		"ObjZhen",		"ImgZhen"		},
	{ Item.EQUIPPOS_SIGNET, 	"ObjSignet", 	"ImgSignet"		},
	{ Item.EQUIPPOS_MANTLE,		"ObjMantle",	"ImgMantle"		},
	{ Item.EQUIPPOS_CHOP,		"ObjChop", 		"ImgChop"		},
	{ Item.EQUIPPOS_ZHENYUAN_MAIN, "ObjZhenYuanMain", "ImgZhenYuanMain" },
	{ Item.EQUIPPOS_ZHENYUAN_SUB1, "ObjZhenYuanSub1", "ImgZhenYuanSub1" },
	{ Item.EQUIPPOS_ZHENYUAN_SUB2, "ObjZhenYuanSub2", "ImgZhenYuanSub2" },
	{ Item.EQUIPPOS_GARMENT,	"ObjGarment", 	"ImgGarment"	},
	{ Item.EQUIPPOS_OUTHAT,		"ObjOutHat",	"ImgOutHat"		},
};

local SELF_SWITCHABLE_EQUIP =
{
	{ Item.EQUIPEXPOS_HEAD,		"ObjHead",		"ImgHead"		},
	{ Item.EQUIPEXPOS_BODY,		"ObjBody",		"ImgBody"		},
	{ Item.EQUIPEXPOS_BELT,		"ObjBelt",		"ImgBelt"		},
	{ Item.EQUIPEXPOS_WEAPON,	"ObjWeapon",	"ImgWeapon"		},
	{ Item.EQUIPEXPOS_FOOT,		"ObjFoot",		"ImgFoot"		},
	{ Item.EQUIPEXPOS_CUFF,		"ObjCuff",		"ImgCuff"		},
	{ Item.EQUIPEXPOS_AMULET,	"ObjAmulet",	"ImgAmulet"		},
	{ Item.EQUIPEXPOS_RING,		"ObjRing",		"ImgRing"		},
	{ Item.EQUIPEXPOS_NECKLACE,	"ObjNecklace",	"ImgNecklace"	},
	{ Item.EQUIPEXPOS_PENDANT,	"ObjPendant",	"ImgPendant"	},
};

local ATTRIB_EDIT_TABLE =
{
	[Player.ATTRIB_STR] = EDIT_BASIC_STR,
	[Player.ATTRIB_DEX] = EDIT_BASIC_DEX,
	[Player.ATTRIB_VIT] = EDIT_BASIC_VIT,
	[Player.ATTRIB_ENG] = EDIT_BASIC_ENG,
};


function tbPlayerPanel:Init()
	self.nRemain				= 0;						-- 显示剩余潜能点数（加点期间和实际点数可能不同）
	self.tbReputeSetting		= nil;
	self.tbTitleTable			= {};						-- 称号列表
	self.tbHonorData			= {};
	self.nSelTitleIndex			= 0;						-- 所选称号索引
	self.nShowEquipEx			= 0;						-- 当前显示装备
	self.nCurHistroyPage		= HISTORY_PAGE_NORMAL;
	self.tbDeltaAttrib 			=							-- 该表记录加点差值
	{
		[Player.ATTRIB_STR]		= 0,						-- 本次所加力量点数
		[Player.ATTRIB_DEX]		= 0,						-- 本次所加身法点数
		[Player.ATTRIB_VIT]		= 0,						-- 本次所加外功点数
		[Player.ATTRIB_ENG]		= 0, 						-- 本次所加内功点数
	};
	
end

function tbPlayerPanel:OnCreate()
	self.tbEquipCont = {};
	for _, tb in ipairs(SELF_EQUIPMENT) do
		local nPos = tb[1];
		self.tbEquipCont[nPos] = tbObject:RegisterContainer(
			self.UIGROUP,
			tb[2],
			1,
			1,
			{ nOffsetX = nPos },
			"equiproom"
		);
	end
	self.tbObjPreView = {};
	self.tbObjPreView = tbObject:RegisterContainer(self.UIGROUP, OBJ_EQUIP_PREVIEW);
	self.tbObjPreView1 = {};
	self.tbObjPreView1 = tbObject:RegisterContainer(self.UIGROUP, OBJ_EQUIP_PREVIEW1);
	self.nCurMarriageTypeCmbIndex = 0;
	self.nCurSexCmbIndex = 0;
	self.nCurYearCmbIndex = 0;
	self.nCurMonthCmbIndex = 0;
	self.nCurDayCmbIndex = 0;
end

function tbPlayerPanel:OnDestroy()
	for _, tbCont in pairs(self.tbEquipCont) do
		tbObject:UnregContainer(tbCont);
	end
	
	tbObject:UnregContainer(self.tbObjPreView);
	tbObject:UnregContainer(self.tbObjPreView1);
end

function tbPlayerPanel:WriteStatLog()
	Log:Ui_SendLog("Giao diện nhân vật F1", 1);
end

function tbPlayerPanel:OnOpen()
	self.tbReputeSetting = KPlayer.GetReputeInfo();		-- 获得声望配置信息
	self:WriteStatLog();
	UiManager:CloseWindow(Ui.UI_SERIESSWITCH);
	self:SetShowEquipState();
	Ui(Ui.UI_SIDEBAR):WndOpenCloseCallback(self.UIGROUP, 1);
	

	self.nRemain = me.nRemainPotential;					-- 获得实际剩余潜能点数

	self:OnUpdatePageBasic();
	self:OnUpdatePageRepute();
	self:OnUpdatePageTitle();
	self:OnUpdatePageHistory();
	self:UpdateEquipment();

	PgSet_ActivePage(self.UIGROUP, PAGESET_MAIN, PAGE_BASIC);	-- 设置首页
	self:OnUpdatePreView();
	self:OnUpdatePreView1();
	self:UpdateEquipDur();
end

function tbPlayerPanel:OnClose()
	for _, tbCont in pairs(self.tbEquipCont) do
		tbCont:ClearRoom();
	end
	Ui(Ui.UI_SIDEBAR):WndOpenCloseCallback(self.UIGROUP, 0);
	OnSelPortrait(0);            -- 参数 1 打开头像选择界面, 0 为关闭选择界面
end

function tbPlayerPanel:OnSyncItem(nRoom,nX,nY)
	if (UiManager:WindowVisible(self.UIGROUP) ~= 1) then
		return;
	end
	self:OnUpdatePreView();
	self:OnUpdatePreView1();
end

function tbPlayerPanel:OnUpdatePreView()
	self.tbObjPreView:ClearObj();
	local tbPart = tbPreViewMgr:GetSelfPart();
	local nSex = me.nSex;
	local tbObj = {};
	tbObj.nType = Ui.OBJ_NPCRES;
	tbObj.nTemplateId = (nSex == 0) and -1 or -2;
	tbObj.nAction = Npc.ACT_FIGHTSTAND;
	tbObj.tbPart = tbPart;
	tbObj.nDir = 0;
	tbObj.bRideHorse = 0;
	self.tbObjPreView:SetObj(tbObj);	
end
function tbPlayerPanel:OnUpdatePreView1()
	self.tbObjPreView1:ClearObj();
	local tbPart = tbPreViewMgr:GetSelfPart();
	local nSex = me.nSex;
	local tbObj = {};
	tbObj.nType = Ui.OBJ_NPCRES;
	tbObj.nTemplateId = (nSex == 0) and -1 or -2;
	tbObj.nAction = Npc.ACT_STAND2;
	tbObj.tbPart = tbPart;
	tbObj.nDir = 7;
	local pItem = me.GetEquip(Item.EQUIPPOS_HORSE);
	if pItem ~= nil then
		tbObj.bRideHorse = 1;
	else
		tbObj.bRideHorse = 0;	
	end
	self.tbObjPreView1:SetObj(tbObj);	
end

function tbPlayerPanel:OnButtonClick(szWnd, nParam)
	if (BTN_CLOSE == szWnd or BTN_BLOGCLOSE == szWnd) then		-- 关闭主窗口
		UiManager:CloseWindow(self.UIGROUP);
	elseif (BTN_SWITCH == szWnd) then		-- 五行装备切换
		self:OnSwitch();
	elseif (BTN_SEL_PORTRAIT == szWnd) then		-- 打开头像选择界面
		OnSelPortrait();	-- 参数 1 打开头像选择界面, 0 为关闭选择界面
	elseif (BTN_BASIC_ASSAUTO == szWnd) then		-- 自动分配潜能
		self:OnAutoAssign();
	elseif (BTN_BASIC_ASSOK == szWnd) then		-- 确认潜能分配
		self:OnSubmitAssign();
	elseif (BTN_BASIC_ASSCANCEL == szWnd) then		-- 取消潜能分配
		self:OnCancelAssign();
	elseif (BTN_BASIC_INCSTR == szWnd) then		-- 力量分配递增
		self:OnIncrease(Player.ATTRIB_STR);
	elseif (BTN_BASIC_DECSTR == szWnd) then		-- 力量分配递减
		self:OnDecrease(Player.ATTRIB_STR);
	elseif (BTN_BASIC_INCDEX == szWnd) then		-- 身法分配递增
		self:OnIncrease(Player.ATTRIB_DEX);
	elseif (BTN_BASIC_DECDEX == szWnd) then		-- 身法分配递减
		self:OnDecrease(Player.ATTRIB_DEX);
	elseif (BTN_BASIC_INCVIT == szWnd) then		-- 外功分配递增
		self:OnIncrease(Player.ATTRIB_VIT);
	elseif (BTN_BASIC_DECVIT == szWnd) then		-- 外功分配递减
		self:OnDecrease(Player.ATTRIB_VIT);
	elseif (BTN_BASIC_INCENG == szWnd) then		-- 内功分配递增
		self:OnIncrease(Player.ATTRIB_ENG);
	elseif (BTN_BASIC_DECENG == szWnd) then		-- 内功分配递减
		self:OnDecrease(Player.ATTRIB_ENG);
	elseif (BTN_ACTIVE_TITLE == szWnd) then		-- 激活称号
		self:OnActiveTitle();
	elseif (BTN_INACTIVE_TITLE	== szWnd) then		-- 激活称号
		self:OnInactiveTitle();
	elseif (BTN_EQUIP_PAGE == szWnd) then
		self:SwitchEquipPage()
	elseif (BTN_SWITCH_EQUIP == szWnd) then
		self:ApplySwitchEquip()
	elseif (BTN_HONOR	== szWnd) then
		self:OnRequestHonorData();
		self:OnUpdatePageHistory();
	elseif (BTN_EDITBLOGEditBLOG == szWnd) then
		local tbBlogMsg = {};
		tbBlogMsg.szMsg = "Nhắc: Trình duyệt của bạn sẽ tự đăng nhập trang này, cẩn thận với virus Trojan!";
		tbBlogMsg.nOptCount = 2;
		local blogUrl = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGEditBLOG);
		function tbBlogMsg:Callback(nOptIndex, szUrl)
			if (nOptIndex == 2) then
				ShellExecute(szUrl);
			end
		end		
		if (blogUrl ~= nil and blogUrl ~= "") then
			UiManager:OpenWindow(Ui.UI_MSGBOX, tbBlogMsg, blogUrl);
		end
	elseif (PAGE_EDITBLOG == szWnd) then
		UiManager.bEditBlogState = 1;
		PProfile:Require(me.szName);
	elseif (PAGE_KINHMACH == szWnd) then
		UiManager.bEditBlogState = 1;
		PProfile:Require(me.szName);	
	elseif (BTN_EDITBLOGSAVE == szWnd) then
	
		local szName = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGNAME);
	 	local szBlogMonicker = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGMONICKER);
		local szFaction = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGOCCUPATION);
		local szCity = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGCITY);
		local szBlogTag = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGTAG);
		local szLike = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGLIKE);
		local szBlogBlog = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGEditBLOG);
		local szDianDi = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGDIANDI);
		local lingChen = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGLINGCHEN);
		local shangWu = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGSHANGWU);
		local zhongWu = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGZHONGWU);
		local xiaWu = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGXIAWU);
		local wanShang = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGWANSHANG);
		local wuYe = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGWUYE);	
		local nOnlineTime = KPProfile.BoolOffset(lingChen, shangWu, zhongWu, xiaWu, wanShang, wuYe);
		if (szName ~= nil and szName ~= "" and
				szBlogMonicker ~= nil and szBlogMonicker ~= "" and
				szFaction ~= nil and szFaction ~= "" and
				szCity ~= nil and szCity ~= "" and
				szBlogTag ~= nil and szBlogTag ~= "" and
				szLike ~= nil and szLike ~= "" and szLike ~= "(Hãy ghi sở thích của bạn!)" and
				szBlogBlog ~= nil and szBlogBlog ~= ""  and
				szDianDi ~= nil and szDianDi ~= "" and szDianDi ~= string.format("Nhắc nhở: Lần đầu điền thông tin sẽ nhận được 100 %s khóa!", IVER_g_szCoinName) and
				nOnlineTime ~= nil and nOnlineTime ~= 0) then	
			
			self:ApplyAllBlogInfo();
		else
			local tbApplyMsg = {};
			tbApplyMsg.szMsg = "Nội dung không đúng, không lưu được.";	
			tbApplyMsg.nOptCount = 1;
			UiManager:OpenWindow(Ui.UI_MSGBOX, tbApplyMsg);		
		end	
    elseif (BTN_FIGHTPOWER == szWnd) then
		Ui:ServerCall("UI_TASKTIPS", "Begin", "Hệ thống sức chiến đấu chưa mở, xin hãy đợi");
	end	
end

function tbPlayerPanel:OnEditSubmit(szWnd)
	if		(EDIT_BASIC_STR	== szWnd) then
		self:OnEditKillFocus(Player.ATTRIB_STR);					-- 力量加点编辑框失去焦点
	elseif	(EDIT_BASIC_DEX	== szWnd) then
		self:OnEditKillFocus(Player.ATTRIB_DEX);					-- 身法加点编辑框失去焦点
	elseif	(EDIT_BASIC_VIT	== szWnd) then
		self:OnEditKillFocus(Player.ATTRIB_VIT);					-- 外功加点编辑框失去焦点
	elseif	(EDIT_BASIC_ENG	== szWnd) then
		self:OnEditKillFocus(Player.ATTRIB_ENG);					-- 内功加点编辑框失去焦点
	end
end

function tbPlayerPanel:OnComboBoxIndexChange(szWnd, nIndex)
	if (szWnd == CMB_EDITBLOGMARRIAGE) then
		self.nCurMarriageTypeCmbIndex = nIndex;
	end
	if (szWnd == CMB_EDITBLOGSEX) then
		self.nCurSexCmbIndex = nIndex;
	end	
	if (szWnd == CMB_YEAR) then
		self.nCurYearCmbIndex = nIndex;
	end	
	if (szWnd == CMB_MONTH) then
		self.nCurMonthCmbIndex = nIndex;
	end	
	if (szWnd == CMB_DATE) then
		self.nCurDayCmbIndex = nIndex;
	end				
end

function tbPlayerPanel:ApplyAllBlogInfo()

	local szName = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGNAME);

 	local szBlogMonicker = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGMONICKER);

	local szFaction = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGOCCUPATION);

	local szCity = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGCITY);

	local szBlogTag = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGTAG);

	local szLike = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGLIKE);
	
	local szBlogBlog = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGEditBLOG);
	
	local szDianDi = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGDIANDI);

	local nSexID = GetComboBoxItemId(self.UIGROUP, CMB_EDITBLOGSEX, self.nCurSexCmbIndex);
	nSexID = nSexID - 1;
	
	local nyear = GetComboBoxItemId(self.UIGROUP, CMB_YEAR, self.nCurYearCmbIndex) - 1;
	local nmonth = GetComboBoxItemId(self.UIGROUP, CMB_MONTH, self.nCurMonthCmbIndex) - 1;
	local nday = GetComboBoxItemId(self.UIGROUP, CMB_DATE, self.nCurDayCmbIndex) - 1;	
	local nBlogBirthday = TOOLS_MakeDate(nmonth,nday,nyear);
	
	local nMarriageType = GetComboBoxItemId(self.UIGROUP, CMB_EDITBLOGMARRIAGE, self.nCurMarriageTypeCmbIndex);
	
	local lingChen = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGLINGCHEN);
	local shangWu = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGSHANGWU);
	local zhongWu = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGZHONGWU);
	local xiaWu = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGXIAWU);
	local wanShang = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGWANSHANG);
	local wuYe = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGWUYE);	
	local nOnlineTime = KPProfile.BoolOffset(lingChen, shangWu, zhongWu, xiaWu, wanShang, wuYe);
	
	local nFriendOnly = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGFRIENDONLY);

	PProfile:EditAllInfo(nSexID,nBlogBirthday,nMarriageType,nOnlineTime,nFriendOnly,szName,szBlogMonicker,szFaction,szCity,szBlogTag,szLike,szBlogBlog,szDianDi)
end

function tbPlayerPanel:ApplyBlogInfo()

	local szName = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGNAME);
	if (szOldName ~= szName) then
		PProfile:ApplyEditStr(PProfile.emPF_BUFTASK_NAME,szName);
	end	
	
 	local szBlogMonicker = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGMONICKER);
 	if (szOldBlogMonicker ~= szBlogMonicker) then
 		PProfile:ApplyEditStr(PProfile.emPF_BUFTASK_AGNAME,szBlogMonicker);
 	end
	
	local szFaction = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGOCCUPATION);
	if (szOldFaction ~= szFaction) then
		PProfile:ApplyEditStr(PProfile.emPF_BUFTASK_PROFESSION,szFaction);
	end
	
	local szCity = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGCITY);
	if (szOldCity ~= szCity) then
		PProfile:ApplyEditStr(PProfile.emPF_BUFTASK_CITY,szCity);
	end	
	
	local szBlogTag = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGTAG);
	if (szOldBlogTag ~= szBlogTag) then
		PProfile:ApplyEditStr(PProfile.emPF_BUFTASK_TAG,szBlogTag);
	end	
	
	local szLike = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGLIKE);
	if (szOldLike ~= szLike) then
		PProfile:ApplyEditStr(PProfile.emPF_BUFTASK_FAVORITE,szLike);
	end
	
	local szBlogBlog = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGEditBLOG);
	if (szOldBlogBlog ~= szBlogBlog) then
		PProfile:ApplyEditStr(PProfile.emPF_BUFTASK_BLOGURL,szBlogBlog);
	end
	
	local szDianDi = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGDIANDI);
	if (szOldDianDi ~= szDianDi) then 
		PProfile:ApplyEditStr(PProfile.emPF_BUFTASK_COMMENT,szDianDi);	
	end	

	local nSexID = GetComboBoxItemId(self.UIGROUP, CMB_EDITBLOGSEX, self.nCurSexCmbIndex);
	nSexID = nSexID - 1;
	if (nOldSex ~= nSexID) then
		PProfile:ApplyEditInt(PProfile.emPF_TASK_SEX, nSexID);
	end	
	
	local nyear = GetComboBoxItemId(self.UIGROUP, CMB_YEAR, self.nCurYearCmbIndex) - 1;
	local nmonth = GetComboBoxItemId(self.UIGROUP, CMB_MONTH, self.nCurMonthCmbIndex) - 1;
	local nday = GetComboBoxItemId(self.UIGROUP, CMB_DATE, self.nCurDayCmbIndex) - 1;	
	local nBlogBirthday = TOOLS_MakeDate(nmonth,nday,nyear);
	if (nOldBlogBirthday ~= nBlogBirthday) then
		PProfile:ApplyEditInt(PProfile.emPF_TASK_BIRTHD,nBlogBirthday);
	end
	
	local nMarriageType = GetComboBoxItemId(self.UIGROUP, CMB_EDITBLOGMARRIAGE, self.nCurMarriageTypeCmbIndex);
	if (nOldMarriageType ~= nMarriageType) then
		PProfile:ApplyEditInt(PProfile.emPF_TASK_REINS,nMarriageType);
	end
	
	local lingChen = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGLINGCHEN);
	local shangWu = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGSHANGWU);
	local zhongWu = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGZHONGWU);
	local xiaWu = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGXIAWU);
	local wanShang = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGWANSHANG);
	local wuYe = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGWUYE);	
	local nOnlineTime = KPProfile.BoolOffset(lingChen, shangWu, zhongWu, xiaWu, wanShang, wuYe);
	if (nOldOnlineTime ~= nOnlineTime) then
		PProfile:ApplyEditInt(PProfile.emPF_TASK_ONLINE,nOnlineTime);
	end
	
	local nFriendOnly = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGFRIENDONLY);
	if (nOldFriendOnly ~= nFriendOnly) then
		PProfile:ApplyEditInt(PProfile.emPF_TASK_FRIEND_ONLY,nFriendOnly);	
	end
end

function tbPlayerPanel:OnUpdatePageAllBlog(RealName,NickName,Profession,Tip,Favor,blog,diary,city,sex,birth,love,online,friendonly,first)
		if (UiManager.bEditBlogState == 1) then
		self:OnUpdatePageEditBlog(RealName,NickName,Profession,Tip,Favor,blog,diary,city,sex,birth,love,online,friendonly,first);
	end
end

function tbPlayerPanel:OnUpdatePageEditBlog(szName, szBlogMonicker, szFaction, szBlogTag, szLike, szBlogBlog, szDianDi, szCity, nSex, nBlogBirthday, nMarriageType, nOnlineTime, nFriendOnly, nProfileVersion)

	szOldName = szName;
	szOldBlogMonicker = szBlogMonicker;
	szOldFaction = szFaction;
	szOldBlogTag = szBlogTag; 
	szOldLike = szLike; 
	szOldBlogBlog = szBlogBlog; 
	szOldDianDi = szDianDi;
	szOldCity = szCity;
	nOldSex = nSex;
	nOldBlogBirthday = nBlogBirthday;
	nOldMarriageType = nMarriageType; 
	nOldOnlineTime = nOnlineTime; 
	nOldFriendOnly = nFriendOnly;

	Edt_SetTxt(self.UIGROUP, EDT_EDITBLOGNAME, szName);
	
	Edt_SetTxt(self.UIGROUP, EDT_EDITBLOGMONICKER, szBlogMonicker);		

	Edt_SetTxt(self.UIGROUP, EDT_EDITBLOGOCCUPATION, szFaction);	
	
	ClearComboBoxItem(self.UIGROUP, CMB_EDITBLOGSEX);	
	for i = 1, #SEX_TYPE do
		ComboBoxAddItem(self.UIGROUP, CMB_EDITBLOGSEX, i, SEX_TYPE[i]);
	end
	local nSexIdx = nSex;
	if (nSexIdx >= 0 and nSexIdx <= (#SEX_TYPE - 1)) then
		ComboBoxSelectItem(self.UIGROUP, CMB_EDITBLOGSEX, nSexIdx);
	else
		ComboBoxSelectItem(self.UIGROUP, CMB_EDITBLOGSEX, 0);
	end			
	
	Edt_SetTxt(self.UIGROUP, EDT_EDITBLOGTAG, szBlogTag);	

	local bCanSee = nFriendOnly;
	if ( bCanSee == 1 ) then
		Btn_Check(self.UIGROUP, BTN_EDITBLOGFRIENDONLY, 1);
	else
		Btn_Check(self.UIGROUP, BTN_EDITBLOGFRIENDONLY, 0);
	end
	Wnd_SetTip(self.UIGROUP, BTN_EDITBLOGFRIENDONLY,"Chọn mục này, chỉ có hảo hữu mới đọc được tin của bạn.");
	
	
	ClearComboBoxItem(self.UIGROUP, CMB_YEAR);	
	for iyear = 1, #YEAR do
		ComboBoxAddItem(self.UIGROUP, CMB_YEAR, iyear, YEAR[iyear]);
	end
	
	ClearComboBoxItem(self.UIGROUP, CMB_MONTH);	
	for imonth = 1, #MONTH do
		ComboBoxAddItem(self.UIGROUP, CMB_MONTH, imonth, MONTH[imonth]);
	end	
	
	ClearComboBoxItem(self.UIGROUP, CMB_DATE);	
	for iday = 1, #DAY do
		ComboBoxAddItem(self.UIGROUP, CMB_DATE, iday, DAY[iday]);
	end		
	local nmonth = 0;
	local nday = 0;
	local nyear = 0;
	nmonth, nday, nyear = TOOLS_SpliteDate(nBlogBirthday);
	if (nyear >= 0 and nyear <= (#YEAR - 1)) then
		ComboBoxSelectItem(self.UIGROUP, CMB_YEAR, nyear);
	end
	if (nmonth >= 0 and nmonth <= (#MONTH - 1)) then
		ComboBoxSelectItem(self.UIGROUP, CMB_MONTH, nmonth);
	end
	if (nday >= 0 and nday <= (#DAY - 1)) then
		ComboBoxSelectItem(self.UIGROUP, CMB_DATE, nday);
	end	
	
	Edt_SetTxt(self.UIGROUP, EDT_EDITBLOGCITY, szCity);	
	
	ClearComboBoxItem(self.UIGROUP, CMB_EDITBLOGMARRIAGE);	
	for i = 1, #MARRIAGE_TYPE do
		ComboBoxAddItem(self.UIGROUP, CMB_EDITBLOGMARRIAGE, i, MARRIAGE_TYPE[i]);
	end
	local lmt = nMarriageType - 1;
	if (lmt >= 0 and lmt <= (#MARRIAGE_TYPE - 1)) then
		ComboBoxSelectItem(self.UIGROUP, CMB_EDITBLOGMARRIAGE, lmt);
	else
		ComboBoxSelectItem(self.UIGROUP, CMB_EDITBLOGMARRIAGE, 0);
	end		
	
	local like = szLike;
	if (like == "") then
		Edt_SetTxt(self.UIGROUP, EDT_EDITBLOGLIKE, "(Hãy ghi sở thích của bạn!)");
	else
		Edt_SetTxt(self.UIGROUP, EDT_EDITBLOGLIKE, like);	
	end	
		
	Edt_SetTxt(self.UIGROUP, EDT_EDITBLOGEditBLOG, szBlogBlog);	
	if (szBlogBlog == "") then
		Wnd_SetEnable(self.UIGROUP, BTN_EDITBLOGEditBLOG, 0);
	else
		Wnd_SetEnable(self.UIGROUP, BTN_EDITBLOGEditBLOG, 1);
	end 		
		
	local dianDI = szDianDi;
	if (dianDI == "") then
		Edt_SetTxt(self.UIGROUP, EDT_EDITBLOGDIANDI, string.format("Nhắc nhở: Lần đầu điền thông tin sẽ nhận được 100 %s khóa!", IVER_g_szCoinName));
	else
		Edt_SetTxt(self.UIGROUP, EDT_EDITBLOGDIANDI, dianDI);
	end	
	
	local lingChen = 0;
	local shangWu = 0;
	local zhongWu = 0;
	local xiaWu = 0;
	local wanShang = 0;
	local wuYe = 0;
	
	lingChen, shangWu, zhongWu, xiaWu, wanShang, wuYe = KPProfile.ValueOffset(nOnlineTime);
		
	if (lingChen == 1) then
		Btn_Check(self.UIGROUP, BTN_EDITBLOGLINGCHEN, 1);
	else
		Btn_Check(self.UIGROUP, BTN_EDITBLOGLINGCHEN, 0);
	end
	
	if (shangWu == 1) then
		Btn_Check(self.UIGROUP, BTN_EDITBLOGSHANGWU, 1);
	else
		Btn_Check(self.UIGROUP, BTN_EDITBLOGSHANGWU, 0);
	end
	
	if (zhongWu == 1) then
		Btn_Check(self.UIGROUP, BTN_EDITBLOGZHONGWU, 1);
	else
		Btn_Check(self.UIGROUP, BTN_EDITBLOGZHONGWU, 0);
	end
	
	if (xiaWu == 1) then
		Btn_Check(self.UIGROUP, BTN_EDITBLOGXIAWU, 1);
	else
		Btn_Check(self.UIGROUP, BTN_EDITBLOGXIAWU, 0);
	end
	
	if (wanShang == 1) then
		Btn_Check(self.UIGROUP, BTN_EDITBLOGWANSHANG, 1);
	else
		Btn_Check(self.UIGROUP, BTN_EDITBLOGWANSHANG, 0);
	end		
	
	if (wuYe == 1) then
		Btn_Check(self.UIGROUP, BTN_EDITBLOGWUYE, 1);
	else
		Btn_Check(self.UIGROUP, BTN_EDITBLOGWUYE, 0);
	end	
		
end

function tbPlayerPanel:OnUpdatePageBasic()

	self:UpdateBasicName();
	self:UpdateBeBi();
	self:UpdateKyNangBang();
	self:UpdateTamPhap();
	self:UpdateKMachHuyet1();
	self:UpdateKMachHuyet2();
	self:UpdateKMachHuyet3();
	self:UpdateKMachHuyet4();
	self:UpdateKMachHuyet5();
	self:UpdateKMachHuyet6();
	self:UpdateKMachHuyet7();
	self:UpdateKMachHuyet8();
	self:UpdateKMachHuyet9();
	self:UpdateKMachHuyet10();
	self:UpdateKMachHuyet11();
	self:UpdateKMachHuyet12();
	self:UpdateKMachHuyet13();
	self:UpdateKMachHuyet14();
	self:UpdateKMachHuyet15();
	self:UpdateLevelTuLinh();
	self:UpdateBasicSeries();
	self:UpdateBasicLevel();
	self:UpdateBasicPortrait();
	self:UpdateTuLinhNhan();
	self:UpdateTuLinhTay();
	self:UpdateTuLinhPhu();
	self:UpdateTuLinhVKhi();
	self:UpdateTuLinhYPhuc();
	self:UpdateTuLinhLien();
	self:UpdateTuLinhLung();
	self:UpdateTuLinhGiay();
	self:UpdateTuLinhBoi();
	self:UpdateTuLinhNon();
	self:UpdateBasicBaoChauNon();
	self:UpdateBasicBaoChauAo();
	self:UpdateBasicBaoChauLung();
	self:UpdateBasicBaoChauTay();
	self:UpdateBasicBaoChauGiay();
	self:UpdateBasicBaoChauVKhi();
	self:UpdateBasicBaoChauLien();
	self:UpdateBasicBaoChauNhan();
	self:UpdateBasicBaoChauBoi();
	self:UpdateBasicBaoChauPhu();	
	self:UpdateBasicLvTieuBaoBoi();
	self:UpdateBasicTieuBaoBoi();	
	self:UpdatePlayerTieuBaoBoi();	
	self:UpdateBasicFaction();
	self:UpdateBasicPKValue();
	self:UpdateBasicExp();
	self:UpdateBasicLife();
	self:UpdateBasicMana();
	self:UpdateBasicStamina();
	self:UpdateBasicGTP();
	self:UpdateBasicMKP();
	self:UpdateBasicResist();
	self:UpdateBasicLeftDamage();
	self:UpdateBasicRightDamage();
	self:UpdateBasicAttackRate();
	self:UpdateBasicAttackSpeed();
	self:UpdateBasicDefense();
	self:UpdateBasicRunSpeed();
	self:UpdateBasicStrength();
	self:UpdateBasicDexterity();
	self:UpdateBasicVitality();
	self:UpdateBasicEnergy();
	self:UpdateBasicRemain();
	self:UpdatePrestige();

	if me.nRemainPotential > 0 then	-- 有潜能点
		self:EnableAssign();
	else
		self:DisableAssign();
	end

end

function tbPlayerPanel:GetSeriesReputeValue(tbContent, tbSet, nClass, nType, nLevel)
	local tbShowSeries	= {0, 0, 0, 0, 0};
	local nSeries		= me.nSeries;
	local tbFactionInfo = Faction:GetGerneFactionInfo(me);
	if (nSeries <= 0 or nSeries > 5) then
		local tbItemContent = {};
		tbItemContent[1] = "";
		tbItemContent[2] = tbSet[nClass][nType].szName;
		tbItemContent[3] = tbSet[nClass][nType][nLevel].szName.."["..nLevel.."]";
		if (#tbSet[nClass][nType] == nLevel) then
			tbItemContent[4] = "Cấp cao nhất";
		else
			tbItemContent[4] = me.GetReputeValue(nClass, nType, nLevel).."/"..tbSet[nClass][nType][nLevel].nLevelUp;
		end
		tbContent[#tbContent + 1] = tbItemContent;
		return;
	end

	tbShowSeries[nSeries] = 1;

	for _, nFactionId in pairs(tbFactionInfo) do
		local tbFactionInfo = KPlayer.GetFactionInfo(nFactionId);
		tbShowSeries[tbFactionInfo.nSeries] = 1;
	end

	for nSeriesType = 1, #tbShowSeries do
		if (tbShowSeries[nSeriesType] == 1) then
			local szFlag		= "";
			local tbItemContent	= {};
			local nValue		= 0;
			local nNowLevel		= 0;
			if (nSeriesType == nSeries) then	-- 当前五行声望
				nValue		= me.GetReputeValue(nClass, nType, nLevel);
				nNowLevel	= nLevel;
				szFlag		= "★";
			else
				nValue, nNowLevel = Faction:GetRepute(me, nSeriesType, nClass, nType);
				if (not nValue) then
					nValue		= 0;
					nNowLevel	= tbSet[nClass][nType].nDefLevel;
				end
			end
			if (nValue) then
				tbItemContent[1] = szFlag;
				tbItemContent[2] = tbSet[nClass][nType].szName .. "(" .. SERIES_NAME[nSeriesType] .. ")";
				tbItemContent[3] = tbSet[nClass][nType][nNowLevel].szName.."["..nNowLevel.."]";
				if (#tbSet[nClass][nType] == nNowLevel) then
					tbItemContent[4] = "Cấp cao nhất";
				else
					tbItemContent[4] = nValue.."/"..tbSet[nClass][nType][nNowLevel].nLevelUp;
				end
				tbContent[#tbContent + 1] = tbItemContent;
			end			
		end
	end 

end

function tbPlayerPanel:GetReputePanelValue()
	local tbSet			= self.tbReputeSetting;
	if (not tbSet) then
		return;
	end
	local tbResultSet	= {};
	for i = 1, #tbSet do
		tbResultSet[i]	= {};
		tbResultSet[i].szName	= tbSet[i].szName;
		local tbContent = {};
		for j = 1, #tbSet[i] do
			local nLevel = me.GetReputeLevel(i, j);
			if (nLevel) then
				if (1 == i and 1 == j) then	 	-- 义军声望
					self:GetSeriesReputeValue(tbContent, tbSet, i, j, nLevel);
				elseif (2 == i) then			-- 宋金战场
					self:GetSeriesReputeValue(tbContent, tbSet, i, j, nLevel);
				elseif (5 == i and 1 == j) then	-- 白虎堂
					self:GetSeriesReputeValue(tbContent, tbSet, i, j, nLevel);
				elseif (4 == i and 1 == j) then	-- 家族关卡
					self:GetSeriesReputeValue(tbContent, tbSet, i, j, nLevel);
				else
					local tbItemContent = {};
					tbItemContent[1] = "";
					tbItemContent[2] = tbSet[i][j].szName;
					tbItemContent[3] = tbSet[i][j][nLevel].szName.."["..nLevel.."]";
					if (#tbSet[i][j] == nLevel) then
						tbItemContent[4] = "Cấp cao nhất";
					else
						tbItemContent[4] = me.GetReputeValue(i, j, nLevel).."/"..tbSet[i][j][nLevel].nLevelUp;
					end
					tbContent[#tbContent + 1] = tbItemContent;
				end
			end
		end
		tbResultSet[i].tbContent = tbContent;
	end
	return tbResultSet;
end

function tbPlayerPanel:OnUpdatePageRepute()
	self:UpdateReputeName();
	local tbSet = self:GetReputePanelValue();
	if (not tbSet) then
		return;
	end
	OutLookPanelClearAll(self.UIGROUP, OUTLOOK_REPUTE);
	AddOutLookPanelColumnHeader(self.UIGROUP, OUTLOOK_REPUTE, "");
	AddOutLookPanelColumnHeader(self.UIGROUP, OUTLOOK_REPUTE, "");
	AddOutLookPanelColumnHeader(self.UIGROUP, OUTLOOK_REPUTE, "");
	AddOutLookPanelColumnHeader(self.UIGROUP, OUTLOOK_REPUTE, "");
	SetOutLookHeaderWidth(self.UIGROUP, OUTLOOK_REPUTE, 0, 20);
	SetOutLookHeaderWidth(self.UIGROUP, OUTLOOK_REPUTE, 1, 100);
	SetOutLookHeaderWidth(self.UIGROUP, OUTLOOK_REPUTE, 2, UiManager.IVER_nPlayerPanelRepute);
	SetOutLookHeaderWidth(self.UIGROUP, OUTLOOK_REPUTE, 3, 100);

	for i = 1, #tbSet do
		AddOutLookGroup(self.UIGROUP, OUTLOOK_REPUTE, tbSet[i].szName);
		local tbContent = tbSet[i].tbContent;
		for j = 1, #tbContent do
			local nRet = AddOutLookItem(self.UIGROUP, OUTLOOK_REPUTE, i - 1, tbContent[j]);
		end
		if i ~= 1 then
			SetGroupCollapseState(self.UIGROUP, OUTLOOK_REPUTE, i - 1, 0);
		end
	end

	Wnd_SetEnable(self.UIGROUP, BTN_ACTIVE_TITLE,	0);
	Wnd_SetEnable(self.UIGROUP, BTN_INACTIVE_TITLE,	0);

end

function tbPlayerPanel:OnUpdatePageTitle()
	self:UpdateTitleName();
	self:UpdatePlayerTitleInfo();
	self:UpdateTitleOutLook();
	
	Wnd_SetEnable(self.UIGROUP, BTN_ACTIVE_TITLE,	0);
	Wnd_SetEnable(self.UIGROUP, BTN_INACTIVE_TITLE,	0);
end

function tbPlayerPanel:OnHonorRefresh()
	self.tbHonorData = PlayerHonor.tbPlayerHonorData.tbHonorData;
	self:OnUpdatePageHistory();
end

function tbPlayerPanel:OnRequestHonorData()
	PlayerHonor:ApplyHonorData(me);
	self.tbHonorData = PlayerHonor.tbPlayerHonorData.tbHonorData;
end

function tbPlayerPanel:OnUpdatePageHistory()
	local tbHonorSettings = self.tbHonorData;
	Txt_SetTxt(self.UIGROUP, TEXT_HISTROY_NAME, me.szName);

	OutLookPanelClearAll(self.UIGROUP, OUTLOOK_HISTORY);
	AddOutLookPanelColumnHeader(self.UIGROUP, OUTLOOK_HISTORY, "");
	AddOutLookPanelColumnHeader(self.UIGROUP, OUTLOOK_HISTORY, "");
	AddOutLookPanelColumnHeader(self.UIGROUP, OUTLOOK_HISTORY, "");
	AddOutLookPanelColumnHeader(self.UIGROUP, OUTLOOK_HISTORY, "");
	SetOutLookHeaderWidth(self.UIGROUP, OUTLOOK_HISTORY, 0, 100);
	SetOutLookHeaderWidth(self.UIGROUP, OUTLOOK_HISTORY, 1, 60);
	SetOutLookHeaderWidth(self.UIGROUP, OUTLOOK_HISTORY, 2, 65);
	SetOutLookHeaderWidth(self.UIGROUP, OUTLOOK_HISTORY, 3, 40);	

	for nClass, tbSubList in ipairs(tbHonorSettings) do
		AddOutLookGroup(self.UIGROUP, OUTLOOK_HISTORY, tbSubList.szName);
		if (tbSubList.tbHonorSubList and #tbSubList.tbHonorSubList > 0) then
			for nType, tbHonor in ipairs(tbSubList.tbHonorSubList) do
				local nValue	= tbHonor.nValue;
				local szValue	= string.format("%d điểm", nValue);
				local nRank		= tbHonor.nRank;
				local nLevel	= tbHonor.nLevel;
				local szRank	= "";
				local szLevel	= "";
				if (not nRank or 0 == nRank) then
					szRank = "?";
				elseif (nRank > 0) then
					szRank = string.format("Hạng %d", nRank);
					if (nLevel > 0) then
						szLevel = string.format("cấp %d", nLevel);
					else
						szLevel	= " ";
					end
				end
				
				local nRet = AddOutLookItem(self.UIGROUP, OUTLOOK_HISTORY, nClass - 1, {tbHonor.szName, szValue, szRank, szLevel});
			end
		else
			SetGroupCollapseState(self.UIGROUP, OUTLOOK_HISTORY, nClass - 1, 0);
		end
	end
end

function tbPlayerPanel:OnSwitch()
	UiManager:OpenWindow(Ui.UI_SERIESSWITCH);
	UiManager:CloseWindow(self.UIGROUP);
end

function tbPlayerPanel:OnAutoAssign()
	self:OnCancelAssign();
	if (0 >= self.nRemain) then	-- 显示已经没有剩余潜能点了，就不允许再自动分配
		return;
	end
	local tbAssign = Player:AutoAssginPotential(me.nFaction, me.nRouteId, me.nRemainPotential);
	for i = 1, #self.tbDeltaAttrib do
		self.tbDeltaAttrib[i] = tbAssign[i];
		self.nRemain = self.nRemain - self.tbDeltaAttrib[i];
	end
	self:UpdateAttribView();
end

function tbPlayerPanel:OnSubmitAssign()
	if (me.ApplyAssignPotential(unpack(self.tbDeltaAttrib)) == 1) then
		return;
	end
	me.Msg("Tiềm năng 1 mục không thể quá 60% tổng số, cộng điểm thất bại!");
	self:OnCancelAssign();
end

function tbPlayerPanel:OnCancelAssign()
	self:EnableAssign();
end

function tbPlayerPanel:OnIncrease(nAttrib)
	if (self.nRemain <= 0) then
		return;
	end

	self.nRemain = self.nRemain - 1;
	self.tbDeltaAttrib[nAttrib] = self.tbDeltaAttrib[nAttrib] + 1;

	self:UpdateAttribView(nAttrib);
end

function tbPlayerPanel:OnDecrease(nAttrib)
	if (self.tbDeltaAttrib[nAttrib] <= 0) then
		return;
	end

	self.nRemain = self.nRemain + 1;
	self.tbDeltaAttrib[nAttrib] = self.tbDeltaAttrib[nAttrib] - 1;

	self:UpdateAttribView(nAttrib);
end

function tbPlayerPanel:OnEditKillFocus(nAttrib)
	local tbBase =
	{
		[Player.ATTRIB_STR] = me.nStrength,
		[Player.ATTRIB_DEX] = me.nDexterity,
		[Player.ATTRIB_VIT] = me.nVitality,
		[Player.ATTRIB_ENG] = me.nEnergy,
	};
	
	local tbBase2 =
	{
		[Player.ATTRIB_STR] = me.nBaseStrength,
		[Player.ATTRIB_DEX] = me.nBaseDexterity,
		[Player.ATTRIB_VIT] = me.nBaseVitality,
		[Player.ATTRIB_ENG] = me.nBaseEnergy,
	};	

	local nValue = Edt_GetInt(self.UIGROUP, ATTRIB_EDIT_TABLE[nAttrib]) - tbBase[nAttrib];
	local nOld = self.tbDeltaAttrib[nAttrib];

	nValue = math.max(nValue, 0);
	nValue = math.min(nValue, self.nRemain + self.tbDeltaAttrib[nAttrib]);

	nValue = math.min(nValue, math.floor((me.nRemainPotential + me.nBaseStrength + me.nBaseDexterity + me.nBaseVitality + me.nBaseEnergy)*0.6) - tbBase2[nAttrib]);
	local nDetValue	= nValue - self.tbDeltaAttrib[nAttrib];
	
	self.nRemain = self.nRemain - nDetValue;
	self.tbDeltaAttrib[nAttrib] = nValue;

	self:UpdateAttribView(nAttrib);
end

function tbPlayerPanel:OnSyncDamage()
	self:UpdateBasicLeftDamage();
	self:UpdateBasicRightDamage();
end

function tbPlayerPanel:OnSyncPotential()
	self:UpdateBasicStrength();
	self:UpdateBasicDexterity();
	self:UpdateBasicVitality();
	self:UpdateBasicEnergy();
end

function tbPlayerPanel:OnSyncRemainPotential()
	if (me.nRemainPotential <= 0) then
		self:DisableAssign();
		return;
	end

	self:EnableAssign();

	local nRemainDelta = self.nRemain;	-- 用于计算同步前后的差值
	for i = 1, #self.tbDeltaAttrib do
		nRemainDelta = nRemainDelta + self.tbDeltaAttrib[i];
	end
	nRemainDelta = me.nRemainPotential - nRemainDelta;
	self.nRemain = self.nRemain + nRemainDelta;
	if (self.nRemain < 0) then			-- 同步后显示剩余潜能点为负，复位数据
		self.nRemain = me.nRemainPotential;
		self.tbDeltaAttrib[Player.ATTRIB_STR]	= 0;
		self.tbDeltaAttrib[Player.ATTRIB_DEX]	= 0;
		self.tbDeltaAttrib[Player.ATTRIB_VIT]	= 0;
		self.tbDeltaAttrib[Player.ATTRIB_ENG]	= 0;
	end

	self:UpdateAttribView();
end

function tbPlayerPanel:OnActiveTitle()

	local nX = self.m_nSelTitleX;
	local nY = self.m_nSelTitleY;
	local theTitleDataEx = self.tbTitleTable[nX + 1].TitleData[nY + 1];

	if (theTitleDataEx == nil) then
		return;
	end

	if (self:IsCurActiveTitle(nX + 1, nY + 1) == 1) then
		me.SetCurTitle(0, 0, 0, 0);
	else
		me.SetCurTitle(
			theTitleDataEx.byTitleGenre,
			 theTitleDataEx.byTitleDetailType,
			theTitleDataEx.byTitleLevel,
			 theTitleDataEx.dwTitleParam
		);
	end
end

function tbPlayerPanel:OnInactiveTitle()

	local nX = self.m_nSelTitleX;
	local nY = self.m_nSelTitleY;
	local theTitleDataEx = self.tbTitleTable[nX + 1].TitleData[nY + 1];

	if (theTitleDataEx == nil) then
		return;
	end

	if (self:IsCurActiveTitle(nX + 1, nY + 1) == 1) then
		me.SetCurTitle(0, 0, 0, 0);
	end
end

function tbPlayerPanel:EnableAssign()

	if (0 >= me.nRemainPotential) then
		self:DisableAssign();
		return;
	end

	self.nRemain = me.nRemainPotential;

	self.tbDeltaAttrib[Player.ATTRIB_STR]	= 0;
	self.tbDeltaAttrib[Player.ATTRIB_DEX]	= 0;
	self.tbDeltaAttrib[Player.ATTRIB_VIT]	= 0;
	self.tbDeltaAttrib[Player.ATTRIB_ENG]	= 0;

	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_ASSAUTO,		1);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_ASSOK,		1);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_ASSCANCEL,	1);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_INCSTR,		1);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_DECSTR,		1);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_INCDEX,		1);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_DECDEX,		1);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_INCVIT,		1);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_DECVIT,		1);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_INCENG,		1);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_DECENG,		1);
	Wnd_SetEnable(self.UIGROUP, EDIT_BASIC_STR,			1);
	Wnd_SetEnable(self.UIGROUP, EDIT_BASIC_DEX,			1);
	Wnd_SetEnable(self.UIGROUP, EDIT_BASIC_VIT,			1);
	Wnd_SetEnable(self.UIGROUP, EDIT_BASIC_ENG,			1);

	self:UpdateAttribView();

end

function tbPlayerPanel:DisableAssign()

	self.nRemain = me.nRemainPotential;

	self.tbDeltaAttrib[Player.ATTRIB_STR]	= 0;
	self.tbDeltaAttrib[Player.ATTRIB_DEX]	= 0;
	self.tbDeltaAttrib[Player.ATTRIB_VIT]	= 0;
	self.tbDeltaAttrib[Player.ATTRIB_ENG]	= 0;

	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_ASSAUTO,		0);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_ASSOK,		0);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_ASSCANCEL,	0);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_INCSTR,		0);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_DECSTR,		0);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_INCDEX,		0);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_DECDEX,		0);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_INCVIT,		0);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_DECVIT,		0);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_INCENG,		0);
	Wnd_SetEnable(self.UIGROUP, BTN_BASIC_DECENG,		0);
	Wnd_SetEnable(self.UIGROUP, EDIT_BASIC_STR,			0);
	Wnd_SetEnable(self.UIGROUP, EDIT_BASIC_DEX,			0);
	Wnd_SetEnable(self.UIGROUP, EDIT_BASIC_VIT,			0);
	Wnd_SetEnable(self.UIGROUP, EDIT_BASIC_ENG,			0);

	self:UpdateAttribView();

	if me.nRemainPotential > 0 then
		self:EnableAssign();
	end

end

function tbPlayerPanel:UpdateAttribView(nAttrib)

	local tbBase =
	{
		[Player.ATTRIB_STR] = me.nStrength,
		[Player.ATTRIB_DEX] = me.nDexterity,
		[Player.ATTRIB_VIT] = me.nVitality,
		[Player.ATTRIB_ENG] = me.nEnergy,
	};

	if (not nAttrib) then
		for i = 1, #ATTRIB_EDIT_TABLE do
			Edt_SetInt(self.UIGROUP, ATTRIB_EDIT_TABLE[i], self.tbDeltaAttrib[i] + tbBase[i]);
		end
	else
		Edt_SetInt(self.UIGROUP, ATTRIB_EDIT_TABLE[nAttrib], self.tbDeltaAttrib[nAttrib] + tbBase[nAttrib]);
	end

	self:UpdateBasicRemain();
end

function tbPlayerPanel:ResetTitleData()
	self.tbTitleTable = {};
end

function tbPlayerPanel:GetTitleDataByItemData(nItemData)
	for i = 1, #self.tbTitleTable do
		if (self.tbTitleTable[i] ~= nil) then
			if (self.tbTitleTable[i].TitleData ~= nil) then
				for j = 1, #self.tbTitleTable[i].TitleData do
					if (self.tbTitleTable[i].TitleData[j].nItemData == nItemData) then
						return self.tbTitleTable[i].TitleData[j];
					end
				end
			end
		end
	end
end

function tbPlayerPanel:InsertTitleItem(TitleItem)

	if (TitleItem == nil) then
		return;
	end

	for i = 1, #self.tbTitleTable do
		if (self.tbTitleTable[i] == nil) then
			break;
		end

		if (self.tbTitleTable[i].byTitleGenre == TitleItem.byTitleGenre) then
			table.insert(self.tbTitleTable[i].TitleData, TitleItem);
			return
		end
	end

	local theTitleTable = {};
	theTitleTable.TitleData = {};
	theTitleTable.byTitleGenre = TitleItem.byTitleGenre;
	local TitleGenreAttr = KPlayer.GetTitleGenreAttr(TitleItem.byTitleGenre);

	if (TitleGenreAttr ~= nil) then
		theTitleTable.szTitleGenreAttr = TitleGenreAttr.szGenreName;
	end

	table.insert(theTitleTable.TitleData, TitleItem);
	table.insert(self.tbTitleTable, theTitleTable);

end

function tbPlayerPanel:GetCurTitleData()

	local byTitleGenre, byTitleDetailType, byTitleLevel, dwTitleParam = me.GetCurTitle();

	if (self.tbTitleTable == nil) or (byTitleGenre == nil) or (byTitleDetailType == nil)
		or (byTitleLevel == nil) or (dwTitleParam == nil) then
		return;
	end

	if (self.tbTitleTable == 0) and (byTitleGenre == 0) and (byTitleDetailType == 0) and
		(byTitleLevel == 0) and (dwTitleParam == 0) then
		return;
	end

	local CurTitleKey = byTitleGenre..byTitleDetailType..byTitleLevel..dwTitleParam

	for i = 1, #self.tbTitleTable do
		if (self.tbTitleTable[i].byTitleGenre == byTitleGenre) then
			for _, v in ipairs(self.tbTitleTable[i].TitleData) do
				TitleKey = v.byTitleGenre..v.byTitleDetailType..v.byTitleLevel..v.dwTitleParam;
				if (CurTitleKey == TitleKey) then
					return self.tbTitleTable[i].TitleData[j];
				end
			end
		end
	end

end

function tbPlayerPanel:UpdateBasicName()
	Txt_SetTxt(self.UIGROUP, EDIT_BASIC_NAME, me.szName);
end
tbPlayerPanel.szImgBeBi = {
	[1] = 1,
	[3] = 1,
	[6] = 2,
	[10] = 2
};
function tbPlayerPanel:UpdateBeBi()
	Txt_SetTxt(self.UIGROUP, TEXT_BEBI_LEVEL, "");
	
	local nNhanCuoi = me.GetSkillLevel(1897)
	local nBeBiNu = me.GetSkillLevel(1860)
	local nBeBiNam = me.GetSkillLevel(1861)
	local szSprBB = "image\\Update2016\\BeBi\\Img_BeBiHid.spr"
	if nBeBiNu >= 1 then
		szSprBB = "image\\Update2016\\BeBi\\Img_BeBiFemale"..self.szImgBeBi[nNhanCuoi]..".spr"
	end
	if nBeBiNam >= 1 then
		szSprBB = "image\\Update2016\\BeBi\\Img_BeBiMale"..self.szImgBeBi[nNhanCuoi]..".spr"
	end	
	Img_SetImage(self.UIGROUP, IMG_BEBI, 1, szSprBB);	
end
function tbPlayerPanel:UpdateKyNangBang()
	local nSkillTC = me.GetSkillLevel(1862)
	local szSkillTC = "<color=gold>Tấn Công<color>\nCấp: 0\nPhát huy lực tấn công cơ bản, kỹ năng: 0%"
	if nSkillTC >= 1 then
		szSkillTC = "<color=gold>Tấn Công<color>\n"..
					"Cấp: "..nSkillTC.."\n"..
					"Phát huy lực tấn công cơ bản, kỹ năng: ".. nSkillTC*2 .."%"
	end
	Txt_SetTxt(self.UIGROUP, TEXT_TONGSKILL_TANCONG, szSkillTC);
	
	local nSkillSL = me.GetSkillLevel(1864)
	local szSkillSL = "<color=gold>Sinh Lực<color>\nCấp: 0\nSinh lực tối đa: +0 điểm"
	if nSkillSL >= 1 then
		szSkillSL = "<color=gold>Sinh Lực<color>\n"..
					"Cấp: "..nSkillSL.."\n"..
					"Sinh lực tối đa: +".. nSkillSL*90 .." điểm"
	end
	Txt_SetTxt(self.UIGROUP, TEXT_TONGSKILL_SINHLUC, szSkillSL);	
	
	local nSkillPT = me.GetSkillLevel(1863)
	local szSkillPT = "<color=gold>Kháng Tất Cả<color>\nCấp: 0\nKháng tất cả: +0"
	if nSkillPT >= 1 then
		szSkillPT = "<color=gold>Kháng Tất Cả<color>\n"..
					"Cấp: "..nSkillPT.."\n"..
					"Kháng tất cả: +".. nSkillPT*11 ..""
	end
	Txt_SetTxt(self.UIGROUP, TEXT_TONGSKILL_PHONGTHU, szSkillPT);
	
	local nSkillNT = me.GetSkillLevel(1866)
	local szSkillNT = "<color=gold>Né Tránh<color>\nCấp: 0\nNé tránh: +0 điểm"
	if nSkillNT >= 1 then
		szSkillNT = "<color=gold>Né Tránh<color>\n"..
					"Cấp: "..nSkillNT.."\n"..
					"Né tránh: +".. nSkillNT*64 .." điểm"
	end
	Txt_SetTxt(self.UIGROUP, TEXT_TONGSKILL_NETRANH, szSkillNT);
	
	local nSkillBQNT = me.GetSkillLevel(1865)
	local szSkillBQNT = "<color=gold>Bỏ Qua Né Tránh Đối Thủ<color>\nCấp: 0\nBỏ qua né tránh đối thủ: +0"
	if nSkillBQNT >= 1 then
		szSkillBQNT = "<color=gold>Bỏ Qua Né Tránh Đối Thủ<color>\n"..
					  "Cấp: "..nSkillBQNT.."\n"..
					  "Bỏ qua né tránh đối thủ: +".. nSkillBQNT*64 ..""
	end
	Txt_SetTxt(self.UIGROUP, TEXT_TONGSKILL_BOQUANT, szSkillBQNT);	
end
function tbPlayerPanel:UpdateTamPhap()
	Txt_SetTxt(self.UIGROUP, TEXT_TAMPHAP_THIENTHUONG, "<color=green>Thiên Thương<color>\n<color=gold>Cấp: 0<color>");
	Txt_SetTxt(self.UIGROUP, TEXT_TAMPHAP_THIENUY, "<color=green>Thiên Uy<color>\n<color=gold>Cấp: 0<color>");
	Txt_SetTxt(self.UIGROUP, TEXT_TAMPHAP_THIENDUNG, "<color=green>Thiên Dũng<color>\n<color=gold>Cấp: 0<color>");
	Txt_SetTxt(self.UIGROUP, TEXT_TAMPHAP_THIENHUNG, "<color=green>Thiên Hùng<color>\n<color=gold>Cấp: 0<color>");
	Txt_SetTxt(self.UIGROUP, TEXT_TAMPHAP_THIENMANH, "<color=green>Thiên Mãnh<color>\n<color=gold>Cấp: 0<color>");
	Txt_SetTxt(self.UIGROUP, TEXT_TAMPHAP_THIENSAT, "<color=green>Thiên Sát<color>\n<color=gold>Cấp: 0<color>");
	Txt_SetTxt(self.UIGROUP, TEXT_TAMPHAP_THIENCANH, "<color=green>Thiên Canh<color>\n<color=gold>Cấp: 0<color>");
	
	Txt_SetTxt(self.UIGROUP, TEXT_TAMPHAP_DIAXICH, "<color=green>Địa Xích<color>\n<color=gold>Cấp: 0<color>");
	Txt_SetTxt(self.UIGROUP, TEXT_TAMPHAP_DIANGUY, "<color=green>Địa Nguy<color>\n<color=gold>Cấp: 0<color>");
	Txt_SetTxt(self.UIGROUP, TEXT_TAMPHAP_DIABANG, "<color=green>Địa Băng<color>\n<color=gold>Cấp: 0<color>");
	Txt_SetTxt(self.UIGROUP, TEXT_TAMPHAP_DIABICH, "<color=green>Địa Bích<color>\n<color=gold>Cấp: 0<color>");
	Txt_SetTxt(self.UIGROUP, TEXT_TAMPHAP_DIAPHUC, "<color=green>Địa Phúc<color>\n<color=gold>Cấp: 0<color>");
	Txt_SetTxt(self.UIGROUP, TEXT_TAMPHAP_DIALINH, "<color=green>Địa Linh<color>\n<color=gold>Cấp: 0<color>");
	Txt_SetTxt(self.UIGROUP, TEXT_TAMPHAP_DIASAT, "<color=green>Địa Sát<color>\n<color=gold>Cấp: 0<color>");
	
end
function tbPlayerPanel:UpdateKMachHuyet1()
	local nLevel = me.GetSkillLevel(1958)
	if nLevel < 1 then	
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET1, "Chưa mở");
	else
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET1, "Thừa Khấp "..nLevel);	
	end
end
function tbPlayerPanel:UpdateKMachHuyet2()
	local nLevel = me.GetSkillLevel(1959)
	if nLevel < 1 then	
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET2, "Chưa mở");
	else
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET2, "Thừa Tương "..nLevel);
	end
end
function tbPlayerPanel:UpdateKMachHuyet3()
	local nLevel = me.GetSkillLevel(1960)
	if nLevel < 1 then	
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET3, "Chưa mở");
	else
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET3, "Liêm Tuyền "..nLevel);
	end
end
function tbPlayerPanel:UpdateKMachHuyet4()
	local nLevel = me.GetSkillLevel(1961)
	if nLevel < 1 then	
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET4, "Chưa mở");
	else
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET4, "Thiên Đột "..nLevel);
	end
end
function tbPlayerPanel:UpdateKMachHuyet5()
	local nLevel = me.GetSkillLevel(1962)
	if nLevel < 1 then	
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET5, "Chưa mở");
	else
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET5, "Tuyền Ki "..nLevel);
	end
end
function tbPlayerPanel:UpdateKMachHuyet6()
	local nLevel = me.GetSkillLevel(1963)
	if nLevel < 1 then	
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET6, "Chưa mở");
	else
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET6, "Hoa Cái "..nLevel);
	end
end
function tbPlayerPanel:UpdateKMachHuyet7()
	local nLevel = me.GetSkillLevel(1964)
	if nLevel < 1 then	
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET7, "Chưa mở");
	else
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET7, "Tử Cung "..nLevel);
	end
end
function tbPlayerPanel:UpdateKMachHuyet8()
	local nLevel = me.GetSkillLevel(1965)
	if nLevel < 1 then	
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET8, "Chưa mở");
	else
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET8, "Ngọc Đường "..nLevel);
	end
end
function tbPlayerPanel:UpdateKMachHuyet9()
	local nLevel = me.GetSkillLevel(1966)
	if nLevel < 1 then	
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET9, "Chưa mở");
	else
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET9, "Đãn Trung "..nLevel);
	end
end
function tbPlayerPanel:UpdateKMachHuyet10()
	local nLevel = me.GetSkillLevel(1967)
	if nLevel < 1 then	
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET10, "Chưa mở");
	else
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET10, "Trung Đình "..nLevel);
	end
end
function tbPlayerPanel:UpdateKMachHuyet11()
	local nLevel = me.GetSkillLevel(1968)
	if nLevel < 1 then	
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET11, "Chưa mở");
	else
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET11, "Cưu Vĩ "..nLevel);
	end
end
function tbPlayerPanel:UpdateKMachHuyet12()
	local nLevel = me.GetSkillLevel(1969)
	if nLevel < 1 then	
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET12, "Chưa mở");
	else
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET12, "Cự Khuyết "..nLevel);
	end
end
function tbPlayerPanel:UpdateKMachHuyet13()
	local nLevel = me.GetSkillLevel(1970)
	if nLevel < 1 then	
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET13, "Chưa mở");
	else
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET13, "Thượng Oản "..nLevel);
	end
end
function tbPlayerPanel:UpdateKMachHuyet14()
	local nLevel = me.GetSkillLevel(1971)
	if nLevel < 1 then	
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET14, "Chưa mở");
	else
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET14, "Trung Oản "..nLevel);
	end
end
function tbPlayerPanel:UpdateKMachHuyet15()
	local nLevel = me.GetSkillLevel(1972)
	if nLevel < 1 then	
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET15, "Chưa mở");
	else
		Txt_SetTxt(self.UIGROUP, TEXT_KINHMACH_HUYET15, "Thiên Xung "..nLevel);
	end
end
function tbPlayerPanel:UpdateLevelTuLinh()
	local pItem = me.GetEquip(Item.EQUIPPOS_HORSE);
	local szNameThuCuoi = "<color=red>Chưa trang bị thú cưỡi<color>";
	if pItem ~= nil then
		szNameThuCuoi = pItem.szName;
	end
	Txt_SetTxt(self.UIGROUP, TEXT_TULINH_LEVEL, ""..szNameThuCuoi);
end

function tbPlayerPanel:UpdateBasicSeries()
	local szSeries = Env.SERIES_NAME[me.nSeries];
	if (not szSeries) then
		szSeries = Env.SERIES_NAME[Env.SERIES_NONE];
	end
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_SERIES,	"N.hành:"..szSeries);
end

function tbPlayerPanel:UpdateBasicLevel()
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_LEVEL, "Cấp:"..me.nLevel);
end

function tbPlayerPanel:UpdateBasicPortrait()
	local szSpr = GetPortraitSpr(me.nPortrait, me.nSex);
	Img_SetImage(self.UIGROUP, IMG_PLAYER_PORTRAIT, 1, szSpr);
end

function tbPlayerPanel:UpdateBasicBaoChauNon()
	local nSkill = me.GetSkillLevel(1908)
	local szSpr = ""
	if nSkill >= 1 then
		szSpr = "image\\ui\\001a\\common\\BaoChau_hien.spr"
	end
	Img_SetImage(self.UIGROUP, IMG_PLAYER_BAOCHAUNON, 1, szSpr);
end
function tbPlayerPanel:UpdateBasicBaoChauAo()
	local nSkill = me.GetSkillLevel(1909)
	local szSpr = ""
	if nSkill >= 1 then
		szSpr = "image\\ui\\001a\\common\\BaoChau_hien.spr"
	end
	Img_SetImage(self.UIGROUP, IMG_PLAYER_BAOCHAUAO, 1, szSpr);
end
function tbPlayerPanel:UpdateBasicBaoChauLung()
	local nSkill = me.GetSkillLevel(1910)
	local szSpr = ""
	if nSkill >= 1 then
		szSpr = "image\\ui\\001a\\common\\BaoChau_hien.spr"
	end
	Img_SetImage(self.UIGROUP, IMG_PLAYER_BAOCHAULUNG, 1, szSpr);
end
function tbPlayerPanel:UpdateBasicBaoChauTay()
	local nSkill = me.GetSkillLevel(1911)
	local szSpr = ""
	if nSkill >= 1 then
		szSpr = "image\\ui\\001a\\common\\BaoChau_hien.spr"
	end
	Img_SetImage(self.UIGROUP, IMG_PLAYER_BAOCHAUTAY, 1, szSpr);
end
function tbPlayerPanel:UpdateBasicBaoChauGiay()
	local nSkill = me.GetSkillLevel(1912)
	local szSpr = ""
	if nSkill >= 1 then
		szSpr = "image\\ui\\001a\\common\\BaoChau_hien.spr"
	end
	Img_SetImage(self.UIGROUP, IMG_PLAYER_BAOCHAUGIAY, 1, szSpr);
end
function tbPlayerPanel:UpdateBasicBaoChauVKhi()
	local nSkill = me.GetSkillLevel(1913)
	local szSpr = ""
	if nSkill >= 1 then
		szSpr = "image\\ui\\001a\\common\\BaoChau_hien.spr"
	end
	Img_SetImage(self.UIGROUP, IMG_PLAYER_BAOCHAUVKHI, 1, szSpr);
end
function tbPlayerPanel:UpdateBasicBaoChauLien()
	local nSkill = me.GetSkillLevel(1914)
	local szSpr = ""
	if nSkill >= 1 then
		szSpr = "image\\ui\\001a\\common\\BaoChau_hien.spr"
	end
	Img_SetImage(self.UIGROUP, IMG_PLAYER_BAOCHAULIEN, 1, szSpr);
end
function tbPlayerPanel:UpdateBasicBaoChauNhan()
	local nSkill = me.GetSkillLevel(1915)
	local szSpr = ""
	if nSkill >= 1 then
		szSpr = "image\\ui\\001a\\common\\BaoChau_hien.spr"
	end
	Img_SetImage(self.UIGROUP, IMG_PLAYER_BAOCHAUNHAN, 1, szSpr);
end
function tbPlayerPanel:UpdateBasicBaoChauBoi()
	local nSkill = me.GetSkillLevel(1916)
	local szSpr = ""
	if nSkill >= 1 then
		szSpr = "image\\ui\\001a\\common\\BaoChau_hien.spr"
	end
	Img_SetImage(self.UIGROUP, IMG_PLAYER_BAOCHAUBOI, 1, szSpr);
end
function tbPlayerPanel:UpdateBasicBaoChauPhu()
	local nSkill = me.GetSkillLevel(1917)
	local szSpr = ""
	if nSkill >= 1 then
		szSpr = "image\\ui\\001a\\common\\BaoChau_hien.spr"
	end
	Img_SetImage(self.UIGROUP, IMG_PLAYER_BAOCHAUPHU, 1, szSpr);
end

function tbPlayerPanel:UpdateBasicTieuBaoBoi()
	local nTieuBB = me.GetSkillLevel(1982)
	local szSpr = "image\\ui\\001a\\playerpanel\\baoboi\\img_tieubaoboihuhid.spr"
	if nTieuBB >= 1 then
		szSpr = "image\\ui\\001a\\playerpanel\\baoboi\\img_tieubaoboihu.spr"
	end		
		Img_SetImage(self.UIGROUP, IMG_PLAYER_TIEUBAOBOI, 1, szSpr);			
end
function tbPlayerPanel:UpdateBasicLvTieuBaoBoi()
	local nTieuBB = me.GetSkillLevel(1982)
	local szSpr = 0;
	if nTieuBB >= 1 then
		szSpr = nTieuBB
	end
		Img_SetImage(self.UIGROUP, IMG_PLAYER_LVTIEUBAOBOI, 1, "image\\ui\\001a\\playerpanel\\baoboi\\Lv"..szSpr..".spr");			
end
tbPlayerPanel.tbOptBaoBoi = {
	[1] = {64,15,100,9,5,4,10},
};
function tbPlayerPanel:UpdatePlayerTieuBaoBoi()
	local nLevel = me.GetSkillLevel(1982)
	local szInfo = ""
	if nLevel < 1 then
		szInfo = 
		"\n<color=red>Rút đồng nạp thẻ lần đầu thông qua NPC Cổ Phong Hà sẽ kích     hoạt tính năng Tiểu Bảo Bối"
	else
		szInfo = 
		"<color=blue>Thuộc tính cộng thêm:<color>\n"..
		"<color=white>Né tránh: <color=gold>+".. 64*nLevel .." điểm<color>                    H.suất hồi phục sinh lực: <color=gold>+".. 4*nLevel .."%<color>\n"..
		"Kháng tất cả: <color=gold>+".. 15*nLevel .." điểm<color>              Kinh nghiệm giết địch: <color=gold>+".. 10*nLevel .."%<color>\n"..
		"Sinh lực tối đa: <color=gold>+".. 100*nLevel .." điểm<color>\n"..
		"Tỉ lệ sinh lực tối đa: <color=gold>Tăng ".. 9*nLevel .."%<color>\n"..
		"Chịu sát thương chí mạng: <color=gold>-".. 5*nLevel .."%<color>"
	end
	Txt_SetTxt(self.UIGROUP, TEXT_TIEUBAOBOI_OPT, szInfo);
end

function tbPlayerPanel:UpdateTuLinhVKhi()
	local nLevel = me.GetSkillLevel(1898)
	local szSpr = {
		[1] = "\\image\\icon\\fightskill\\horse\\changsheng.spr",
	};	
	Img_SetImage(self.UIGROUP, IMG_TULINH_VKHI, 1, szSpr[1]);
end
function tbPlayerPanel:UpdateTuLinhYPhuc()
	local nLevel = me.GetSkillLevel(1899)
	local szSpr = {
		[1] = "\\image\\icon\\fightskill\\horse\\guixi.spr",
	};	
	Img_SetImage(self.UIGROUP, IMG_TULINH_YPHUC, 1, szSpr[1]);
end
function tbPlayerPanel:UpdateTuLinhNhan()
	local nLevel = me.GetSkillLevel(1900)
	local szSpr = {
		[1] = "\\image\\icon\\fightskill\\horse\\yishuige.spr",
	};	
	Img_SetImage(self.UIGROUP, IMG_TULINH_NHAN, 1, szSpr[1]);
end
function tbPlayerPanel:UpdateTuLinhTay()
	local nLevel = me.GetSkillLevel(1901)
	local szSpr = {
		[1] = "\\image\\icon\\fightskill\\horse\\tiejia.spr",
	};	
	Img_SetImage(self.UIGROUP, IMG_TULINH_TAY, 1, szSpr[1]);
end
function tbPlayerPanel:UpdateTuLinhPhu()
	local nLevel = me.GetSkillLevel(1902)
	local szSpr = {
		[1] = "\\image\\icon\\fightskill\\public\\haihun.spr",
	};	
	Img_SetImage(self.UIGROUP, IMG_TULINH_PHU, 1, szSpr[1]);
end
function tbPlayerPanel:UpdateTuLinhLien()
	local nLevel = me.GetSkillLevel(1903)
	local szSpr = {
		[1] = "\\image\\icon\\fightskill\\horse\\yue_ma.spr",
	};	
	Img_SetImage(self.UIGROUP, IMG_TULINH_LIEN, 1, szSpr[1]);
end
function tbPlayerPanel:UpdateTuLinhLung()
	local nLevel = me.GetSkillLevel(1904)
	local szSpr = {
		[1] = "\\image\\icon\\fightskill\\horse\\yuma.spr",
	};	
	Img_SetImage(self.UIGROUP, IMG_TULINH_LUNG, 1, szSpr[1]);
end
function tbPlayerPanel:UpdateTuLinhGiay()
	local nLevel = me.GetSkillLevel(1905)
	local szSpr = {
		[1] = "\\image\\icon\\fightskill\\horse\\fuhushi.spr",
	};	
	Img_SetImage(self.UIGROUP, IMG_TULINH_GIAY, 1, szSpr[1]);
end
function tbPlayerPanel:UpdateTuLinhBoi()
	local nLevel = me.GetSkillLevel(1906)
	local szSpr = {
		[1] = "\\image\\icon\\fightskill\\horse\\huozhibaoyan.spr",
	};	
	Img_SetImage(self.UIGROUP, IMG_TULINH_BOI, 1, szSpr[1]);
end
function tbPlayerPanel:UpdateTuLinhNon()
	local nLevel = me.GetSkillLevel(1907)
	local szSpr = {
		[1] = "\\image\\icon\\fightskill\\horse\\jinzhiliren.spr",
	};	
	Img_SetImage(self.UIGROUP, IMG_TULINH_MU, 1, szSpr[1]);
end
function tbPlayerPanel:UpdateBasicFaction()
	local szFaction = Player:GetFactionRouteName(me.nFaction);
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_FACTION, "Phái:"..szFaction);
end

function tbPlayerPanel:UpdateBasicPKValue()
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_PKVALUE, "Trị PK: "..me.nPKValue);
end

function tbPlayerPanel:UpdateBasicExp()
end

function tbPlayerPanel:UpdatePrestige()
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_EXP, "Uy danh:"..me.nPrestige);
end

function tbPlayerPanel:UpdateBasicLife()
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_LIFE, "Sinh lực:"..me.nCurLife.."/"..me.nMaxLife);
end

function tbPlayerPanel:UpdateBasicMana()
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_MANA, "Nội lực:"..me.nCurMana.."/"..me.nMaxMana);
end

function tbPlayerPanel:UpdateBasicStamina()
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_STAMINA, "Thể lực:"..me.nCurStamina.."/"..me.nMaxStamina);
end

function tbPlayerPanel:UpdateBasicGTP()
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_GTP, "Hoạt lực:"..me.dwCurGTP);
end

function tbPlayerPanel:UpdateBasicMKP()
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_MKP, "Tinh lực:"..me.dwCurMKP);
end

function tbPlayerPanel:UpdateBasicResist()
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_GR, "Vật phòng:"..me.nGR);
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_PR, "Độc phòng:"..me.nPR);
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_CR, "Băng phòng:"..me.nCR);
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_FR, "Hỏa phòng:"..me.nFR);
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_LR, "Lôi phòng:"..me.nLR);
end

function tbPlayerPanel:UpdateBasicLeftDamage()
	local nLeft  = me.nLeftDamageMin;
	local nRight = me.nLeftDamageMax;
	if (nLeft  < 0) then
		nLeft  = "-";
	end
	if (nRight < 0) then
		nRight = "-";
	end
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_LDAMAGE, "Lực tay trái:\n"..nLeft.." - "..nRight);
end

function tbPlayerPanel:UpdateBasicRightDamage()
	local nLeft  = me.nRightDamageMin;
	local nRight = me.nRightDamageMax;
	if (nLeft  < 0) then
		nLeft  = 0;
	end
	if (nRight < 0) then
		nRight = 0;
	end
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_RDAMAGE, "Lực tay phải:\n"..nLeft.." - "..nRight);
end

function tbPlayerPanel:UpdateBasicAttackRate()

	local nLeft  = me.nLeftAR;
	local nRight = me.nRightAR;

	if (nLeft  < 0) then
		nLeft  = "-";
	end
	if (nRight < 0) then
		nRight = "-";
	end

	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_AR, "Chính xác:"..nLeft.."/"..nRight);

end

function tbPlayerPanel:UpdateBasicAttackSpeed()
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_AS, "Tốc đánh:"..me.nAttackSpeed.."/"..me.nCastSpeed);
end

function tbPlayerPanel:UpdateBasicDefense()
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_DEFENSE, "Né tránh:"..me.nDefense);
end

function tbPlayerPanel:UpdateBasicRunSpeed()
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_RUNSPEED, "Tốc chạy:"..me.nRunSpeed);
end

function tbPlayerPanel:UpdateBasicPotential()
	self:UpdateBasicStrength();
	self:UpdateBasicDexterity();
	self:UpdateBasicVitality();
	self:UpdateBasicEnergy();
end

function tbPlayerPanel:UpdateBasicStrength()
	Edt_SetInt(self.UIGROUP, EDIT_BASIC_STR, me.nStrength + self.tbDeltaAttrib[Player.ATTRIB_STR]);
end

function tbPlayerPanel:UpdateBasicDexterity()
	Edt_SetInt(self.UIGROUP, EDIT_BASIC_DEX, me.nDexterity + self.tbDeltaAttrib[Player.ATTRIB_DEX]);
end

function tbPlayerPanel:UpdateBasicVitality()
	Edt_SetInt(self.UIGROUP, EDIT_BASIC_VIT, me.nVitality + self.tbDeltaAttrib[Player.ATTRIB_VIT]);
end

function tbPlayerPanel:UpdateBasicEnergy()
	Edt_SetInt(self.UIGROUP, EDIT_BASIC_ENG, me.nEnergy + self.tbDeltaAttrib[Player.ATTRIB_ENG]);
end
tbPlayerPanel.tbInfoHuyet1 = {
	[1] = 10,
	[2] = 20,
	[3] = 30,
	[4] = 40,
	[5] = 50,
	[6] = 60,
	[7] = 70,
	[8] = 80,
	[9] = 90,
	[10] = 100,
	[11] = 110,
	[12] = 120,
	[13] = 130,
	[14] = 140,
	[15] = 150,
	[16] = 160,
	[17] = 170,
	[18] = 180,
	[19] = 190,
	[20] = 200
};
tbPlayerPanel.tbVuKhiTuLinh = {
	[1] = "<color=yellow>Bích Huyết Chi Nhẫn<color>\n"..
		"Tỉ lệ sinh lực tối đa: <color=gold>Tăng 10%<color>\n"..
		"Tấn công khi đánh chí mạng: <color=gold>+15%<color>",
	[2] = "<color=yellow>Kim Lân Chi Nhẫn<color>\n"..
		"Tỉ lệ sinh lực tối đa: <color=gold>Tăng 12%<color>\n"..
		"Tấn công khi đánh chí mạng: <color=gold>+20%<color>",
	[3] = "<color=yellow>Đơn Tâm Chi Nhẫn<color>\n"..
		"Tỉ lệ sinh lực tối đa: <color=gold>Tăng 15%<color>\n"..
		"Tấn công khi đánh chí mạng: <color=gold>+25%<color>",
	[4] = "<color=yellow>Kim Long Chi Nhẫn<color>\n"..
		"Tỉ lệ sinh lực tối đa: <color=gold>Tăng 20%<color>\n"..
		"Tấn công khi đánh chí mạng: <color=gold>+30%<color>",	
};
tbPlayerPanel.tbYPhucTuLinh = {
	[1] = "<color=yellow>Bích Huyết Chiến Y<color>\n"..
		"Tỉ lệ nội lực tối đa: <color=gold>Tăng 10%<color>\n"..
		"Chịu sát thương chí mạng: <color=gold>-15%<color>",
	[2] = "<color=yellow>Kim Lân Chiến Y<color>\n"..
		"Tỉ lệ nội lực tối đa: <color=gold>Tăng 12%<color>\n"..
		"Chịu sát thương chí mạng: <color=gold>-20%<color>",
	[3] = "<color=yellow>Đơn Tâm Chiến Y<color>\n"..
		"Tỉ lệ nội lực tối đa: <color=gold>Tăng 15%<color>\n"..
		"Chịu sát thương chí mạng: <color=gold>-25%<color>",
	[4] = "<color=yellow>Kim Long Chiến Y<color>\n"..
		"Tỉ lệ nội lực tối đa: <color=gold>Tăng 20%<color>\n"..
		"Chịu sát thương chí mạng: <color=gold>-30%<color>",		
};
tbPlayerPanel.tbNhanTuLinh = {
	[1] = "<color=yellow>Bích Huyết Giới Chỉ<color>\n"..
		"Vật công ngoại: <color=gold>+100%<color>\n"..
		"Vật công nội: <color=gold>+100%<color>\n"..
		"Hiệu suất phục hồi nội lực: <color=gold>+11%<color>\n"..
		"Thời gian bị trạng thái ngũ hành: <color=gold>-50<color>",
	[2] = "<color=yellow>Kim Lân Giới Chỉ<color>\n"..
		"Vật công ngoại: <color=gold>+150%<color>\n"..
		"Vật công nội: <color=gold>+150%<color>\n"..
		"Hiệu suất phục hồi nội lực: <color=gold>+13%<color>\n"..
		"Thời gian bị trạng thái ngũ hành: <color=gold>-75<color>",
	[3] = "<color=yellow>Đan Tâm Giới Chỉ<color>\n"..
		"Vật công ngoại: <color=gold>+200%<color>\n"..
		"Vật công nội: <color=gold>+200%<color>\n"..
		"Hiệu suất phục hồi nội lực: <color=gold>+16%<color>\n"..
		"Thời gian bị trạng thái ngũ hành: <color=gold>-100<color>",	
	[4] = "<color=yellow>Kim Long Giới Chỉ<color>\n"..
		"Vật công ngoại: <color=gold>+250%<color>\n"..
		"Vật công nội: <color=gold>+250%<color>\n"..
		"Hiệu suất phục hồi nội lực: <color=gold>+19%<color>\n"..
		"Thời gian bị trạng thái ngũ hành: <color=gold>-125<color>",		
};
tbPlayerPanel.tbTayTuLinh = {
	[1] = "<color=yellow>Bích Huyết Hộ Uyển<color>\n"..
		"Kháng tất cả: <color=gold>+75<color>\n"..
		"Hiệu Suất phụ hồi sinh lực: <color=gold>+11%<color>",
	[2] = "<color=yellow>Kim Lân Hộ Uyển<color>\n"..
		"Kháng tất cả: <color=gold>+90<color>\n"..
		"Hiệu Suất phụ hồi sinh lực: <color=gold>+13%<color>",
	[3] = "<color=yellow>Đơn Tâm Hộ Uyển<color>\n"..
		"Kháng tất cả: <color=gold>+105<color>\n"..
		"Hiệu Suất phụ hồi sinh lực: <color=gold>+16%<color>",
	[4] = "<color=yellow>Kim Long Hộ Uyển<color>\n"..
		"Kháng tất cả: <color=gold>+115<color>\n"..
		"Hiệu Suất phụ hồi sinh lực: <color=gold>+19%<color>",		
};
tbPlayerPanel.tbPhuTuLinh = {
	[1] = "<color=yellow>Bích Huyết Hộ Thân Phù<color>\n"..
		"Mỗi 5 giây hồi phục sinh lực: <color=gold>+30 điểm<color>\n"..
		"Mỗi 5 giây hồi phục nội lực: <color=gold>+30 điểm<color>\n"..
		"Mỗi 5 giây hồi phục thể lực: <color=gold>+30 điểm<color>\n"..
		"Kháng tất cả: <color=gold>+15<color>",
	[2] = "<color=yellow>Kim Lân Hộ Thân Phù<color>\n"..
		"Mỗi 5 giây hồi phục sinh lực: <color=gold>+40 điểm<color>\n"..
		"Mỗi 5 giây hồi phục nội lực: <color=gold>+40 điểm<color>\n"..
		"Mỗi 5 giây hồi phục thể lực: <color=gold>+40 điểm<color>\n"..
		"Kháng tất cả: <color=gold>+20<color>",
	[3] = "<color=yellow>Đơn Tâm Hộ Thân Phù<color>\n"..
		"Mỗi 5 giây hồi phục sinh lực: <color=gold>+50 điểm<color>\n"..
		"Mỗi 5 giây hồi phục nội lực: <color=gold>+50 điểm<color>\n"..
		"Mỗi 5 giây hồi phục thể lực: <color=gold>+50 điểm<color>\n"..
		"Kháng tất cả: <color=gold>+25<color>",
	[4] = "<color=yellow>Kim Long Hộ Thân Phù<color>\n"..
		"Mỗi 5 giây hồi phục sinh lực: <color=gold>+60 điểm<color>\n"..
		"Mỗi 5 giây hồi phục nội lực: <color=gold>+60 điểm<color>\n"..
		"Mỗi 5 giây hồi phục thể lực: <color=gold>+60 điểm<color>\n"..
		"Kháng tất cả: <color=gold>+30<color>",		
};
tbPlayerPanel.tbLienTuLinh = {
	[1] = "<color=yellow>Bích Huyết Hạng Liên<color>\n"..
		"Phát huy lực tấn công cơ bản: <color=gold>+10%<color>\n"..
		"Bỏ qua né tránh đối thủ: <color=gold>+155<color>\n"..
		"Chuyển hóa sát thương thành nội lực Trả lời: <color=gold>+1%<color>\n"..
		"Cường hóa ngũ hành tương khắc: <color=gold>+55 điểm<color>",
	[2] = "<color=yellow>Kim Lân Hạng Liên<color>\n"..
		"Phát huy lực tấn công cơ bản: <color=gold>+17%<color>\n"..
		"Bỏ qua né tránh đối thủ: <color=gold>+415<color>\n"..
		"Chuyển hóa sát thương thành nội lực Trả lời: <color=gold>+3%<color>\n"..
		"Cường hóa ngũ hành tương khắc: <color=gold>+135 điểm<color>",
	[3] = "<color=yellow>Đơn Tâm Hạng Liên<color>\n"..
		"Phát huy lực tấn công cơ bản: <color=gold>+25%<color>\n"..
		"Bỏ qua né tránh đối thủ: <color=gold>+605<color>\n"..
		"Chuyển hóa sát thương thành nội lực Trả lời: <color=gold>+5%<color>\n"..
		"Cường hóa ngũ hành tương khắc: <color=gold>+205 điểm<color>",
	[4] = "<color=yellow>Kim Long Hạng Liên<color>\n"..
		"Phát huy lực tấn công cơ bản: <color=gold>+32%<color>\n"..
		"Bỏ qua né tránh đối thủ: <color=gold>+798<color>\n"..
		"Chuyển hóa sát thương thành nội lựcTrả lời: <color=gold>+7%<color>\n"..
		"Cường hóa ngũ hành tương khắc: <color=gold>+265 điểm<color>",		
};
tbPlayerPanel.tbLungTuLinh = {
	[1] = "<color=yellow>Bích Huyết Thúc Yêu<color>\n"..
		"Kháng tất cả: <color=gold>+70<color>\n"..
		"Sinh lực tối đa: <color=gold>+500 điểm<color>\n"..
		"Nhược hóa ngũ hành tương khắc: <color=gold>+55 điểm<color>",
	[2] = "<color=yellow>Kim Lân Thúc Yêu<color>\n"..
		"Kháng tất cả: <color=gold>+105<color>\n"..
		"Sinh lực tối đa: <color=gold>+1000 điểm<color>\n"..
		"Nhược hóa ngũ hành tương khắc: <color=gold>+135 điểm<color>",
	[3] = "<color=yellow>Đơn Tâm Thúc Yêu<color>\n"..
		"Kháng tất cả: <color=gold>+140<color>\n"..
		"Sinh lực tối đa: <color=gold>+1500 điểm<color>\n"..
		"Nhược hóa ngũ hành tương khắc: <color=gold>+205 điểm<color>",
	[4] = "<color=yellow>Kim Long Thúc Yêu<color>\n"..
		"Kháng tất cả: <color=gold>+175<color>\n"..
		"Sinh lực tối đa: <color=gold>+2000 điểm<color>\n"..
		"Nhược hóa ngũ hành tương khắc: <color=gold>+265 điểm<color>",		
};
tbPlayerPanel.tbGiayTuLinh = {
	[1] = "<color=yellow>Bích Huyết Chiến Ngoa<color>\n"..
		"Tăng vật công ngoại: <color=gold>+2560 điểm<color>\n"..
		"Tăng vật công nội: <color=gold>+2560 điểm<color>\n"..
		"Tăng tỷ lệ chí mạng: <color=gold>+10%<color>",
	[2] = "<color=yellow>Kim Lân Chiến Ngoa<color>\n"..
		"Tăng vật công ngoại: <color=gold>+4100 điểm<color>\n"..
		"Tăng vật công nội: <color=gold>+4100 điểm<color>\n"..
		"Tăng tỷ lệ chí mạng: <color=gold>+15%<color>",
	[3] = "<color=yellow>Đơn Tâm Chiến Ngoa<color>\n"..
		"Tăng vật công ngoại: <color=gold>+5120 điểm<color>\n"..
		"Tăng vật công nội: <color=gold>+5120 điểm<color>\n"..
		"Tăng tỷ lệ chí mạng: <color=gold>+20%<color>",
	[4] = "<color=yellow>Kim Long Chiến Ngoa<color>\n"..
		"Tăng vật công ngoại: <color=gold>+6140 điểm<color>\n"..
		"Tăng vật công nội: <color=gold>+6140 điểm<color>\n"..
		"Tăng tỷ lệ chí mạng: <color=gold>+30%<color>",		
};
tbPlayerPanel.tbBoiTuLinh = {
	[1] = "<color=yellow>Bích Huyết Bội<color>\n"..
		"Phát huy lực tấn công cơ bản: <color=gold>+5%<color>\n"..
		"Phát huy lực tấn công kỹ năng: <color=gold>+5%<color>\n"..
		"Thể lực tối đa: <color=gold>+500 điểm<color>",
	[2] = "<color=yellow>Kim Lân Bội<color>\n"..
		"Phát huy lực tấn công cơ bản: <color=gold>+10%<color>\n"..
		"Phát huy lực tấn công kỹ năng: <color=gold>+10%<color>\n"..
		"Thể lực tối đa: <color=gold>+750 điểm<color>",
	[3] = "<color=yellow>Đơn Tâm Bội<color>\n"..
		"Phát huy lực tấn công cơ bản: <color=gold>+15%<color>\n"..
		"Phát huy lực tấn công kỹ năng: <color=gold>+15%<color>\n"..
		"Thể lực tối đa: <color=gold>+1000 điểm<color>",
	[4] = "<color=yellow>Kim Long Bội<color>\n"..
		"Phát huy lực tấn công cơ bản: <color=gold>+20%<color>\n"..
		"Phát huy lực tấn công kỹ năng: <color=gold>+20%<color>\n"..
		"Thể lực tối đa: <color=gold>+1250 điểm<color>",		
};
tbPlayerPanel.tbNonTuLinh = {
	[1] = "<color=yellow>Bích Huyết Chi Quán<color>\n"..
		"Kháng tất cả: <color=gold>+50<color>\n"..
		"Nhược hóa ngũ hành tương khắc: <color=gold>+50<color>\n"..
		"Chịu sát thương chí mạng: <color=gold>-10%<color>",
	[2] = "<color=yellow>Kim Lân Chi Quán<color>\n"..
		"Kháng tất cả: <color=gold>+100<color>\n"..
		"Nhược hóa ngũ hành tương khắc: <color=gold>+135<color>\n"..
		"Chịu sát thương chí mạng: <color=gold>-15%<color>",
	[3] = "<color=yellow>Đơn Tâm Chi Quán<color>\n"..
		"Kháng tất cả: <color=gold>+150<color>\n"..
		"Nhược hóa ngũ hành tương khắc: <color=gold>+205<color>\n"..
		"Chịu sát thương chí mạng: <color=gold>-20%<color>",
	[4] = "<color=yellow>Kim Long Chi Quán<color>\n"..
		"Kháng tất cả: <color=gold>+200<color>\n"..
		"Nhược hóa ngũ hành tương khắc: <color=gold>+265<color>\n"..
		"Chịu sát thương chí mạng: <color=gold>-30%<color>",		
};
tbPlayerPanel.tbInfoNhanCuoi = {
	[1] = "<color=yellow>Nhẫn Tình Yêu-Bạc<color>\n"..
			"\n   <pic=155><pic=154><pic=154><pic=154><pic=154><pic=154><pic=154><pic=154><pic=154><pic=154>\n",
	[3] = "<color=yellow>Nhẫn Tình Yêu-Bạch Kim<color>\n"..
			"\n   <pic=155><pic=155><pic=155><pic=154><pic=154><pic=154><pic=154><pic=154><pic=154><pic=154>\n",
	[6] = "<color=yellow>Nhẫn Tình Yêu-Vàng<color>\n"..
			"\n   <pic=155><pic=155><pic=155><pic=155><pic=155><pic=155><pic=154><pic=154><pic=154><pic=154>\n",
	[10] = "<color=yellow>Nhẫn Tình Yêu-Kim Cương<color>\n"..
			"\n   <pic=155><pic=155><pic=155><pic=155><pic=155><pic=155><pic=155><pic=155><pic=155><pic=155>\n"
}
function tbPlayerPanel:OnMouseEnter(szWnd)
	local nLevelHuyet1 = me.GetSkillLevel(1958)
	local nLevelHuyet2 = me.GetSkillLevel(1959)
	local nLevelHuyet3 = me.GetSkillLevel(1960)
	local nLevelHuyet4 = me.GetSkillLevel(1961)
	local nLevelHuyet5 = me.GetSkillLevel(1962)
	local nLevelHuyet6 = me.GetSkillLevel(1963)
	local nLevelHuyet7 = me.GetSkillLevel(1964)
	local nLevelHuyet8 = me.GetSkillLevel(1965)
	local nLevelHuyet9 = me.GetSkillLevel(1966)
	local nLevelHuyet10 = me.GetSkillLevel(1967)
	local nLevelHuyet11 = me.GetSkillLevel(1968)
	local nLevelHuyet12 = me.GetSkillLevel(1969)
	local nLevelHuyet13 = me.GetSkillLevel(1970)
	local nLevelHuyet14 = me.GetSkillLevel(1971)
	local nLevelHuyet15 = me.GetSkillLevel(1972)
	
	local nVKPet = me.GetSkillLevel(1898)
	local nYPPet = me.GetSkillLevel(1899)
	local nGCPet = me.GetSkillLevel(1900)
	local nHUPet = me.GetSkillLevel(1901)
	local nHPPet = me.GetSkillLevel(1902)
	local nHLPet = me.GetSkillLevel(1903)
	local nDLPet = me.GetSkillLevel(1904)
	local nCNPet = me.GetSkillLevel(1905)
	local nHBPet = me.GetSkillLevel(1906)
	local nNPet = me.GetSkillLevel(1907)

	local nBaoChauNon = me.GetSkillLevel(1908)
	local nBaoChauAo = me.GetSkillLevel(1909)
	local nBaoChauLung = me.GetSkillLevel(1910)
	local nBaoChauTay = me.GetSkillLevel(1911)
	local nBaoChauGiay = me.GetSkillLevel(1912)
	local nBaoChauVuKhi = me.GetSkillLevel(1913)
	local nBaoChauLien = me.GetSkillLevel(1914)
	local nBaoChauNhan = me.GetSkillLevel(1915)
	local nBaoChauBoi = me.GetSkillLevel(1916)
	local nBaoChauPhu = me.GetSkillLevel(1917)	
	
	local nNhanCuoi = me.GetSkillLevel(1897)
	local szHonPhu = me.GetTaskStr(7729,4)
	local szNameHonPhu = "";
	if szHonPhu ~= "" then
		szNameHonPhu = szHonPhu;
	else
		szNameHonPhu = "Không";
	end
	local nMate = "Phu nhân: "..szNameHonPhu.."";
	if me.nSex == 1 then
		nMate = "Tướng công: "..szNameHonPhu.."";
	end
	local szTip = "";
	if (szWnd == TEXT_BASIC_AS) then
		szTip = me.GetAttackSpeedTip();
	elseif (szWnd == EDIT_BASIC_STR) then
		szTip = me.GetPotentialTip(Player.ATTRIB_STR);
	elseif (szWnd == EDIT_BASIC_DEX) then
		szTip = me.GetPotentialTip(Player.ATTRIB_DEX);
	elseif (szWnd == EDIT_BASIC_VIT) then
		szTip = me.GetPotentialTip(Player.ATTRIB_VIT);
	elseif (szWnd == EDIT_BASIC_ENG) then
		szTip = me.GetPotentialTip(Player.ATTRIB_ENG);
	elseif (szWnd == TEXT_BASIC_GR) then
		szTip = me.GetResistTip(Env.SERIES_METAL);
	elseif (szWnd == TEXT_BASIC_PR) then
		szTip = me.GetResistTip(Env.SERIES_WOOD);
	elseif (szWnd == TEXT_BASIC_CR) then
		szTip = me.GetResistTip(Env.SERIES_WATER);
	elseif (szWnd == TEXT_BASIC_FR) then
		szTip = me.GetResistTip(Env.SERIES_FIRE);
	elseif (szWnd == TEXT_BASIC_LR) then
		szTip = me.GetResistTip(Env.SERIES_EARTH);
	elseif (szWnd == BTN_BASIC_ASSAUTO or szWnd == TEXT_BASIC_REMAIN) then
		szTip = "Trước cấp 60 điểm tiềm năng được hệ thống tự động phân phối khi tăng cấp\nSau cấp 60 có thể đến chỗ <color=green>Chưởng môn môn phái<color> để vào <color=green>Tẩy Tủy Đảo<color> tẩy điểm"
	elseif (szWnd == TEXT_KINHMACH_HUYET1) then		
		szTip = "Ngoại công +"..self.tbInfoHuyet1[nLevelHuyet1].." điểm"
	elseif (szWnd == TEXT_KINHMACH_HUYET2) then		
		szTip = "Nội công +"..self.tbInfoHuyet1[nLevelHuyet2].." điểm"		
	elseif (szWnd == TEXT_KINHMACH_HUYET3) then		
		szTip = "Thân pháp +"..self.tbInfoHuyet1[nLevelHuyet3].." điểm"
	elseif (szWnd == TEXT_KINHMACH_HUYET4) then		
		szTip = "Sức mạnh +"..self.tbInfoHuyet1[nLevelHuyet4].." điểm"
	elseif (szWnd == TEXT_KINHMACH_HUYET5) then		
		szTip = "Tỉ lệ sinh lực tối đa tăng "..self.tbInfoHuyet1[nLevelHuyet5].."%"
	elseif (szWnd == TEXT_KINHMACH_HUYET6) then		
		szTip = "Tỉ lệ nội lực tối đa tăng ".. self.tbInfoHuyet1[nLevelHuyet6]/2 .."%"
	elseif (szWnd == TEXT_KINHMACH_HUYET7) then		
		szTip = "Cường hóa tương khắc +".. self.tbInfoHuyet1[nLevelHuyet7]*10 .." điểm"
	elseif (szWnd == TEXT_KINHMACH_HUYET8) then		
		szTip = "Nhược hóa tương khắc +".. self.tbInfoHuyet1[nLevelHuyet8]*10 .." điểm"
	elseif (szWnd == TEXT_KINHMACH_HUYET9) then		
		szTip = "Kháng tất cả +".. self.tbInfoHuyet1[nLevelHuyet9]*2 .." điểm"
	elseif (szWnd == TEXT_KINHMACH_HUYET10) then		
		szTip = "Bỏ qua né tránh đối thủ +".. self.tbInfoHuyet1[nLevelHuyet10]*5 .." điểm"
	elseif (szWnd == TEXT_KINHMACH_HUYET11) then		
		szTip = "Phát huy lực tấn công cơ bản +".. self.tbInfoHuyet1[nLevelHuyet11]/2 .."%"
	elseif (szWnd == TEXT_KINHMACH_HUYET12) then		
		szTip = "Phát huy lực tấn công kỹ năng +".. self.tbInfoHuyet1[nLevelHuyet12]/2 .."%"
	elseif (szWnd == TEXT_KINHMACH_HUYET13) then		
		szTip = "Tấn công khi đánh chí mạng +".. self.tbInfoHuyet1[nLevelHuyet13]/2 .."%"
	elseif (szWnd == TEXT_KINHMACH_HUYET14) then		
		szTip = "Chịu sát thương chí mạng -".. self.tbInfoHuyet1[nLevelHuyet14]/2 .."%"
	elseif (szWnd == TEXT_KINHMACH_HUYET15) then		
		szTip = "Sinh lực tối đa +".. self.tbInfoHuyet1[nLevelHuyet15]*100 .." điểm"					
	elseif (szWnd == IMG_PLAYER_BAOCHAUNON) then	
		if nBaoChauNon < 1 then
			szTip = "<color=yellow>Bảo Châu-Nón <color=red>(Chưa Mở)<color><color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Sinh lực tối đa: +0 điểm\n"..
			"Tỉ lệ sinh lực tối đa: +0%"
		else
			szTip = "<color=yellow>Bảo Châu-Nón<color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nBaoChauNon.."/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Sinh lực tối đa: +".. nBaoChauNon*100 .." điểm\n"..
			"Tỉ lệ sinh lực tối đa: +".. nBaoChauNon*10 .."%"			
		end
	elseif (szWnd == IMG_PLAYER_BAOCHAUAO) then		
		if nBaoChauAo < 1 then
			szTip = "<color=yellow>Bảo Châu-Áo <color=red>(Chưa Mở)<color><color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Tỉ lệ nội lực tối đa: +0%"
		else
			szTip = "<color=yellow>Bảo Châu-Áo<color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nBaoChauAo.."/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Tỉ lệ nội lực tối đa: +".. nBaoChauAo*5 .."%"			
		end
	elseif (szWnd == IMG_PLAYER_BAOCHAULUNG) then		
		if nBaoChauLung < 1 then
			szTip = "<color=yellow>Bảo Châu-Lưng <color=red>(Chưa Mở)<color><color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Kinh nghiệm giết địch: +0%"
		else
			szTip = "<color=yellow>Bảo Châu-Lưng<color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nBaoChauLung.."/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Kinh nghiệm giết địch: +".. nBaoChauLung*5 .."%"
		end
	elseif (szWnd == IMG_PLAYER_BAOCHAUTAY) then		
		if nBaoChauTay < 1 then
			szTip = "<color=yellow>Bảo Châu-Tay <color=red>(Chưa Mở)<color><color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Kháng tất cả: +0"
		else
			szTip = "<color=yellow>Bảo Châu-Tay<color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nBaoChauTay.."/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Kháng tất cả: +".. nBaoChauTay*20 ..""		
		end
	elseif (szWnd == IMG_PLAYER_BAOCHAUGIAY) then		
		if nBaoChauGiay < 1 then
			szTip = "<color=yellow>Bảo Châu-Giày <color=red>(Chưa Mở)<color><color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Bỏ qua né tránh đối thủ: +0"
		else
			szTip = "<color=yellow>Bảo Châu-Giày<color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nBaoChauGiay.."/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Bỏ qua né tránh đối thủ: +".. nBaoChauGiay*50 ..""		
		end
	elseif (szWnd == IMG_PLAYER_BAOCHAUVKHI) then		
		if nBaoChauVuKhi < 1 then
			szTip = "<color=yellow>Bảo Châu-Vũ Khí <color=red>(Chưa Mở)<color><color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Lực tấn công cơ bản: +0%"
		else
			szTip = "<color=yellow>Bảo Châu-Vũ Khí<color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nBaoChauVuKhi.."/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Lực tấn công cơ bản: +".. nBaoChauVuKhi*3 .."%"		
		end
	elseif (szWnd == IMG_PLAYER_BAOCHAULIEN) then		
		if nBaoChauLien < 1 then
			szTip = "<color=yellow>Bảo Châu-Liên <color=red>(Chưa Mở)<color><color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Chí mạng: +0\n"..
			"Tấn công khi đánh chí mạng: +0%"
		else
			szTip = "<color=yellow>Bảo Châu-Liên<color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nBaoChauLien.."/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Chí mạng: +".. nBaoChauLien*40 .."\n"..
			"Tấn công khi đánh chí mạng: +".. nBaoChauLien*5 .."%"		
		end
	elseif (szWnd == IMG_PLAYER_BAOCHAUNHAN) then		
		if nBaoChauNhan < 1 then
			szTip = "<color=yellow>Bảo Châu-Nhẫn <color=red>(Chưa Mở)<color><color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Lực tấn công kỹ năng: +0%"
		else
			szTip = "<color=yellow>Bảo Châu-Nhẫn<color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nBaoChauNhan.."/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Lực tấn công kỹ năng: +".. nBaoChauNhan*3 .."%"		
		end
	elseif (szWnd == IMG_PLAYER_BAOCHAUBOI) then		
		if nBaoChauBoi < 1 then
			szTip = "<color=yellow>Bảo Châu-Bội <color=red>(Chưa Mở)<color><color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Né tránh: +0 điểm\n"..
			"Chịu sát thương chí mạng: -0%"
		else
			szTip = "<color=yellow>Bảo Châu-Bội<color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nBaoChauBoi.."/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Né tránh: +".. nBaoChauBoi*60 .." điểm\n"..
			"Chịu sát thương chí mạng: -".. nBaoChauBoi*4 .."%"		
		end
	elseif (szWnd == IMG_PLAYER_BAOCHAUPHU) then		
		if nBaoChauPhu < 1 then
			szTip = "<color=yellow>Bảo Châu-Phù <color=red>(Chưa Mở)<color><color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Mỗi nửa giây hồi phục sinh lực: +0 điểm\n"..		
			"Mỗi nửa giây hồi phục nội lực: +0 điểm"
		else
			szTip = "<color=yellow>Bảo Châu-Phù<color>\n\n"..
			"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nBaoChauPhu.."/10<color>\n\n"..
			"<color=green>Thuộc tính cơ bản\n\n<color>"..
			"Mỗi nửa giây hồi phục sinh lực: +".. nBaoChauPhu*17 .." điểm\n"..		
			"Mỗi nửa giây hồi phục nội lực: +".. nBaoChauPhu*14 .." điểm"		
		end
	elseif (szWnd == IMG_BEBI) then
		if nNhanCuoi < 1 then
			szTip = "<color=red>Lv50 trở lên tổ chức tiệc cưới mới có thể kích hoạt tính năng này<color>"
		else
			szTip = "<color=gold>Bé Yêu Lv"..nNhanCuoi.."<color>\n\n"..
			"<color=green>Lực tấn công cơ bản: ".. nNhanCuoi*2 .."%\n"..
			"Lực tấn công kỹ năng: ".. nNhanCuoi*2 .."%\n"..
			"Sinh lực tối đa: +".. nNhanCuoi*90 .." điểm\n"..
			"Kháng tất cả: +".. nNhanCuoi*11 .."\n"..
			"Tỉ lệ sinh lực tối đa: Tăng ".. nNhanCuoi*9 .."%<color>\n\n"..
			"<color=gold>Kích hoạt Bé Yêu sẽ tăng thuộc\ntính cho cả Mẹ và Cha<color>"
		end
	elseif (szWnd == IMG_TULINH_VKHI) then
		if nVKPet < 1 then
			szTip = "<color=yellow>Trường Sinh <color=red>(Chưa học)<color><color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Tăng điểm sinh lực tối đa của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10 cấp<color>\n\n"..
					"Sinh lực tối đa: <color=gold>+0 điểm<color>"
		else
			szTip = "<color=yellow>Trường Sinh<color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Tăng điểm sinh lực tối đa của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nVKPet.."/10 cấp<color>\n\n"..	
					"Sinh lực tối đa: <color=gold>+".. nVKPet*1000 .." điểm<color>"					
		end
	elseif (szWnd == IMG_TULINH_YPHUC) then	
		if nYPPet < 1 then
			szTip = "<color=yellow>Diên Thọ <color=red>(Chưa học)<color><color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Tăng hiệu suất hồi phục sinh lực và nội lực của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10 cấp<color>\n\n"..
					"Hiệu suất hồi phục sinh lực: <color=gold>+0%<color>\n"..	
					"Hiệu suất hồi phục nội lực: <color=gold>+0%<color>"
		else
			szTip = "<color=yellow>Diên Thọ<color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Tăng hiệu suất hồi phục sinh lực và nội lực của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nYPPet.."/10 cấp<color>\n\n"..
					"Hiệu suất hồi phục sinh lực: <color=gold>+".. nYPPet*4 .."%<color>\n"..	
					"Hiệu suất hồi phục nội lực: <color=gold>+".. nYPPet*2 .."%<color>"		
		end
	elseif (szWnd == IMG_TULINH_NHAN) then	
		if nGCPet < 1 then
			szTip = "<color=yellow>Cản Thiền <color=red>(Chưa học)<color><color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Tăng điểm né tránh của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10 cấp<color>\n\n"..
					"Né tránh: <color=gold>+0 điểm<color>"
		else
			szTip = "<color=yellow>Cản Thiền<color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Tăng điểm né tránh của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nGCPet.."/10 cấp<color>\n\n"..
					"Né tránh: <color=gold>+".. nGCPet*64 .." điểm<color>"		
		end
	elseif (szWnd == IMG_TULINH_TAY) then	
		if nHUPet < 1 then
			szTip = "<color=yellow>Thiết Giáp <color=red>(Chưa học)<color><color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Tăng toàn bộ kháng tính của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10 cấp<color>\n\n"..
					"Kháng tất cả: <color=gold>+0 điểm<color>"
		else
			szTip = "<color=yellow>Thiết Giáp<color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Tăng toàn bộ kháng tính của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nHUPet.."/10 cấp<color>\n\n"..
					"Kháng tất cả: <color=gold>+".. nHUPet*11 .." điểm<color>"		
		end
	elseif (szWnd == IMG_TULINH_PHU) then	
		if nHPPet < 1 then
			szTip = "<color=yellow>Lãng Đào Sa <color=red>(Chưa học)<color><color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Giảm sát thương chí mạng phải chịu của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10 cấp<color>\n\n"..
					"Chịu sát thương chí mạng: <color=gold>-0 %<color>"
		else
			szTip = "<color=yellow>Lãng Đào Sa<color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Giảm sát thương chí mạng phải chịu của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nHPPet.."/10 cấp<color>\n\n"..
					"Chịu sát thương chí mạng: <color=gold>-".. nHPPet*5 .." %<color>"		
		end
	elseif (szWnd == IMG_TULINH_LIEN) then	
		if nHLPet < 1 then
			szTip = "<color=yellow>Diệu Mã <color=red>(Chưa học)<color><color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Tăng thể lực tối đa của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10 cấp<color>\n\n"..
					"Thể lực tối đa: <color=gold>+0 điểm<color>"
		else
			szTip = "<color=yellow>Diệu Mã<color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Tăng thể lực tối đa của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nHLPet.."/10 cấp<color>\n\n"..
					"Thể lực tối đa: <color=gold>+".. nHLPet*100 .." điểm<color>"				
		end
	elseif (szWnd == IMG_TULINH_LUNG) then		
		if nDLPet < 1 then
			szTip = "<color=yellow>Dương Mã <color=red>(Chưa học)<color><color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Tăng kinh nghiệm khi giết địch của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10 cấp<color>\n\n"..
					"Kinh nghiệm giết địch: <color=gold>+0 %<color>"
		else
			szTip = "<color=yellow>Dương Mã<color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Tăng kinh nghiệm khi giết địch của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nDLPet.."/10 cấp<color>\n\n"..
					"Kinh nghiệm giết địch: <color=gold>+".. nDLPet*5 .." %<color>"				
		end
	elseif (szWnd == IMG_TULINH_GIAY) then		
		if nCNPet < 1 then
			szTip = "<color=yellow>Phục Hổ Thức <color=red>(Chưa học)<color><color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Tăng điểm chí mạng và tấn công chí mạng của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10 cấp<color>\n\n"..
					"Chí mạng: <color=gold>+0 điểm<color>\n"..
					"Tấn công khi đánh chí mạng: <color=gold>+0 %<color>"
		else
			szTip = "<color=yellow>Phục Hổ Thức<color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Tăng điểm chí mạng và tấn công chí mạng của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nCNPet.."/10 cấp<color>\n\n"..
					"Chí mạng: <color=gold>+".. nCNPet*48 .." điểm<color>\n"..
					"Tấn công khi đánh chí mạng: <color=gold>+".. nCNPet*6 .." %<color>"		
		end
	elseif (szWnd == IMG_TULINH_BOI) then		
		if nHBPet < 1 then
			szTip = "<color=yellow>Hỏa Bạo Viêm <color=red>(Chưa học)<color><color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Tăng lực tấn công cơ bản của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10 cấp<color>\n\n"..
					"Phát huy lực tấn công cơ bản: <color=gold>+0 %<color>"
		else
			szTip = "<color=yellow>Hỏa Bạo Viêm<color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Tăng lực tấn công cơ bản của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nHBPet.."/10 cấp<color>\n\n"..
					"Phát huy lực tấn công cơ bản: <color=gold>+".. nHBPet*5 .." %<color>"		
		end
	elseif (szWnd == IMG_TULINH_MU) then
		if nNPet < 1 then
			szTip = "<color=yellow>Kim Lợi Nhẫn <color=red>(Chưa học)<color><color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Tăng lực tấn công kỹ năng của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>0/10 cấp<color>\n\n"..
					"Phát huy lực tấn công kỹ năng: <color=gold>+0 %<color>"
		else
			szTip = "<color=yellow>Kim Lợi Nhẫn<color>\n\n"..
					"<color=green>Cấp học: 50<color>\n"..
					"<color=metal>Hỗ trợ bị động<color>\n\n"..
					"Tăng lực tấn công kỹ năng của chủ nhân.\n\n"..
					"<color=cyan>Cấp hiện tại:<color> <color=gold>"..nNPet.."/10 cấp<color>\n\n"..
					"Phát huy lực tấn công kỹ năng: <color=gold>+".. nNPet*5 .." %<color>"		
		end
	end
	
	if (szTip ~= "") then
		Wnd_ShowMouseHoverInfo(self.UIGROUP, szWnd, "", szTip);
	end
end

function tbPlayerPanel:OnMouseLeave(szWnd)
	Wnd_HideMouseHoverInfo();
end

function tbPlayerPanel:UpdateBasicRemain()
	Txt_SetTxt(self.UIGROUP, TEXT_BASIC_REMAIN, "Tiềm năng: "..self.nRemain);
end

function tbPlayerPanel:UpdateReputeName()
	Txt_SetTxt(self.UIGROUP, TEXT_REPUTE_NAME, me.szName);
end

function tbPlayerPanel:UpdateTitleName()
	Txt_SetTxt(self.UIGROUP, TEXT_TITLE_NAME, me.szName);
end

function tbPlayerPanel:UpdatePlayerTitleInfo()
	self:ResetTitleData()
	local theTitleTable = me.GetAllTitle();
	if theTitleTable == nil then
		return;
	end
	for i = 1, #theTitleTable do
		self:InsertTitleItem(theTitleTable[i]);
	end
end

function tbPlayerPanel:UpdateEquipment()
	for _, tbCont in pairs(self.tbEquipCont) do
		tbCont.nRoom = Item.ROOM_EQUIP;
		tbCont:UpdateRoom();
	end
	self:SetShowEquipState();	-- 设置替换装备按钮是否可用
end

function tbPlayerPanel:UpdateEquipEx()
	for _, tbEquipType in pairs(SELF_SWITCHABLE_EQUIP) do
		local tbCont = self.tbEquipCont[tbEquipType[1]];
		tbCont.nRoom = Item.ROOM_EQUIPEX;
		tbCont:UpdateRoom();
	end
	self:SetShowEquipState();	-- 设置替换装备按钮是否可用
end

function tbPlayerPanel:GetEquipPos(szWnd)
	for _, tbEquipItem in ipairs(SELF_EQUIPMENT) do
		if (tbEquipItem[2] == szWnd) then
			return tbEquipItem[1];
		end
	end
end

function tbPlayerPanel:GetEquipWndTableItem(nPosition)
	for _, tbEquipItem in ipairs(SELF_EQUIPMENT) do
		if tbEquipItem[1] == nPosition then
			return tbEquipItem;
		end
	end
end

function tbPlayerPanel:SetEquipPosHighLight(tbObj)
	local nRet = 1;
	if not tbObj or tbObj.nType ~= Ui.OBJ_OWNITEM then
		self:ReleaseEquipPosHighLight();
		return;
	end
	local pItem = me.GetItem(tbObj.nRoom, tbObj.nX, tbObj.nY);
	if (not pItem) or (not pItem.nEquipPos) then
		self:ReleaseEquipPosHighLight();
		return;
	end
	-- me.Msg("tbObj.nRoom player: " .. tostring(tbObj.nRoom));
	-- me.Msg("tbObj.nX player: " .. tostring(tbObj.nX));
	-- me.Msg("tbObj.nY player: " .. tostring(tbObj.nY));
	-- me.Msg("pItem.nEquipPos player: " .. tostring(pItem.nEquipPos));
	local nPosition = pItem.nEquipPos;
	local tbEquipWnd = self:GetEquipWndTableItem(nPosition);
	if tbEquipWnd then
		self.m_szHighLightEquipPos = tbEquipWnd[3];
		Img_SetFrame(self.UIGROUP, self.m_szHighLightEquipPos, 0);
	end
end

function tbPlayerPanel:ReleaseEquipPosHighLight()
	if self.m_szHighLightEquipPos == nil then
		return;
	end
	Img_SetFrame(self.UIGROUP, self.m_szHighLightEquipPos, 1);
	self.m_szHighLightEquipPos = nil;
end

function tbPlayerPanel:OnOutLookItemSelected(szWndName, nGroupIndex, nItemIndex)

	if (szWndName ~= OUTLOOK_TITLE) then
		return;
	end

	self.m_nSelTitleX = nGroupIndex;
	self.m_nSelTitleY = nItemIndex;

	local szDesc = self.tbTitleTable[nGroupIndex+1].TitleData[nItemIndex+1].szTitleDesc;
	Txt_SetTxt(self.UIGROUP, TEXT_TITLE_DESCRIBE, szDesc);

	if self:IsCurActiveTitle( nGroupIndex+1, nItemIndex+1 ) == 1 then		-- 被选中的那行
		Wnd_SetEnable(self.UIGROUP, BTN_ACTIVE_TITLE, 0);
		Wnd_SetEnable(self.UIGROUP, BTN_INACTIVE_TITLE, 1);
	else
		Wnd_SetEnable(self.UIGROUP, BTN_ACTIVE_TITLE, 1);
		Wnd_SetEnable(self.UIGROUP, BTN_INACTIVE_TITLE, 0);
	end

end

function tbPlayerPanel:UpdateTitleOutLook()

	OutLookPanelClearAll(self.UIGROUP, OUTLOOK_TITLE);
	AddOutLookPanelColumnHeader(self.UIGROUP, OUTLOOK_TITLE, "");
	AddOutLookPanelColumnHeader(self.UIGROUP, OUTLOOK_TITLE, "");
	AddOutLookPanelColumnHeader(self.UIGROUP, OUTLOOK_TITLE, "");
	AddOutLookPanelColumnHeader(self.UIGROUP, OUTLOOK_TITLE, "");
	SetOutLookHeaderWidth(self.UIGROUP, OUTLOOK_TITLE, 0, 30);
	SetOutLookHeaderWidth(self.UIGROUP, OUTLOOK_TITLE, 1, 120);
	SetOutLookHeaderWidth(self.UIGROUP, OUTLOOK_TITLE, 2, 120);
	SetOutLookHeaderWidth(self.UIGROUP, OUTLOOK_TITLE, 3, 30);

	if self.tbTitleTable == nil then
		return;
	end

	local byTitleGenre, byTitleDetailType, byTitleLevel, dwTitleParam = me.GetCurTitle();
	local szIsActiveTitle = "";

	for i = 1, #self.tbTitleTable do
		AddOutLookGroup(self.UIGROUP, OUTLOOK_TITLE, self.tbTitleTable[i].szTitleGenreAttr)
		for j = 1, #self.tbTitleTable[i].TitleData do
			local tItem = self.tbTitleTable[i].TitleData[j]
			if tItem ~= nil then
				local szEndTime = "";
				if (tItem.tTitleEndTime == 0) then
					szEndTime = "--";
				else
					szEndTime = os.date("%Y/%m/%d %H:%M", tItem.tTitleEndTime);
				end
				if self:IsCurActiveTitle(i, j) == 1 then
					szIsActiveTitle = "★";
				else
					szIsActiveTitle = " ";
				end
				local tOLItem = { szIsActiveTitle, tItem.szTitleName, szEndTime, tItem.byTitleRank };
				AddOutLookItem(self.UIGROUP,  OUTLOOK_TITLE, i - 1, tOLItem );
			end
		end
		if i ~= 1 then
			SetGroupCollapseState(self.UIGROUP, OUTLOOK_TITLE, i - 1, 0);
		end
	end

end

function tbPlayerPanel:IsCurActiveTitle(nX, nY)

	if (not nX) or (not nY) or (nX <= 0) or (nY <= 0) then
		return 0;
	end

	local tGroup = self.tbTitleTable[nX];
	if type(tGroup) ~= "table" then
		return 0;
	end
	local tItem = tGroup.TitleData[nY];
	if type(tItem) ~= "table" then
		return 0;
	end

	local nTitleGenre, nTitleDetailType, nTitleLevel = me.GetCurTitle();
	if nTitleGenre == tItem.byTitleGenre and nTitleDetailType == tItem.byTitleDetailType and nTitleLevel == tItem.byTitleLevel then
		return 1;
	else
		return 0;
	end

end

function tbPlayerPanel:SwitchEquipPage()
	if self.nShowEquipEx == 1 then
		self.nShowEquipEx = 0;
		self:UpdateEquipment();
	else
		self.nShowEquipEx = 1;
		self:UpdateEquipEx();
	end
	self:UpdateEquipDur();
end

function tbPlayerPanel:ApplySwitchEquip(bReFresh)
	local tbPair = {};
	local nCount = 0;
	for _, tbEquipType in ipairs(SELF_SWITCHABLE_EQUIP) do
		local nEquipPos   = tbEquipType[1];
		local pEquipEx    = me.GetEquipEx(nEquipPos);
		if pEquipEx then
			nCount = nCount + 1;
			tbPair[nCount] = { nEquipPos, Item:EqPos2EqExPos(nEquipPos) };
		end
	end
	if nCount == 0 then
		me.Msg("Bạn không có trang bị dự phòng, không thể đổi!");
		return;
	end
	me.SwitchEquip(nCount, tbPair);
	self.nShowEquipEx = 0;
	if bReFresh then				-- 快捷键加参数不刷新OBJ空间 防止弹TIP
		self:SetShowEquipState();
	else
		self:UpdateEquipment();
	end
	self:UpdateEquipDur();
end

function tbPlayerPanel:IsSwitchEquip(szEquipPos)
	for _, tbEquipType in ipairs(SELF_SWITCHABLE_EQUIP) do
		if (tbEquipType[2] == szEquipPos) then
			return 1;
		end
	end
	return 0;
end

function tbPlayerPanel:SetShowEquipState()
	if self.nShowEquipEx == 1 then
		Btn_SetTxt(self.UIGROUP, BTN_EQUIP_PAGE, "Hiện tại");
	else
		Btn_SetTxt(self.UIGROUP, BTN_EQUIP_PAGE, "Dự phòng");
	end
end

function tbPlayerPanel:UpdateFaction()
	self:UpdateBasicFaction();
end

function tbPlayerPanel:UpdateEquipDur()
	for _, tbCont in pairs(self.tbEquipCont) do
		if tbCont then
			local pItem = me.GetItem(tbCont.nRoom, tbCont.nOffsetX, tbCont.nOffsetY);
			if pItem then
				if tbCont.nOffsetX >= Item.EQUIPEXPOS_HEAD and tbCont.nOffsetX <= Item.EQUIPEXPOS_PENDANT then
					ObjGrid_ShowSubScript(tbCont.szUiGroup, tbCont.szObjGrid, 1, 0, 0);
					local nPerDur = math.ceil((pItem.nCurDur / pItem.nMaxDur) * 100)
					if nPerDur > 0 and nPerDur <= 10 then
						ObjGrid_ChangeSubScriptColor(tbCont.szUiGroup, tbCont.szObjGrid, "Red");
					elseif nPerDur > 10 and nPerDur <= 60 then
						ObjGrid_ChangeSubScriptColor(tbCont.szUiGroup, tbCont.szObjGrid, "yellow");
					elseif nPerDur > 60 then
						ObjGrid_ChangeSubScriptColor(tbCont.szUiGroup, tbCont.szObjGrid, "green");
					end
				
					local szDur = tostring(nPerDur).."%";
					ObjGrid_ChangeSubScript(tbCont.szUiGroup, tbCont.szObjGrid, szDur, 0, 0);
				end
			end
		end
	end
end

function tbPlayerPanel:RegisterEvent()
	local tbRegEvent =
	{
		{ UiNotify.emCOREEVENT_SYNC_SERIES,			self.UpdateBasicSeries },
		{ UiNotify.emCOREEVENT_SYNC_LEVEL,			self.UpdateBasicLevel },
		{ UiNotify.emCOREEVENT_SYNC_EXP,			self.UpdateBasicExp },
		{ UiNotify.emCOREEVENT_SYNC_FACTION,		self.UpdateFaction },
		{ UiNotify.emCOREEVENT_SYNC_PKVALUE,		self.UpdateBasicPKValue },
		{ UiNotify.emCOREEVENT_SYNC_LIFE,			self.UpdateBasicLife },
		{ UiNotify.emCOREEVENT_SYNC_MANA,			self.UpdateBasicMana },
		{ UiNotify.emCOREEVENT_SYNC_STAMINA,		self.UpdateBasicStamina },
		{ UiNotify.emCOREEVENT_SYNC_GTP,			self.UpdateBasicGTP },
		{ UiNotify.emCOREEVENT_SYNC_MKP,			self.UpdateBasicMKP },
		{ UiNotify.emCOREEVENT_SYNC_RESIST,			self.UpdateBasicResist },
		{ UiNotify.emCOREEVENT_SYNC_DAMAGE,			self.OnSyncDamage },
		{ UiNotify.emCOREEVENT_SYNC_ATTACKRATE,		self.UpdateBasicAttackRate },
		{ UiNotify.emCOREEVENT_SYNC_ATTACKSPEED,	self.UpdateBasicAttackSpeed },
		{ UiNotify.emCOREEVENT_SYNC_DEFENSE,		self.UpdateBasicDefense },
		{ UiNotify.emCOREEVENT_SYNC_RUNSPEED,		self.UpdateBasicRunSpeed },
		{ UiNotify.emCOREEVENT_SYNC_POTENTIAL,		self.OnSyncPotential },
		{ UiNotify.emCOREEVENT_SYNC_REMAIN,			self.OnSyncRemainPotential },
		{ UiNotify.emCOREEVENT_SYNC_PORTRAIT,		self.UpdateBasicPortrait },
		{ UiNotify.emCOREEVENT_SYNC_REPUTE,			self.OnUpdatePageRepute },
		{ UiNotify.emCOREEVENT_SYNC_TITLE,			self.OnUpdatePageTitle },
		{ UiNotify.emCOREEVENT_SYNC_ITEM,			self.OnUpdatePreView },	
		{ UiNotify.emCOREEVENT_SYNC_BLOGINFO,		self.OnUpdatePageAllBlog	},
		{ UiNotify.emCOREEVENT_SYNC_PRESTIGE,		self.UpdatePrestige	},
		{ UiNotify.emCOREEVENT_HONORDATAREFRESH,	self.OnHonorRefresh	},
		{ UiNotify.emCOREEVENT_CHANGE_FACTION_FINISHED, self.OnUpdatePageRepute},
		{ UiNotify.emUIEVENT_EQUIP_REFRESH, 		self.UpdateEquipDur},
		{ UiNotify.emUIEVENT_REPAIRALL_SEND, 		self.RepairAll},
		{ UiNotify.emUIEVENT_REPAIREXALL_SEND, 		self.RepairExAll},
		
	};
	for _, tbEquip in pairs(self.tbEquipCont) do
		tbRegEvent = Lib:MergeTable(tbRegEvent, tbEquip:RegisterEvent());
	end
	
	tbRegEvent = Lib:MergeTable(tbRegEvent, self.tbObjPreView:RegisterEvent());
	
	return tbRegEvent;
end

function tbPlayerPanel:RegisterMessage()
	local tbRegMsg = {}
	for _, tbEquip in pairs(self.tbEquipCont) do
		tbRegMsg = Lib:MergeTable(tbRegMsg, tbEquip:RegisterMessage());
	end
	tbRegMsg = Lib:MergeTable(tbRegMsg, self.tbObjPreView:RegisterMessage());
	return tbRegMsg;
end

function tbPlayerPanel:GetHistroy(nPage)
	return "";			-- 模拟历程文字
end


function tbPlayerPanel:RepairAll()
	for nPos, tbCont in pairs(self.tbEquipCont) do
		tbCont.nRoom = Item.ROOM_EQUIP;
		local pItem = me.GetItem(tbCont.nRoom, nPos, 0);
		if pItem and (pItem.nCurDur < pItem.nMaxDur) then
			me.RepairEquipment(pItem.nIndex, Item.REPAIR_COMMON);
		end
	end
end

function tbPlayerPanel:RepairExAll()
	if (tbTempData.nForbidSpeRepair and tbTempData.nForbidSpeRepair == 1) then
		me.Msg("Hiện ngươi không thể sửa kỹ trang bị!");
		return 0;
	end
	for nPos, tbCont in pairs(self.tbEquipCont) do
		tbCont.nRoom = Item.ROOM_EQUIP;
		local pItem = me.GetItem(tbCont.nRoom, nPos, 0);
		if pItem then
			me.RepairEquipment(pItem.nIndex, Item.REPAIR_COMMON);
			me.RepairEquipment(pItem.nIndex, Item.REPAIR_SPECIAL);
		end
	end
end

function tbPlayerPanel:NeedRepair(nType)
	if not nType then nType = 1; end
	
		for nPos = 1, Item.EQUIPPOS_CHOP do
			tbCont.nRoom = Item.ROOM_EQUIP;
			local pItem = me.GetItem(tbCont.nRoom, nPos, 0);
			if nType == 1 then
				if pItem and (pItem.nCurDur < pItem.nMaxDur) then
					return 1;
				end
			elseif nType == 2 then
				if pItem and (pItem.nMaxDur < Item.DUR_MAX) then
					return 1;
				end
			end
		end

	return 0;
end
