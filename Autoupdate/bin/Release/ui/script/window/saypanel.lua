
local uiSayPanel = Ui:GetClass("saypanel");

local IMG_HEAD_PIC		= "ImgHeadPic";
local IMG_CONTENT_PIC	= "ImgContentPic";
local WND_SAY			= "WndSay";			-- 主信息面板
local WND_SEL			= "WndSel";			-- 选项面板
local TXT_DIALOG		= "TxtDialog";
local LST_SELECT_ARRAY	= "LstSelectArray";

local LEFT				= 10;
local CLICK_FRAME		= { 0, 0, 0, 0 };		-- spr动作帧依次是Up, UpOver, Down, DownOver
local SELECT_IMAGE		= "\\image\\ui\\001a\\dialog\\say_choose.spr"

function uiSayPanel:OnOpen(tbParam)

	local szHead, szPic, szContent = self:ParseQuestion(tbParam[1]);
	Img_SetImage(self.UIGROUP, IMG_HEAD_PIC, 1, szHead);
	Img_SetImage(self.UIGROUP, IMG_CONTENT_PIC, 1, szPic);

	local nImgHeight = 0;
	if #szPic > 0 then
		local _, n = Wnd_GetSize(self.UIGROUP, IMG_CONTENT_PIC);
		nImgHeight = n;
	end

	Txt_SetTxt(self.UIGROUP, TXT_DIALOG, szContent);
	local _, nTxtHeight = Wnd_GetSize(self.UIGROUP, TXT_DIALOG);
	nTxtHeight = nTxtHeight + 30;
	if nTxtHeight < 60 then
		nTxtHeight = 60;
	end

	Wnd_SetPos(self.UIGROUP, TXT_DIALOG, LEFT, nImgHeight + 5);
	Wnd_SetPos(self.UIGROUP, LST_SELECT_ARRAY, LEFT, nTxtHeight + nImgHeight + 5);

	local nYOffset = 0;
	for i = 1, #tbParam[2] do
		Lst_SetCell(self.UIGROUP, LST_SELECT_ARRAY, i, 2, tbParam[2][i]);
		Lst_SetImageCell(self.UIGROUP, LST_SELECT_ARRAY, i, 0, SELECT_IMAGE, unpack(CLICK_FRAME));
	end

	ScrPnl_Update(self.UIGROUP, WND_SAY);

end

function uiSayPanel:OnListSel(szWnd, nParam)
	if nParam == 0 then
		return 0;
	end
	if szWnd == LST_SELECT_ARRAY then
		me.AnswerQestion(nParam - 1);
		UiManager:CloseWindow(self.UIGROUP);
	end
end

function uiSayPanel:OnEscExclusiveWnd(szWnd)
	UiManager:CloseWindow(self.UIGROUP);
end

function uiSayPanel:ParseQuestion(szQuestion)

	local _, i, szHeadImg = string.find(szQuestion, "<head:([^>]*)>");
	local _, j, szPic = string.find(szQuestion, "<pic:([^>]*)>");

	if not i then
		i = 0;
	end
	if not j then
		j = 0;
	end

	local nOffset = math.max(i, j) + 1;
	local szQues = string.sub(szQuestion, nOffset, -1);

	if not szHeadImg then
		szHeadImg = "";
	end

	if not szPic then
		szPic = "";
	end

	if not szQues then
		szQues = "";
	end

	return szHeadImg, szPic, szQues;

end
