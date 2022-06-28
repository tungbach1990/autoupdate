-----------------------------------------------------
--�ļ���		��	popbar.lua
--������		��	
--����ʱ��		��	2007-04-19
--��������		��	
--�޸���		��	
--�޸�ʱ��		��	2009-06-05
------------------------------------------------------
local uiPopBar = Ui:GetClass("popbar");

uiPopBar.BTN_SIT					= "BtnSit";
uiPopBar.BTN_RUN					= "BtnRun";
uiPopBar.BTN_MOUNT				= "BtnMount";
uiPopBar.BTN_PK						= "BtnPk";
uiPopBar.BTN_REC					= "BtnRec";
uiPopBar.SWITCHSTATUS_RUN			= "run";				--�ܲ�
uiPopBar.SWITCHSTATUS_SIT			= "sit";				--����
uiPopBar.SWITCHSTATUS_TRADE		= "trade";				--����
uiPopBar.SWITCHSTATUS_MOUNT		= "horse";				--��
uiPopBar.SWITCHSTATUS_SHOWNAME	= "showplayername";		--��ʾ�������
uiPopBar.SWITCHSTATUS_SHOWHP		= "showplayerlife";		--��ʾ�������
uiPopBar.SWITCHSTATUS_SHOWMP		= "showplayermana";		--��ʾ�������
uiPopBar.SWITCHSTATUS_SHOWPLAYERNUM	= "showplayernumber";	--������ʾ�������
uiPopBar.IMG_DISMOUNT			= "\\image\\ui\\001a\\main\\btn_pop_dismount.spr";
uiPopBar.IMG_MOUNT				= "\\image\\ui\\001a\\main\\btn_pop_mount.spr";
uiPopBar.IMG_RUN					= "\\image\\ui\\001a\\main\\btn_pop_run.spr";
uiPopBar.IMG_WALK					= "\\image\\ui\\001a\\main\\btn_pop_walk.spr";

local uiPopBar = Ui(Ui.UI_POPBAR);
local BTNGoiGiaToc					= "BtnGoiGiaToc"
local BTNGoiBang					= "BtnGoiBang"
local BTNGoiDoi					= "BtnGoiDoi"
local BTNGoiHaoHuu					= "BtnGoiHaoHuu"
local BTNYUANCHENG				= "BtnYuanCheng"
local BTNCallBAN					= "BtnCallBAN"
local BTNCallBAN1					= "BtnCallBAN1"
local BTNCallBAN2					= "BtnCallBAN2"
local BTNCallBAN3					= "BtnCallBAN3"
local BTNCallBAN4					= "BtnCallBAN4"
local BTNCallBAN5					= "BtnCallBAN5"
local BTNCallBAN6					= "BtnCallBAN6"
local BTNCallBAN7					= "BtnCallBAN7"
local BTNCallBAN8					= "BtnCallBAN8"
local BTNCallBAN9					= "BtnCallBAN9"
local BTNCallBAN0					= "BtnCallBAN0"
local BTNCallBAN10				= "BtnCallBAN10"
local BTNCallBAN11				= "BtnCallBAN11"
local BTNCallBAN12				= "BtnCallBAN12"
local BTNCallBAN13				= "BtnCallBAN13"
local BTNCallKin1					= "BtnCallKin1"
local BtnSit1					    = "BtnSit1"
local BtnRun1					    = "BtnRun1"
local BTNSuperMapLink					= "BtnSuperMapLink"  --Map
local BTN_yijun                                         = "BTN_yijun"
local BTNCallGua					= "BtnCallGua"
local BTNCallQuangAnhThach					= "BtnCallQuangAnhThach" -- QAT
local BTNCallLuyenCong					= "BtnCallLuyenCong" 
local BTNCallPKBang					= "BtnCallPKBang"
local BTNCallPKPhe					= "BtnCallPKPhe"
local BTNCallAutoPuFire					= "BTNCallAutoPuFire" -- QAT


uiPopBar.PKMODE =
{
	[Player.emKPK_STATE_PRACTISE] 	= { "Luyện công", 0x7BD794, "\\image\\ui\\001a\\main\\fightmode\\anneal.spr"  },
	[Player.emKPK_STATE_CAMP] 		= { "Phe phái", 0xFFC352, "\\image\\ui\\001a\\main\\fightmode\\camp_pk.spr" },
	[Player.emKPK_STATE_TONG] 		= { "Gia tộc", 0x399ED6, "\\image\\ui\\001a\\main\\fightmode\\tong_pk.spr" },
	[Player.emKPK_STATE_BUTCHER] 	= { "Đồ sát", 0xF7595A, "\\image\\ui\\001a\\main\\fightmode\\butcher.spr" },
	[Player.emKPK_STATE_UNION]		= { "Trạng thái liên minh", 0x399ED6, "\\image\\ui\\001a\\main\\fightmode\\tong_pk.spr"},
	
};

local	enum_Replay_Recing = 1;
local	enum_Replay_Saving = 2;

local 	SPR_BTN_REC			= "\\image\\ui\\001a\\recplayer\\btn_rec.spr";
local	SPR_BTN_STOPREC			= "\\image\\ui\\001a\\recplayer\\btn_stoprec.spr";

function uiPopBar:Init()
	self.nBtn	= 0;
	self.bExclusive	= 0;
	self.fnLButton  = nil;
	self.fnRButton  = nil;
end

--дlog
function uiPopBar:WriteStatLog(szField)
	Log:Ui_SendLog(szField, 1);
end

function uiPopBar:OnOpen()
	self:UpdatePKModel(1);
	self:UpdateRecPlayState();
end

function uiPopBar:OnButtonClick(szWnd, nParam)
	
     self:ReleaseAllAction();
if szWnd ==	self.BTN_SIT then
		Switch(self.SWITCHSTATUS_SIT)
	elseif szWnd ==	self.BTN_RUN then
		Switch(self.SWITCHSTATUS_RUN)
	elseif szWnd ==	BTNYUANCHENG then
		Map.tbAutoEgg:Eggswitch();
		SendChannelMsg("Team",string.format("�ӿ�"));
		elseif szWnd == BTNGoiGiaToc then
		Map.tbSuperCall:GoiGiaToc()
		elseif szWnd == BTNGoiBang then
		Map.tbSuperCall:GoiBang()
	elseif szWnd == BTNGoiDoi then
		Map.tbSuperCall:GoiDoi()
	elseif szWnd == BTNGoiHaoHuu then
		Map.tbSuperCall:GoiHaoHuu()
	elseif szWnd == BTNSuperMapLink then
		UiManager:SwitchWindow(Ui.UI_SUPERMAPLINK_UI)
	elseif szWnd == BTNCallQuangAnhThach then
		Map.tbSuperCall:QuangAnhThach()
	elseif szWnd == BTNCallAutoPuFire then
		Map.tbSuperCall:AutoPuFire()	
		
	elseif szWnd == BTNCallLuyenCong then
		Map.tbSuperCall:LuyenCong()  
	elseif szWnd == BTNCallPKBang then
		Map.tbSuperCall:PKBang()
	elseif szWnd == BTNCallPKPhe then
		Map.tbSuperCall:PKPhe()		
	elseif szWnd == BTNCallBAN then
		Map.tbSuperCall:Callto10()
	elseif szWnd == BTNCallBAN1 then
		Map.tbSuperCall:Callto11()
	elseif szWnd == BTNCallBAN2 then
		Map.tbSuperCall:Callto12()
	elseif szWnd == BTNCallBAN3 then
		Map.tbSuperCall:Callto13()
        elseif szWnd == BTNCallBAN4 then
		UiManager:hexuan()
        elseif szWnd == BTNCallBAN5 then
		UiManager:MaiCai()
        elseif szWnd == BTNCallBAN6 then
		UiManager:StartBao()
		elseif szWnd ==	BTN_yijun then                          --ؔ֯ӥ߼
		UiManager:SwitchWindow(Ui.UI_YIJUN_SETTING);
        elseif szWnd == BTNCallBAN8 then
		Map.tbSuperCall:Callto18()
        elseif szWnd == BTNCallBAN9 then
		Map.tbSuperCall:Callto19()
        elseif szWnd == BTNCallBAN7 then
		UiManager:StopBao()
		elseif szWnd == BTNCallGua then       --тѦڒܺ
		UiManager:StartGua()
        elseif szWnd == BTNCallBAN10 then
		Map.tbSuperCall:Callto20()
        elseif szWnd == BTNCallBAN11 then
		Map.tbSuperCall:Callto21()
        elseif szWnd == BTNCallBAN12 then
		Map.tbSuperCall:Callto22()   
        elseif szWnd == BTNCallBAN13 then
		Map.tbSuperCall:Callto23()     
        elseif szWnd ==	self.BTN_MOUNT then
		Switch(self.SWITCHSTATUS_MOUNT)
	elseif szWnd ==	self.BTN_PK	then
		if (me.IsFreshPlayer() == 1) then
			UiManager:OpenWindow(Ui.UI_INFOBOARD, "Nhân vật dưới cấp 50 hoặc chữ trắng không thể bật chế độ PK");
			return;
		end
		local nKinId, _ = 0;
		nKinId, _ = me.GetKinMember();
		UiManager:SwitchWindow(Ui.UI_FIGHTMODE);
	elseif szWnd == self.BTN_REC then
		local nState = GetReplayState();
		if nState == enum_Replay_Recing then
			Replay("endrec");
			Ui(Ui.UI_TASKTIPS):Begin("<bclr=blue><color=white>Hệ thống quay phim kết thúc<color><bclr> ");
		else
			Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Hệ thống quay phim bắt đầu<color><bclr> ");
			Replay("rec");
		end	
		self:UpdateRecPlayState();
	elseif nParam > 0 then

	end
end

function uiPopBar:UpdateRecPlayState()
	local nState = GetReplayState();
	if nState == enum_Replay_Recing then
		Img_SetImage(self.UIGROUP, self.BTN_REC, 1, SPR_BTN_STOPREC);
		Wnd_SetTip(self.UIGROUP, self.BTN_REC, "Ngừng thu hình");
	else
		Img_SetImage(self.UIGROUP, self.BTN_REC, 1, SPR_BTN_REC);
		Wnd_SetTip(self.UIGROUP, self.BTN_REC, "Bắt đầu thu hình");

	end	
end

function uiPopBar:ReleaseAllAction()
	return;
end

function uiPopBar:UpdateHorseState()
	local bChecked = me.GetNpc().IsRideHorse();
	if bChecked	== 1 then
		Img_SetImage(self.UIGROUP, self.BTN_MOUNT, 1,	self.IMG_DISMOUNT);
	else
		Img_SetImage(self.UIGROUP, self.BTN_MOUNT, 1,	self.IMG_MOUNT);
	end
end

function uiPopBar:UpdateDoingState()
	local bChecked = 0;
	if me.GetNpc().nDoing == Npc.DO_SIT	then
		bChecked = 1;
	end
	Btn_Check(self.UIGROUP, self.BTN_SIT,	bChecked);
end

function uiPopBar:UpdateRunState()
	local bChecked = me.IsRunStatus();
	if bChecked	== 1 then
		Img_SetImage(self.UIGROUP, self.BTN_RUN, 1, self.IMG_WALK);
	else
		Img_SetImage(self.UIGROUP, self.BTN_RUN, 1, self.IMG_RUN);
	end
end

function uiPopBar:UpdatePKModel()


	if (me.nPkModel == Player.emKPK_STATE_PRACTISE) then
		me.Msg("PK chuyển sang luyện công!");
	elseif(me.nPkModel == Player.emKPK_STATE_CAMP) then
		me.Msg("Pk chuyển sang phe phái");
	elseif(me.nPkModel == Player.emKPK_STATE_TONG) then
		local nKinId = me.GetKinMember();
		if (me.dwTongId > 0) then
			me.Msg("PK sang bang hội!");
			self.PKMODE[me.nPkModel][1] = "Bang hội";
		elseif (nKinId and nKinId > 0) then
			me.Msg("PK chuyển sang gia tộc!");
			self.PKMODE[me.nPkModel][1] = "Gia tộc";
			
		elseif (nKinId and nKinId <= 0 and me.dwTongId <= 0) then
			return;
		end	
	elseif(me.nPkModel == Player.emKPK_STATE_BUTCHER) then
		me.Msg("PK chuyển sang Đồ sát");
	end

	Btn_SetTxt(self.UIGROUP, self.BTN_PK, self.PKMODE[me.nPkModel][1]);
	Btn_SetTextColor(self.UIGROUP, self.BTN_PK, self.PKMODE[me.nPkModel][2]);
    Img_SetImage(self.UIGROUP, self.BTN_PK, 1, self.PKMODE[me.nPkModel][3]);

end

function uiPopBar:ChangeToNextModel()

	if (me.IsFreshPlayer() == 1) then
		UiManager:OpenWindow(Ui.UI_INFOBOARD, "Nhân vật dưới cấp 50 hoặc chữ trắng không thể bật chế độ PK");
		return;
	end
		
	local nKinId, _ = me.GetKinMember();
	if (me.dwTongId ~= 0 or (nKinId and nKinId ~= 0)) then
		me.nPkModel = me.nPkModel % 3 + 1;
	else
		if (me.nPkModel % 7 + 1 == 2) then
			me.nPkModel = 3;
		else
			me.nPkModel = me.nPkModel % 3 + 1;
		end
	end

	self:WriteStatLog("Đổi PK");

end

function uiPopBar:RegisterEvent()
	local tbRegEvent = 
	{
		{ UiNotify.emCOREEVENT_SYNC_RIDEHORSE,	self.UpdateHorseState	},
		{ UiNotify.emCOREEVENT_SYNC_DOING,		self.UpdateDoingState	},
		{ UiNotify.emCOREEVENT_SYNC_RUNSTATUS,	self.UpdateRunState 	},
		{ UiNotify.emCOREEVENT_SYNC_PK_MODEL,	self.UpdatePKModel 		},
	};
	return tbRegEvent;
end

local tbSuperCall	= Map.tbSuperCall or {};
Map.tbSuperCall		= tbSuperCall;

local tbMsgInfo = Ui.tbLogic.tbMsgInfo;

local callStart = 0;

function tbSuperCall:ModifyUi()

	tbSuperCall.Say_bak	= tbSuperCall.Say_bak or UiCallback.OnMsgArrival
	function UiCallback:OnMsgArrival(nChannelID, szSendName, szMsg, szGateway)
		tbSuperCall.Say_bak(UiCallback, nChannelID, szSendName, szMsg, szGateway);
		local function fnOnSay()
			tbSuperCall:OnSay(nChannelID, szSendName, szMsg, szGateway);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnOnSay);
	end

end

----Chuẩn
function tbSuperCall:GoiDoi()
	local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
	--local szMsg = string.format("Triệu tập::"","..nMapId..","..nCurWorldPosX..","..nCurWorldPosY);
	local szMsg = string.format("Triệu tập::,"..nMapId..","..nCurWorldPosX..","..nCurWorldPosY.." , ("..GetMapNameFormId(nMapId)..")");
	local szPosText	= "";
	local tbMsg = {};
	tbMsg.szMsg = string.format("Bạn thực sự muốn gọi Đồng Đội đến giúp?");
	tbMsg.nOptCount = 2;
	tbMsg.tbOptTitle = { "Hủy", "Gọi"};
	function tbMsg:Callback(nOptIndex, n1, n2)
		if (nOptIndex == 2) then	--Ƶր
			SendChannelMsg("Team",szPosText.."Triệu tập::,"..nMapId..","..nCurWorldPosX..","..nCurWorldPosY.." , ("..GetMapNameFormId(nMapId)..")");
			
			--SendChatMsg(szMsg);
		end
	end
	UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg);
end

function tbSuperCall:GoiGiaToc()
	local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
	--local szMsg = string.format("Triệu tập::"","..nMapId..","..nCurWorldPosX..","..nCurWorldPosY);
	local szMsg = string.format("Triệu tập::,"..nMapId..","..nCurWorldPosX..","..nCurWorldPosY.." , ("..GetMapNameFormId(nMapId)..")");
	local szPosText	= "";
	local tbMsg = {};
	tbMsg.szMsg = string.format("Bạn thực sự muốn gọi Gia tộc đến giúp?");
	tbMsg.nOptCount = 2;
	tbMsg.tbOptTitle = { "Hủy", "Gọi"};
	function tbMsg:Callback(nOptIndex, n1, n2)
		if (nOptIndex == 2) then	--Ƶր
			SendChannelMsg("Kin",szPosText.."Triệu tập::,"..nMapId..","..nCurWorldPosX..","..nCurWorldPosY.." , ("..GetMapNameFormId(nMapId)..")");
			
			--SendChatMsg(szMsg);
		end
	end
	UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg);
end




function tbSuperCall:GoiHaoHuu()
	local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
	--local szMsg = string.format("Triệu tập::"","..nMapId..","..nCurWorldPosX..","..nCurWorldPosY);
	local szMsg = string.format("Triệu tập::,"..nMapId..","..nCurWorldPosX..","..nCurWorldPosY.." , ("..GetMapNameFormId(nMapId)..")");
	local szPosText	= "";
	local tbMsg = {};
	tbMsg.szMsg = string.format("Bạn thực sự muốn gọi Hảo hửu đến giúp?");
	tbMsg.nOptCount = 2;
	tbMsg.tbOptTitle = { "Hủy", "Gọi"};
	function tbMsg:Callback(nOptIndex, n1, n2)
		if (nOptIndex == 2) then	--Ƶր
			SendChannelMsg("Friend",szPosText.."Triệu tập::,"..nMapId..","..nCurWorldPosX..","..nCurWorldPosY.." , ("..GetMapNameFormId(nMapId)..")");
			
			--SendChatMsg(szMsg);
		end
	end
	UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg);
end



function tbSuperCall:GoiBang()
	local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
	--local szMsg = string.format("Triệu tập::"","..nMapId..","..nCurWorldPosX..","..nCurWorldPosY);
	local szMsg = string.format("Triệu tập::,"..nMapId..","..nCurWorldPosX..","..nCurWorldPosY.." , ("..GetMapNameFormId(nMapId)..")");
	local szPosText	= "";
	local tbMsg = {};
	tbMsg.szMsg = string.format("Bạn thực sự muốn gọi Bang hội đến giúp?");
	tbMsg.nOptCount = 2;
	tbMsg.tbOptTitle = { "Hủy", "Gọi"};
	function tbMsg:Callback(nOptIndex, n1, n2)
		if (nOptIndex == 2) then	--Ƶր
			SendChannelMsg("Tong",szPosText.."Triệu tập::,"..nMapId..","..nCurWorldPosX..","..nCurWorldPosY.." , ("..GetMapNameFormId(nMapId)..")");
			
			--SendChatMsg(szMsg);
		end
	end
	UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg);
end


function tbSuperCall:LuyenCong()
	local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
	local szPosText	= "";
	me.nPkModel = Player.emKPK_STATE_PRACTISE;
	szPosText = string.format("", GetMapNameFormId(nMapId), nCurWorldPosX / 8, nCurWorldPosY / 16);

	SendChannelMsg("Team",szPosText.."Tôi đã bật chế độ Luyện.:.Công");
end
function tbSuperCall:PKBang()
	local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
	local szPosText	= "";
	me.nPkModel = Player.emKPK_STATE_TONG;
	szPosText = string.format("", GetMapNameFormId(nMapId), nCurWorldPosX / 8, nCurWorldPosY / 16);

	SendChannelMsg("Tong",szPosText.."Tôi đã bật chế độ PK.:.Bang");
end
function tbSuperCall:PKPhe()
	local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
	local szPosText	= "";
	me.nPkModel = Player.emKPK_STATE_CAMP;
	szPosText = string.format("", GetMapNameFormId(nMapId), nCurWorldPosX / 8, nCurWorldPosY / 16);

	SendChannelMsg("Team",szPosText.."Tôi đã bật chế độ PK.:.Phe");
end

function tbSuperCall:Split(szFullString, szSeparator)
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
tbSuperCall:Init()