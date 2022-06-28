local tbAutoTVBV = Map.tbAutoTVBV or {};
Map.tbAutoTVBV = tbAutoTVBV;
local nCastState = 0;
local nCastTimerId = 0;
local nCastTime = 1;
local nLastOpenTime = 0;
local nWaitTime = 5; 
local nproduceTimer;
local uiTextInput = Ui(Ui.UI_TEXTINPUT);

function tbAutoTVBV:BV()
	if nCastState == 0 then
		nCastState = 1;
		me.Msg("<color=green>Auto đập trứng <color>");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow> Bắt đầu đập (kiemthehungba.com) <color>");
		assert(nCastTimerId == 0);
		nCastTimerId = Timer:Register(nCastTime * Env.GAME_FPS, self.MuaTV, self);
	else
		nCastState = 0;
		me.Msg("<color=yellow> Server Kiếm Thế Hùng Bá <color>");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow> Đập xong (kiemthehungba.com) <color>");
		Timer:Close(nCastTimerId);
		nCastTimerId = 0;
		self:Reloadevent();
	end
end

function tbAutoTVBV:AutoStar()
	if me.GetJbCoin() < 5000 then
		nCastState = 0;
		me.Msg("<color=yellow> Server Kiếm Thế Hùng Bá <color>");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow> Đập xong (kiemthehungba.com) <color>");
		Timer:Close(nCastTimerId);
		nCastTimerId = 0;
	end	
	if me.CountFreeBagCell() < 10 then
		nCastState = 0;
		me.Msg("<color=yellow> Không đủ 10 ô trống <color>");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow> Không đủ 10 ô trống (kiemthehungba.com) <color>");
		Timer:Close(nCastTimerId);
		nCastTimerId = 0;		
	end
	if (me.GetItemCountInBags(18,1,25107,1) == 0) then
	tbAutoTVBV.MuaTV();
	end
	if (me.GetItemCountInBags(18,1,25107,1) == 40) and(me.GetItemCountInBags(18,1,25108,1) == 0) then
	tbAutoTVBV.MuaBV();
	end
	if (me.GetItemCountInBags(18,1,25108,1) > 0) then
	tbAutoTVBV:AutoTV();
	end
	end
	
function tbAutoTVBV:AutoTV()
if nCastState == 1 then
	local nCurTime = GetTime();
	local nDiff = nCurTime - nLastOpenTime;
	if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1) then		
		return;
	end
	if UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1 then
		me.CallServerScript({ "DlgCmd", "InputNum", nPlanNum });
		UiManager:CloseWindow(Ui.UI_TEXTINPUT);
	end
	if nLastOpenTime > 0 and nDiff < nWaitTime then
		return; 
	end
	if nLastOpenTime > 0 and nDiff >= nWaitTime then			
	nLastOpenTime = 0;
		return;
	end
	if (nCastTimerId ~= 0) and me.GetItemCountInBags(18,1,25108,1) > 0 then
		local tbFind = me.FindItemInBags(18,1,25107,1);
		for _, tbItem in pairs(tbFind) do
		me.UseItem(tbItem.pItem);
		nLastOpenTime = nCurTime;
		end
	else
	nCastState = 0;
	me.Msg("<color=yellow> Server Kiếm Thế Hùng Bá <color>");
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow> Đập xong yeah yeah (kiemthehungba.com) <color>");
	Timer:Close(nCastTimerId);
	nCastTimerId = 0;
	end
end
end

function tbAutoTVBV.MuaTV()
	local nCount = me.GetItemCountInBags(18,1,1,1);
	if nCount >=10 then
		
	selft:CloseDBWindow();
	end
	if me.GetMapTemplateId() >= 1 and me.GetMapTemplateId() <= 8 then
		
				Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",8,3601"});
				me.AnswerQestion(0);
				me.AnswerQestion(0);
			
					
	end	

end
function tbAutoTVBV:CloseDBWindow()
       local uiGutAward = Ui(Ui.UI_GUTAWARD);
       if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
               uiGutAward:OnButtonClick("zBtnAccept");
               Ui.tbLogic.tbTimer:Close(nRoseTimerId);
       end 
end

function tbAutoTVBV.MuaBV()
		if me.GetJbCoin() < 5000 then
		nCastState = 0;
		me.Msg("<color=yellow> Server Kiếm Thế Hùng Bá <color>");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow> Đập xong (kiemthehungba.com) <color>");
		Timer:Close(nCastTimerId);
		nCastTimerId = 0;
		UiManager:CloseWindow(Ui.UI_IBSHOP);
		end
        local nType1 = 1;--nWareZone--3
        local nType2 = 103;--nWareType--102
        local nType3 = 962;--nPreWareId--这一条id怎样获得，怎么定义？
        local nType4 = 40;--购买数量--1
        local nType5 = 963;--商城ID--310
        local nType6 = 0;--帮金区--2
        if UiManager:WindowVisible(Ui.UI_IBSHOP) == 0 then 
                UiManager:OpenWindow(Ui.UI_IBSHOP); 
        else 			
			local hhShop = me.IbCart_CurType();
			if hhShop ~= 0  then
					me.IbShop_Apply(nType1, nType2, nType3, 1);
					me.IbCart_AddWare(nType5,nType6)
			else
					if UiManager:WindowVisible(Ui.UI_IBSHOPCART) == 0 then
							UiManager:OpenWindow(Ui.UI_IBSHOPCART);
					else
							me.IbCart_SetWareCount(nType5, nType4);
							me.IbCart_Commit(nType6);
					end
			end 
        end
end

function tbAutoTVBV.TimNPC_TEN(sName)
	local tbEnemyList = {}	
	local tbNpcList = KNpc.GetAroundNpcList(me,1000);
	for _, pNpc in ipairs(tbNpcList) do
		if pNpc and pNpc.szName == sName then
			table.insert(tbEnemyList,pNpc)
		end
	end
	if table.getn(tbEnemyList) == nil then
		return		
	end
end

function tbAutoTVBV.GoTo(M,X,Y)
	local tbPosInfo ={}
	tbPosInfo.szType = "pos"
	tbPosInfo.szLink = ","..M..","..X..","..Y
	Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,tbPosInfo)
end

function tbAutoTVBV:Reloadevent()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	fnDoScript("\\interface\\TuDongDanh\\golden.lua");
end

-- Cam on ban da su dung plugin cua kiemthehungba.com
local tCmd={ "Map.tbAutoTVBV:BV()", "BV", "", "Alt+P", "Alt+P", "AutoTV"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
