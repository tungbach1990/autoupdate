local tbChuctet = Map.tbChuctet or {};
Map.tbChuctet = tbChuctet;

local self = tbChuctet;

local TASKID_ID				= 466
local TASKID_GROUP			= 2113;	
local TASKID_TIME			= 1;	

local nSwitch = 0;
local nIsDone;
local nModifyTimer;

local tbStep = {
 [1] = 3570,
 [2] = 3571,
 [3] = 3561,
 [4] = 3562,
 [5] = 3563,
 [6] = 3564,
 [7] = 3565,
 [8] = 3566,
 [9] = 3567,
 [10] = 3573,
 [11] = 3570,
}

function tbChuctet:SwitchChuctet()
	if nSwitch == 0 then
		self:StartChuctet()
	else
		self:StopChuctet();
	end
end

function tbChuctet:StartChuctet()
	me.Msg("<color=yellow>Bắt đầu nhiệm vụ chúc Tết")
	nIsDone = 0;
	self:ModifyUi()
	self.ChuctetTimer = Timer:Register(Env.GAME_FPS * 2,self.OnChuctetTime,self);
	nSwitch = 1
end

function tbChuctet:StopChuctet(nAuto)
	me.Msg("<color=green>Dừng nhiệm vụ chúc Tết")
	nSwitch = 0
	Timer:Close(nModifyTimer);
	Timer:Close(self.ChuctetTimer)
	if nAuto then
		self.GetAwardTimer = Timer:Register(Env.GAME_FPS * 2,self.CloseAward,self);
	end
end

function tbChuctet:OnChuctetTime()
	local nStep = self:GetTaskState()
	if (not nStep)  then
		me.Msg("<color=yellow>Nhiệm vụ chúc Tết ngày hôm nay đã được hoàn tất");
		self:StopChuctet(1);
		return
	end

	if me.nMapId >= 1 and me.nMapId <= 8 then
		self:TalkToNpc(nStep)
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = string.format(",5,%s",tbStep[nStep])});
	end
end

function tbChuctet:GetTaskState()
	local nDay = me.GetTask(TASKID_GROUP, TASKID_TIME);
	local nNowDay = tonumber(GetLocalDate("%Y%m%d"));
	if nNowDay > nDay then
		return self:GetTaskStep();
	else
		return
	end
end

function tbChuctet:GetTaskStep()
	local tbPlayerTask = Task:GetPlayerTask(me) 
	local tbTask = tbPlayerTask.tbTasks[TASKID_ID];  

	if (tbTask) then
		if (tbTask.nCurStep > 0) then
			local nStep = tostring(tbTask.nCurStep);
			nIsDone = 1;
			return tonumber(nStep)
		end
	end
	if nIsDone == 0 then
		return 1;
	else
		return
	end
end

function tbChuctet:TalkToNpc(nStep)
	local nNpc = tbStep[nStep];

	if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
		Ui(Ui.UI_GUTAWARD).OnButtonClick(Ui(Ui.UI_GUTAWARD),"zBtnAccept")
		UiManager:CloseWindow(Ui.UI_GUTAWARD);
		return
	end

	if UiManager:WindowVisible(Ui.UI_GUTTALK) == 1 then
		return
	end

	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
		--return
	end

	if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
		UiManager:CloseWindow(Ui.UI_SHOP)
	end

	if UiManager:WindowVisible(Ui.UI_ITEMGIFT) == 1 then
		UiManager:CloseWindow(Ui.UI_ITEMGIFT)
	end


	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = string.format(",0,%s",tbStep[nStep])});
end

function tbChuctet:CloseAward()
	if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
		Ui(Ui.UI_GUTAWARD).OnButtonClick(Ui(Ui.UI_GUTAWARD),"zBtnAccept")
		UiManager:CloseWindow(Ui.UI_GUTAWARD);
	end
	Timer:Close(self.GetAwardTimer)
end


function tbChuctet:ModifyUi()
	local uiSayPanel	= Ui(Ui.UI_SAYPANEL);
	tbChuctet.Say_bak = tbChuctet.Say_bak or uiSayPanel.OnOpen;
	function uiSayPanel:OnOpen(tbParam)
		tbChuctet.Say_bak(uiSayPanel, tbParam);
		
		local function fnOnSay()
			tbChuctet:OnSay(tbParam);
			return 0;
		end
		nModifyTimer = Timer:Register(1, fnOnSay);
	end
end


function tbChuctet:OnSay(tbParam)
	if nSwitch ~= 1 then
		return
	end
	if (not tbParam) then
		return
	end

	local nSelNum = 0;

	for i, nText in ipairs(tbParam[2]) do
		if string.find(nText, "Tân Mão Cát Tường") then
			nSelNum= i;
			break;
		end
	end

	if nSelNum > 0 then
		Ui(Ui.UI_SAYPANEL):OnListSel("LstSelectArray", nSelNum);
	end
end

local tCmd={ "Map.tbChuctet:SwitchChuctet()", "SwitchChuctet", "", "Shift+K", "Shift+K", "Chúc tết"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);


