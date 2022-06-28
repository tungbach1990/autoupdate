-- GM×¨ÓÃ¿¨

local tbGMCard	= Item:GetClass("gmcard");

tbGMCard.MAX_RECENTPLAYER	= 15;

function tbGMCard:OnUse()
	local nIsHide	= GM.tbGMRole:IsHide();
	
	local tbOpt = {
		{(nIsHide == 1 and "Hiá»‡n ThÃ¢n") or "áº¨n ThÃ¢n", "GM.tbGMRole:SetHide", 1 - nIsHide},
		{"Lá»‡nh BÃ i Äá»“ng HÃ nh", self.Mau, self},
		{"ThÃªm Uy Danh", self.themvatpham, self},
		{"TÃ¬m NhÃ¢n Váº­t", self.AskRoleName, self},
		{"NhÃ¢n váº­t xung quanh", self.AroundPlayer, self},
		{"NhÃ¢n váº«n Ä‘Ã£ tÆ°Æ¡ng tÃ¡c", self.RecentPlayer, self},
		{"Chá»‰nh cáº¥p Ä‘á»™", self.AdjustLevel, self},
		{"Load láº¡i Script Lá»… Quan", self.Reload, self},
		{"<color=yellow>Táº§n LÄƒng KhÃ´ng Giá»›i Háº¡n<color>", self.SuperQinling, self},
		{"Káº¿t thÃºc Ä‘á»‘i thoáº¡i"},
	};
	Dialog:Say("GM lÃ  pháº£i Ä‘Ã ng hoÃ ng", tbOpt);
	
	return 0;
end;
function tbGMCard:Mau()
	-- local nMapId, nPosX, nPosY = me.GetWorldPos();
	--     KNpc.Add2(2935, 2, 1, nMapId, nPosX, nPosY);
	--me.AddStackItem(18,1,2002,1,nil,500);
	--me.Earn(15000000,0);
	--me.SetTask(2001,3,6000);

me.AddItem(1,24,1,1);



	

	
	-- GCExcute({"PlayerHonor:UpdateLingXiuHonorLadder"});
-- GCExcute({"PlayerHonor:UpdateWuLinHonorLadder"});
-- GCExcute({"PlayerHonor:UpdateMoneyHonorLadder"});
-- GCExcute({"PlayerHonor:UpdateLeaderHonorLadder"});
-- KGblTask.SCSetDbTaskInt(86, GetTime());
-- GlobalExcute({"PlayerHonor:OnLadderSorted"});
end
function tbGMCard:themvatpham()
	me.AddKinReputeEntry(1000);
end

function tbGMCard:themvatpham2(loaivatpham)
	me.AddItem(loaivatpham);
end

function tbGMCard:SuperQinling()
	me.NewWorld(1536, 1567, 3629);
	me.SetTask(2098, 1, 0);
	me.AddSkillState(1413, 4, 1, 2 * 60 * 60 * Env.GAME_FPS, 1, 1);
end

function tbGMCard:Reload()
	local nRet1	= DoScript("\\script\\item\\class\\gmcard.lua");
	local nRet2	= DoScript("\\script\\misc\\gm_role.lua");
	local nRet3	= DoScript("\\script\\npc\\liguan.lua");
	local nRet4	= DoScript("\\script\\task\\wanted\\wanted_gs.lua");
	local nRet5	= DoScript("\\script\\task\\wanted\\wanted_def.lua");
	local nRet6	= DoScript("\\script\\task\\wanted\\wanted_npc.lua");
	local nRet7	= DoScript("\\script\\marry\\logic\\marry_npc.lua");
	local nRet8	= DoScript("\\script\\npc\\tuiguangyuan.lua");
	local nRet9	= DoScript("\\script\\mission\\battle\\npc\\baomingdianjunxuguan.lua");
	GCExcute({"DoScript", "\\script\\misc\\gm_role.lua"});
	local szMsg	= "Reloaded!!("..nRet1..","..nRet2..","..nRet3..","..nRet4..","..nRet5..","..nRet9..GetLocalDate(") %Y-%m-%d %H:%M:%S");
	me.Msg(szMsg);
	print(szMsg);
end

function tbGMCard:AskRoleName()
	Dialog:AskString("Nháº­p tÃªn", 16, self.OnInputRoleName, self);
end

function tbGMCard:OnInputRoleName(szRoleName)
	local nPlayerId	= KGCPlayer.GetPlayerIdByName(szRoleName);
	if (not nPlayerId) then
		Dialog:Say("KhÃ´ng á»“n táº¡i", {"Nháº­p láº¡i", self.AskRoleName, self}, {"Káº¿t thÃºc"});
		return;
	end
	
	self:ViewPlayer(nPlayerId);
end

function tbGMCard:ViewPlayer(nPlayerId)
	-- ²åÈë×î½üÍæ¼ÒÁĞ±í
	local tbRecentPlayerList	= self.tbRecentPlayerList or {};
	self.tbRecentPlayerList		= tbRecentPlayerList;
	for nIndex, nRecentPlayerId in ipairs(tbRecentPlayerList) do
		if (nRecentPlayerId == nPlayerId) then
			table.remove(tbRecentPlayerList, nIndex);
			break;
		end
	end
	if (#tbRecentPlayerList >= self.MAX_RECENTPLAYER) then
		table.remove(tbRecentPlayerList);
	end
	table.insert(tbRecentPlayerList, 1, nPlayerId);

	local szName	= KGCPlayer.GetPlayerName(nPlayerId);
	local tbInfo	= GetPlayerInfoForLadderGC(szName);
	local tbState	= {
		[0]		= "KhÃ´ng trá»±c tuyáº¿n",
		[-1]	= "´¦ÀíÖĞ",
		[-2]	= "¹Ò»ú£¿",
	};
	local nState	= KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_ONLINESERVER);
	local tbText	= {
		{"NhÃ¢n váº­t :", szName},
		{"TÃ i khoáº£n :", tbInfo.szAccount},
		{"Cáº¥p Ä‘á»™ : ", tbInfo.nLevel},
		{"Giá»›i tÃ­nh : ", (tbInfo.nSex == 1 and "Nam") or "Ná»¯"},
		{"MÃ´n phÃ¡i : ", Player:GetFactionRouteName(tbInfo.nFaction, tbInfo.nRoute)},
		{"Gia tá»™c :", tbInfo.szKinName},
		{"Bang há»™i :", tbInfo.szTongName},
		{"ÍşÍû", KGCPlayer.GetPlayerPrestige(nPlayerId)},
		{"×´Ì¬", (tbState[nState] or "<color=green>Trá»±c tuyáº¿n<color>") .. "("..nState..")"},
	}
	local szMsg	= "";
	for _, tb in ipairs(tbText) do
		szMsg	= szMsg .. "\n  " .. Lib:StrFillL(tb[1], 6) .. tostring(tb[2]);
	end
	local szButtonColor	= (nState > 0 and "") or "<color=gray>";
	local tbOpt = {
		{szButtonColor.."KÃ©o háº¯n tá»›i Ä‘Ã¢y", "GM.tbGMRole:CallHimHere", nPlayerId},
		{szButtonColor.."ÄÆ°a ta Ä‘áº¿n Ä‘Ã³", "GM.tbGMRole:SendMeThere", nPlayerId},
		{szButtonColor.."Cho háº¯n rá»›t máº¡ng", "GM.tbGMRole:KickHim", nPlayerId},
		{"Bá» tÃ¹", "GM.tbGMRole:ArrestHim", nPlayerId},
		{"Tháº£ tÃ¹", "GM.tbGMRole:FreeHim", nPlayerId},
		{"Gá»­i thÆ°", self.SendMail, self, nPlayerId},
		{"Táº¡m biá»‡t"},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbGMCard:RecentPlayer()
	local tbOpt	= {};
	for nIndex, nPlayerId in ipairs(self.tbRecentPlayerList or {}) do
		local szName	= KGCPlayer.GetPlayerName(nPlayerId);
		local nState	= KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_ONLINESERVER);
		tbOpt[#tbOpt+1]	= {((nState > 0 and "<color=green>") or "")..szName, self.ViewPlayer, self, nPlayerId};
	end
	tbOpt[#tbOpt + 1]	= {"Káº¿t thÃºc Ä‘á»‘i thoáº¡i"};
	
	Dialog:Say("Danh sÃ¡ch :", tbOpt);
end

function tbGMCard:AroundPlayer()
	local tbPlayer	= {};
	local _, nMyMapX, nMyMapY	= me.GetWorldPos();
	for _, pPlayer in ipairs(KPlayer.GetAroundPlayerList(me.nId, 50)) do
		if (pPlayer.szName ~= me.szName) then
			local _, nMapX, nMapY	= pPlayer.GetWorldPos();
			local nDistance	= (nMapX - nMyMapX) ^ 2 + (nMapY - nMyMapY) ^ 2;
			tbPlayer[#tbPlayer+1]	= {nDistance, pPlayer};
		end
	end
	local function fnLess(tb1, tb2)
		return tb1[1] < tb2[1];
	end
	table.sort(tbPlayer, fnLess);
	local tbOpt	= {};
	for _, tb in ipairs(tbPlayer) do
		local pPlayer	= tb[2];
		tbOpt[#tbOpt+1]	= {pPlayer.szName, self.ViewPlayer, self, pPlayer.nId};
		if (#tbOpt >= 8) then
			break;
		end
	end
	tbOpt[#tbOpt + 1]	= {"Káº¿t thÃºc Ä‘á»‘i thoáº¡i"};
	
	Dialog:Say("Danh sÃ¡ch", tbOpt);
end

function tbGMCard:AdjustLevel()
	local nMaxLevel	= GM.tbGMRole:GetMaxAdjustLevel();
	Dialog:AskNumber("ÆÚÍûµÈ¼¶(1~"..nMaxLevel..")", nMaxLevel, "GM.tbGMRole:AdjustLevel");
end

function tbGMCard:SendMail(nPlayerId)
	Dialog:AskString("ÓÊ¼şÄÚÈİ", 500, "GM.tbGMRole:SendMail", nPlayerId);
end

function tbGMCard:LookWldh()
	if not GLOBAL_AGENT then
		local szMsg = "ÎäÁÖ´ó»á¼ÇÕßÈë¿Ú<pic=98><pic=98><pic=98>";
		local tbOpt = {
			{"½øÈëÓ¢ĞÛµº", self.EnterGlobalServer, self},
			{"ÏÈµÈµÈ"}};
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	local szMsg = "ÎäÁÖ´ó»á¼ÇÕßÈë¿Ú<pic=98><pic=98><pic=98>";
	local tbOpt = {
			{"·µ»ØÓ¢ĞÛµº", self.ReturnGlobalServer, self},
			{"·µ»ØÁÙ°²¸®", self.ReturnMyServer, self},
			{"¹Û¿´µ¥ÈËÈü¾öÈü", self.Wldh_SelectFaction, self},
			{"¹Û¿´Ë«ÈËÈü¾öÈü", self.Wldh_SelectVsState, self, 2, 1},
			{"¹Û¿´ÈıÈËÈü¾öÈü", self.Wldh_SelectVsState, self, 3, 1},
			{"¹Û¿´ÎåÈËÈü¾öÈü", self.Wldh_SelectVsState, self, 4, 1},
			{"¹Û¿´ÍÅÌåÈü¾öÈü", self.Wldh_SelectBattleVsState, self},
			{"ÏÈµÈµÈ"},
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbGMCard:ReturnMyServer()
	me.GlobalTransfer(29, 1694, 4037);
end

function tbGMCard:Wldh_SelectBattleVsState()
	local szMsg = "";
	local tbOpt = {
		{"¹Ú¾üÍÅÌåÈü³¡£¨½ğ·½£©", self.Wldh_EnterBattleMap, self, 1, 1},
		{"¹Ú¾üÍÅÌåÈü³¡£¨ËÎ·½£©", self.Wldh_EnterBattleMap, self, 1, 2},
		{"ËÄÇ¿ÍÅÌåÈü³¡£¨½ğÒ»£©", self.Wldh_EnterBattleMap, self, 1, 1},
		{"ËÄÇ¿ÍÅÌåÈü³¡£¨ËÎÒ»£©", self.Wldh_EnterBattleMap, self, 1, 2},
		{"ËÄÇ¿ÍÅÌåÈü³¡£¨½ğ¶ş£©", self.Wldh_EnterBattleMap, self, 2, 1},
		{"ËÄÇ¿ÍÅÌåÈü³¡£¨ËÎ¶ş£©", self.Wldh_EnterBattleMap, self, 2, 2},
		{"·µ»ØÉÏ²ã", self.LookWldh, self},
		{"½áÊø¶Ô»°"},		
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbGMCard:Wldh_EnterBattleMap(nAreaId, nCamp)
	local tbMap = {
		[1] = 1631,
		[2] = 1632,
	};
	local tbPos = {
		[1] = {1767, 2977},
		[2] = {1547, 3512},
	};	
	local nMapId = tbMap[nAreaId];
	
	me.NewWorld(nMapId, unpack(tbPos[nCamp]));
end

function tbGMCard:Wldh_SelectFaction()
	local szMsg = "ÇëÑ¡ÔñÄãÏëÒª¹ÛÕ½µÄÃÅÅÉ£¿";
	local tbOpt = {};
	for i=1, 12  do
		table.insert(tbOpt, {Player:GetFactionRouteName(i).."¾öÈü", self.Wldh_SelectVsState, self, 1, i});
	end

	table.insert(tbOpt, {"·µ»ØÉÏ²ã", self.LookWldh, self});
	table.insert(tbOpt, {"ÎÒÔÙ¿¼ÂÇ¿¼ÂÇ"});
	Dialog:Say(szMsg, tbOpt);	
end

function tbGMCard:Wldh_SelectVsState(nType, nReadyId)
	local szMsg = "ÇëÑ¡ÔñÄãÏëÒª¹ÛÕ½µÄÈüÊÂ£¿";
	local tbOpt = {
		{"¹Ú¾üÈü³¡", self.Wldh_SelectPkMap, self, nType, nReadyId, 1},
		{"ËÄÇ¿Èü³¡", self.Wldh_SelectPkMap, self, nType, nReadyId, 2},
		{"°ËÇ¿Èü³¡", self.Wldh_SelectPkMap, self, nType, nReadyId, 4},
		{"Ê®ÁùÇ¿Èü³¡", self.Wldh_SelectPkMap, self, nType, nReadyId, 8},
		{"ÈıÊ®¶şÇ¿Èü³¡", self.Wldh_SelectPkMap, self, nType, nReadyId, 16},
		{"·µ»ØÉÏ²ã", self.LookWldh, self},
		{"½áÊø¶Ô»°"},
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbGMCard:Wldh_SelectPkMap(nType, nReadyId, nMapCount)
	local szMsg = "ÇëÑ¡ÔñÄãÏëÒª¹ÛÕ½µÄÈü³¡£¿";
	local tbOpt = {};
	for i=1, nMapCount do
		local szSelect = string.format("Èü³¡£¨%s£©", i);
		table.insert(tbOpt, {szSelect, self.Wldh_EnterPkMap, self, nType, nReadyId, i});
	end
	table.insert(tbOpt, {"·µ»ØÉÏ²ã", self.LookWldh, self});
	table.insert(tbOpt, {"ÎÒÔÙ¿¼ÂÇ¿¼ÂÇ"});	
	Dialog:Say(szMsg, tbOpt);	
end

function tbGMCard:Wldh_EnterPkMap(nType, nReadyId, nAearId)
	local nMapId = Wldh:GetMapMacthTable(nType)[nReadyId];
	local nPosX, nPosY = unpack(Wldh:GetMapPKPosTable(nType)[nAearId]);
	me.NewWorld(nMapId, nPosX, nPosY);
end

function tbGMCard:EnterGlobalServer()
	local nGateWay = Transfer:GetTransferGateway();
	if nGateWay <= 0  then
		nGateWay = tonumber(string.sub(GetGatewayName(), 5, 8));
		me.SetTask(Transfer.tbServerTaskId[1], Transfer.tbServerTaskId[2], nGateWay);
	end
	local nMapId = Wldh.Battle.tbLeagueName[nGateWay] and Wldh.Battle.tbLeagueName[nGateWay][2];
	if not nMapId then
		Dialog:Say("ÄãËùÔÚµÄÇø·ş²»ÔÊĞí½øÈëÓ¢ĞÛµº¡£");
		return 0;
	end
	local nCanSure = Map:CheckGlobalPlayerCount(nMapId);
	if nCanSure < 0 then
		me.Msg("Ç°·½µÀÂ·²»Í¨¡£");
		return 0;
	end
	if nCanSure == 0 then
		me.Msg("ÎäÁÖ´ó»á³¡µØÈËÊıÒÑÂú£¬ÇëÉÔºóÔÙ³¢ÊÔ¡£");
		return 0;
	end
	me.GlobalTransfer(nMapId, 1648, 3377);
end

function tbGMCard:ReturnGlobalServer()
	local nGateWay = Transfer:GetTransferGateway();
	if not Wldh.Battle.tbLeagueName[nGateWay] then
		me.NewWorld(1609, 1680, 3269);
		return 0;
	end
	local nMapId = Wldh.Battle.tbLeagueName[nGateWay][2];
	if nMapId then
		me.NewWorld(nMapId, 1680, 3269);
		return 0;
	end
	me.NewWorld(1609, 1680, 3269);
end
