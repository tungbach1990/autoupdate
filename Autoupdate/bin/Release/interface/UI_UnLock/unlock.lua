local UiUnLock = Ui(Ui.UI_UNLOCK);
local BTN_AUTOPASS					= "BtnAutoPass";
local BTN_SETPASS	="BtnSetPass"
local tbHEX={{"5"},{"9"},{"A"},{"B"},{"C"},{"Q"},{"E"},{"F"},{"0"},{"1"},}
local self=UiUnLock
local	BTN_ENTER 		=	"BtnEnter";
local	BTN_CANCEL		=	"BtnCancel";
local	BTN_FINDPASS 	=	"BtnFindPass";
local	EDIT_PWD		=	"EdtPwd";
local	BTN_CLOSE		=	"BtnClose";
local	PWD_MAXLENS		= 	6;
local	TXT_NOTE		=	"TxtNote";
local	NOTE			=	"<color=yellow>Xin vui lòng thiết lập mật khẩu ban đầu một lần, sau khi on-line bạn có thể chỉ cần nhấp vào một nút mở khóa để mở. ";
 UiUnLock.Init=function(self)
	self.nPwd = 1;
	self.nPos = 100000;
	self:UpdatePwdShow();
end
 UiUnLock.OnEditFocus=function(self,szWndName)

	if szWndName == EDIT_PWD then
		self:ShowMiniKeyBoard();
	end
	
end
 UiUnLock.ShowMiniKeyBoard=function(self)
	self.nr1 = MathRandom(63);
	self.nr2 = MathRandom(63);
	self.nr3 = MathRandom(65535) / 65536;
	UiManager:OpenWindow(Ui.UI_MINIKEYBOARD);
	local x, y = Wnd_GetPos(Ui.UI_MINIKEYBOARD, "Main");
	y = MathRandom(10) * 30;
	Wnd_SetPos(Ui.UI_MINIKEYBOARD, "Main", x, y);
end
 UiUnLock.ProcessPwd=function(self,nKey)
	--local nKey = self.tbChar2Num[szKey];
	if UiManager:WindowVisible(self.UIGROUP) ~= 1 then
		return;
	end
	if not nKey then
		return;
	end
	if nKey == 0 and self.nPwd == 1 then
		me.Msg("<color=green>Mật khẩu không thể bắt đầu bằng số 0");
		return;
	end
	if nKey ~= -1 then		
		if self.nPwd >= 1000000 or self.nPos < 1 then
			return;
		end
		self.nPwd = self.nPwd * 10 + (nKey + math.floor(self.nNameId / self.nPos) % 10) % 10;
		self.nPos = self.nPos / 10;
	elseif self.nPwd >= 10 then
		self.nPwd = math.floor(self.nPwd / 10);	
		self.nPos = self.nPos * 10;
	end
end

 UiUnLock.BuildStarByCount=function(self,nCount)
	local szStar = "";
	if nCount > 0 then
		for i = 1, nCount do
			szStar = szStar.."*";
		end;
	end
	return szStar;
end

 UiUnLock.KeyProc=function(self,szKey)

	self:ProcessPwd(szKey);

	self:UpdatePwdShow();
end

 UiUnLock.UpdatePwdShow=function(self)	
	local szPwdStar = self:BuildStarByCount(math.ceil(math.log10(1 + self.nPwd)) - 1);
	Edt_SetTxt(self.UIGROUP, EDIT_PWD, szPwdStar);
end

 UiUnLock.OnClose=function(self)
	UiManager:CloseWindow(Ui.UI_MINIKEYBOARD);
end

 UiUnLock.RegisterEvent=function(self)
	local tbRegEvent = 
	{
		{ UiNotify.emUIEVENT_MINIKEY_SEND,	self.KeyProc },
	};
	return tbRegEvent;
end
--------------------------------------------------------
 UiUnLock.OnButtonClick=function(self,szWndName, nParam)
	if szWndName == BTN_ENTER then
		self:OnEnter();
	end
	
	if szWndName == BTN_CANCEL then
		UiManager:CloseWindow(Ui.UI_MINIKEYBOARD);
		UiManager:CloseWindow(self.UIGROUP);
	end
	
	if szWndName == BTN_CLOSE then
		UiManager:CloseWindow(Ui.UI_MINIKEYBOARD);
		UiManager:CloseWindow(self.UIGROUP);
	end
	
	if szWndName == BTN_FINDPASS then
		local tbMsg = {};
		if Player.bApplyingJiesuo == 1 then
			tbMsg.szMsg = "Bạn có chắc là bạn giữ ổ khóa tài khoản? Chọn [OK] , tài khoản của khóa sẽ tiếp tục bảo vệ an ninh tài khoản của bạn";
			tbMsg.nOptCount = 2;
			function tbMsg:Callback(nOptIndex)
				if (nOptIndex == 2) then
					me.CallServerScript({"AccountCmd", Account.JIESUO_CANCEL});
				end
			end		 
			UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg);
			UiManager:CloseWindow(Ui.UI_MINIKEYBOARD);
			UiManager:CloseWindow(self.UIGROUP);
		else
			tbMsg.szMsg = "Bạn có chắc là bạn hủy bảo vệ mật khẩu? Ứng dụng sẽ có hiệu lực 5 ngày";
			tbMsg.nOptCount = 2;
			function tbMsg:Callback(nOptIndex)
				if (nOptIndex == 2) then
					me.CallServerScript({"AccountCmd", Account.JIESUO_APPLY});
				end
			end
			UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg);
			UiManager:CloseWindow(Ui.UI_MINIKEYBOARD);
			UiManager:CloseWindow(self.UIGROUP);
		end
	end
	if szWndName == BTN_SETPASS then
		self:SetOrMide()
	end
	if szWndName == BTN_AUTOPASS then
		self:AutoPass()
	end
end

UiUnLock.AutoPass=function(self)
	self.nr1 = MathRandom(63);
	self.nr2 = MathRandom(63);
	self.nr3 = MathRandom(65535) / 65536;
	local szTxt=tostring(self:LoadKey())
	print(szTxt)
	local sPass=""
	local s=""
	local str=szTxt
	local i=1
	while i<=6 do
		str=string.sub(szTxt,i)
		s=string.sub(str,1,1)
		--print(str)
		for j=1,#tbHEX do
			if tbHEX[j][1]==s then
				sPass=sPass..tostring(j-1)
				break--j=#tbHEX+1
				--me.Msg(sPass)
			end
		end
		i=i+1
	end
	local nkey=tonumber(sPass)
	--me.Msg(sPass)
	--nkey=self:StrToNumber(sxTxt)
	for j=1,6 do
		local d=10^(6-j)
		local nk=math.floor(nkey/d);		
		print(d,nk)
		UiNotify:OnNotify(UiNotify.emUIEVENT_MINIKEY_SEND, nk);
		nkey=math.mod(nkey,d);
	end	
	self:OnEnter();
end
 UiUnLock.OnEnter=function(self)
	local bRightPwd = self:CheckPwd();
	if bRightPwd == 1 then
		local nPsw = (self.nPwd % 1000000) * 64 + 32 + self.nr2 * 67108864;
		local nDivValue = nPsw / self.nr3;
		if math.abs(nDivValue * self.nr3 - nPsw) < 1 then
			me.CallServerScript{"AccountCmd", Account.UNLOCK, nDivValue, self.nr3};	
		else
			me.CallServerScript{"AccountCmd", Account.UNLOCK, nPsw};			
		end
		UiManager:CloseWindow(Ui.UI_MINIKEYBOARD);
		UiManager:CloseWindow(self.UIGROUP);
		return;
	end
	self:Init();
end
 UiUnLock.CheckPwd=function(self)
	if self.nPwd < 1000000 or self.nPwd > 1999999 then
		me.Msg("<color=green>Mật khẩu phải có 6 ký tự");
		return 0;
	end
	return 1;
end
 UiUnLock.EncryptPsw=function(self)
	return (self.nPwd % 1000000) * 64 + 32 + self.nr2 * 67108864;
end
UiUnLock.Load=function(self,Files,key)
	self.m_szFilePath=Files
	local szData = KIo.ReadTxtFile(self.m_szFilePath);
	if (szData) then
		if self:CheckErrorData(szData) == 1 then
			self.m_tbData = Lib:Str2Val(szData);
		else
			KIo.WriteFile(self.m_szFilePath, "nil");
		end
	end
	local tbData = self.m_tbData[key];
	--print(self.m_tbData)
	return tbData
end

UiUnLock.Save=function(self,szKey, tbData)
	self.m_szFilePath="\\user\\key\\"..me.szName.."_key.dat";
	self.m_tbData={}
	self.m_tbData[szKey] = tbData;
	local szData = Lib:Val2Str(self.m_tbData);
	assert(self.m_szFilePath);
	if self:CheckErrorData(szData) == 1 then
		KIo.WriteFile(self.m_szFilePath, szData);
	else
		local szSaveData = Lib:Val2Str(tbData);
	end
end

UiUnLock.LoadSetting=function(self)
	local file="\\user\\key\\"..me.szName.."_setting.dat"
	local tbFightSetting = self:Load(file,"OptionSetting");
	if not tbFightSetting then
		tbFightSetting = {};
	end
	if tbFightSetting.nUnlock then
		self.nUnlock=tbFightSetting.nUnlock;
	end 
	if tbFightSetting.nAutoPass then
		self.nAutoPass=tbFightSetting.nAutoPass;
	end 
	--if self.nUnlock==1 and self.nAutoPass==1 then
	--	self:AutoPass()
	--end
end

UiUnLock.LoadKey=function(self)
	local file="\\user\\key\\"..me.szName.."_key.dat"
	local tbKey = self:Load(file,"PassWord");
	if not tbKey then
		tbKey = {};
	end
	if tbKey.szPW then
		return tbKey.szPW;
	end 
end

UiUnLock.OnOpen=function(self)
	if	UiManager:WindowVisible(Ui.UI_SETPASSWORD) == 1 then
		UiManager:CloseWindow(Ui.UI_SETPASSWORD);
	end
	self:Init();
	TxtEx_SetText(self.UIGROUP, TXT_NOTE, NOTE);
	self.nNameId = KLib.String2Id(tostring(me.GetNpc().dwId));
	if Player.bApplyingJiesuo == 1 then
		Btn_SetTxt(self.UIGROUP, BTN_FINDPASS, "Giải tự giúp mở khóa");
	else
		Btn_SetTxt(self.UIGROUP, BTN_FINDPASS, "Để tự giúp mở khóa");
	end
	local szData = KIo.ReadTxtFile("\\user\\key\\"..me.szName.."_key.dat");
	if (szData) then
		Wnd_SetEnable(self.UIGROUP, BTN_SETPASS,0);
		Wnd_SetEnable(self.UIGROUP, BTN_AUTOPASS,1);
	else
		Wnd_SetEnable(self.UIGROUP, BTN_SETPASS,1);
		Wnd_SetEnable(self.UIGROUP, BTN_AUTOPASS,0);
	end
	--self:LoadSetting();
end

UiUnLock.ToString=function(self,nPassWord)
	local sPass="";	
	local sPassWord=tostring(nPassWord)
	for i=1,6 do
		local s=math.floor(nPassWord/(10^(6-i)))
		sPass=sPass..tbHEX[s+1][1]
		nPassWord=nPassWord-(s*(10^(6-i)))
	end
	return sPass
end
UiUnLock.SetOrMide=function(self)
	local tbFundParam = {};
	tbFundParam.tbTable = self;
	tbFundParam.fnAccept = self.AcceptGetInPutPass;
	tbFundParam.nMaxLen=6
	tbFundParam.szTitle = "Nhập mã mở khóa";
	UiManager:OpenWindow(Ui.UI_TEXTINPUT,tbFundParam)
end

UiUnLock.AcceptGetInPutPass=function(self,nPass)
	if tonumber(nPass) < 100000 then
		me.Msg("<color=green>Mật khẩu phải được 6 ký tự, và không bắt đầu bằng 0, xin vui lòng nhập lại!");
		UiManager:CloseWindow(Ui.UI_TEXTINPUT)
		self:SetOrMide()
		return
	end
	UiManager:CloseWindow(Ui.UI_TEXTINPUT)
	local szTxt=self:ToString(nPass)
	local tbData={
		szPW=szTxt,
		}
	self:Save("PassWord",tbData)
	Wnd_SetEnable(self.UIGROUP, BTN_SETPASS,0);
	Wnd_SetEnable(self.UIGROUP, BTN_AUTOPASS,1);
end

UiUnLock.CheckErrorData=function(self,szDate)
	if szDate ~= "" then
		if string.find(szDate, "Ptr:") and string.find(szDate, "ClassName:") then
			return 0; 
		end
		if (not Lib:CallBack({"Lib:Str2Val", szDate})) then
			return 0;
		end
	end
	return 1;
end