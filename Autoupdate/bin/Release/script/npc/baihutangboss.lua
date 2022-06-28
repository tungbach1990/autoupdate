
local tbChuangTangzeiBoss = Npc:GetClass("chuangtangzeiboss");
tbChuangTangzeiBoss.nNpcId = 2661;
tbChuangTangzeiBoss.tbPos 	= {nX = 50496, nY = 100672};
tbChuangTangzeiBoss.NLASTMAPID = 232;
tbChuangTangzeiBoss.FILE = "\\setting\\npc\\droprate\\baihutang\\"

local tbChuangTangzeiBossAdv = Npc:GetClass("chuangtangzeiboss_adv");
tbChuangTangzeiBossAdv.nNpcId = 2663;
tbChuangTangzeiBossAdv.tbPos = {nX = 50496, nY = 100672};
tbChuangTangzeiBossAdv.NLASTMAPID = 240;
tbChuangTangzeiBossAdv.FILE = "\\setting\\npc\\droprate\\baihutang\\"

local tbChuangTangzeiBossAdv2 = Npc:GetClass("chuangtangzeiboss_adv2");
tbChuangTangzeiBossAdv2.nNpcId = 3684;
tbChuangTangzeiBossAdv2.tbPos = {nX = 50496, nY = 100672};
tbChuangTangzeiBossAdv2.NLASTMAPID = 828;
tbChuangTangzeiBossAdv2.FILE = "\\setting\\npc\\droprate\\baihutang\\"


local tbChuangTangzei = Npc:GetClass("chuangtangzei");

function tbChuangTangzeiBoss:OnDeath(pNpcKiller)
	local szBoss = "";
	local szNote = "";	
	local nMapId = him.nMapId;
	
	local tbPlayer, nCount = KPlayer.GetMapPlayer(nMapId);
	local pPlayerKiller = pNpcKiller.GetPlayer();
	local nOffer = 0;
	local nPrestige = 0;
	local nFloor  = BaiHuTang:GetFloor(nMapId);
	local nStockBaseCount = 0; -- 股份基数
	local nLevel = 0;	
	local szFile = "";
	if (nFloor == 1) then
		nStockBaseCount = 30; -- 杀死一层boss加30点股份基数	
		nLevel = 1;
		nOffer = 10;
		nPrestige = 2;	
		szBoss = "Thủ Lĩnh Sấm Đường Tặc";
		szNote = "Lối vào Bạch Hổ Đường 2";
		szFile = self.FILE.."boss_1.txt";
	elseif (nFloor == 2) then
		nStockBaseCount = 60; -- 杀死二层boss加60点股份基数			
		nLevel = 2;
		nOffer = 20;
		nPrestige = 3;
		szBoss = "Thủ Lĩnh Thiết Đồ Tặc";
		szNote	= "Lối vào Bạch Hổ Đường 3";
		szFile = self.FILE.."boss_2.txt";
	elseif (nFloor == 3) then
		nStockBaseCount = 100; -- 杀死三层boss加100点股份基数		
		nLevel = 3;
		nOffer = 30;
		nPrestige = 4;
		szBoss = "Hộ Đồ Sứ";
		szNote	= "Lối ra Bạch Hổ Đường";
		szFile = self.FILE.."boss_3.txt";
	end
	
	local nRate = 1;
	if TimeFrame:GetStateGS("OpenOneAdvBaiHuTang") == 1 then
		nPrestige = math.floor(nPrestige / 2);
		nRate = 0.5
	end

	if (nMapId ~= BaiHuTang.ChuJi or nMapId ~= BaiHuTang.ChuJi2) then
		local pNpc = KNpc.Add2(2525, 1, -1, nMapId, 1628, 3104);  -- 点起一束光
		pNpc.szName	= szNote;
		BaiHuTang.tbIsOpen[nMapId] = 1;
	end	
	
	if not pPlayerKiller then
		return 0;
	end
	
	local nTeamCount = 0;	
	local nTeamId = pPlayerKiller.nTeamId;
	if (nCount > 0 and pPlayerKiller) then
		local szMsg = "";
		if (nMapId== 232 or nMapId == 281 or nMapId == 340) then --最后一层
			szMsg = "Lối ra Bạch Hổ Đường đã mở!";
		else
			szMsg = "Lối vào tầng 1 đã mở!";
		end
		szMsg = "["..pNpcKiller.szName .. "] đã giết chết " ..szBoss .. ", " .. szMsg;
		KDialog.Msg2PlayerList(tbPlayer, szMsg, "Hệ thống nhắc nhở");
		
		pPlayerKiller.SendMsgToFriend("Hảo hữu của bạn [".. pPlayerKiller.szName.."] đã giết chết Bạch Hổ Đường - " ..szBoss..".");
		Player:SendMsgToKinOrTong(pPlayerKiller, " đã giết chết Bạch Hổ Đường - " ..szBoss..".", 0);
		
		if nTeamId == 0 then -- 如果没队
			pPlayerKiller.AddOfferEntry(nOffer, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	-- 杀死一层boss加10点贡献度
			pPlayerKiller.AddKinReputeEntry(nPrestige, "baihutang");
			Tong:AddStockBaseCount_GS1(pPlayerKiller.nId, nStockBaseCount, 0.7, 0.2, 0.1, 0, 0, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	
		end
		for _, pMapPlayer in ipairs(tbPlayer) do
			if (pMapPlayer.nTeamId ~= 0) then
				local nFavor = 10;
				if (nTeamId == pMapPlayer.nTeamId) then -- 如果是杀死boss的队伍
					nFavor = 15;
					pMapPlayer.AddOfferEntry(nOffer, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	-- 杀死一层boss加10点贡献度
					pMapPlayer.AddKinReputeEntry(nPrestige, "baihutang");
					Tong:AddStockBaseCount_GS1(pMapPlayer.nId, nStockBaseCount, 0.7, 0.2, 0.1, 0, 0, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	-- 加股份
					nTeamCount = nTeamCount + 1; -- 统计在场人数
				end
				BaiHuTang:AddFriendFavor(pMapPlayer, tbPlayer, nFavor);
			end	
			
		end
	end
	if nTeamId ~= 0 and BaiHuTang.HONOR[nLevel] and BaiHuTang.HONOR[nLevel][nTeamCount] then
		local tbMember = KTeam.GetTeamMemberList(nTeamId);
		PlayerHonor:AddPlayerHonorById_GS(tbMember[1], PlayerHonor.HONOR_CLASS_LINGXIU, 0, BaiHuTang.HONOR[nLevel][nTeamCount] * nRate);
	end
	
	Dbg:WriteLogEx(Dbg.LOG_INFO, "Bạch Hổ Đường", pNpcKiller.szName .." đã giết chết "..szBoss);	--记录是谁杀死的
	local nIndx = SubWorldID2Idx(nMapId);
	if nIndx < 0 then
		assert(false);
		return;
	end

	if (nMapId == tbChuangTangzeiBoss.NLASTMAPID)then --初级最后一个场
		pPlayerKiller.Msg("Chúc mừng bạn đã chinh phục Bạch Hổ Đường thành công!");
	end

	local nNpcMapId, nNpcPosX, nNpcPosY = him.GetWorldPos();
	KItem.AddItemInPos(nNpcMapId,nNpcPosX,nNpcPosY,18,1,99,1);
	for i = 1, BaiHuTang.nTimes - 1 do 		
		pPlayerKiller.DropRateItem(szFile,24,pPlayerKiller.nCurLucky, -1, him);
	end	
end

function tbChuangTangzeiBossAdv:OnDeath(pNpcKiller)
	local szBoss ="";
	local szNote	 = "";	
	local pPlayerKiller = pNpcKiller.GetPlayer();
	local nMapId = him.nMapId;
	local tbPlayer, nCount = KPlayer.GetMapPlayer(nMapId);
	local nOffer = 0;
	local nPrestige = 0;
	local nFloor = BaiHuTang:GetFloor(nMapId);
	local nStockBaseCount = 0; -- 股份基数
	local nLevel = 0;	
	local szFile = "";
	if (nFloor == 1) then
		nStockBaseCount = 30; -- 杀死一层boss加10点股份基数
		nLevel = 1;
		nOffer = 10;
		nPrestige = 2;
		szBoss = "Thủ Lĩnh Sấm Đường Tặc";
		szNote = "Lối vào Bạch Hổ Đường 2";
		szFile = self.FILE.."boss_4.txt";
	elseif (nFloor == 2) then
		nStockBaseCount = 60; -- 杀死二层boss加20点股份基数
		nLevel = 2;
		nOffer = 20;
		nPrestige = 3;
		szBoss = "Thủ Lĩnh Thiết Đồ Tặc";
		szNote	= "Lối vào Bạch Hổ Đường 3";
		szFile = self.FILE.."boss_5.txt";
	elseif (nFloor == 3) then
		nStockBaseCount = 100; -- 杀死三层boss加30点股份基数
		nLevel = 3;
		nOffer = 30;
		nPrestige = 4;
		szBoss = "Hộ Đồ Sứ";
		szNote	= "Lối ra Bạch Hổ Đường";
		szFile = self.FILE.."boss_6.txt";
	end

	if (nMapId ~= BaiHuTang.GaoJi) then
		local pNpc	= KNpc.Add2(2525, 1, -1, nMapId, 1628, 3104);  -- 点起一束光
		pNpc.szName	= szNote;
		BaiHuTang.tbIsOpen[nMapId] = 1;
	end

	if not pPlayerKiller then
		return 0;
	end
	
	local nTeamCount = 0;
	local nTeamId = pPlayerKiller.nTeamId;
	if (nCount > 0 and pPlayerKiller) then
		local szMsg = "";
		if (nMapId == tbChuangTangzeiBossAdv.NLASTMAPID) then --最后一层
			szMsg = "Lối ra Bạch Hổ Đường đã mở!";
		else
			szMsg = "Lối vào tầng 1 đã mở!";
		end
		szMsg = "["..pNpcKiller.szName .. "] đã giết chết " ..szBoss ..", " .. szMsg;
		KDialog.Msg2PlayerList(tbPlayer, szMsg, "Hệ thống nhắc nhở");
		
		pPlayerKiller.SendMsgToFriend("Hảo hữu của bạn [".. pPlayerKiller.szName.."] đã giết chết Bạch Hổ Đường - " ..szBoss..".");
		Player:SendMsgToKinOrTong(pPlayerKiller, " đã giết chết Bạch Hổ Đường - " ..szBoss..".", 0);
		
		if nTeamId == 0 then -- 如果没队
			pPlayerKiller.AddOfferEntry(nOffer, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	-- 杀死一层boss加10点贡献度
			pPlayerKiller.AddKinReputeEntry(nPrestige, "baihutang");	
			Tong:AddStockBaseCount_GS1(pPlayerKiller.nId, nStockBaseCount, 0.7, 0.2, 0.1, 0, 0, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);
		end
		for _, pMapPlayer in ipairs(tbPlayer) do
			if (pMapPlayer.nTeamId ~= 0) then
				local nFavor = 10;
				if (nTeamId == pMapPlayer.nTeamId) then -- 如果是杀死boss的队伍
					nFavor = 15;
					pMapPlayer.AddOfferEntry(nOffer, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	-- 杀死一层boss加10点贡献度
					pMapPlayer.AddKinReputeEntry(nPrestige, "baihutang");
					Tong:AddStockBaseCount_GS1(pMapPlayer.nId, nStockBaseCount, 0.7, 0.2, 0.1, 0, 0, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	-- 加股份
					nTeamCount = nTeamCount + 1; -- 统计在场人数
				end
				BaiHuTang:AddFriendFavor(pMapPlayer, tbPlayer, nFavor);
			end			
		end
	end
	if nTeamId ~= 0 and BaiHuTang.HONOR[nLevel] and BaiHuTang.HONOR[nLevel][nTeamCount] then
		local tbMember = KTeam.GetTeamMemberList(nTeamId);
		PlayerHonor:AddPlayerHonorById_GS(tbMember[1], PlayerHonor.HONOR_CLASS_LINGXIU, 0, BaiHuTang.HONOR[nLevel][nTeamCount]);
	end
	Dbg:WriteLogEx(Dbg.LOG_INFO, "Bạch Hổ Đường", pNpcKiller.szName .." đã giết chết "..szBoss);	--记录是谁杀死的
	local nIndx = SubWorldID2Idx(nMapId);
	if nIndx < 0 then
		assert(false);
		return;
	end

	if (pPlayerKiller.nMapId == tbChuangTangzeiBossAdv.NLASTMAPID)then --高级最后一场
		BaiHuTang:BroadcastMsg(6, BaiHuTang.GaoJi);
	end
	
	local nNpcMapId, nNpcPosX, nNpcPosY = him.GetWorldPos();
	KItem.AddItemInPos(nNpcMapId,nNpcPosX,nNpcPosY,18,1,99,1);
	for i = 1, BaiHuTang.nTimes - 1 do 
		pPlayerKiller.DropRateItem(szFile,24,pPlayerKiller.nCurLucky, -1, him);
	end	
end


function tbChuangTangzeiBossAdv2:OnDeath(pNpcKiller)
	local szBoss ="";
	local szNote	 = "";	
	local pPlayerKiller = pNpcKiller.GetPlayer();
	local nMapId = him.nMapId;
	local tbPlayer, nCount = KPlayer.GetMapPlayer(nMapId);
	local nOffer = 0;
	local nPrestige = 0;
	local nFloor = BaiHuTang:GetFloor(nMapId);
	local nStockBaseCount = 0; -- 股份基数
	local nLevel = 0;	
	local szFile = "";
	if (nFloor == 1) then
		nStockBaseCount = 30; -- 杀死一层boss加10点股份基数
		nLevel = 1;
		nOffer = 10;
		nPrestige = 2;
		szBoss = "Thủ Lĩnh Sấm Đường Tặc";
		szNote = "Lối vào Bạch Hổ Đường 2";
		szFile = self.FILE.."boss_7.txt";
	elseif (nFloor == 2) then
		nStockBaseCount = 60; -- 杀死二层boss加20点股份基数
		nLevel = 2;
		nOffer = 20;
		nPrestige = 3;
		szBoss = "Thủ Lĩnh Thiết Đồ Tặc";
		szNote	= "Lối vào Bạch Hổ Đường 3";
		szFile = self.FILE.."boss_8.txt";
	elseif (nFloor == 3) then
		nStockBaseCount = 100; -- 杀死三层boss加30点股份基数
		nLevel = 3;
		nOffer = 30;
		nPrestige = 4;
		szBoss = "Hộ Đồ Sứ";
		szNote	= "Lối ra Bạch Hổ Đường";
		szFile = self.FILE.."boss_9.txt";
	end

	if (nMapId ~= BaiHuTang.Goldlen) then
		local pNpc	= KNpc.Add2(2525, 1, -1, nMapId, 1628, 3104);  -- 点起一束光
		pNpc.szName	= szNote;
		BaiHuTang.tbIsOpen[nMapId] = 1;
	end

	if not pPlayerKiller then
		return 0;
	end
	
	local nTeamCount = 0;
	local nTeamId = pPlayerKiller.nTeamId;
	if (nCount > 0 and pPlayerKiller) then
		local szMsg = "";
		if (nMapId == self.NLASTMAPID) then --最后一层
			szMsg = "Lối ra Bạch Hổ Đường đã mở!";
		else
			szMsg = "Lối vào tầng 1 đã mở!";
		end
		szMsg = "["..pNpcKiller.szName .. "] đã giết chết " ..szBoss ..", " .. szMsg;
		KDialog.Msg2PlayerList(tbPlayer, szMsg, "Hệ thống nhắc nhở");
		
		pPlayerKiller.SendMsgToFriend("Hảo hữu của bạn [".. pPlayerKiller.szName.."] đã giết chết Bạch Hổ Đường - " ..szBoss..".");
		Player:SendMsgToKinOrTong(pPlayerKiller, " đã giết chết Bạch Hổ Đường - " ..szBoss..".", 0);
		
		if nTeamId == 0 then -- 如果没队
			pPlayerKiller.AddOfferEntry(nOffer, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	-- 杀死一层boss加10点贡献度
			pPlayerKiller.AddKinReputeEntry(nPrestige, "baihutang");	
			Tong:AddStockBaseCount_GS1(pPlayerKiller.nId, nStockBaseCount, 0.7, 0.2, 0.1, 0, 0, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);
		end
		for _, pMapPlayer in ipairs(tbPlayer) do
			if (pMapPlayer.nTeamId ~= 0) then
				local nFavor = 10;
				if (nTeamId == pMapPlayer.nTeamId) then -- 如果是杀死boss的队伍
					nFavor = 15;
					pMapPlayer.AddOfferEntry(nOffer, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	-- 杀死一层boss加10点贡献度
					pMapPlayer.AddKinReputeEntry(nPrestige, "baihutang");
					Tong:AddStockBaseCount_GS1(pMapPlayer.nId, nStockBaseCount, 0.7, 0.2, 0.1, 0, 0, WeeklyTask.GETOFFER_TYPE_BAIHUTANG);	-- 加股份
					nTeamCount = nTeamCount + 1; -- 统计在场人数
				end
				BaiHuTang:AddFriendFavor(pMapPlayer, tbPlayer, nFavor);
			end			
		end
	end
	if nTeamId ~= 0 and BaiHuTang.HONOR[nLevel] and BaiHuTang.HONOR[nLevel][nTeamCount] then
		local tbMember = KTeam.GetTeamMemberList(nTeamId);
		PlayerHonor:AddPlayerHonorById_GS(tbMember[1], PlayerHonor.HONOR_CLASS_LINGXIU, 0, BaiHuTang.HONOR[nLevel][nTeamCount]);
	end
	Dbg:WriteLogEx(Dbg.LOG_INFO, "Bạch Hổ Đường", pNpcKiller.szName .." đã giết chết "..szBoss);	--记录是谁杀死的
	local nIndx = SubWorldID2Idx(nMapId);
	if nIndx < 0 then
		assert(false);
		return;
	end

	if (pPlayerKiller.nMapId == self.NLASTMAPID)then --高级最后一场
		BaiHuTang:BroadcastMsg(6, BaiHuTang.Goldlen);
	end
	
	local nNpcMapId, nNpcPosX, nNpcPosY = him.GetWorldPos();
	KItem.AddItemInPos(nNpcMapId,nNpcPosX,nNpcPosY,18,1,99,1);
	for i = 1, BaiHuTang.nTimes - 1 do 
		pPlayerKiller.DropRateItem(szFile,24,pPlayerKiller.nCurLucky, -1, him);
	end	
end


function tbChuangTangzei:OnDeath(pNpcKiller)
	local pPlayer = pNpcKiller.GetPlayer();
	local nMapId = him.nMapId;
	local nFloor = BaiHuTang:GetFloor(nMapId);
	
	Merchant:TryGiveToken_Baihu(pPlayer, nFloor);
end
