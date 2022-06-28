local uiPartner = Ui:GetClass("partner");
local tbObject	= Ui.tbLogic.tbObject;
local tbPreViewMgr = Ui.tbLogic.tbPreViewMgr;

uiPartner.BUTTON_CLOSE 		= "BtnClose";
uiPartner.BUTTON_PRESENT 	= "BtnPresent";
uiPartner.BUTTON_ACTIVE 	= "BtnActive";
uiPartner.BUTTON_DISBAND 	= "BtnDisband";
uiPartner.BUTTON_LEVEL_UP 	= "BtnLevelUp";
uiPartner.BUTTON_BINDEQUIP  = "BtnEquipBind";
uiPartner.BUTTON_CONVERT	= "BtnConvert";
uiPartner.LIST_PARTNER 		= "LstPartner";

uiPartner.IMG_CONVERT		= "ImgConvert";
uiPartner.TXT_ACCUMULATE_EXP = "TxtAccumulateExp";
uiPartner.TXT_NEED_EXP 		 = "TxtNeedExp";
uiPartner.TXT_FRIENDSHIP	 = "TxtFriendship";
uiPartner.TXT_TALENT	 	 = "TxtTalent";
uiPartner.TXT_ADD_STR 		 = "TxtAddStr";
uiPartner.TXT_ADD_DEX		 = "TxtAddDex";
uiPartner.TXT_ADD_VIT		 = "TxtAddVit";
uiPartner.TXT_ADD_ENG		 = "TxtAddEng";
uiPartner.TXT_START		 	 = "TxtStart";
uiPartner.TXT_PARTNER_LIST	 = "TxtPartnerList";
uiPartner.SZ_TXT_SKILL_LV	 = "TxtSkillLv";
uiPartner.TXT_FIGHTPOWER	 = "TxtFightPower";
uiPartner.IMG_VKHI	 = "ImgWeapon1";
uiPartner.IMG_Ao	 = "ImgBody1";
uiPartner.IMG_NHAN	 = "ImgRing1";
uiPartner.IMG_TAY	 = "ImgCuff1";
uiPartner.IMG_PHU	 = "ImgAmulet1";
uiPartner.IMG_EFFECT	 = "ImgEffectTBi";
uiPartner.IMG_NECKLACE	 = "ImgNecklace";
uiPartner.IMG_BELT	 = "ImgBelt";
uiPartner.IMG_FOOT	 = "ImgFoot";
uiPartner.IMG_PEDANT	 = "ImgPedant";
uiPartner.IMG_HEAD	 = "ImgHead";
uiPartner.TXT_SKILL_LV 		 = {};
uiPartner.OBJ_PARTNER_PREVIEW 	= "ObjPartnerPreview";
uiPartner.OBJ_SKILL_PREVIEW 	= "ObjSkillPreview";
uiPartner.CONVERT_EFFECT	 = "ImgConvertEffect";
uiPartner.OBJ_SKILL_CONFIGER = { bShowCd = 1, bUse = 0, bLink = 0, bSwitch = 0 };	-- 对应同伴技能
uiPartner.ROWCOUNT = 5;
uiPartner.PARTNER_VALUE = { TEMP_ID = 0, EXP = 1, LEVEL = 2, FRIENDSHIP = 3, TALENT = 4 }; -- 对应代码中的 emPARTNER_VALUE
uiPartner.PARTNER_ATTRIB = {STR = 0, DEX = 1, VIT = 2, ENG = 3}; -- 对应代码中的 emPARTNER_ATTRIB
uiPartner.MAX_SKILL_COUNT = 10;

local PARTNER_EQUIP_OBJ_CONFIGER =
{
	{Item.PARTNEREQUIP_WEAPON,	"ObjWeapon",	"ImgWeapon"},	-- 同伴装备--武器
	{Item.PARTNEREQUIP_BODY,	"ObjBody",		"ImgBody"},		-- 同伴装备--衣服
	{Item.PARTNEREQUIP_RING,	"ObjRing",		"ImgRing"},		-- 同伴装备--戒指
	{Item.PARTNEREQUIP_CUFF,	"ObjCuff",		"ImgCuff"},		-- 同伴装备--护腕
	{Item.PARTNEREQUIP_AMULET,	"ObjAmulet",	"ImgAmulet"},	-- 同伴装备--护身符
}

local tbPartnerEquipCont = { bShowCd = 0, bUse = 0, bLink = 0, nRoom = Item.ROOM_PARTNEREQUIP };	-- 对应同伴装备栏
function uiPartner:OnCreate()
	self.nSelect = 1;
	self.tbSkillIds = {};
	self.tbObjPartnerView = {};
	self.tbObjSkillView = {};
	self.tbObjPartnerView = tbObject:RegisterContainer(self.UIGROUP, self.OBJ_PARTNER_PREVIEW);
	self.tbObjSkillView = tbObject:RegisterContainer(self.UIGROUP, self.OBJ_SKILL_PREVIEW, 5, 2, self.OBJ_SKILL_CONFIGER, "SkillView");
	self.tbObjEquipView = {};
	for i, tbCon in pairs(PARTNER_EQUIP_OBJ_CONFIGER) do
		local nPos = tbCon[1];
		self.tbObjEquipView[nPos] = tbObject:RegisterContainer(
			self.UIGROUP,
			tbCon[2],
			1,
			1,
			{ nOffsetX = nPos, nRoom = Item.ROOM_PARTNEREQUIP },	-- 加上偏移量
			"equiproom"
		);
	end
	
	for i = 1, self.MAX_SKILL_COUNT do
		self.TXT_SKILL_LV[i] = self.SZ_TXT_SKILL_LV..i;
	end
end

function uiPartner:OnKillFocus(szWnd)
	UiManager:CloseWindow(self.UIGROUP);
end

function uiPartner:OnDestroy()
	tbObject:UnregContainer(self.tbObjPartnerView);
	tbObject:UnregContainer(self.tbObjSkillView);
	for _, tbCont in pairs(self.tbObjEquipView) do
		tbObject:UnregContainer(tbCont);
	end
end

function uiPartner:OnClose()
	for _, tbCont in pairs(self.tbObjEquipView) do
		tbCont:ClearRoom();
	end
end

function uiPartner:OnListSel(szWnd, nParam)
	if szWnd == self.LIST_PARTNER then
		local nKey = Lst_GetCurKey(self.UIGROUP, self.LIST_PARTNER);
		self.nSelect = nKey;
		self:UpdatePartner(self.nSelect - 1);
	end
end

function uiPartner:OnObjGridEnter(szWnd, nX, nY)
	if Wnd_Visible(self.UIGROUP, "Main") == 0 then
		return;
	end

	if (szWnd == self.OBJ_SKILL_PREVIEW) then
		local nOffset = 0;
		if nY > 0 then
			nOffset = 5;
		else
			nOffset = 1;
		end
		local uId = nX + nOffset + nY;
		if self.tbSkillIds[uId] then
			Wnd_ShowMouseHoverInfo(self.UIGROUP, szWnd, 
								FightSkill:GetDesc(self.tbSkillIds[uId].nId,
				 				self.tbSkillIds[uId].nLevel));
		end
	end

end

function uiPartner:OnOpen()
	if (Partner.bOpenPartner == 0) then
		return 0;
	end
	
	Wnd_SetVisible(self.UIGROUP, "Main", 1);
	if me.nActivePartner ~= -1 then
		self.nSelect = me.nActivePartner + 1;
	end
	self:Update();
end

function uiPartner:UpdateList()
	Lst_Clear(self.UIGROUP, self.LIST_PARTNER);
	for nIndex = 1, me.nPartnerCount do
		local pPartner = me.GetPartner(nIndex - 1);
		if pPartner then
			Lst_SetCell(self.UIGROUP, self.LIST_PARTNER, nIndex, 1, "   "..pPartner.szName);
			Lst_SetCell(self.UIGROUP, self.LIST_PARTNER, nIndex, 2, pPartner.GetValue(self.PARTNER_VALUE.LEVEL).."");
		end
	end
	
	if me.nActivePartner ~= -1 then
		local pPartner = me.GetPartner(me.nActivePartner);
		if pPartner then
			Lst_SetCell(self.UIGROUP, self.LIST_PARTNER, 
					me.nActivePartner + 1, 1, "<color=orange>★ <color>"..pPartner.szName);
		end
	end
end

function uiPartner:Update()
	if Wnd_Visible(self.UIGROUP, "Main") == 0 then
		return;
	end

	Wnd_SetEnable(self.UIGROUP,self.BUTTON_LEVEL_UP, 0);
	Wnd_SetEnable(self.UIGROUP,self.BUTTON_PRESENT, 0);
	Txt_SetTxt(self.UIGROUP, self.TXT_PARTNER_LIST, "Danh sách đồng hành ("..me.nPartnerCount.."/"..me.nPartnerLimit..")")
	
	self:UpdateList();
	self:UpdateImgVKhiPet();
	self:UpdateImgLienPet();
	self:UpdateImgLungPet();
	self:UpdateImgGiayPet();
	self:UpdateImgBoiPet();
	self:UpdateImgNonPet();
	self:UpdateImgAoPet();
	self:UpdateImgNhanPet();
	self:UpdateImgTayPet();
	self:UpdateImgPhuPet();
	if self.nSelect > me.nPartnerCount and me.nPartnerCount > 0 and me.nPartnerCount <= me.nPartnerLimit then
		if me.nActivePartner ~= -1 then
			self.nSelect = me.nActivePartner + 1;
		else
			self.nSelect = 1;
		end
	end
	Lst_SetCurKey(self.UIGROUP, self.LIST_PARTNER, self.nSelect);
	
	self:UpdatePartner(self.nSelect - 1);
	
	self:UpdatePartnerEquip();
	return 1;
end

function uiPartner:UpdatePartner(nPartnerIndex)
	self:UpdatePartnerInfo(nPartnerIndex);
	self:UpdatePartnerView(nPartnerIndex);
	self:UpdateSkillView(nPartnerIndex);
end
function uiPartner:UpdateImgVKhiPet()
	local nLevel = me.GetSkillLevel(1988)
	local szSpr = {
		[1] = "\\image\\item\\partnerequip\\weapon\\partner_lv1_1_s.spr",
		[2] = "\\image\\item\\partnerequip\\weapon\\partner_lv2_1_s.spr",
		[3] = "\\image\\item\\partnerequip\\weapon\\partner_lv3_1_s.spr",
		[4] = "\\image\\item\\partnerequip\\weapon\\partner_lv4_1_s.spr",
	};	
		Img_SetImage(self.UIGROUP, self.IMG_VKHI, 1, szSpr[nLevel]);		
end
function uiPartner:UpdateImgAoPet()
	local nLevel = me.GetSkillLevel(1989)
	local szSpr = {
		[1] = "\\image\\item\\partnerequip\\body\\partner_lv1_2_s.spr",
		[2] = "\\image\\item\\partnerequip\\body\\partner_lv2_2_s.spr",
		[3] = "\\image\\item\\partnerequip\\body\\partner_lv3_2_s.spr",
		[4] = "\\image\\item\\partnerequip\\body\\partner_lv4_2_s.spr",
	};	
	Img_SetImage(self.UIGROUP, self.IMG_Ao, 1, szSpr[nLevel]);
end
function uiPartner:UpdateImgNhanPet()
	local nLevel = me.GetSkillLevel(1990)
	local szSpr = {
		[1] = "\\image\\item\\partnerequip\\ring\\partner_ring_01_s.spr",
		[2] = "\\image\\item\\partnerequip\\ring\\partner_ring_02_s.spr",
		[3] = "\\image\\item\\partnerequip\\ring\\partner_ring_03_s.spr",
		[4] = "\\image\\item\\partnerequip\\ring\\partner_ring_04_s.spr",
	};	
	Img_SetImage(self.UIGROUP, self.IMG_NHAN, 1, szSpr[nLevel]);
end
function uiPartner:UpdateImgTayPet()
	local nLevel = me.GetSkillLevel(1991)
	local szSpr = {
		[1] = "\\image\\item\\partnerequip\\cuff\\partner_cuff_01_s.spr",
		[2] = "\\image\\item\\partnerequip\\cuff\\partner_cuff_02_s.spr",
		[3] = "\\image\\item\\partnerequip\\cuff\\partner_cuff_03_s.spr",
		[4] = "\\image\\item\\partnerequip\\cuff\\partner_cuff_04_s.spr",
	};	
	Img_SetImage(self.UIGROUP, self.IMG_TAY, 1, szSpr[nLevel]);
end
function uiPartner:UpdateImgPhuPet()
	local nLevel = me.GetSkillLevel(1992)
	local szSpr = {
		[1] = "\\image\\item\\partnerequip\\amulet\\partner_lv1_3_s.spr",
		[2] = "\\image\\item\\partnerequip\\amulet\\partner_lv2_3_s.spr",
		[3] = "\\image\\item\\partnerequip\\amulet\\partner_lv3_3_s.spr",
		[4] = "\\image\\item\\partnerequip\\amulet\\partner_lv4_3_s.spr",
	};	
	Img_SetImage(self.UIGROUP, self.IMG_PHU, 1, szSpr[nLevel]);
end
function uiPartner:UpdateImgLienPet()
	local nLevel = me.GetSkillLevel(1993)
	local szSpr = {
		[1] = "\\image\\item\\partnerequip\\necklace\\partner_necklace_01_s.spr",
		[2] = "\\image\\item\\partnerequip\\necklace\\partner_necklace_02_s.spr",
		[3] = "\\image\\item\\partnerequip\\necklace\\partner_necklace_03_s.spr",
		[4] = "\\image\\item\\partnerequip\\necklace\\partner_necklace_04_s.spr",
	};	
	Img_SetImage(self.UIGROUP, self.IMG_NECKLACE, 1, szSpr[nLevel]);
end
function uiPartner:UpdateImgLungPet()
	local nLevel = me.GetSkillLevel(1994)
	local szSpr = {
		[1] = "\\image\\item\\partnerequip\\belt\\partner_belt_01_s.spr",
		[2] = "\\image\\item\\partnerequip\\belt\\partner_belt_02_s.spr",
		[3] = "\\image\\item\\partnerequip\\belt\\partner_belt_03_s.spr",
		[4] = "\\image\\item\\partnerequip\\belt\\partner_belt_04_s.spr",
	};	
	Img_SetImage(self.UIGROUP, self.IMG_BELT, 1, szSpr[nLevel]);
end
function uiPartner:UpdateImgGiayPet()
	local nLevel = me.GetSkillLevel(1995)
	local szSpr = {
		[1] = "\\image\\item\\partnerequip\\foot\\partner_foot_lv1_s.spr",
		[2] = "\\image\\item\\partnerequip\\foot\\partner_foot_lv2_s.spr",
		[3] = "\\image\\item\\partnerequip\\foot\\partner_foot_lv3_s.spr",
		[4] = "\\image\\item\\partnerequip\\foot\\partner_foot_lv4_s.spr",
	};	
	Img_SetImage(self.UIGROUP, self.IMG_FOOT, 1, szSpr[nLevel]);
end
function uiPartner:UpdateImgBoiPet()
	local nLevel = me.GetSkillLevel(1996)
	local szSpr = {
		[1] = "\\image\\item\\partnerequip\\pendant\\partner_pendant_lv1_s.spr",
		[2] = "\\image\\item\\partnerequip\\pendant\\partner_pendant_lv2_s.spr",
		[3] = "\\image\\item\\partnerequip\\pendant\\partner_pendant_lv3_s.spr",
		[4] = "\\image\\item\\partnerequip\\pendant\\partner_pendant_lv4_s.spr",
	};	
	Img_SetImage(self.UIGROUP, self.IMG_PEDANT, 1, szSpr[nLevel]);
end
function uiPartner:UpdateImgNonPet()
	local nLevel = me.GetSkillLevel(1997)
	local szSpr = {
		[1] = "\\image\\item\\partnerequip\\head\\partner_head_lv1_s.spr",
		[2] = "\\image\\item\\partnerequip\\head\\partner_head_lv2_s.spr",
		[3] = "\\image\\item\\partnerequip\\head\\partner_head_lv3_s.spr",
		[4] = "\\image\\item\\partnerequip\\head\\partner_head_lv4_s.spr",
	};	
	Img_SetImage(self.UIGROUP, self.IMG_HEAD, 1, szSpr[nLevel]);
end
function uiPartner:UpdatePartnerView(nPartnerIndex)
	if not self.tbObjPartnerView.szObjGrid then
		print("No tbObjPartnerView");
		return;
	end
	self.tbObjPartnerView:ClearObj();
	if nPartnerIndex < 0 or  nPartnerIndex >= me.nPartnerCount then
		return;
	end
	local pPartner = me.GetPartner(nPartnerIndex);
	if not pPartner then
		return;
	end
	
	local tbPart = tbPreViewMgr:GetSelfPart();
	local nNpcId = Partner.tbPartIdToNpcId[pPartner.GetValue(self.PARTNER_VALUE.TEMP_ID)];
	if not nNpcId then
		return;
	end
	local tbObj = {};
	tbObj.nType = Ui.OBJ_NPCRES;
	tbObj.nTemplateId = nNpcId;
	tbObj.nAction = Npc.ACT_STAND1;
	tbObj.tbPart = tbPart;
	tbObj.nDir = 0;
	tbObj.bRideHorse = 0;
	self.tbObjPartnerView:SetObj(tbObj);
end

function uiPartner:UpdateSkillView(nPartnerIndex)
	self.tbSkillIds = {};
	if not self.tbObjSkillView.szObjGrid then
		print("No tbObjSkillView")
		return;
	end
	self.tbObjSkillView:ClearObj();
	self:ClearSkillLevel();
	if nPartnerIndex < 0 or  nPartnerIndex >= me.nPartnerCount then
		return;
	end
	local pPartner = me.GetPartner(nPartnerIndex);
	if not pPartner then
		return;
	end

	for nIndex = 1, pPartner.nSkillCount do
		table.insert(self.tbSkillIds, pPartner.GetSkill(nIndex - 1));
	end

		   	
	local nRow = 0;
	local nLine = 0;
	for nIndex, tbPartnerSkill in ipairs(self.tbSkillIds) do
		nRow = nIndex - 1;
		if nIndex > self.ROWCOUNT and self.ROWCOUNT > 0 then
			nRow = nRow - self.ROWCOUNT;
			nLine = math.floor(nRow / self.ROWCOUNT) + 1;
		end
		local tbSkill = {};
		tbSkill.nType = Ui.OBJ_FIGHTSKILL;
		tbSkill.nSkillId = tbPartnerSkill.nId;
		self.tbObjSkillView:SetObj(tbSkill, nRow, nLine);
		ObjBox_Clear(self.UIGROUP, Ui.OBJ_FIGHTSKILL);
		ObjBox_HoldObject(self.UIGROUP, self.OBJ_SKILL_PREVIEW, Ui.CGOG_SKILL_SHORTCUT, tbPartnerSkill.nId);	
		Txt_SetTxt(self.UIGROUP, self.TXT_SKILL_LV[nIndex], tbPartnerSkill.nLevel);	
	end
end

function uiPartner:UpdatePartnerEquip()
	for i, tbCont in pairs(self.tbObjEquipView) do
		tbCont:UpdateRoom();
	end
end

function uiPartner:UpdateEquipDur()
	for _, tbCont in pairs(self.tbObjEquipView) do
		if tbCont then
			local pItem = me.GetItem(tbCont.nRoom, tbCont.nOffsetX, tbCont.nOffsetY);
			if pItem then
				if tbCont.nOffsetX >= Item.PARTNEREQUIP_WEAPON and tbCont.nOffsetY <= Item.PARTNEREQUIP_AMULET then
					ObjGrid_ShowSubScript(tbCont.szUiGroup, tbCont.szObjGrid, 1, 0, 0);
					local nPerDur = math.ceil((pItem.nCurDur / pItem.nMaxDur) * 100)
					if nPerDur > 0 and nPerDur <= 10 then
						ObjGrid_ChangeSubScriptColor(tbCont.szUiGroup, tbCont.szObjGrid, "Red");
					elseif nPerDur > 10 and nPerDur <= 60 then
						ObjGrid_ChangeSubScriptColor(tbCont.szUiGroup, tbCont.szObjGrid, "yellow");
					elseif nPerDur > 60 then
						ObjGrid_ChangeSubScriptColor(tbCont.szUiGroup, tbCont.szObjGrid, "green");
					end;
				
					local szDur = tostring(nPerDur).."%";
					ObjGrid_ChangeSubScript(tbCont.szUiGroup, tbCont.szObjGrid, szDur, 0, 0);
				end
			end
		end
	end
end

function uiPartner:ClearSkillLevel()
	for i = 1, self.MAX_SKILL_COUNT do
		Txt_SetTxt(self.UIGROUP, self.TXT_SKILL_LV[i], "");	
	end
end

function uiPartner:UpdatePartnerInfo(nPartnerIndex)
	local szAccumulateExp =  "Kinh nghiệm hiện tại: ";
	local szNeedExp = "Kinh nghiệm cần: ";
	local szFriendship = "Thân mật: ";
	local szTalent = "Lĩnh ngộ: ";
	local szAddStr = "Sức mạnh tăng: ";
	local szAddDex = "Thân pháp tăng: ";
	local szTxtAddVit = "Ngoại công tăng: ";
	local szTxtAddEng = "Nội công tăng: ";
	local szFightPower = "Tăng sức chiến đấu: ";
	local szStart = "";

	if nPartnerIndex >= 0 and nPartnerIndex < me.nPartnerCount then
		local pPartner = me.GetPartner(nPartnerIndex);
		if pPartner then
			szStart = self:SetStart(nPartnerIndex);
			szAccumulateExp = szAccumulateExp..pPartner.GetValue(self.PARTNER_VALUE.EXP);
			szNeedExp = szNeedExp..Partner:GetNeedLevel(pPartner.GetValue(self.PARTNER_VALUE.LEVEL));
			local szTemp = string.format("%0.2f", pPartner.GetValue(self.PARTNER_VALUE.FRIENDSHIP) / 100);
			szFriendship = szFriendship..szTemp;
			local nTalent = pPartner.GetValue(self.PARTNER_VALUE.TALENT) % 1000
			szTalent = szTalent..nTalent;
			szAddStr = szAddStr..pPartner.GetAttrib(self.PARTNER_ATTRIB.STR);
			szAddDex = szAddDex..pPartner.GetAttrib(self.PARTNER_ATTRIB.DEX);
			szTxtAddVit = szTxtAddVit..pPartner.GetAttrib(self.PARTNER_ATTRIB.VIT);
			szTxtAddEng = szTxtAddEng..pPartner.GetAttrib(self.PARTNER_ATTRIB.ENG);
		end
	end
	local nKey = Lst_GetCurKey(self.UIGROUP, self.LIST_PARTNER);
	if me.nActivePartner ~= nKey - 1 or me.nActivePartner == -1 then
		Btn_SetTxt(self.UIGROUP, self.BUTTON_ACTIVE, "Giúp đỡ");
		Wnd_SetEnable(self.UIGROUP,self.BUTTON_LEVEL_UP, 0);
		Wnd_SetEnable(self.UIGROUP,self.BUTTON_PRESENT, 0);
	else
		Btn_SetTxt(self.UIGROUP, self.BUTTON_ACTIVE, "Đứng nhìn");
		Wnd_SetEnable(self.UIGROUP,self.BUTTON_LEVEL_UP, 1);
		Wnd_SetEnable(self.UIGROUP,self.BUTTON_PRESENT, 1);
	end
	Txt_SetTxt(self.UIGROUP, self.TXT_START, szStart);
	Txt_SetTxt(self.UIGROUP, self.TXT_ACCUMULATE_EXP, szAccumulateExp);
	Txt_SetTxt(self.UIGROUP, self.TXT_NEED_EXP, szNeedExp);
	Txt_SetTxt(self.UIGROUP, self.TXT_FRIENDSHIP, szFriendship);
	Txt_SetTxt(self.UIGROUP, self.TXT_TALENT, szTalent);
	Txt_SetTxt(self.UIGROUP, self.TXT_ADD_STR, szAddStr);
	Txt_SetTxt(self.UIGROUP, self.TXT_ADD_DEX, szAddDex);
	Txt_SetTxt(self.UIGROUP, self.TXT_ADD_VIT, szTxtAddVit);
	Txt_SetTxt(self.UIGROUP, self.TXT_ADD_ENG, szTxtAddEng);
end

function uiPartner:SetStart(nPartnerIndex)
	local szTip = "\n  ";
	if not nPartnerIndex then
		return szTip;
	end
	local tbSetting = Partner.tbStarLevel;
	local pPartner = me.GetPartner(nPartnerIndex);
	if not pPartner then
		return szTip;
	end
	local nStartCount = Partner:GetSelfStartCount(pPartner);
	local szFillStar = "";
	local szEmptyStar = "";
	if tbSetting and tbSetting[nStartCount] then
		szFillStar = string.format("<pic=%s>", tbSetting[nStartCount].nFillStar - 1);
		szEmptyStar = string.format("<pic=%s>", tbSetting[nStartCount].nEmptyStar - 1);
	else
		szFillStar = "★";
		szEmptyStar = "☆";
	end

	for i = 1, math.floor(nStartCount / 2) do
		szTip = szTip..szFillStar;
		if i % 3 == 0 then
			szTip = szTip.." ";
		end
	end
	if (nStartCount % 2 ~= 0) then
		szTip = szTip..szEmptyStar;
	end
	return	szTip;
end
function uiPartner:OnButtonClick(szWnd, nParam)
	if (szWnd == self.BUTTON_CLOSE) then
		UiManager:CloseWindow(self.UIGROUP);
	elseif (szWnd == self.BUTTON_PRESENT) then
		if me.nActivePartner >= 0 and me.nActivePartner <= me.nPartnerLimit then
			me.CallServerScript({ "PartnerCmd", "SendGift", me.nActivePartner});
		end
	elseif (szWnd == self.BUTTON_LEVEL_UP) then
		if me.nActivePartner >= 0 and me.nActivePartner <= me.nPartnerLimit then
			me.CallServerScript({ "PartnerCmd", "UpgradeLevel", me.nActivePartner});
		end
	elseif (szWnd == self.BUTTON_ACTIVE) then
		local nKey = Lst_GetCurKey(self.UIGROUP, self.LIST_PARTNER);
		if nKey > 0 and nKey <= me.nPartnerLimit then
			me.CallServerScript({ "PartnerCmd", "CallPartner", nKey - 1});
		else
			me.Msg("Hãy chọn đồng hành cần thao tác");
		end
	elseif (szWnd == self.BUTTON_DISBAND) then
		local nKey = Lst_GetCurKey(self.UIGROUP, self.LIST_PARTNER);
		if nKey > 0 and nKey <= me.nPartnerLimit then
			me.CallServerScript({ "PartnerCmd", "DissolvePartner", nKey - 1});
		else
			me.Msg("Hãy chọn đồng hành cần giải tán");
		end
	elseif (szWnd == self.BUTTON_BINDEQUIP) then
		me.CallServerScript({"PartnerCmd", "BindEquip", me.nId});
	elseif (szWnd == self.BUTTON_CONVERT) then
		local nKey = Lst_GetCurKey(self.UIGROUP, self.LIST_PARTNER);
		if nKey > 0 and nKey <= me.nPartnerLimit then
			me.CallServerScript({"PartnerCmd", "Convert", nKey - 1});
		else
			me.Msg("Hãy chọn đồng hành mà bạn muốn chuyển hóa");
		end
	end
end
uiPartner.tbLienDHanh = {
	[1] = "<color=yellow>Bích Huyết Hạng Liên<color>\n"..
		"\n   <pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>1000<color>\n\n"..
		"Phát huy lực tấn công cơ bản: <color=gold>+10%<color>\n"..
		"Bỏ qua né tránh đối thủ: <color=gold>+155<color>\n"..
		"Chuyển hóa sát thương thành nội lựcTrả lời: <color=gold>+1%<color>\n"..
		"Cường hóa ngũ hành tương khắc: <color=gold>+55 điểm<color>",
	[2] = "<color=yellow>Kim Lân Hạng Liên<color>\n"..
		"\n   <pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>2000<color>\n\n"..		
		"Phát huy lực tấn công cơ bản: <color=gold>+17%<color>\n"..
		"Bỏ qua né tránh đối thủ: <color=gold>+415<color>\n"..
		"Chuyển hóa sát thương thành nội lựcTrả lời: <color=gold>+3%<color>\n"..
		"Cường hóa ngũ hành tương khắc: <color=gold>+135 điểm<color>",
	[3] = "<color=yellow>Đơn Tâm Hạng Liên<color>\n"..
		"\n   <pic=155><pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>3000<color>\n\n"..		
		"Phát huy lực tấn công cơ bản: <color=gold>+25%<color>\n"..
		"Bỏ qua né tránh đối thủ: <color=gold>+605<color>\n"..
		"Chuyển hóa sát thương thành nội lựcTrả lời: <color=gold>+5%<color>\n"..
		"Cường hóa ngũ hành tương khắc: <color=gold>+205 điểm<color>",
	[4] = "<color=yellow>Long Đằng Hạng Liên<color>\n"..
		"\n   <pic=155><pic=155><pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>4000<color>\n\n"..		
		"Phát huy lực tấn công cơ bản: <color=gold>+32%<color>\n"..
		"Bỏ qua né tránh đối thủ: <color=gold>+798<color>\n"..
		"Chuyển hóa sát thương thành nội lựcTrả lời: <color=gold>+7%<color>\n"..
		"Cường hóa ngũ hành tương khắc: <color=gold>+265 điểm<color>",		
};
uiPartner.tbLungDHanh = {
	[1] = "<color=yellow>Bích Huyết Thúc Yêu<color>\n"..
		"\n   <pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>1000<color>\n\n"..		
		"Kháng tất cả: <color=gold>+70<color>\n"..
		"Sinh lực tối đa: <color=gold>+500 điểm<color>\n"..
		"Nhược hóa ngũ hành tương khắc: <color=gold>+55 điểm<color>",
	[2] = "<color=yellow>Kim Lân Thúc Yêu<color>\n"..
		"\n   <pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>2000<color>\n\n"..		
		"Kháng tất cả: <color=gold>+105<color>\n"..
		"Sinh lực tối đa: <color=gold>+1000 điểm<color>\n"..
		"Nhược hóa ngũ hành tương khắc: <color=gold>+135 điểm<color>",
	[3] = "<color=yellow>Đơn Tâm Thúc Yêu<color>\n"..
		"\n   <pic=155><pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>3000<color>\n\n"..		
		"Kháng tất cả: <color=gold>+140<color>\n"..
		"Sinh lực tối đa: <color=gold>+1500 điểm<color>\n"..
		"Nhược hóa ngũ hành tương khắc: <color=gold>+205 điểm<color>",
	[4] = "<color=yellow>Long Đằng Thúc Yêu<color>\n"..
		"\n   <pic=155><pic=155><pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>4000<color>\n\n"..		
		"Kháng tất cả: <color=gold>+175<color>\n"..
		"Sinh lực tối đa: <color=gold>+2000 điểm<color>\n"..
		"Nhược hóa ngũ hành tương khắc: <color=gold>+265 điểm<color>",		
};
uiPartner.tbGiayDHanh = {
	[1] = "<color=yellow>Bích Huyết Chiến Ngoa<color>\n"..
		"\n   <pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>1000<color>\n\n"..		
		"Tăng vật công ngoại: <color=gold>+2560 điểm<color>\n"..
		"Tăng vật công nội: <color=gold>+2560 điểm<color>\n"..
		"Tăng tỷ lệ chí mạng: <color=gold>+10%<color>",
	[2] = "<color=yellow>Kim Lân Chiến Ngoa<color>\n"..
		"\n   <pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>2000<color>\n\n"..		
		"Tăng vật công ngoại: <color=gold>+4100 điểm<color>\n"..
		"Tăng vật công nội: <color=gold>+4100 điểm<color>\n"..
		"Tăng tỷ lệ chí mạng: <color=gold>+15%<color>",
	[3] = "<color=yellow>Đơn Tâm Chiến Ngoa<color>\n"..
		"\n   <pic=155><pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>3000<color>\n\n"..		
		"Tăng vật công ngoại: <color=gold>+5120 điểm<color>\n"..
		"Tăng vật công nội: <color=gold>+5120 điểm<color>\n"..
		"Tăng tỷ lệ chí mạng: <color=gold>+20%<color>",
	[4] = "<color=yellow>Long Đằng Chiến Ngoa<color>\n"..
		"\n   <pic=155><pic=155><pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>4000<color>\n\n"..		
		"Tăng vật công ngoại: <color=gold>+6140 điểm<color>\n"..
		"Tăng vật công nội: <color=gold>+6140 điểm<color>\n"..
		"Tăng tỷ lệ chí mạng: <color=gold>+30%<color>",		
};
uiPartner.tbBoiDHanh = {
	[1] = "<color=yellow>Bích Huyết Bội<color>\n"..
		"\n   <pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>1000<color>\n\n"..		
		"Phát huy lực tấn công cơ bản: <color=gold>+5%<color>\n"..
		"Phát huy lực tấn công kỹ năng: <color=gold>+5%<color>\n"..
		"Thể lực tối đa: <color=gold>+500 điểm<color>",
	[2] = "<color=yellow>Kim Lân Bội<color>\n"..
		"\n   <pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>2000<color>\n\n"..		
		"Phát huy lực tấn công cơ bản: <color=gold>+10%<color>\n"..
		"Phát huy lực tấn công kỹ năng: <color=gold>+10%<color>\n"..
		"Thể lực tối đa: <color=gold>+750 điểm<color>",
	[3] = "<color=yellow>Đơn Tâm Bội<color>\n"..
		"\n   <pic=155><pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>3000<color>\n\n"..		
		"Phát huy lực tấn công cơ bản: <color=gold>+15%<color>\n"..
		"Phát huy lực tấn công kỹ năng: <color=gold>+15%<color>\n"..
		"Thể lực tối đa: <color=gold>+1000 điểm<color>",
	[4] = "<color=yellow>Long Đằng Bội<color>\n"..
		"\n   <pic=155><pic=155><pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>4000<color>\n\n"..		
		"Phát huy lực tấn công cơ bản: <color=gold>+20%<color>\n"..
		"Phát huy lực tấn công kỹ năng: <color=gold>+20%<color>\n"..
		"Thể lực tối đa: <color=gold>+1250 điểm<color>",		
};
uiPartner.tbNonDHanh = {
	[1] = "<color=yellow>Bích Huyết Chi Quán<color>\n"..
		"\n   <pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>1000<color>\n\n"..		
		"Kháng tất cả: <color=gold>+50<color>\n"..
		"Nhược hóa ngũ hành tương khắc: <color=gold>+50<color>\n"..
		"Chịu sát thương chí mạng: <color=gold>-10%<color>",
	[2] = "<color=yellow>Kim Lân Chi Quán<color>\n"..
		"\n   <pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>2000<color>\n\n"..		
		"Kháng tất cả: <color=gold>+100<color>\n"..
		"Nhược hóa ngũ hành tương khắc: <color=gold>+135<color>\n"..
		"Chịu sát thương chí mạng: <color=gold>-15%<color>",
	[3] = "<color=yellow>Đơn Tâm Chi Quán<color>\n"..
		"\n   <pic=155><pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>3000<color>\n\n"..		
		"Kháng tất cả: <color=gold>+150<color>\n"..
		"Nhược hóa ngũ hành tương khắc: <color=gold>+205<color>\n"..
		"Chịu sát thương chí mạng: <color=gold>-20%<color>",
	[4] = "<color=yellow>Long Đằng Chi Quán<color>\n"..
		"\n   <pic=155><pic=155><pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>4000<color>\n\n"..		
		"Kháng tất cả: <color=gold>+200<color>\n"..
		"Nhược hóa ngũ hành tương khắc: <color=gold>+265<color>\n"..
		"Chịu sát thương chí mạng: <color=gold>-30%<color>",		
};
uiPartner.tbVKhiDHanh = {
	[1] = "<color=yellow>Bích Huyết Chi Nhẫn<color>\n"..
		"\n   <pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>1000<color>\n\n"..		
		"Tỉ lệ sinh lực tối đa: <color=gold>Tăng 10%<color>\n"..
		"Tấn công khi đánh chí mạng: <color=gold>+15%<color>",
	[2] = "<color=yellow>Kim Lân Chi Nhẫn<color>\n"..
		"\n   <pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>2000<color>\n\n"..		
		"Tỉ lệ sinh lực tối đa: <color=gold>Tăng 12%<color>\n"..
		"Tấn công khi đánh chí mạng: <color=gold>+20%<color>",
	[3] = "<color=yellow>Đơn Tâm Chi Nhẫn<color>\n"..
		"\n   <pic=155><pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>3000<color>\n\n"..		
		"Tỉ lệ sinh lực tối đa: <color=gold>Tăng 15%<color>\n"..
		"Tấn công khi đánh chí mạng: <color=gold>+25%<color>",
	[4] = "<color=yellow>Long Đằng Chi Nhẫn<color>\n"..
		"\n   <pic=155><pic=155><pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>4000<color>\n\n"..		
		"Tỉ lệ sinh lực tối đa: <color=gold>Tăng 20%<color>\n"..
		"Tấn công khi đánh chí mạng: <color=gold>+30%<color>",	
};
uiPartner.tbAoDHanh = {
	[1] = "<color=yellow>Bích Huyết Chiến Y<color>\n"..
		"\n   <pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>1000<color>\n\n"..		
		"Tỉ lệ nội lực tối đa: <color=gold>Tăng 10%<color>\n"..
		"Chịu sát thương chí mạng: <color=gold>-15%<color>",
	[2] = "<color=yellow>Kim Lân Chiến Y<color>\n"..
		"\n   <pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>2000<color>\n\n"..		
		"Tỉ lệ nội lực tối đa: <color=gold>Tăng 12%<color>\n"..
		"Chịu sát thương chí mạng: <color=gold>-20%<color>",
	[3] = "<color=yellow>Đơn Tâm Chiến Y<color>\n"..
		"\n   <pic=155><pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>3000<color>\n\n"..		
		"Tỉ lệ nội lực tối đa: <color=gold>Tăng 15%<color>\n"..
		"Chịu sát thương chí mạng: <color=gold>-25%<color>",
	[4] = "<color=yellow>Long Đằng Chiến Y<color>\n"..
		"\n   <pic=155><pic=155><pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>4000<color>\n\n"..		
		"Tỉ lệ nội lực tối đa: <color=gold>Tăng 20%<color>\n"..
		"Chịu sát thương chí mạng: <color=gold>-30%<color>",		
};
uiPartner.tbNhanDHanh = {
	[1] = "<color=yellow>Bích Huyết Giới Chỉ<color>\n"..
		"\n   <pic=155>\n"..	
		"<color=cyan>Tài phú:<color> <color=green>1000<color>\n\n"..		
		"Vật công ngoại: <color=gold>+100%<color>\n"..
		"Vật công nội: <color=gold>+100%<color>\n"..
		"Hiệu suất phục hồi nội lực: <color=gold>+11%<color>\n"..
		"Thời gian bị trạng thái ngũ hành: <color=gold>-50<color>",
	[2] = "<color=yellow>Kim Lân Giới Chỉ<color>\n"..
		"\n   <pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>2000<color>\n\n"..		
		"Vật công ngoại: <color=gold>+150%<color>\n"..
		"Vật công nội: <color=gold>+150%<color>\n"..
		"Hiệu suất phục hồi nội lực: <color=gold>+13%<color>\n"..
		"Thời gian bị trạng thái ngũ hành: <color=gold>-75<color>",
	[3] = "<color=yellow>Đan Tâm Giới Chỉ<color>\n"..
		"\n   <pic=155><pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>3000<color>\n\n"..		
		"Vật công ngoại: <color=gold>+200%<color>\n"..
		"Vật công nội: <color=gold>+200%<color>\n"..
		"Hiệu suất phục hồi nội lực: <color=gold>+16%<color>\n"..
		"Thời gian bị trạng thái ngũ hành: <color=gold>-100<color>",	
	[4] = "<color=yellow>Long Đằng Giới Chỉ<color>\n"..
		"\n   <pic=155><pic=155><pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>4000<color>\n\n"..		
		"Vật công ngoại: <color=gold>+250%<color>\n"..
		"Vật công nội: <color=gold>+250%<color>\n"..
		"Hiệu suất phục hồi nội lực: <color=gold>+19%<color>\n"..
		"Thời gian bị trạng thái ngũ hành: <color=gold>-125<color>",		
};
uiPartner.tbTayDHanh = {
	[1] = "<color=yellow>Bích Huyết Hộ Uyển<color>\n"..
		"\n   <pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>1000<color>\n\n"..		
		"Kháng tất cả: <color=gold>+75<color>\n"..
		"Hiệu Suất phụ hồi sinh lực: <color=gold>+11%<color>",
	[2] = "<color=yellow>Kim Lân Hộ Uyển<color>\n"..
		"\n   <pic=155><pic=155>\n"..	
		"<color=cyan>Tài phú:<color> <color=green>2000<color>\n\n"..		
		"Kháng tất cả: <color=gold>+90<color>\n"..
		"Hiệu Suất phụ hồi sinh lực: <color=gold>+13%<color>",
	[3] = "<color=yellow>Đơn Tâm Hộ Uyển<color>\n"..
		"\n   <pic=155><pic=155><pic=155>\n"..
		"<color=cyan>Tài phú:<color> <color=green>3000<color>\n\n"..		
		"Kháng tất cả: <color=gold>+105<color>\n"..
		"Hiệu Suất phụ hồi sinh lực: <color=gold>+16%<color>",
	[4] = "<color=yellow>Long Đằng Hộ Uyển<color>\n"..
		"\n   <pic=155><pic=155><pic=155><pic=155>\n"..	
		"<color=cyan>Tài phú:<color> <color=green>4000<color>\n\n"..		
		"Kháng tất cả: <color=gold>+115<color>\n"..
		"Hiệu Suất phụ hồi sinh lực: <color=gold>+19%<color>",		
};
uiPartner.tbPhuDHanh = {
	[1] = "<color=yellow>Bích Huyết Hộ Thân Phù<color>\n"..
		"\n   <pic=155>\n"..	
		"<color=cyan>Tài phú:<color> <color=green>1000<color>\n\n"..		
		"Mỗi 5 giây hồi phục sinh lực: <color=gold>+30 điểm<color>\n"..
		"Mỗi 5 giây hồi phục nội lực: <color=gold>+30 điểm<color>\n"..
		"Mỗi 5 giây hồi phục thể lực: <color=gold>+30 điểm<color>\n"..
		"Kháng tất cả: <color=gold>+15<color>",
	[2] = "<color=yellow>Kim Lân Hộ Thân Phù<color>\n"..
		"\n   <pic=155><pic=155>\n"..	
		"<color=cyan>Tài phú:<color> <color=green>2000<color>\n\n"..		
		"Mỗi 5 giây hồi phục sinh lực: <color=gold>+40 điểm<color>\n"..
		"Mỗi 5 giây hồi phục nội lực: <color=gold>+40 điểm<color>\n"..
		"Mỗi 5 giây hồi phục thể lực: <color=gold>+40 điểm<color>\n"..
		"Kháng tất cả: <color=gold>+20<color>",
	[3] = "<color=yellow>Đơn Tâm Hộ Thân Phù<color>\n"..
		"\n   <pic=155><pic=155><pic=155>\n"..	
		"<color=cyan>Tài phú:<color> <color=green>3000<color>\n\n"..		
		"Mỗi 5 giây hồi phục sinh lực: <color=gold>+50 điểm<color>\n"..
		"Mỗi 5 giây hồi phục nội lực: <color=gold>+50 điểm<color>\n"..
		"Mỗi 5 giây hồi phục thể lực: <color=gold>+50 điểm<color>\n"..
		"Kháng tất cả: <color=gold>+25<color>",
	[4] = "<color=yellow>Long Đằng Hộ Thân Phù<color>\n"..
		"\n   <pic=155><pic=155><pic=155><pic=155>\n"..	
		"<color=cyan>Tài phú:<color> <color=green>4000<color>\n\n"..		
		"Mỗi 5 giây hồi phục sinh lực: <color=gold>+60 điểm<color>\n"..
		"Mỗi 5 giây hồi phục nội lực: <color=gold>+60 điểm<color>\n"..
		"Mỗi 5 giây hồi phục thể lực: <color=gold>+60 điểm<color>\n"..
		"Kháng tất cả: <color=gold>+30<color>",		
};
function uiPartner:OnMouseEnter(szWnd)
	local nLevelLien = me.GetSkillLevel(1993)
	local nLevelLung = me.GetSkillLevel(1994)
	local nLevelGiay = me.GetSkillLevel(1995)
	local nLevelBoi = me.GetSkillLevel(1996)
	local nLevelNon = me.GetSkillLevel(1997)
	local nLevelVKhi = me.GetSkillLevel(1988)
	local nLevelAo = me.GetSkillLevel(1989)
	local nLevelNhan = me.GetSkillLevel(1990)
	local tbTayDHanh = me.GetSkillLevel(1991)
	local tbPhuDHanh = me.GetSkillLevel(1992)
	local szTip = "";
	if (szWnd == self.IMG_NECKLACE) then
		szTip = self.tbLienDHanh[nLevelLien]
	elseif (szWnd == self.IMG_BELT) then
		szTip = self.tbLungDHanh[nLevelLung]
	elseif (szWnd == self.IMG_FOOT) then
		szTip = self.tbGiayDHanh[nLevelGiay]
	elseif (szWnd == self.IMG_PEDANT) then
		szTip = self.tbBoiDHanh[nLevelBoi]
	elseif (szWnd == self.IMG_HEAD) then
		szTip = self.tbNonDHanh[nLevelNon]	
	elseif (szWnd == self.IMG_VKHI) then
			szTip = self.tbVKhiDHanh[nLevelVKhi]		
	elseif (szWnd == self.IMG_Ao) then
		szTip = self.tbAoDHanh[nLevelAo]
	elseif (szWnd == self.IMG_NHAN) then
		szTip = self.tbNhanDHanh[nLevelNhan]
	elseif (szWnd == self.IMG_TAY) then
		szTip = self.tbTayDHanh[tbTayDHanh]	
	elseif (szWnd == self.IMG_PHU) then
		szTip = self.tbPhuDHanh[tbPhuDHanh]
	end
	
	if (szTip ~= "") then
		Wnd_ShowMouseHoverInfo(self.UIGROUP, szWnd, "", szTip);
	end	
end
function uiPartner:RegisterEvent()
	local tbRegEvent = 
	{
		{ UiNotify.emCOREEVENT_SYNC_PARTNER,	self.Update },
		{ UiNotify.emCOREEVENT_SYNC_ITEM,		self.UpdatePartnerEquip },
	};
	tbRegEvent = Lib:MergeTable(tbRegEvent, self.tbObjSkillView:RegisterEvent());
	for _, tbCont in pairs(self.tbObjEquipView) do
		tbRegEvent = Lib:MergeTable(tbRegEvent, tbCont:RegisterEvent());
	end
	return tbRegEvent;
end

function uiPartner:RegisterMessage()
	local tbRegMsg = self.tbObjSkillView:RegisterMessage();
	for _, tbCont in pairs(self.tbObjEquipView) do
		tbRegMsg = Lib:MergeTable(tbRegMsg, tbCont:RegisterMessage());
	end
	return tbRegMsg;
end

function uiPartner:SetEquipPosHighLight(tbObj)
	local nRet = 1;
	if not tbObj or tbObj.nType ~= Ui.OBJ_OWNITEM then
		self:ReleaseEquipPosHighLight();
		return;
	end
	local pItem = me.GetItem(tbObj.nRoom, tbObj.nX, tbObj.nY);
	if (not pItem) or (not pItem.nEquipPos) or (pItem.nEquipPos < Item.EQUIPPOS_NUM)then
		self:ReleaseEquipPosHighLight();
		return;
	end
	-- me.Msg("tbObj.nRoom partner: " .. tostring(tbObj.nRoom));
	-- me.Msg("tbObj.nX partner: " .. tostring(tbObj.nX));
	-- me.Msg("tbObj.nY partner: " .. tostring(tbObj.nY));
	-- me.Msg("pItem.nEquipPos partner: " .. tostring(pItem.nEquipPos));
	local nPosition = pItem.nEquipPos - Item.EQUIPPOS_NUM;
	local tbEquipWnd = self:GetEquipWndTableItem(nPosition);
	if tbEquipWnd then
		self.m_szHighLightEquipPos = tbEquipWnd[3];
		Img_SetFrame(self.UIGROUP, self.m_szHighLightEquipPos, 0);
	end	
end

function uiPartner:ReleaseEquipPosHighLight()
	if self.m_szHighLightEquipPos == nil then
		return;
	end
	Img_SetFrame(self.UIGROUP, self.m_szHighLightEquipPos, 1);
	self.m_szHighLightEquipPos = nil;
end

function uiPartner:GetEquipWndTableItem(nPosition)
	for _, tbEquipItem in ipairs(PARTNER_EQUIP_OBJ_CONFIGER) do
		if tbEquipItem[1] == nPosition then
			return tbEquipItem;
		end
	end
end
