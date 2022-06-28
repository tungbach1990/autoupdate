

local tbHuichengfu = Item:GetClass("huichengfu");

tbHuichengfu.nTime = 10;					-- 延时的时间(秒)

tbHuichengfu.nWuxianhuichengfuId =	{[23] = 1, [234] = 1}; 	-- 无限回城符的Id

function tbHuichengfu:OnUse()
	Log:Ui_LogSetValue("Có dùng Hồi Thành Quyển không", 1)	
	self:DelayTime(it, me);
	return	0;
end

function tbHuichengfu:DelayTime(pItem, pPlayer)
	if (me.nFightState == 0) then
		self:TransPlayer(pItem.dwId, pPlayer.nId);
		return;
	end
	local tbEvent = {
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SIT,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,		
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
	}
	GeneralProcess:StartProcess("Đang về thành…", self.nTime * Env.GAME_FPS, {self.TransPlayer, self, pItem.dwId, pPlayer.nId}, nil, tbEvent);
end

function tbHuichengfu:TransPlayer(nItemId, nPlayerId)
	local pItem = KItem.GetObjById(nItemId);
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	if (not pItem) then
		pPlayer.Msg("Hồi Thành Phù không tồn tại!");
		return;
	end
	local nMapId, nReliveId		= pPlayer.GetRevivePos();
	local nReliveX, nReliveY = RevID2WXY(nMapId, nReliveId);	-- 得到trip点的地图Id(nMapId),以及它的坐标(nReliveX, nReliveY)

	local nCanUse = KItem.CheckLimitUse(pPlayer.nMapId, "chuansong");
	if (not nCanUse or nCanUse == 0) then
		pPlayer.Msg("Đạo cụ này không được dùng ở đây")
		return;
	end
	
	local nRet, szMsg = Map:CheckTagServerPlayerCount(nMapId)
	if nRet ~= 1 then
		pPlayer.Msg(szMsg);
		return;
	end
	if (not self.nWuxianhuichengfuId[pItem.nParticular]) then
		if (pPlayer.DelItem(pItem, Player.emKLOSEITEM_USE) ~= 1) then
			pPlayer.Msg("Hủy Hồi Thành Phù thất bại!");
			return;
		end
	end
	pPlayer.NewWorld(nMapId, nReliveX / 32, nReliveY / 32);
end
