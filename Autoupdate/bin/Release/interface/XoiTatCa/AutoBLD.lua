local tbAutoBLD = Map.tbAutoBLD or {};
Map.tbAutoBLD = tbAutoBLD;
local nCastState = 0;
local nCastTimerId = 0;
local nCastTime = 1;
function tbAutoBLD:Switch()
	if nCastState == 0 then
		nCastState = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Xơi Tất Cả Trong Hành Trang<color>");
		assert(nCastTimerId == 0);
		nCastTimerId = Timer:Register(nCastTime * Env.GAME_FPS, self.AutoEat, self);
	else
		nCastState = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Stop Here<color>");
		Timer:Close(nCastTimerId);
		nCastTimerId = 0;
	end
end
function tbAutoBLD:AutoEat()
	if (nCastTimerId ~= 0) then
		local tbFind = me.FindItemInBags(bailiandan);
		for _, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			
		end
	end
end
-- An TLHL By Thuận Nguyễn
local tCmd={ "Map.tbAutoBLD:Switch()", "Switch", "", "Shift+S", "Shift+S", "AutoThucPham"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);