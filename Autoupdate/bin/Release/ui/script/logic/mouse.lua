
Ui.tbLogic.tbMouse = {};
local tbMouse  = Ui.tbLogic.tbMouse;
local tbObject = Ui.tbLogic.tbObject;

function tbMouse:Init()
	self.tbObj 		= nil;				-- 鼠标上拿着的Object
	self.tbOverObj	= nil;				-- 鼠标悬停的Object
	UiNotify:RegistNotify(UiNotify.emCOREEVENT_SYNC_ITEM, self.OnSyncItem, self);
end

function tbMouse:SetObj(tbObj)
	ClearMouseObj();	-- 清除鼠标Object绘制
	if (not tbObj) or (tbObj ~= self.tbObj) then
		Ui(Ui.UI_PLAYERPANEL):SetEquipPosHighLight();		-- TODO: 为了保持原来的装备高亮效果，临时做法
		Ui(Ui.UI_PARTNER):SetEquipPosHighLight();
	end
	self.tbObj = tbObj;
	if not tbObj then
		return;
	end
	if (Ui.tbLogic.tbObject:CheckObj(tbObj) ~= 1) then
		Ui:Output("[ERR] Thử lấy đối tượng Object không hợp lệ!", tbObj);
		return;
	end
	SetMouseObj(tbObject:GetObjImage(self.tbObj));	-- 更新鼠标绘制
	Ui(Ui.UI_PLAYERPANEL):SetEquipPosHighLight(self.tbObj);
	Ui(Ui.UI_PARTNER):SetEquipPosHighLight(self.tbObj);
end

function tbMouse:GetObj()
	return self.tbObj; 
end

function tbMouse:Refresh()
	ClearMouseObj();								-- 清除鼠标Object绘制
	SetMouseObj(tbObject:GetObjImage(self.tbObj));	-- 更新鼠标绘制
	Ui(Ui.UI_PLAYERPANEL):SetEquipPosHighLight(self.tbObj);
	Ui(Ui.UI_PARTNER):SetEquipPosHighLight(self.tbObj);
end

function tbMouse:Clear()
	if (self.tbObj) then
		tbObject:DestroyObj(self.tbObj);
	end
	self:SetObj(nil);
end

function tbMouse:ThrowAway()
	if (not self.tbObj) then
		return 0;
	end
	local nType = self.tbObj.nType;
	if (nType == Ui.OBJ_OWNITEM) then
		local pItem = me.GetItem(self.tbObj.nRoom, self.tbObj.nX, self.tbObj.nY);
		if not pItem then
			return 0;
		end
		if pItem.IsForbitThrow() == 1 then
			me.Msg("Không thể vứt bỏ")
			return 1;
		end
		local tbMsg = {};
		tbMsg.szMsg = string.format("Bạn muốn vứt <color=red>%s<color>?", pItem.szName);
		tbMsg.nOptCount = 2;
		function tbMsg:Callback(nOptIndex, nRoom, nX, nY)
			if (nOptIndex == 2) then
				me.ThrowAway(nRoom, nX, nY);
			end
		end
		UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg, self.tbObj.nRoom, self.tbObj.nX, self.tbObj.nY);
		return 1;
	end
	if (nType == Ui.OBJ_TEMPITEM) or (nType == Ui.OBJ_FIGHTSKILL) or (nType == Ui.OBJ_LIFESKILL) then
		self:Clear();		-- 清除鼠标上的东西
	end
	return 1;
end

function tbMouse:ResetObj()
	local tbObj = self.tbObj;
	if not tbObj then
		return;
	end
	self:SetObj(nil);	-- 先清掉鼠标
	if (tbObj.nType == Ui.OBJ_OWNITEM) then
		UiNotify:OnNotify(UiNotify.emCOREEVENT_SYNC_ITEM, tbObj.nRoom, tbObj.nX, tbObj.nY);	-- TODO: xyf 临时做法
	end
end

function tbMouse:OnSyncItem(nRoom, nX, nY)
	if (not self.tbObj) or (self.tbObj.nType ~= Ui.OBJ_OWNITEM) or (self.tbObj.nRoom ~= nRoom) or (self.tbObj.nX ~= nX) or (self.tbObj.nY ~= nY) then
		return;
	end
	local pItem = me.GetItem(nRoom, nX, nY);
	if (not pItem) then
		self:Clear();
	else
		SetMouseObj(tbObject:GetObjImage(self.tbObj));	-- 更新鼠标绘制
	end
end

function tbMouse:OnStateChanged(nState)

	local tbStateToIndex =
	{
		[UiManager.UIS_TRADE_SELL]				= Ui.CURSOR_SELL,
		[UiManager.UIS_TRADE_BUY]				= Ui.CURSOR_BUY,
		[UiManager.UIS_TRADE_REPAIR]			= Ui.CURSOR_REPAIR,
		[UiManager.UIS_TRADE_REPAIR_EX]			= Ui.CURSOR_REPAIR,
		[UiManager.UIS_STALL_SETPRICE]			= Ui.CURSOR_STALL_MARK_PIRCE,
		[UiManager.UIS_OFFER_SETPRICE]			= Ui.CURSOR_STALL_MARK_PIRCE,
		[UiManager.UIS_ACTION_VIEWITEM]			= Ui.CURSOR_USE,
		[UiManager.UIS_ACTION_FOLLOW]			= Ui.CURSOR_USE,
		[UiManager.UIS_ACTION_MAKEFRIEND]		= Ui.CURSOR_USE,
		[UiManager.UIS_ACTION_TRADE]			= Ui.CURSOR_USE,
		[UiManager.UIS_ITEM_REPAIR]				= Ui.CURSOR_REPAIR,
		[UiManager.UIS_ITEM_SPLIT]				= Ui.CURSOR_SPLIT,
		[UiManager.UIS_CAPTURE_SCREEN]			= Ui.CURSOR_CAPTURE_SCREEN,
		[UiManager.UIS_CAPTURE_SCREEN_SELECTING]= Ui.CURSOR_CAPTURE_SCREEN,
		[UiManager.UIS_CAPTURE_SCREEN_DONE]		= Ui.CURSOR_CAPTURE_SCREEN,
		[UiManager.UIS_STONE_UPGRADE]			= Ui.CURSOR_STONE_UPGRADE,
	};
	
	local nIndex = tbStateToIndex[nState] or Ui.CURSOR_NORMAL;

	if (UiManager:GetUiState(nState) == 1) and (nIndex ~= Ui.CURSOR_NORMAL) then
		SetCursorImageIdx(nIndex);
		LockCursorImage(1);
	else
		LockCursorImage(0);
		SetCursorImageIdx(Ui.CURSOR_NORMAL);
	end

end
