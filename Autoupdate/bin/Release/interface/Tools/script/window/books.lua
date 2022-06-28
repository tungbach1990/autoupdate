local tbFightAim	= Map.tbFightAim or {};
Map.tbFightAim	= tbFightAim;

local tbTimer = Ui.tbLogic.tbTimer;
local szCmd = [=[
	Map.tbFightAim:Fight_Clock();
	]=];
	UiShortcutAlias:AddAlias("GM_S4", szCmd);	-- Phím tắt：Ctrl + 4 

function tbFightAim:Init()
	self.nMyFightState = 0;
	self.nMyAction = 0;
end
function tbFightAim:Fight_Clock()
	if self.nMyFightState == 0 then
		self.nMyAction = 0;
		self.nMyFightState = 1;
		self.MainClock = tbTimer:Register(2.5 * Env.GAME_FPS, self.Fight_Main, self);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bật tự nhận nhiệm vụ đọc sách Ctrl+4")
		me.Msg("<color=yellow>Bật tự nhận NV đọc sách<color>")
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt tự nhận nhiệm vụ đọc sách Ctrl+4")
		me.Msg("<color=yellow>Tắt tự nhận NV đọc sách<color>")
		self.nMyFightState = 0;
		Timer:Close(self.MainClock);
	end
end
function tbFightAim:Fight_Main()
	me.Msg("<color=gold>Số lần đọc còn <color>  "..self.nMyAction)
	if nMyMap == -1 then
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			Ui.tbLogic.tbTimer:Register(1, self.CloseSay);
		end
		return;
	end
	if self.nMyFightState == 0 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự động tắt nhiệm vụ đọc sách Ctrl+4")
		me.Msg("<color=gold>kết thúc<color>")
		return 0;
	end
	if (self.nMyAction < 9) then
		self:AutoReBook();
		return;
	elseif (self.nMyAction >= 9) then 	
		self.nMyFightState = 0;
	end
end
function tbFightAim:GetBookState()
	self.nBSFinish = Task.tbArmyCampInstancingManager:GetBingShuReadTimesThisDay(me.nId);
	self.nJGFinish = Task.tbArmyCampInstancingManager:JiGuanShuReadedTimesThisDay(me.nId);
	local tbnTasks	= Task:GetPlayerTask(me).tbTasks;
	if (me.nLevel >= 90) and (me.nLevel <= 109) then
			self.nJunXiang = me.GetTask(1022, 132);
			self.nBFBook = tbnTasks[229];
			self.nJGBook = tbnTasks[230];
	elseif (me.nLevel >= 110) and (me.nLevel <= 129) then
			self.nJunXiang = me.GetTask(1022, 171);
			self.nBFBook = tbnTasks[340];
			self.nJGBook = tbnTasks[341];
	elseif (me.nLevel >= 130) then
			self.nJunXiang = me.GetTask(1022, 185);	
			self.nBFBook = tbnTasks[378];
			self.nJGBook = tbnTasks[379];
	end
end
function tbFightAim:AutoReBook()
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return;
	end
	self:GetBookState();
	if self.nMyAction < 5 then
		if self.nJGFinish >= 1 and (not self.nJGBook) then
			me.Msg("Nhiệm vụ đọc sách hoàn thành ")
			self.nMyAction = 5;
		else
			self:ReJiGuanBook();
		end
	elseif self.nMyAction >= 5 and self.nMyAction < 9 then
		if self.nBSFinish >= 1 and (not self.nBFBook) then
			self.nMyAction = 9;
			me.Msg("Bạn không có nhiệm vụ")
		else
			self:ReBingBook();
		end
	end
end
function tbFightAim:ReJiGuanBook()

		if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
			return 0;
		end
	if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
		local uiGutAward = Ui(Ui.UI_GUTAWARD)
		uiGutAward.OnButtonClick(uiGutAward,"ObjOptional2")
		uiGutAward.OnButtonClick(uiGutAward,"zBtnAccept")
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			Ui.tbLogic.tbTimer:Register(1, self.CloseSay);
		end
	end
	if (not self.nJGBook) or (self.nJGBook.nCurStep ~= 2) then
		me.Msg("<color=Gold>Bạn không có Vô Hạn Truyền Tống Phù<color>")
		local nMyMap,nMyX, nMyY = me.GetWorldPos();
		if nMyMap == 556 or nMyMap == 558 or nMyMap == 559 then	
			Map.tbFightAim:jiguan();
		else
			self:GotoDisMap(556,1600,3200);

		end
	elseif self.nJGBook and self.nJGBook.nCurStep == 2 then 
		me.Msg("<color=Gold>Sách đã nhận được các cơ quan<color>")
		self.nMyAction = 5;
	end
	if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
		UiManager:CloseWindow(Ui.UI_SHOP);
	end
end

function tbFightAim:ReBingBook()

		if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
			return 0;
		end
	if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
		local uiGutAward = Ui(Ui.UI_GUTAWARD)
		uiGutAward.OnButtonClick(uiGutAward,"zBtnAccept")
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			Ui.tbLogic.tbTimer:Register(1, self.CloseSay);
		end
	end
	if (not self.nBFBook) or (self.nBFBook.nCurStep ~= 2) or (self.nJunXiang == 1)then
		me.Msg("<color=Gold>Bạn không có Vô Hạn Truyền Tống Phù<color>")
		local nMyMap,nMyX, nMyY = me.GetWorldPos();
		if nMyMap == 556 or nMyMap == 558 or nMyMap == 559 then	
			Map.tbFightAim:bingfa();
		else
			self:GotoDisMap(556,1646,3204);
		end
	else
		me.Msg("<color=Gold>Nhận đủ sách và ăn túi quân hưởng<color>")
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự động tắt nhiệm vụ đọc sách Ctrl+4")
		self.nMyAction = 9;
	end
	if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
		UiManager:CloseWindow(Ui.UI_SHOP);
	elseif UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
		UiManager:CloseWindow(Ui.UI_GUTAWARD);
	end
end
function tbFightAim:GotoDisMap(nDmapID,nDx,nDy)

		if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
			return 0;
		end
	local nChuanSong = self:GetChuanSong();
	local nHuiCheng = self:GetHuiCheng();
	local nMyMap,nMyX, nMyY = me.GetWorldPos();
	self.nDisMap = nDmapID;
	if (me.nAutoFightState == 1) then
		AutoAi.ProcessHandCommand("auto_fight", 0);
		AutoAi.SetTargetIndex(0);
	end
	if (self.nDisMap == 556 or self.nDisMap == 558 or self.nDisMap == 559) and (nMyMap == 556 or nMyMap == 558 or nMyMap == 559) then
		self.nDisMap=nMyMap;
	end
	if (nChuanSong) or (nMyMap == self.nDisMap) then
		me.Msg("Không phải bản đồ quân doanh , truyền tống đến bản đồ quân doanh.")
		local nMapName = GetMapNameFormId(self.nDisMap)
		local DisPosInfo ={}
		DisPosInfo.szType = "pos"
		DisPosInfo.szLink = nMapName..","..self.nDisMap..","..nDx..","..nDy
		me.Msg(DisPosInfo.szLink)
		Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,DisPosInfo);
	else
		me.Msg("Bạn không có Vô Hạn Truyền Tống Phù.")
		if (nMyMap >= 1 and nMyMap <= 8) and (self.nDisMap == 556 or self.nDisMap == 558 or self.nDisMap == 559) then --在新手村且目標是軍營
			me.Msg("Đến NPC truyền tống quân doanh");
			Map.tbFightAim:wang();
		else
			me.Msg("Hãy trang bị Vô Hạn Truyền Tống Phù")			
			if nHuiCheng then
				me.UseItem(nHuiCheng);
				local function fnHuiCheng()
				me.Msg("Không giới hạn việc sử dụng trở lại Delay")	
					if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
					return 0;
					end
				Ui.tbLogic.tbTimer:Register(3, fnHuiCheng);
				end
			end
		end
	end
end

function tbFightAim:jiguan()
      if (me.IsDead() == 1) then
                me.SendClientCmdRevive(0);
                if me.nAutoFightState == 1 then
                        AutoAi.ProcessHandCommand("auto_fight", 0);
                       Ui(Ui.UI_SYSTEM):UpdateOnlineState();
              end
        end
      Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4033,1,"});
me.Msg("<color=yellow>Tìm kiếm<color>！");
end
function tbFightAim:bingfa()
      if (me.IsDead() == 1) then
                me.SendClientCmdRevive(0);
                if me.nAutoFightState == 1 then
                        AutoAi.ProcessHandCommand("auto_fight", 0);
                       Ui(Ui.UI_SYSTEM):UpdateOnlineState();
              end
        end
      Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4037,1,"});
me.Msg("<color=yellow>Tìm NPC truyền tống quân doanh<color>！");
end
function tbFightAim:wang()
      if (me.IsDead() == 1) then
                me.SendClientCmdRevive(0);
                if me.nAutoFightState == 1 then
                        AutoAi.ProcessHandCommand("auto_fight", 0);
                       Ui(Ui.UI_SYSTEM):UpdateOnlineState();
              end
        end
      Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4042,1,"});
me.Msg("<color=yellow>Đến NPC truyền tống quân doanh<color>！");
end

function tbFightAim:GetHuiCheng()
	local tbItem	= me.FindItemInBags(18,1,23,1)[1] or me.FindItemInBags(18,1,234,1)[1];
	return (tbItem or {}).pItem;
end
function tbFightAim:GetChuanSong()
	local tbItem	= me.FindItemInBags(18,1,195,1)[1] or me.FindItemInBags(18,1,235,1)[1];
	return (tbItem or {}).pItem;
end
function tbFightAim:CloseSay()
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
		return 0;
	end
end
function tbFightAim:Fight_Test()
	local tbnTasks	= Task:GetPlayerTask(me).tbTasks;
me.Msg("1")
	local tbTask1 = tbnTasks[229];
	if tbTask1 then
		me.Msg("Tôn tử binh pháp cấp 90"..tbTask1.nCurStep)
	end

	local tbTask3 = tbnTasks[340];
	if tbTask3 then
		me.Msg("Võ Mục Di Thư cấp 110: "..tbTask3.nCurStep)
	else
		me.Msg("110 Nghệ thuật không có chiến tranh")
	end
	local tbTask4 = tbnTasks[341];
	if tbTask4 then
		me.Msg("Quỷ cốc đạo thuật 110: "..tbTask4.nCurStep)
	else
		me.Msg("Không có 110 cơ quan")
	end	
end
function tbFightAim:Time_Test()
	self.testdelay = 5;
	me.Msg("Kiểm tra sự chậm trễ");
end
function tbFightAim:Pao_Bao()
	local nMyMap,nMyX, nMyY = me.GetWorldPos();
	if nMyMap == 1 or nMyMap == 7 or nMyMap == 29 then
		self.nMyFightState = 0;
                self:Fight_Clock()
	else
		self.nMyFightState = 0;
		if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
			return;
		end
        end
end

tbFightAim:Init();