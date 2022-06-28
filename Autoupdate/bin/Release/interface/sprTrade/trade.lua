local uiTrade	 = Ui(Ui.UI_TRADE);
local tbObject   = Ui.tbLogic.tbObject;

uiTrade.OBJ_TRADE 					= "ObjTrade";
uiTrade.TRADE_FREEZE_TIME           = 6;    				-- 交易冷却6秒

local tbTradeCont = { bUse = 0, bLink = 0, nRoom = Item.ROOM_TRADE,bSendToGift = 1 };	-- 不可使用，不可链接--非金山原版

uiTrade.OnOpen=function(self)
	tbObject:UnregContainer(self.tbTradeCont);
	self.tbTradeCont = tbObject:RegisterContainer(
		self.UIGROUP,
		self.OBJ_TRADE,
		Item.ROOM_TRADE_WIDTH,
		Item.ROOM_TRADE_HEIGHT,
		tbTradeCont,
		"itemroom"
	);
	--me.Msg("交易打开");
	self:WriteStatLog();
	self:UpdateTradeState();
	self.nFreezeTime = self.TRADE_FREEZE_TIME;
	UiManager:SetUiState(UiManager.UIS_TRADE_PLAYER);
	UiManager:OpenWindow(Ui.UI_ITEMBOX);
end

uiTrade.tbTradeCont.CanSendStateUse=function(self)
	return	1;
end

uiTrade.StateRecvUse=function(self,szUiGroup)
	if szUiGroup == self.UIGROUP then
		return;
	end

	if (UiManager:WindowVisible(self.UIGROUP) ~= 1) then
		return;
	end
	self.tbTradeCont:SpecialStateRecvUse();
end
uiTrade.RegistermyEvent=function(self)
	UiNotify:RegistNotify(UiNotify.emUIEVENT_OBJ_STATE_USE, self.StateRecvUse, self);
end
uiTrade:RegistermyEvent();
