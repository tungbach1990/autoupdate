local self = tbvaoTK;

local tbvaoTK	= Map.tbvaoTK or {};
Map.tbvaoTK		= tbvaoTK;
local nState = 0;
local nTimerId1 = 0;
local pTimerClose = 0;
local tbGetParam 	= {};
local uiSayPanel 	= Ui(Ui.UI_SAYPANEL);



local szCmd = [=[
	Map.tbvaoTK:vaoTKSwitch();
]=];

function tbvaoTK:vaoTKSwitch()
	if nState == 0 then
		nState = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bật tự sử dụng Tu Luyện Đơn<color>");
		nTimerId1 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.EatTLD,self);
	elseif nState == 1 then
		nState = 0;
		pTimerClose = 0;
		Ui.tbLogic.tbTimer:Close(nTimerId1);
		nTimerId1 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<color=white>Tắt tự sử dụng Tu Luyện Đơn<color>");
	end
end

function tbvaoTK:EatTLD()
	local tbItem = Item:GetClass("xiulianzhu");
	local nRemain = tbItem:GetRemainTime();
	if (nRemain < 2) then
--[[		local nCount_TLD = me.GetItemCountInBags(18,1,258,1);
		if(nCount_TLD < 1) then
			me.Msg("Hết TLD rùi");
			AutoAi:BuyItemByBindCoin();
		end
		]]

		local tbFind = me.FindItemInBags(18,1,258,1);--18,1,258,1 TLD
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
	end
end


function AutoAi:BuyItemByBindCoin()
	if me.nBindCoin >= 1800 then
		if UiManager:WindowVisible(Ui.UI_IBSHOP) == 1 then
			if Ui(Ui.UI_IBSHOP).m_nZoneType ~= 3 then
				local bRet1 = Ui(Ui.UI_IBSHOP):OnButtonClick("BtnBindGoldSection");
			else
				if Ui(Ui.UI_IBSHOP).m_nWareType ~= 2 then
					local bRet2 = Ui(Ui.UI_IBSHOP):OnButtonClick("BtnType2");
					return;
				end
				if	me.IbCartIsEmpty() ~= 1 then
					me.IbCart_Commit(2);
					
					return 0
				else
					me.IbCart_AddWare(388,2)
					me.IbCart_SetWareCount(388,7)
				end
			end
		else
			UiManager:OpenWindow(Ui.UI_IBSHOP);
		end
	else
		me.Msg("Khong du 1800 dong khoa de mua");
	end
end

local tCmd={"Map.tbvaoTK:vaoTKSwitch()", "vaoTK", "", "ALT+E", "ALT+E", "vaoTK"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);