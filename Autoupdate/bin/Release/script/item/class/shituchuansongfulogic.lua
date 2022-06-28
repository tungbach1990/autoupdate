
if (not Item.tbShiTuChuanSongFu) then
	Item.tbShiTuChuanSongFu = {};
end

local tb = Item.tbShiTuChuanSongFu;
tb.ITEM_ID = {18,1,65,1};
tb.tbc2sFun = {};

function tb:SelectDstPlayerPos(szDstPlayerName, szAppPlayerName)
	GlobalExcute({"Item.tbShiTuChuanSongFu:SeachPlayer", szDstPlayerName, szAppPlayerName});
end


function tb:SeachPlayer(szDstPlayerName, szAppPlayerName)
	local pDstPlayer = GetPlayerObjFormRoleName(szDstPlayerName);
	if (pDstPlayer) then
		local nMapId, nPosX, nPosY = pDstPlayer.GetWorldPos();
		local nCanSendIn  = Item:IsCallOutAtMap(nMapId, unpack(self.ITEM_ID));
		if (nCanSendIn ~= 1) then
			nMapId = -1;
		end	
		GCExcute({"Item.tbShiTuChuanSongFu:FindDstPlayer", szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY});		
	end
end


function tb:FindDstPlayer(szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY)
	GlobalExcute({"Item.tbShiTuChuanSongFu:ObtainDstPlayerPos", szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY})
end


function tb:ObtainDstPlayerPos(szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY)

	local pAppPlayer = GetPlayerObjFormRoleName(szAppPlayerName);
	if (not pAppPlayer) then
		return 0;
	end
	if nMapId == -1 then
		pAppPlayer.Msg("Không thể đến được mục tiêu!");
		return 0;
	end
	local nCanSendOut = Item:IsCallInAtMap(nMapId, unpack(self.ITEM_ID));
	if (nCanSendOut ~= 1) then
		pAppPlayer.Msg("Không được đến khu vực hiện tại!");
		return 0;
	end
	
	GCExcute({"Item.tbShiTuChuanSongFu:Msg2DstPlayer4Confirm_GC", szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY});
end


function tb:Msg2DstPlayer4Confirm_GC(szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY)
	GlobalExcute({"Item.tbShiTuChuanSongFu:Msg2DstPlayer4Confirm_GS", szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY});
end

function tb:Msg2DstPlayer4Confirm_GS(szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY)
	local pDstPlayer = GetPlayerObjFormRoleName(szDstPlayerName);
	if (not pDstPlayer) then
		return;
	end
	
	pDstPlayer.CallClientScript({"Item.tbShiTuChuanSongFu:Msg2DstPlayer4Confirm_C", szDstPlayerName, szAppPlayerName});
end

function tb:Msg2DstPlayer4Confirm_C(szDstPlayerName, szAppPlayerName)
	CoreEventNotify(UiNotify.emCOREEVENT_CONFIRMATION, UiNotify.CONFIRMATION_TEACHER_CONVECTION, szDstPlayerName, szAppPlayerName);
end

function tb:DstPlayerAccredit(szDstPlayerName, szAppPlayerName, bAccept)	
	local pStudent = GetPlayerObjFormRoleName(szDstPlayerName);
	if (not pStudent) then
		return;
	end
	if (bAccept ~= 1) then
		Item.tbShiTuChuanSongFu:Msg2Player_GS(szAppPlayerName, "Đồ đệ bạn không cần bạn qua đây! ");
		return;
	end
	
	local nMapId, nPosX, nPosY = pStudent.GetWorldPos();
	local nStudentFightState = pStudent.nFightState;
	local nCanSendIn  = Item:IsCallOutAtMap(nMapId, unpack(Item.tbShiTuChuanSongFu.ITEM_ID));
	if (nCanSendIn ~= 1) then
		nMapId = -1;
	end	
	
	GCExcute({"Item.tbShiTuChuanSongFu:AgreeTeacherComeHere_GC", szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY,nStudentFightState});		
end
tb.tbc2sFun["DstPlayerAccredit"] = tb.DstPlayerAccredit;


function tb:AgreeTeacherComeHere_GC(szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY, nStudentFightState)
	GlobalExcute({"Item.tbShiTuChuanSongFu:AgreeTeacherComeHere_GS", szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY, nStudentFightState});
end


function tb:AgreeTeacherComeHere_GS(szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY, nStudentFightState, nSure)
	local pPlayer = GetPlayerObjFormRoleName(szAppPlayerName);
	if (not pPlayer) then
		return;
	end
	local szDestStudent = pPlayer.GetTempTable("Item").szBeComeToSutdentName;
	if (not szDestStudent or szDestStudent ~= szDstPlayerName) then
		self:Msg2Player_GS(szDstPlayerName, "Sư đồ truyền tống đã quá hạn, nếu muốn truyền tống phải đăng ký lại.")
		pPlayer.Msg("Sư đồ truyền tống đã quá hạn, nếu muốn truyền tống phải đăng ký lại.");
		return;
	end
	if nMapId == -1 then
		pPlayer.Msg("Không thể đến được mục tiêu!");
		return 0;
	end
	local nRet, szMsg = Map:CheckTagServerPlayerCount(nMapId)
	if nRet ~= 1 then
		pPlayer.Msg(szMsg);
		return 0;
	end
	local nCanSendOut = Item:IsCallInAtMap(nMapId,unpack(self.ITEM_ID));
	if (nCanSendOut ~= 1) then
		pPlayer.Msg("Không được đến khu vực hiện tại!");
		return 0;
	end
	if (nSure ~= 1 and pPlayer.nFightState == 1) then				-- 玩家在非战斗状态下传送无延时正常传送
		local tbEvent	= {-- 会中断延时的事件
			Player.ProcessBreakEvent.emEVENT_MOVE,
			Player.ProcessBreakEvent.emEVENT_ATTACK,
			Player.ProcessBreakEvent.emEVENT_SITE,
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
			};
		Setting:SetGlobalObj(pPlayer)
		GeneralProcess:StartProcess("Đang truyền tống...", 10 * Env.GAME_FPS, {self.AgreeTeacherComeHere_GS, self, szDstPlayerName, szAppPlayerName, nMapId, nPosX, nPosY, nStudentFightState, 1}, nil, tbEvent);
		Setting:RestoreGlobalObj()
		return 0;
	end
	pPlayer.GetTempTable("Item").szBeComeToSutdentName = nil;
	pPlayer.SetFightState(nStudentFightState);
	pPlayer.NewWorld(nMapId, nPosX, nPosY);
end

function tb:Msg2Player_GS(szPlayerName, szMsg)
	GCExcute({"Item.tbShiTuChuanSongFu:Msg2Player_GC", szPlayerName, szMsg});	
end

function tb:Msg2Player_GC(szPlayerName, szMsg)
	GlobalExcute({"Item.tbShiTuChuanSongFu:ReceiveMsg", szPlayerName,szMsg});
end

function tb:ReceiveMsg(szPlayerName, szMsg)
	local pPlayer = GetPlayerObjFormRoleName(szPlayerName);
	if (not pPlayer) then
		return;
	end
	
	pPlayer.Msg(szMsg);
end

