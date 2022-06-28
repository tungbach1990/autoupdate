local tbAutoAimHT	= Map.tbAutoAimHT or {};
Map.tbAutoAimHT	= tbAutoAimHT;
--δ��ɲ���
--1���ӳ�����ID��ʶ��������š�
--2�����ø���Ӧ�ð���ͬ���ɽ��б���Ͷ�ȡ��

--ע��ʱ��ؼ�
local tbTimer = Ui.tbLogic.tbTimer;
--ע����Ϣ����ؼ�
local tbMsgInfo = Ui.tbLogic.tbMsgInfo;
--��SELECTNPC�ҹ�
local tbSelectNpc    = Ui(Ui.UI_SELECTNPC);

--[[local tCmd = { "Map.tbAutoAimHT:AutoFollow();", "AutoFollow", "", "Ctrl+X", "Ctrl+X", "AutoFollow̦" };
AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]); ]]

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
};


-- ����ʱ��ʼ��
function tbAutoAimHT:Init()
	self:ModifyUi();
	self.nYaoState 		= 0;	-- �Զ���ҩ״̬
	self.nPickState 	= 0;	-- �Զ�ʰȡ״̬
	self.nfireState 	= 0;	-- �Զ����״̬
	self.nFollowTime    	= 0.1;  -- ������Ƶ��
	self.nFollowState 	= 0;
	self.nPID 		= 0;
	self.nPlayerID		= 0;  
	self.nszName		= nil;
	self.nFRange		= 0.6; 	-- ս������ֱ�߾���
	self.nEmFRange		= 0.6; 	-- ���Ҹ���ֱ�߾���
	self.EatFood 		= 80;	-- Ѫ���ڵ���80%���Բ�
	self.DelayStat 		= 0;	-- �ӳ��жϲ���
	
	self.nAttackMonsterState = 0;
	self.nRepairItemState = 0;
	self.nRideRange = 1.7;
	
	self.TimeStartFollow = 0;
	self.MaxTimeRepairItem = 3600; --1800
	self.LastRepairTime = 0;
	self.nVuaSua = 0;
	self.nOnOffTrainAfk = 1;
	self.MapidTrain = 132;
	self.PosXTrain = 1682;
	self.PosYTrain = 3481;
	
	self.OldPosX = 0;
	self.OldPosY = 0;
	self.OldTime = 0;
	self.MaxOldTime1 = 300;
	self.MaxOldTime = 900; --thoi gian max afk
	self.nTrainDcChua = 0;
	self.nBatAutoFight = 0;
end
--���ø���
function tbAutoAimHT:UpdateSetting(AimCfg)
	self.bYaoDelay 	= AimCfg.nYaoDelay;
	self.life_left 	= AimCfg.nLifeRet;
	self.mana_left 	= AimCfg.nManaRet;
	self.EMHealDelay = AimCfg.nHealDelay;
	self.bAutoEat = AimCfg.nAutoEat;
end
--����1���Զ���ҩ----------------------------------------------------------------------------------------
--�Զ���ҩ����
function tbAutoAimHT:FAutoYao()
	local nYaoTimer = 0;
	local TXTINT	= self.bYaoDelay*1000;
	if self.nYaoState == 0 then
		self.nYaoState = 1;
		me.Msg("<color=yellow>Dùng thuốc tự động<color>");
		me.Msg("<color=yellow>Delay:<color>"..string.format("<color=green>%d<color>",TXTINT).."ms");
		me.Msg("<color=yellow>Bơm máu khi sinh lực < <color>"..string.format("<color=green>%d",self.life_left).."<color>");
		me.Msg("<color=yellow>Bơm mana khi lực < <color>"..string.format("<color=green>%d",self.mana_left).."<color>");
		nYaoTimer = tbTimer:Register(0.5 * Env.GAME_FPS, self.YaoTimer, self);
	else
		self.nYaoState = 0;
	end
end

--�Զ���ҩ
function tbAutoAimHT:YaoTimer()
	if self.nYaoState == 0 then
		me.Msg("<color=red>Tắt dùng thuốc tự động<color>");
		return 0;
	end
	--�Ժ�
	if (me.nCurLife < tonumber(self.life_left)) and self.DelayStat == 0 then
		local nHONG = Map.AimCommonHT:GetHongYao();
		me.UseItem(nHONG);
		self:MyDelay(self.bYaoDelay);
	end
	--����
	if (me.nCurMana < tonumber(self.mana_left)) and self.DelayStat == 0 then
		local nLAN = Map.AimCommonHT:GetLanYao();
		me.UseItem(nLAN);
		self:MyDelay(self.bYaoDelay);
	end
end
--����2���Զ�ʰȡ------------------------------------------------------------------------------------
tbAutoAimHT.FPickUp = function(self)
	local nPickTime = 0;
	local Space_Time = 0.2;	-- 0.1ʰȡ��Ʒ��ʱ���ӳ�/��(�Ѿ��������ٿ��������)
	if (self.nPickState == 0 ) then
		self.nPickState =1;
		nPickTime = Timer:Register(Space_Time * Env.GAME_FPS, self.PickTimer, self);
		me.Msg("<color=yellow>Bật nhặt đồ nhanh<color>");
	else
		self.nPickState =0;
		Timer:Close(nPickTime);
		nPickTime = 0;
		me.Msg("<color=green>Tắt nhặt đồ nhanh<color>");
	end
end

tbAutoAimHT.PickTimer = function(self)
	if (self.nPickState ==0 ) then
		return 0;
	end
	AutoAi.PickAroundItem(Space);
end

--����3�������ٻ�------------------------------------------------------------------------------------

---- ����������Ϣ ----
function tbAutoAimHT:ModifyUi()
	tbAutoAimHT.Say_bak	= tbAutoAimHT.Say_bak or UiCallback.OnMsgArrival
	function UiCallback:OnMsgArrival(nChannelID, szSendName, szMsg)
		tbAutoAimHT.Say_bak(UiCallback, nChannelID, szSendName, szMsg);
		-- �ӳٵ���OnSay�����ӳٹز������ڣ�
		local function fnOnSay()
			tbAutoAimHT:OnSay(nChannelID, szSendName, szMsg);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnOnSay);
	end
end

----�ٻ�1�����𼯺��ٻ�----
function tbAutoAimHT:Select()
	local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
	--local szMsg = string.format("Triệu tập::"","..nMapId..","..nCurWorldPosX..","..nCurWorldPosY);
	local szMsg = string.format("Triệu tập::,"..nMapId..","..nCurWorldPosX..","..nCurWorldPosY.." , ("..GetMapNameFormId(nMapId)..") Cần anh em giúp đở !");
	local tbMsg = {};
	tbMsg.szMsg = string.format("Chọn kênh Chat để gọi triệu tập!");
	tbMsg.nOptCount = 2;
	tbMsg.tbOptTitle = { "Hủy", "Gọi"};
	function tbMsg:Callback(nOptIndex, n1, n2)
		if (nOptIndex == 2) then	--Ƶ��
			SendChatMsg(szMsg);
		end
	end
	UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg);
end

----�ٻ�2�������ɼ�ħ��ʯ----
function tbAutoAimHT:CalltoDan()
	SendChannelMsg("Team","Mè");
end

----�ٻ�3������[����/ֹͣ]���----
function tbAutoAimHT:CalltoFire()
	if self.nfireState == 0 then
		self.nfireState = 1
		SendChannelMsg("Team","Bắt đầu cháy");
	else
		self.nfireState = 0
		SendChannelMsg("Team","Ngừng chiến đấu");
	end
end

---- �ͻ����յ���Ϣʱ ----
function tbAutoAimHT:OnSay(nChannelID, szSendName, szMsg)
	local stype
	if nChannelID==3 then
		stype="Đồng Đội"
	end      
	---- ������Ϣ�ֲ� ----
	function tbAutoAimHT:Split(szFullString, szSeparator)
		local nFindStartIndex = 1
		local nSplitIndex = 1
		local nSplitArray = {}
		while true do
		   local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
		   if not nFindLastIndex then
			nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
			break
	 	  end
	  	 nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
	   	nFindStartIndex = nFindLastIndex + string.len(szSeparator)
	  	 nSplitIndex = nSplitIndex + 1
		end
		return nSplitArray
	end
	----�ɼ�ħ��ʯ��Ϣ----
	if string.find(szMsg,"Mè") and stype=="Đồng Đội" then
		me.Msg("Spar bắt đầu thu thập phép thuật")
		local tbAroundNpc	= KNpc.GetAroundNpcList(me, 1000);
		for _, pNpc in ipairs(tbAroundNpc) do
			if (pNpc.nTemplateId == 4223) then
				AutoAi.SetTargetIndex(pNpc.nIndex);
				break;
			end
		end
	end
	----���������Ϣ----
	if  string.find(szMsg,"Bắt đầu cháy chữa cháy") and szSendName==me.szName  then
		self.TimeridFire = Ui.tbLogic.tbTimer:Register(20, tbAutoAimHT.Fire, self)
		me.Msg("<color=yellow>Bắt đầu cháy chữa cháy<color>")
	end
	----ֹͣ�����Ϣ----
	if  string.find(szMsg,"Cháy hết") and szSendName==me.szName  then
		Ui.tbLogic.tbTimer:Close(self.TimeridFire);
		--Ui.tbLogic.tbTimer:Close(Map.TimeridFire);
		me.Msg("<color=red>Cháy hết<color>")
	end
end

------�ӹ���2-3�����----
function tbAutoAimHT:Fire()
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		--��������ʲôҲ����
		return
	end
	if self.nfireState == 0 then
		me.Msg("Fire break.... ...");
		return 0
	end

	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();

	--if nCurMapId ~= 493 then
	--	return 0
	--end

	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 1000);

	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == 4235) then
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
		end
	end
end

--����3���Զ�����------------------------------------------------------------------------------------
--����������
function tbAutoAimHT:FollowData(szName,nItemData)
	self.nTrainDcChua = 0;
	self.nBatAutoFight = 0;
	if (nItemData >0) then
		self.nPID = 1;
		self.nPlayerID = nItemData;
		local tbSplit	= Lib:SplitStr(szName, " ");
		self.nszName = tbSplit[1];
		self.nPType = 1;
	else
		self.nPID = 0;
	end
	self:AutoFollow()
end

--�Զ�����
function tbAutoAimHT:AutoFollow()
	--ȷ���������
	if (me.nFaction == 5 and me.CanCastSkill(98) == 1) then
		self.nRange = self.nEmFRange;  -- ����Ƕ���,��ʹ��nEmFollowRange�������
	else
		self.nRange = self.nFRange; 
	end

	if self.nFollowState == 0 then
		self.nFollowState = 1;
		--��һ�����������ȷ��
		if self.nPID == 0 then --�����û��ѡ�����������˳��ѡ�����
			local playerInfo = tbSelectNpc.pPlayerInfo;
			--����1�����ѡ���NPC
			if playerInfo then
				self.nPlayerID = tbSelectNpc.pPlayerInfo.dwId;
				self.nszName = tbSelectNpc.pPlayerInfo.szName;
				self.nPType = 2;
			--����2��ѡ�����Ķӳ�
			else
				local nAllotModel, tbMemberList = me.GetTeamInfo();
				if nAllotModel and tbMemberList then
    					local tLeader = tbMemberList[1];
					if tLeader.szName == me.szName then
						Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Không có mục tiêu chính xác<color>");
						me.Msg("<color=Yellow>Bạn là đội trưởng, không thể theo bạn được<color=Yellow>");
						return;
					else
						self.nPlayerID = tLeader.nPlayerID;
						self.nszName = tLeader.szName;
						self.nPType = 3;
					end
				end
			end
		end
		if (self.nPlayerID == 0) then
			Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Không có mục tiêu chính xác<color>");
			me.Msg("<color=Yellow>Không có mục tiêu chính xác<color=Yellow>");
			self.nFollowState = 0;
			return;
		end
		--��������
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Theo sau: <color> ["..self.nszName.."<color>]");
		me.Msg("<color=green>Bắt đầu theo sau:<color> [<color=Yellow>"..self.nszName.."<color>]");
		nFTimer1 = Timer:Register(self.nFollowTime * Env.GAME_FPS, self.OnFollow1, self);
	else
		self.nFollowState = 0;
		Timer:Close(nFTimer1);
		me.Msg("<color=green>Ngừng theo sau - Hộ tống<color>");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blue><color=yellow>Ngừng theo sau - Hộ tống<color>");
		self.nPID = 0;
		self.nPosX = 0;
		self.nPosY = 0;
		if (me.nAutoFightState == 1) then
			AutoAi.ProcessHandCommand("auto_fight", 0);
			AutoAi.SetTargetIndex(0);
		end
	end
end
--ս������
function tbAutoAimHT:OnFollow1()
	-- ����ʳ��self.EatFood=80% 	
	if (me.IsDead() == 1) then	
		me.SendClientCmdRevive(0);		
		if me.nAutoFightState == 1 then
			AutoAi.ProcessHandCommand("auto_fight", 0);			
		end		
		--self.nTrainDcChua = 0
		self.nBatAutoFight = 0;
		--return
	end
	if self.nTrainDcChua == 0 then
	--me.Msg("Time = "..GetTime());
	if (GetTime() - self.TimeStartFollow > 1) and (self.nVuaSua == 1) then
		--UiManager:SwitchWindow(Ui.UI_PLAYERPANEL);
		UiManager:CloseWindow(Ui.UI_PLAYERPANEL);
		UiManager:ReleaseUiState(UiManager.UIS_ITEM_REPAIR);	
		self.nVuaSua = 0;
	end
	if (GetTime() - self.TimeStartFollow > self.MaxTimeRepairItem) and ( self.nRepairItemState == 1 ) then
		self:RepairItemAll();
		self:RepairItemAll();
		if (UiManager:WindowVisible(Ui.UI_PLAYERPANEL) == 1) then
				UiManager:CloseWindow(Ui.UI_PLAYERPANEL);
		end
		self.TimeStartFollow = GetTime();
		self.nVuaSua		 = 1;		
	end
	if self.bAutoEat == 1 and ((me.nCurLife*100/me.nMaxLife < self.EatFood) or (me.nCurMana*100/me.nMaxMana < self.EatFood)) then
		if me.IsCDTimeUp(3) == 1 and 0 == AutoAi.Eat(3) then	-- �ȳԶ�Чʳ��
			local nLevel, nState, nTime = me.GetSkillState(AutoAi.FOOD_SKILL_ID);
			if (not nTime or nTime < 36) then
				if 0 == AutoAi.Eat(4) then -- ��Чʳ��
					print("AutoAi- No Food...");
				end
			end
		end
	end
	--��������ʲôҲ����
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	--ǿ���ж�
	if self.nFollowState == 0 then
		AutoAi.ProcessHandCommand("auto_fight", 0);
		return 0;
	end
	--��ȡ�Լ���ͼ����
	local nMyMap,nMyX, nMyY = me.GetWorldPos();
	self.nMMap = nMyMap
	self.nMyPosX = nMyX / 8;
	self.nMyPosY = nMyY / 16;
	--��ȡ�����ͼ
	local tbMember = me.GetTeamMemberInfo();
	for i = 1, #tbMember do
		if tbMember[i].szName and tbMember[i].szName == self.nszName then
			self.nPMap = tbMember[i].nMapId;
		end
	end
	--����������ͼID
	if self.nMMap == 344 then --������
		self.nPMap = 344;
	elseif self.nMMap == 273 then --��������ؿ�[���ر���]
		self.nPMap = 273;
	elseif self.nMMap == 287 then --����ǧ��
		self.nPMap = 287;
	elseif self.nMMap == 254 then --�������칫��ڣ
		self.nPMap = 254;
	elseif self.nMMap == 272 then --������Į�ų�
		self.nPMap = 272;
	elseif self.nMMap == 557 then --������ţɽ��ɽ(����)
		self.nPMap = 557;
	elseif self.nMMap == 560 then --��������ɽ
		self.nPMap = 560;
	elseif self.nMMap == 493 then --����������Ĺ
		self.nPMap = 493;
	end
	--�ж���ͼ�����ս��and self.nPMap == self.nMMap
	if self.nPType == 2 then
		self:FLFight();
	elseif self.nPMap == self.nMMap then
		self:FLFight();
	else
		--��ͼ�޸���������
		if self.nPMap == 90 then -- �޸�[佻�Ϫ]
			self.PlayX = "1900";
			self.PlayY = "3900";
		elseif self.nPMap == 97 and self.nMMap ~=90 then -- �޸�[��ˮ��]
			self.PlayX = "1920";
			self.PlayY = "3620";
		else
			self.PlayX = "1500";
			self.PlayY = "3000";
		end
		self:GotoPmap(self.PlayX,self.PlayY);
	end
	else
		if self.nFollowState == 0 then
			AutoAi.ProcessHandCommand("auto_fight", 0);
			return 0;
		end
		self:FLFight();
	end
end

-- ��ͼ��ͼ
function tbAutoAimHT:GotoPmap(PlayX,PlayY)
	--��������ʲôҲ����
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	local sznMap = GetMapNameFormId(self.nPMap)
	me.Msg("Bản đồ: <color=Blue>["..sznMap.."]<color> Theo sau: <color=Yellow>"..self.nszName.."<color>")
	local nPlayPosInfo ={}
	nPlayPosInfo.szType = "pos"
	nPlayPosInfo.szLink = sznMap..","..self.nPMap..","..PlayX..","..PlayY;
	Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,nPlayPosInfo);
	me.Msg(nPlayPosInfo.szLink)
end
-- ͬͼ����ս��
function tbAutoAimHT:FLFight()
	local bChecked = me.GetNpc().IsRideHorse();
	--��ȡ��������
	if self.nTrainDcChua == 0 then
	if self.nPType == 2 then
		me.Msg("<color=green>Theo sau:<color>[<color=Gold>"..self.nszName.."<color>]")
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Theo sau: <color> ["..self.nszName.."<color>]");
		me.Msg(self.nFollowState)
		local tbAroundNpc	= KNpc.GetAroundNpcList(me, 300);
		for _, pNpc in ipairs(tbAroundNpc) do
			if (pNpc.szName == self.nszName) then
				local _, nNpcX, nNpcY	= pNpc.GetWorldPos();
				self.nPosX = nNpcX/8;
				self.nPosY = nNpcY/16;
			end
		end
	else
		local tbNpc = SyncNpcInfo();	
		if tbNpc then
			for _, tbNpcInfo in ipairs(tbNpc) do
				if tbNpcInfo.szName == self.nszName then
					self.nPosX = tbNpcInfo.nX/16;
					self.nPosY = tbNpcInfo.nY/16;
				end
			end
		end
	end
	else
		--me.Msg("di train rieng thoi");
		local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
		if (nMapId == self.MapidTrain) and (nCurWorldPosX == self.PosXTrain) and (nCurWorldPosY == self.PosYTrain) then
			
				if (me.nAutoFightState ~= 1) then
					AutoAi.ProcessHandCommand("auto_fight", 1);					
				end	
				self.nBatAutoFight = 1;
		elseif (self.nBatAutoFight == 0) then
		if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1 then
			local tbPosInfo ={}
			tbPosInfo.szType = "pos"
			tbPosInfo.szLink = ","..self.MapidTrain..","..self.PosXTrain..","..self.PosYTrain
			Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,tbPosInfo);			
		end
		end
	end
	--����ֱ�߾���
	if (self.nTrainDcChua == 0) then
	local TargetDis = math.sqrt((self.nMyPosX-self.nPosX)^2 + (self.nMyPosY-self.nPosY)^2);
		--�жϾ��벢ȷ��ս�����Ѫme.Msg("D:"..self.EMHealDelay.."Eat:"..self.bAutoEat)	
		if (TargetDis < self.nRange) then
			if (self.OldPosX ~= self.nPosX) or (self.OldPosY ~= self.nPosY) then
				self.OldTime = GetTime();
			end
			if (self.OldPosX == self.nPosX) and (self.OldPosY == self.nPosY) and (self.OldTime + self.MaxOldTime1 < GetTime()) and (self.nOnOffTrainAfk == 1) then
				SendChannelMsg("Team","Khởi động lại auto train!!");				
			end
			if (self.OldPosX == self.nPosX) and (self.OldPosY == self.nPosY) and (self.OldTime + self.MaxOldTime < GetTime()) and (self.nOnOffTrainAfk == 1) then
				--me.Msg("tran gan = 1");
				self.nTrainDcChua = 1;
			else
			self.OldPosX = self.nPosX;
			self.OldPosY = self.nPosY;
			--me.Msg(self.OldPosX.."="..self.nPosX);
			--me.Msg(self.OldPosY.."="..self.nPosY);
			--me.Msg(self.OldTime.."="..GetTime());
			if (me.nFaction == 5 and me.CanCastSkill(98) == 1 and self.nAttackMonsterState ~= 1) then
				--me.Msg("buff thoi");
				if self.DelayStat == 0 then
					me.UseSkill(98,GetCursorPos());
					self:MyDelay(self.EMHealDelay);
				else
					return;
				end
			else
				if (self:IsDangerous() == 1) then
					me.Msg("Nguy hiểm Sức bật lạ!!!");
					AutoAi.ProcessHandCommand("auto_fight", 0);
					AutoAi.SetTargetIndex(0);
				else
					local tbSkillInfo	= KFightSkill.GetSkillInfo(me.nLeftSkill, 1);
					if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then	-- kỹ năng phải xuống ngựa， xuống ngựa lập tức
						Switch("horse");	-- xuống ngựa 
					end
					if (me.nAutoFightState ~= 1) then					
						AutoAi.ProcessHandCommand("auto_fight", 1);
					end
				end
			end
			end
		else			
			if (me.nFaction == 5 and me.CanCastSkill(98) == 1 and self.nAttackMonsterState ~= 1) then  -- ����Ƕ���ֱ�Ӹ���
				if (me.nAutoFightState == 1) then
					AutoAi.ProcessHandCommand("auto_fight", 0);
					AutoAi.SetTargetIndex(0);
				end
				if (TargetDis > self.nRideRange and bChecked ~= 1) then					
					Switch([[horse]])					
				end
				me.AutoPath(self.nPosX*8, self.nPosY*16);
			else
				--me.Msg("khoang cach ="..TargetDis);
				if (TargetDis > self.nRideRange and bChecked ~= 1) then					
					Switch([[horse]])					
				end
				self:StopFight();
			end
		end
	end
end

-- �ر��Զ�ս��
function tbAutoAimHT:StopFight()
	if (self.nMMap < 298 or self.nMMap > 332) or self.nPType == 2 then --��������ѡ����󣬺��ӵ�ͼ��
		if (me.nAutoFightState == 1) then
			AutoAi.ProcessHandCommand("auto_fight", 0);
			AutoAi.SetTargetIndex(0);
		end
		me.AutoPath(self.nPosX*8, self.nPosY*16);
	else -- ��ң�ȵ�ͼ(ID:298-332)
	--��ң�ȵȴ�ɱ�ֽ����Ÿ���[����]
		local tbAroundNpc = KNpc.GetAroundNpcList(me, 10);
		for _, pNpc in ipairs(tbAroundNpc) do
			if (pNpc.nKind == 0) then  --��Χ���й�
				me.Msg("");
				AutoAi.ProcessHandCommand("auto_fight", 0);
				AutoAi.SetTargetIndex(0);
				local nX = math.floor(self.nPosX);
				local nY = math.floor(self.nPosY);
				me.Msg("Tọa độ: <color=Blue>"..nX.."/"..nY.."<color>");
				me.AutoPath(self.nPosX*8, self.nPosY*16);
			else
				me.Msg("");
				AutoAi.ProcessHandCommand("auto_fight", 0);
				AutoAi.SetTargetIndex(0);
				local nX = math.floor(self.nPosX);
				local nY = math.floor(self.nPosY);
				me.Msg("Tọa độ: <color=Blue>"..nX.."/"..nY.."<color>");
				me.AutoPath(self.nPosX*8, self.nPosY*16);
			end
		end
	end
end
-- ��⸽���Ƿ��з�����
function tbAutoAimHT:IsDangerous()
	local isDangerous = 0;
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 40);
	for _, pNpc in ipairs(tbAroundNpc) do		
		local id = pNpc.nTemplateId;
		if (id == 3146 or id == 3149 or id == 3152 or id == 3157 or id == 3177 or id == 3193 or id == 3277 ) then
			-- Ľ�ݼһ�:3146;���մ�����:3149;Ľ�ݼұ�:3152;���Ի��:3157;Ľ���Ϲ��:3177;ǿ�����:3193;ľ׮����:3277
			isDangerous = 1;
			break;
		end
	end
	return isDangerous;
end
-- ͨ��5: �ӳ�
function tbAutoAimHT:MyDelay(DelayTime)
	self.nTest = 0;
	self.nDtime = DelayTime;
	self.DelayStat = 1;
	local DelayStart = tbTimer:Register(0.2 * Env.GAME_FPS, self.DelayClock, self);
end
-- ͨ��5: �ӳ�[ʱ��]
function tbAutoAimHT:DelayClock()
	local nDelay = self.nDtime*5;
	self.nTest = self.nTest + 1;
	if self.nTest >= nDelay+5 then
		self.DelayStat = 0;
		return 0;
	end
end

function tbAutoAimHT:RepairItemAll()
	self.tbEquipCont = {};
	for _, tb in ipairs(SELF_EQUIPMENT) do
		local nPos = tb[1];
		self.tbEquipCont[nPos] = Ui.tbLogic.tbObject:RegisterContainer(
			"UI",
			tb[2],
			1,
			1,
			{ nOffsetX = nPos },
			"equiproom"
		);
	end
	for nPos, tbCont in pairs(self.tbEquipCont) do
		tbCont.nRoom = Item.ROOM_EQUIP;
		local pItem = me.GetItem(tbCont.nRoom, nPos, 0);
		local tbFind = me.FindItemInBags(18,1,2,1);
		for _, tbItem in pairs(tbFind) do
			if pItem then
				me.UseItem(tbItem.pItem);
				me.RepairEquipment(pItem.nIndex, Item.REPAIR_ITEM);
			end;
		end;
	end;
	for nPos, tbCont in pairs(self.tbEquipCont) do
		tbCont.nRoom = Item.ROOM_EQUIP;
		local pItem = me.GetItem(tbCont.nRoom, nPos, 0);
		local tbFind = me.FindItemInBags(18,1,2,2);
		for _, tbItem in pairs(tbFind) do
			if pItem then
				me.UseItem(tbItem.pItem);
				me.RepairEquipment(pItem.nIndex, Item.REPAIR_ITEM);
			end;
		end;
	end;
	for nPos, tbCont in pairs(self.tbEquipCont) do
		tbCont.nRoom = Item.ROOM_EQUIP;
		local pItem = me.GetItem(tbCont.nRoom, nPos, 0);
		local tbFind = me.FindItemInBags(18,1,2,3);
		for _, tbItem in pairs(tbFind) do
			if pItem then
				me.UseItem(tbItem.pItem);
				me.RepairEquipment(pItem.nIndex, Item.REPAIR_ITEM);
			end;
		end;
	end;
	for nPos, tbCont in pairs(self.tbEquipCont) do
		tbCont.nRoom = Item.ROOM_EQUIP;
		local pItem = me.GetItem(tbCont.nRoom, nPos, 0);
		local tbFind = me.FindItemInBags(18,1,2,4);
		for _, tbItem in pairs(tbFind) do
			if pItem then
				me.UseItem(tbItem.pItem);
				me.RepairEquipment(pItem.nIndex, Item.REPAIR_ITEM);
			end;
		end;
	end;
	for nPos, tbCont in pairs(self.tbEquipCont) do
		tbCont.nRoom = Item.ROOM_EQUIP;
		local pItem = me.GetItem(tbCont.nRoom, nPos, 0);
		local tbFind = me.FindItemInBags(18,1,2,5);
		for _, tbItem in pairs(tbFind) do
			if pItem then
				me.UseItem(tbItem.pItem);
				me.RepairEquipment(pItem.nIndex, Item.REPAIR_ITEM);
			end;
		end;
	end;
	UiManager:ReleaseUiState(UiManager.UIS_ITEM_REPAIR);
	return 1;
end


tbAutoAimHT:Init();
--LoadUiGroup(Ui.UI_PLAYERPANEL, "playerpanel.ini");