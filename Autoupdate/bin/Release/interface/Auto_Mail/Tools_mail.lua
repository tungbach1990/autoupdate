---------------------------====== Sửa Bởi YêuLắmCơ129 ======---------------------------
Ui.UI_TOOLS				= "UI_TOOLS";
local uiTools			= Ui.tbWnd[Ui.UI_TOOLS] or {};	
uiTools.UIGROUP			= Ui.UI_TOOLS;
Ui.tbWnd[Ui.UI_TOOLS] 	= uiTools
 
local MailSwitch,MailTimer = 0,0

function uiTools:SwitchDelMails()
    MailSwitch = 1 - MailSwitch;
    if MailSwitch == 1 then
        
        SysMsg("<bclr=0,0,200><color=white>Bắt Đầu Đọc Thư [Ctrl+I]<color><bclr>");
        
        MailTimer = Timer:Register(1.4*Env.GAME_FPS , uiTools.DelMails ,self)
    else
        
        SysMsg("<bclr=200,0,0><color=white>Dừng Đọc Thư [Ctrl+I]<color><bclr>");
        
        Timer:Close(MailTimer);
        MailTimer = 0;
        UiManager:CloseWindow(Ui.UI_MAIL);
    end
end

function uiTools:DelMails()
    if (Mail.nMailCount < 1) or (AutoAi:DelMails() == 0) then
        uiTools:SwitchDelMails()
        return
    else
        return
    end
end
local szCmd = [=[
        Ui.tbWnd[Ui.UI_TOOLS]:SwitchDelMails()      
    ]=];
UiShortcutAlias:AddAlias("", szCmd);
