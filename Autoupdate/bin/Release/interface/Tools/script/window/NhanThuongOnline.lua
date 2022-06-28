
local self = tbGetAwOnl;

local tbGetAwOnl	= Map.tbGetAwOnl or {};
Map.tbGetAwOnl		= tbGetAwOnl;

SpecialEvent.tbAword = SpecialEvent.tbAword or {};
local tbAword = SpecialEvent.tbAword;

local nTimerId1 = 0;
local nCountToStop = 0;
local nPressed = 0;

local szCmd = [=[
	Map.tbGetAwOnl:GetAwardOnline();
]=];

local szCmd = [=[
	Map.tbGetAwOnl:_Init();
]=];

function tbGetAwOnl:GetAwardOnline()
	nTimerId1 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.OnTimer,self);
end

function tbGetAwOnl:OnTimer()
	if me.CountFreeBagCell() == 0 or (UiManager:WindowVisible(Ui.UI_GETAWORD) == 1 and nPressed == 1) then
		if nPressed == 1 then
			nPressed = 0;
			UiManager:CloseWindow(Ui.UI_GETAWORD); 
		end
		return;
	end
	if SpecialEvent.tbAword.nTimerRemain > 0 then
		nCountToStop = 0;
	else
		nCountToStop = nCountToStop + 1;
	end
	if me.CountFreeBagCell() > 4 then
		if me.GetTask(2122,7) == 0 then
			me.CallServerScript({ "AwordDaily"});
			nPressed = 1;
			return;
		end
	end
	local tbAwordLogInMonth = tbAword.tbAword[2] or {};	
	local nNum = me.GetTask(2122,8);
	local tbAwordLogInMonthEx = tbAwordLogInMonth[nNum + 1] or {};
	if #tbAwordLogInMonthEx > 0 then
		if me.CountFreeBagCell() > 1 then
			local nNowLoadTime = me.GetTask(2063,20);
			local nNeedLoadTime = SpecialEvent.tbAword.tbAword_Day[me.GetTask(2122,8) + 1];
			if nNeedLoadTime <= nNowLoadTime  then
				me.CallServerScript({ "AwordLogIn"});
				nPressed = 1;
				return;
			end
		end
	end
	if SpecialEvent.tbAword.nTimerRemain <= 0 and nCountToStop < 10 then
		me.CallServerScript({ "AwordOnlineEx"});
		nPressed = 1;
	end
end

function tbGetAwOnl:_Init()
	tbGetAwOnl.EnterGame_bak	= tbGetAwOnl.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		tbGetAwOnl.EnterGame_bak(Ui);
		tbGetAwOnl:OnEnterGame();
	end
end

function tbGetAwOnl:OnEnterGame()
	Map.tbGetAwOnl:GetAwardOnline();
end

Map.tbGetAwOnl:_Init()