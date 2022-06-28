local tbXiangZiNpc	= {};
Npc.tbXiangZiNpc	= tbXiangZiNpc;
tbXiangZiNpc.NPC_TAMPLATE_ID	= 2700	-- 箱子NPC模板ID

function tbXiangZiNpc:AddBox(nSubWorld, nX, nY, nTakeTime, tbParam, nBagCell, nExistTime)
	local pNpc = KNpc.Add2(self.NPC_TAMPLATE_ID, 10, -1, nSubWorld, nX, nY);
	if not pNpc then
		return;
	end
	local tbTemp = pNpc.GetTempTable("Npc");
	tbTemp.tbBoxData = {};
	tbTemp.tbBoxData.nTakeTime = nTakeTime;
	tbTemp.tbBoxData.nBagCell = nBagCell or 1;
	tbTemp.tbBoxData.tbTable = tbParam.tbTable;
	tbTemp.tbBoxData.fnAwardFunction = tbParam.fnAwardFunction;
	tbTemp.tbBoxData.tbParam = tbParam.tbParam;
	if nExistTime and nExistTime > 0 then
		tbTemp.tbBoxData.nTimerId = Timer:Register(
			nExistTime, 
			self.DelBox, self, pNpc.dwId
		)
	end
	return pNpc;
end

function tbXiangZiNpc:DelBox(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return 0;
	end
	local tbTemp = pNpc.GetTempTable("Npc");
	if tbTemp.tbBoxData and tbTemp.tbBoxData.nTimerId then
		Timer:Close(tbTemp.tbBoxData.nTimerId);
	end
	pNpc.Delete();
end

local tbJiangLiXiangZi = Npc:GetClass("jianglixiangzi");

function tbJiangLiXiangZi:OnDialog()
	local tbTemp = him.GetTempTable("Npc");
	if not tbTemp.tbBoxData then
		return 0;
	end
	if (me.CountFreeBagCell() < tbTemp.tbBoxData.nBagCell) then
		me.Msg("Túi không đủ chỗ.");
		return 0;
	end
	local tbEvent = 
	{
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
	}
	
	GeneralProcess:StartProcess(
		"", 
		tbTemp.tbBoxData.nTakeTime, 
		{self.CompleteProcess, self, him.dwId, me.nId}, 
		nil, 
		tbEvent
	);
end

function tbJiangLiXiangZi:CompleteProcess(nNpcId, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return 0;
	end
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return 0;
	end
	local tbTemp = pNpc.GetTempTable("Npc");
	if tbTemp.tbBoxData then
		if tbTemp.tbBoxData.tbParam then
			tbTemp.tbBoxData.fnAwardFunction(tbTemp.tbBoxData.tbTable, pPlayer, unpack(tbTemp.tbBoxData.tbParam));
		else
			tbTemp.tbBoxData.fnAwardFunction(tbTemp.tbBoxData.tbTable, pPlayer);
		end
	end
	tbXiangZiNpc:DelBox(nNpcId);
end
