local tbExtBagLayout = Ui.tbLogic.tbExtBagLayout
tbExtBagLayout.IMAGES = {
	[Item.EXTBAG_4CELL]  = "\\image\\ui\\001a\\item\\extbag_4cell.spr",
	[Item.EXTBAG_6CELL]  = "\\image\\ui\\001a\\item\\extbag_6cell.spr",
	[Item.EXTBAG_8CELL]  = "\\image\\ui\\001a\\item\\extbag_8cell.spr",
	[Item.EXTBAG_10CELL] = "\\image\\ui\\001a\\item\\extbag_10cell.spr",
	[Item.EXTBAG_12CELL] = "\\image\\ui\\001a\\item\\extbag_12cell.spr",
	[Item.EXTBAG_15CELL] = "\\image\\ui\\001a\\item\\extbag_15cell.spr",
	[Item.EXTBAG_18CELL] = "\\image\\ui\\001a\\item\\extbag_18cell.spr",
	[Item.EXTBAG_20CELL] = "\\image\\ui\\001a\\item\\extbag_20cell.spr",
	[Item.EXTBAG_24CELL] = "\\image\\ui\\001a\\item\\extbag_24cell.spr",
};

local POSMAP = {
	[0] = Ui.UI_EXTBAG1,
	[1] = Ui.UI_EXTBAG2,
	[2] = Ui.UI_EXTBAG3,
};

local ADJUST_POS = {
	a = { 344, 270 },
	b = { 541, 360 },
	c = { 600, 380 },
};

function tbExtBagLayout:Init()
	self.bShow = 1;
	local tbHeight = {};
	for i, v in pairs(self.IMAGES) do
		local tbImageParam = GetImageParam(v, 1);
		if tbImageParam then
			tbHeight[i] = tbImageParam.nHeight;
		end
	end
	self.tbImageHeight = tbHeight;
end


function tbExtBagLayout:Visible()
	return self.bShow;
end

function tbExtBagLayout:Show()
	self.bShow = 1;
	self:Update();
end

function tbExtBagLayout:Hide()
	self.bShow = 0;
	self:Close();
end

function tbExtBagLayout:Close()
	for i = 0, Item.EXTBAGPOS_NUM - 1 do
		local szWnd = POSMAP[i];
		UiManager:CloseWindow(szWnd);
	end
end

function tbExtBagLayout:Update()

	if (self.bShow ~= 1) then
		return;
	end

	local tbState = {};
	local nTotalHeight = 0;

	for nPos = 0, Item.EXTBAGPOS_NUM - 1 do
		local pExtBag = me.GetExtBag(nPos);
		local tb = {};
		if pExtBag then
			local nHeight = self.tbImageHeight[pExtBag.nDetail] or 0;
			tbState[nPos] = { bOpen = 1, nHeight = nHeight };
			nTotalHeight = nTotalHeight + nHeight;
		else
			tbState[nPos] = { bOpen = 0 };
		end
	end

	local tbAdjust = ADJUST_POS[Ui.szMode];
	local nLeft = tbAdjust[1];
	local nTop  = tbAdjust[2] - math.floor(nTotalHeight / 2);

	for nPos = 0, Item.EXTBAGPOS_NUM - 1 do
		local szWnd = POSMAP[nPos];
		local tb = tbState[nPos];
		if (tb.bOpen == 1) then
			UiManager:OpenWindow(szWnd, nPos);
			Ui(szWnd).tbExtBagCont.CanSendStateUse=function (szWnd)
				local bCanSendUse = 0;
				local STATE_USE =
						{
							UiManager.UIS_ACTION_GIFT,
							UiManager.UIS_EQUIP_BREAKUP,
							UiManager.UIS_EQUIP_ENHANCE,
							UiManager.UIS_EQUIP_PEEL,
							UiManager.UIS_EQUIP_COMPOSE,
							UiManager.UIS_EQUIP_UPGRADE,
							UiManager.UIS_EQUIP_REFINE,
							UiManager.UIS_TRADE_PLAYER,
							UiManager.UIS_OPEN_REPOSITORY,
						};

				for i, nState in ipairs (STATE_USE) do
					if UiManager:GetUiState(nState) == 1 then
						bCanSendUse = 1;
						break;
					end
				end
				return bCanSendUse;
			end
			UiManager:MoveWindow(szWnd, nLeft, nTop);
			nTop = nTop + tb.nHeight;
		else
			UiManager:CloseWindow(szWnd);
		end
	end
end
