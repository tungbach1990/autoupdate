
Require("\\script\\npc\\define.lua");

if (not Npc.tbClassBase) then	-- 防止文件重载时破坏已有数据
	Npc.tbClassBase	= {};

	Npc.tbClass	= {
		default	= Npc.tbClassBase,
		[""]	= Npc.tbClassBase,
	};
end;

function Npc:GetClass(szClassName, bNotCreate)
	local tbClass	= self.tbClass[szClassName];
	if (not tbClass and bNotCreate ~= 1) then
		tbClass	= Lib:NewClass(self.tbClassBase);
		self.tbClass[szClassName]	= tbClass;
	end;
	return tbClass;
end;

function Npc:OnDialog(szClassName, szParam)
	if Looker:IsLooker(me) > 0 then
		Dialog:Say("Ai đó? Sao nghe tiếng mà không thấy người vậy?");
		return 0;
	end
	if (me.GetTiredDegree() == 2) then
		Dialog:Say("B?n ?? online quá 5h, kh?ng nh?n ???c b?t c? hi?u qu? nào.");
		return 0;
	end;
	
	local tbOpt	= {};
	local nEventFlag = 0;
	local nTaskFlag = 0;
	
	if (Task:AppendNpcMenu(tbOpt) == 1) then
		nTaskFlag = 1;
	end;
	
	local tbNpc = EventManager:GetNpcClass(him.nTemplateId);
	local tbNpcType = EventManager:GetNpcClass(szClassName);
	
	if tbNpc and EventManager.tbFun:MergeDialog(tbOpt, tbNpc) == 1 then
		nEventFlag = 1;
	end
	
	if tbNpcType and EventManager.tbFun:MergeDialog(tbOpt, tbNpcType) == 1 then
		nEventFlag = 1;
	end		

	if nEventFlag == 1 or nTaskFlag == 1 then
		local szMsg = "";
		local szMsg2 = "";
		if nEventFlag == 1 and nTaskFlag == 1 then
			szMsg = string.format("%s: Đến thật đúng lúc, ta có nhiệm vụ và hoạt động cho ngươi.", him.szName)
			szMsg2 = "Không muốn tham gia";
		elseif nEventFlag == 1 then
			szMsg = string.format("%s: Đến thật đúng lúc, ta có hoạt động cho ngươi.", him.szName)
			szMsg2 = "Ta muốn hỏi chuyện khác";
		elseif nTaskFlag == 1 then
			szMsg = string.format("%s: Đến thật đúng lúc, ta có nhiệm vụ cho ngươi.", him.szName)			
			szMsg2 = "Không muốn làm";
		end
		tbOpt[#tbOpt+1]	= {szMsg2, self.OriginalDialog, self, szClassName, him};	
		if nTaskFlag == 1 then
			tbOpt[#tbOpt+1]	= {"Kết thúc đối thoại"};
		end
		Dialog:Say(szMsg, tbOpt);
		return;
	end
	
	local tbClass	= self.tbClass[szClassName];
	Dbg:Output("Npc", "OnDialog", szClassName, tbClass);
	if (tbClass) then
		tbClass:OnDialog(szParam);
	end;
end;


function Npc:OnBubble(szClassName)
	local tbClass = self.tbClass[szClassName];
	if (tbClass) then
		tbClass:OnTriggerBubble();
	end
end

function Npc:AddBubble(szClassName, nIndex, szMsg)
end
function Npc:OriginalDialog(szClassName, pNpc)
	him	= pNpc;
	self.tbClass[szClassName]:OnDialog();
	him	= nil;
end;

function Npc:OnDeath(szClassName, szParam, ...)
	local tbClass	= self.tbClass[szClassName];
	if him.GetTempTable("Partner").nPersuadeRefCount then
		him.RemoveTaskState(Partner.nBePersuadeSkillId);
		him.GetTempTable("Partner").nPersuadeRefCount = 0;
	end
	
	local tbOnDeath	= him.GetTempTable("Npc").tbOnDeath;
	Dbg:Output("Npc", "OnDeath", szClassName, tbClass, tbOnDeath);
	if (tbOnDeath) then
		local tbCall	= {unpack(tbOnDeath)};
		Lib:MergeTable(tbCall, arg);
		local bOK, nRet	= Lib:CallBack(tbCall);	-- 调用回调
		if (not bOK or nRet ~= 1) then
			him.GetTempTable("Npc").tbOnDeath	= nil;
		end
	end
	

	
	if (tbClass) then
		tbClass:OnDeath(unpack(arg));
	end;
	
	Lib:CallBack({"SpecialEvent.ExtendEvent:DoExecute","Npc_Death", him, arg[1]});
		
	if (not arg[1]) then
		return;
	end
	
	local pNpc 		= arg[1];
	local nNpcType 	= him.GetNpcType();
	local pPlayer  	= pNpc.GetPlayer();
	if (not pPlayer) then
		return;
	end

	if (1 == nNpcType) then
		self:AwardXinDe(pPlayer, 100000);
		self:AwardTeamXinDe(pPlayer, 100000);
	elseif (2 == nNpcType) then
		self:AwardXinDe(pPlayer, 200000);
		self:AwardTeamXinDe(pPlayer, 200000)
	end
	
	EventManager:NpcDeathApi(szClassName, him, pPlayer, unpack(arg))
	
end;

function Npc:AwardTeamXinDe(pPlayer, nXinDe)
	if (nXinDe <= 0) then
		return;
	end

	local nTeamId	= pPlayer.nTeamId;
	local tbPlayerId, nMemberCount	= KTeam.GetTeamMemberList(nTeamId);
	if not tbPlayerId then
		return
	end	
	local nNpcMapId, nNpcX, nNpcY	= pPlayer.GetWorldPos();	
	for i, nPlayerId in pairs(tbPlayerId) do
		local pTPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
		if pTPlayer and pTPlayer.nId ~= pPlayer.nId then
			local nPlayerMapId, nPlayerX, nPlayerY	= pTPlayer.GetWorldPos();
			if (nPlayerMapId == nNpcMapId) then
				local nDisSquare = (nNpcX - nPlayerX)^2 + (nNpcY - nPlayerY)^2;
				if (nDisSquare < 16 * 16) then -- 九屏内玩家
					self:AwardXinDe(pTPlayer, nXinDe);
				end
			end
		end
	end
	
end

function Npc:AwardXinDe(pPlayer, nXinDe)
	if (nXinDe <= 0) then
		return;
	end
	Setting:SetGlobalObj(pPlayer);
	Task:AddInsight(nXinDe);
	Setting:RestoreGlobalObj();
end

function Npc:OnArrive(szClassName, pNpc)
	local tbOnArrive = pNpc.GetTempTable("Npc").tbOnArrive;
	Setting:SetGlobalObj(me, pNpc, it)
	if (tbOnArrive) then
		Lib:CallBack(tbOnArrive);
	end
	Setting:RestoreGlobalObj()
end

function Npc:OnLifePercentReduceHere(szClassName, pNpc, nPercent)
	local tbClass	= self.tbClass[szClassName];
	if (not tbClass) then
		Dbg:WriteLogEx(Dbg.LOG_ERROR, "Npc", string.format("Npc [%s] not found!", szClassName));
		return 0;
	end;
	
	Setting:SetGlobalObj(me, pNpc, it);
	if (tbClass.OnLifePercentReduceHere) then
		tbClass:OnLifePercentReduceHere(nPercent);
	end
	Setting:RestoreGlobalObj();
end

function Npc:OnSetFreeAI(nMapId, nX, nY, nAINpcId, nChatSec, nChatCount, nMaxSec, nRange, nDialogNpcId, nDialogSec, tbChat)
	
	nChatSec 	= ((nChatSec==0 	or not nChatSec) 	and 5) 		or nChatSec;
	nChatCount 	= ((nChatCount==0 	or not nChatCount) 	and 1) 		or nChatCount;
	nRange 		= ((nRange==0 		or not nRange) 		and 1000) 	or nRange;
	nDialogSec 	= ((nDialogSec==0 	or not nDialogSec) 	and 10) 	or nDialogSec;
	
	local pNpc = KNpc.Add(nAINpcId, 100, -1, SubWorldID2Idx(nMapId), nX, nY);
	if pNpc then
		local tbRX =  {math.floor(MathRandom(-nRange, -math.floor(nRange*0.6))), math.floor(MathRandom(math.floor(nRange*0.6), nRange))};
		local tbRY =  {math.floor(MathRandom(-nRange, -math.floor(nRange*0.6))), math.floor(MathRandom(math.floor(nRange*0.6), nRange))};
		local nTrX =  tbRX[math.floor(MathRandom(1, 2))] or 0;
		local nTrY =  tbRY[math.floor(MathRandom(1, 2))] or 0;
		local nMovX = nX + nTrX;
		local nMovY = nY + nTrY;
		pNpc.AI_AddMovePos(nMovX, nMovY);
		pNpc.SetNpcAI(9, 0, 1,-1, 0, 0, 0, 0, 0, 0, 0);
		pNpc.GetTempTable("Npc").tbNpcFreeAI				= {};
		pNpc.GetTempTable("Npc").tbNpcFreeAI.nCalcChatCount = 0;
		pNpc.GetTempTable("Npc").tbNpcFreeAI.nChatCount 	= nChatCount;
		pNpc.GetTempTable("Npc").tbNpcFreeAI.nMaxSec 		= nMaxSec;
		pNpc.GetTempTable("Npc").tbNpcFreeAI.nAINpcId 		= nAINpcId;
		pNpc.GetTempTable("Npc").tbNpcFreeAI.nChatSec 		= nChatSec;
		pNpc.GetTempTable("Npc").tbNpcFreeAI.nRange 		= nRange;
		pNpc.GetTempTable("Npc").tbNpcFreeAI.nDialogNpcId 	= nDialogNpcId;
		pNpc.GetTempTable("Npc").tbNpcFreeAI.nDialogSec 	= nDialogSec;
		pNpc.GetTempTable("Npc").tbNpcFreeAI.tbChat 		= tbChat;
		local nTimerId = Timer:Register(nChatSec * Env.GAME_FPS, self.OnTimerFreeAI, self, pNpc.dwId, 1);
		self._tbDebugFreeAITimer 	= self._tbDebugFreeAITimer or {};
		self._tbDebugFreeAITimer2 	= self._tbDebugFreeAITimer2 or {};
		self._tbDebugFreeAITimer[nTimerId] 	 = pNpc.dwId;
		self._tbDebugFreeAITimer2[pNpc.dwId] = nTimerId;
		Npc.tbFreeAINpcList = Npc.tbFreeAINpcList or {};
		Npc.tbFreeAINpcList[pNpc.dwId] = 1;
	end
	return 0;
end

function Npc:OnTimerFreeAI(nNpcId, nNpcType)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		local nTimerId = self._tbDebugFreeAITimer2[nNpcId];
		if nTimerId then 
			self._tbDebugFreeAITimer[nTimerId]	= nil; 
		end
		self._tbDebugFreeAITimer2[nNpcId] = nil;
		return 0;
	end
	
	local nCalcChatCount=	pNpc.GetTempTable("Npc").tbNpcFreeAI.nCalcChatCount;
	local nChatCount 	=	pNpc.GetTempTable("Npc").tbNpcFreeAI.nChatCount;
	local nMaxSec 		= 	pNpc.GetTempTable("Npc").tbNpcFreeAI.nMaxSec;
	local nAINpcId 		= 	pNpc.GetTempTable("Npc").tbNpcFreeAI.nAINpcId;
	local nChatSec 		= 	pNpc.GetTempTable("Npc").tbNpcFreeAI.nChatSec;
	local nRange 		= 	pNpc.GetTempTable("Npc").tbNpcFreeAI.nRange;
	local nDialogNpcId 	= 	pNpc.GetTempTable("Npc").tbNpcFreeAI.nDialogNpcId;
	local nDialogSec 	= 	pNpc.GetTempTable("Npc").tbNpcFreeAI.nDialogSec;
	local tbChat 		= 	pNpc.GetTempTable("Npc").tbNpcFreeAI.tbChat;
	local nMapId 		= 	pNpc.nMapId;
	local nX, nY 		= 	pNpc.GetMpsPos();
	local tbSec 		= 	{[1] = nChatSec, [2] = nDialogSec,};
	
	if nMaxSec > 0 then
		nMaxSec = nMaxSec - tbSec[nNpcType];
		if nMaxSec == 0 then
			nMaxSec = -1;
		end
	end
	
	if nMaxSec < 0 then
		Npc.tbFreeAINpcList[pNpc.dwId] = nil;
		
		local nTimerId = self._tbDebugFreeAITimer2[pNpc.dwId];
		self._tbDebugFreeAITimer[nTimerId]	= nil;
		self._tbDebugFreeAITimer2[pNpc.dwId] = nil;	
		
		pNpc.Delete();		
		return 0;
	end
	
	if nNpcType == 2 then
		Npc.tbFreeAINpcList[pNpc.dwId] = nil;
		
		local nTimerId = self._tbDebugFreeAITimer2[pNpc.dwId];
		self._tbDebugFreeAITimer[nTimerId]	= nil;
		self._tbDebugFreeAITimer2[pNpc.dwId] = nil;	
		
		pNpc.Delete();
		self:OnSetFreeAI(nMapId, nX, nY, nAINpcId, nChatSec, nChatCount, nMaxSec, nRange, nDialogNpcId, nDialogSec, tbChat)
		return 0;
	end
	
	pNpc.GetTempTable("Npc").tbNpcFreeAI.nMaxSec = nMaxSec;
	if not nDialogNpcId or nDialogNpcId ==0 or nCalcChatCount < nChatCount then
		if nDialogNpcId > 0 then
			pNpc.GetTempTable("Npc").tbNpcFreeAI.nCalcChatCount = pNpc.GetTempTable("Npc").tbNpcFreeAI.nCalcChatCount + 1;
		end
		if type(tbChat) == "table" and #tbChat > 0 then
			local szChar = tbChat[math.floor(MathRandom(1, #tbChat))] or "";
			pNpc.SendChat(szChar);
		end
		return
	end
	
	Npc.tbFreeAINpcList[pNpc.dwId] = nil;
	local nTimerId = self._tbDebugFreeAITimer2[pNpc.dwId];
	self._tbDebugFreeAITimer[nTimerId]	= nil;
	self._tbDebugFreeAITimer2[pNpc.dwId] = nil;	
	
	pNpc.Delete();
	
	local pNpcDialog = KNpc.Add(nDialogNpcId, 100, -1, SubWorldID2Idx(nMapId), nX, nY);
	if  pNpcDialog then
		pNpcDialog.GetTempTable("Npc").tbNpcFreeAI 				= {};
		pNpcDialog.GetTempTable("Npc").tbNpcFreeAI.nChatCount 	= nChatCount;
		pNpcDialog.GetTempTable("Npc").tbNpcFreeAI.nMaxSec 		= nMaxSec;
		pNpcDialog.GetTempTable("Npc").tbNpcFreeAI.nAINpcId 	= nAINpcId;
		pNpcDialog.GetTempTable("Npc").tbNpcFreeAI.nChatSec 	= nChatSec;
		pNpcDialog.GetTempTable("Npc").tbNpcFreeAI.nRange 		= nRange;
		pNpcDialog.GetTempTable("Npc").tbNpcFreeAI.nDialogNpcId = nDialogNpcId;
		pNpcDialog.GetTempTable("Npc").tbNpcFreeAI.nDialogSec 	= nDialogSec;
		pNpcDialog.GetTempTable("Npc").tbNpcFreeAI.tbChat 		= tbChat;
		local nTimerId = Timer:Register(nDialogSec * Env.GAME_FPS, self.OnTimerFreeAI, self, pNpcDialog.dwId, 2);
		
		self._tbDebugFreeAITimer[nTimerId] 	 = pNpcDialog.dwId;
		self._tbDebugFreeAITimer2[pNpcDialog.dwId] = nTimerId;
		
		Npc.tbFreeAINpcList[pNpcDialog.dwId] = 1;
	end
	return 0;
end

function Npc:OnClearFreeAINpc(nNpcId)
	if Npc.tbFreeAINpcList then
		for dwId in pairs(Npc.tbFreeAINpcList) do
			local pNpc = KNpc.GetById(dwId);
			if pNpc then
				if not nNpcId then
					pNpc.Delete();
				end
				
				if nNpcId and pNpc.nTemplateId == nNpcId then
					pNpc.Delete();
				end
			end
		end
	end
	return 0;
end

function Npc:GetLevelData(szClassName, szKey, nSeries, nLevel, tbParam)
	local tbClass	= self.tbClass[szClassName];
	if (not tbClass) then
		Dbg:WriteLogEx(Dbg.LOG_ERROR, "Npc", string.format("Npc [%s] not found!", szClassName));
		return 0;
	end;
	
	local tbData	= nil;
	
	if (szClassName == "") then
		tbClass	= {_tbBase=tbClass};
	end
	
	local tbBaseClasses	= {
		rawget(tbClass, "tbLevelData"),
		self.tbAIBase[tbParam[1]],
		self.tbSkillBase[tbParam[2]],
		self.tbPropBase[tbParam[3]],
		tbClass._tbBase and tbClass._tbBase.tbLevelData,
	};
	for i = 1, 5 do
		local tbBase	= tbBaseClasses[i];
		tbData	= tbBase and tbBase[szKey];
		if (tbData) then
			break;
		end;
	end;
	if (not tbData) then
		Dbg:WriteLogEx(Dbg.LOG_ERROR, "Npc", string.format("Npc [%s] : [%s] not found!", szClassName, szKey));
		return 0;
	end;
	if (type(tbData) == "function") then
		return tbData(nSeries, nLevel, tbParam[4]);
	else
		return Lib.Calc:Link(nLevel, tbData);
	end;
end;

function Npc:RegPNpcOnDeath(pNpc, ...)
	local tbPNpcData		= pNpc.GetTempTable("Npc");
	assert(not tbPNpcData.tbOnDeath, "too many OnDeath registrer on npc:"..pNpc.szName);
	tbPNpcData.tbOnDeath	= arg;
end;

function Npc:UnRegPNpcOnDeath(pNpc)
	pNpc.GetTempTable("Npc").tbOnDeath	= nil;
end;


function Npc:DeathLoseItem(szClassName, pNpc, tbLoseItem)
	local tbClass	= self.tbClass[szClassName];
	if (not tbClass) then
		Dbg:WriteLogEx(Dbg.LOG_ERROR, "Npc", string.format("Npc [%s] not found!", szClassName));
		return 0;
	end;
	
	Setting:SetGlobalObj(me, pNpc, it);
	if (tbClass.DeathLoseItem) then
		tbClass:DeathLoseItem(tbLoseItem);
	end
	Setting:RestoreGlobalObj();
end
