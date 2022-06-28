-- GM专用卡

local tbAdminCard	= Item:GetClass("admincard");

tbAdminCard.MAX_RECENTPLAYER	= 15;


function tbAdminCard:OnUse()
	local nIsHide	= GM.tbGMRole:IsHide();
	
	local tbOpt = {
		{"Thưởng Top", self.Thuongtop, self},
		{"Rương Mảnh Ghép", self.ManhGhep, self},
		{"Lấy đồ khóa", self.Testdo, self},
		{"Nạp đồng", self.AskRoleName1, self},
		{"Chức năng Admin", self.OnDialog_Admin, self},
		{"Chức năng GM", self.OnDialog_GM, self},
		{"Tẩy Tủy", self.OnDialog_taytuy, self},
		{"Đến Đảo Tẩy Tủy", self.OnDialog_gotaytuy, self},
		{"Ta chưa cần"},
	};
	
	Dialog:Say("\n  Các bạn vất vã rồi!<pic=28>\n\n     Vì nhân dân phục vụ<pic=98><pic=98><pic=98>", tbOpt);
	
	return 0;
end;

tbAdminCard.tbItemInfo = {
        bForceBind=1,
};
function tbAdminCard:Thuongtop()
me.AddStackItem(18,1,920,1,self.tbItemInfo,100);
end

function tbAdminCard:ManhGhep()
	for i=1,400 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,1177,1);
		else
			break
		end
	end
	end

function tbAdminCard:Testdo()
	local pItem = me.AddItem(1,12,20001,4);
	pItem.Bind(1);
	--me.SetItemTimeout(pItem, 30*24*60, 0);
end

function tbAdminCard:AskRoleName1()
Dialog:AskString("Tên nhân vật", 16, self.OnInputRoleName1, self);
end
function tbAdminCard:OnInputRoleName1(szRoleName)
local nPlayerId = KGCPlayer.GetPlayerIdByName(szRoleName);
if (not nPlayerId) then
Dialog:Say("Tên này không tồn tại!", {"Nhập lại", self.AskRoleName1, self}, {"Kết thúc đối thoại"});
return 0;
end

self:ViewPlayer2(nPlayerId);
end

--------------
function tbAdminCard:ViewPlayer2(nPlayerId)
local szMsg = "Ta có thể giúp gì cho ngươi";
local tbOpt = {
{"Nạp Đồng Thường", self.Napdong, self, nPlayerId },
{"Nạp Đồng Khóa", self.Napdong1, self, nPlayerId },
{"Nạp Bạc Thường", self.Napdong2, self, nPlayerId },
{"Nạp Bạc Khóa", self.Napdong3, self, nPlayerId },
{"Kết thúc đối thoại"},
};
Dialog:Say(szMsg, tbOpt);
end

function tbAdminCard:Napdong(nPlayerId)
    Dialog:AskNumber("Nhập số đồng thường .", 2000000000, self.ConSo, self,nPlayerId);--Nhập số đồng muốn nạp cho người chơi

end
function tbAdminCard:ConSo(nPlayerId,szSoDong)
    local pPlayer    = KPlayer.GetPlayerObjById(nPlayerId);
pPlayer.AddJbCoin(szSoDong);
end

function tbAdminCard:Napdong1(nPlayerId)
    Dialog:AskNumber("Nhập số đồng khóa.", 2000000000, self.ConSo1, self,nPlayerId);--Nhập số đồng muốn nạp cho người chơi

end
function tbAdminCard:ConSo1(nPlayerId,szSoDong)
    local pPlayer    = KPlayer.GetPlayerObjById(nPlayerId);
pPlayer.AddBindCoin(szSoDong);
end

function tbAdminCard:Napdong2(nPlayerId)
    Dialog:AskNumber("Nhập số bạc thường .", 2000000000, self.ConSo2, self,nPlayerId);--Nhập số đồng muốn nạp cho người chơi

end
function tbAdminCard:ConSo2(nPlayerId,szSoDong)
    local pPlayer    = KPlayer.GetPlayerObjById(nPlayerId);
pPlayer.Earn(szSoDong,0);
end

function tbAdminCard:Napdong3(nPlayerId)
    Dialog:AskNumber("Nhập số bạc khóa .", 2000000000, self.ConSo3, self,nPlayerId);--Nhập số đồng muốn nạp cho người chơi

end
function tbAdminCard:ConSo3(nPlayerId,szSoDong)
    local pPlayer    = KPlayer.GetPlayerObjById(nPlayerId);
pPlayer.AddBindMoney(szSoDong);
end

function tbAdminCard:OnDialog_gotaytuy()
	me.NewWorld(255, 6560, 6624);
end
function tbAdminCard:Tuluyen()
	me.AddXiuWeiTime(10000000);
end
function tbAdminCard:OnDialog_GM()
	local nIsHide	= GM.tbGMRole:IsHide();
	
	local tbOpt = {
		
		{(nIsHide == 1 and "Hủy ẩn thân") or "Bắt đầu ẩn thân", "GM.tbGMRole:SetHide", 1 - nIsHide},
		{"Nhập tên nhân vật", self.AskRoleName, self},
		{"Người chơi bên cạnh", self.AroundPlayer, self},
		{"Thao tác gần đây", self.RecentPlayer, self},
		{"Tự điều chỉnh cấp", self.AdjustLevel, self},
		{"Reload Script", self.Reload, self},
		{"<color=yellow>Phóng viên thi đấu liên server<color>", self.LookWldh, self},
		{"<color=yellow>Hoàng Lăng không giới hạn<color>", self.SuperQinling, self},
		{"Ta chưa cần"},
	};
	
	Dialog:Say("\n  Các bạn vất vả rồi!<pic=28>\n\n     Vì nhân dân phục vụ<pic=98><pic=98><pic=98>", tbOpt);
	
	return 0;
end;
function tbAdminCard:SuperQinling()
	me.NewWorld(1536, 1567, 3629);
	me.SetTask(2098, 1, 0);
	me.AddSkillState(1413, 4, 1, 2 * 60 * 60 * Env.GAME_FPS, 1, 1);
end

function tbAdminCard:Reload()
	local nRet1	= DoScript("\\script\\item\\class\\gmcard.lua");
	local nRet2	= DoScript("\\script\\misc\\gm_role.lua");
	GCExcute({"DoScript", "\\script\\misc\\gm_role.lua"});
	local szMsg	= "Reloaded!!("..nRet1..","..nRet2..GetLocalDate(") %Y-%m-%d %H:%M:%S");
	me.Msg(szMsg);
	print(szMsg);
end

function tbAdminCard:AskRoleName()
	Dialog:AskString("Tên nhân vật", 16, self.OnInputRoleName, self);
end

function tbAdminCard:OnInputRoleName(szRoleName)
	local nPlayerId	= KGCPlayer.GetPlayerIdByName(szRoleName);
	if (not nPlayerId) then
		Dialog:Say("Tên này không tồn tại!", {"Nhập lại", self.AskRoleName, self}, {"Kết thúc đối thoại"});
		return;
	end
	
	self:ViewPlayer(nPlayerId);
end

function tbAdminCard:ViewPlayer(nPlayerId)
	-- 插入最近玩家列表
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
		[0]		= "Không online",
		[-1]	= "Đang xử lý",
		[-2]	= "Auto?",
	};
	local nState	= KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_ONLINESERVER);
	local tbText	= {
		{"Tên: ", szName},
		{"Tài khoản: " , tbInfo.szAccount},
		{"Cấp: " , tbInfo.nLevel},
		{"Giới tính: ", (tbInfo.nSex == 1 and "Nữ") or "Nam"},
		{"Hệ phái: ", Player:GetFactionRouteName(tbInfo.nFaction, tbInfo.nRoute)},
		{"Tộc: ", tbInfo.szKinName},
		{"Bang hội: ", tbInfo.szTongName},
		{"Uy danh: ", KGCPlayer.GetPlayerPrestige(nPlayerId)},
		{"Trạng thái: ", (tbState[nState] or "<color=green>Trên mạng<color>") .. "("..nState..")"},
	}
	local szMsg	= "";
	for _, tb in ipairs(tbText) do
		szMsg	= szMsg .. "\n  " .. Lib:StrFillL(tb[1], 6) .. tostring(tb[2]);
	end
	local szButtonColor	= (nState > 0 and "") or "<color=gray>";
	local tbOpt = {
		{szButtonColor.."Kéo hắn qua đây", "GM.tbGMRole:CallHimHere", nPlayerId},
		{szButtonColor.."Đưa ta đi", "GM.tbGMRole:SendMeThere", nPlayerId},
		{szButtonColor.."Cho hắn rớt mạng", "GM.tbGMRole:KickHim", nPlayerId},
		{"Đưa vào thiên lao", "GM.tbGMRole:ArrestHim", nPlayerId},
		{"Thoát khỏi thiên lao", "GM.tbGMRole:FreeHim", nPlayerId},
		{"Gửi thư", self.SendMail, self, nPlayerId},
		{"Kết thúc đối thoại"},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbAdminCard:RecentPlayer()
	local tbOpt	= {};
	for nIndex, nPlayerId in ipairs(self.tbRecentPlayerList or {}) do
		local szName	= KGCPlayer.GetPlayerName(nPlayerId);
		local nState	= KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_ONLINESERVER);
		tbOpt[#tbOpt+1]	= {((nState > 0 and "<color=green>") or "")..szName, self.ViewPlayer, self, nPlayerId};
	end
	tbOpt[#tbOpt + 1]	= {"Kết thúc đối thoại"};
	
	Dialog:Say("Người chơi cần chọn: ", tbOpt);
end

function tbAdminCard:AroundPlayer()
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
	tbOpt[#tbOpt + 1]	= {"Kết thúc đối thoại"};
	
	Dialog:Say("Người chơi cần chọn: ", tbOpt);
end

function tbAdminCard:AdjustLevel()
	local nMaxLevel	= GM.tbGMRole:GetMaxAdjustLevel();
	Dialog:AskNumber("Đẳng cấp kỳ vọng (1-"..nMaxLevel..")", nMaxLevel, "GM.tbGMRole:AdjustLevel");
end

function tbAdminCard:SendMail(nPlayerId)
	Dialog:AskString("Nội dung thư", 500, "GM.tbGMRole:SendMail", nPlayerId);
end

function tbAdminCard:LookWldh()
	if not GLOBAL_AGENT then
		local szMsg = "Lối vào cho phóng viên thi đấu liên server <pic=98><pic=98><pic=98>";
		local tbOpt = {
			{"Vào Đảo Anh Hùng", self.EnterGlobalServer, self},
			{"Xin đợi"}};
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	local szMsg = "Lối vào cho phóng viên thi đấu liên server <pic=98><pic=98><pic=98>";
	local tbOpt = {
			{"Đến chiến trường liên server", self.ReturnGlobalServer, self},
			{"Quay lại server của tôi", self.ReturnMyServer, self},
			{"Xem trận chung kết Đơn đấu", self.Wldh_SelectFaction, self},
			{"Xem trận chung kết Song đấu", self.Wldh_SelectVsState, self, 2, 1},
			{"Xem trận chung kết Tam đấu", self.Wldh_SelectVsState, self, 3, 1},
			{"Xem trận chung kết Ngũ đấu", self.Wldh_SelectVsState, self, 4, 1},
			{"Xem trận chung kết Đoàn thể đấu", self.Wldh_SelectBattleVsState, self},
			{"Xin đợi"},
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbAdminCard:ReturnMyServer()
	me.GlobalTransfer(29, 1694, 4037);
end

function tbAdminCard:Wldh_SelectBattleVsState()
	local szMsg = "";
	local tbOpt = {
		{"Đấu trường đoàn thể hạng 1 (Kim)", self.Wldh_EnterBattleMap, self, 1, 1},
		{"Đấu trường đoàn thể hạng 1 (Tống)", self.Wldh_EnterBattleMap, self, 1, 2},
		{"Đấu trường đoàn thể tứ kết (Kim 1)", self.Wldh_EnterBattleMap, self, 1, 1},
		{"Đấu trường đoàn thể tứ kết (Tống 1)", self.Wldh_EnterBattleMap, self, 1, 2},
		{"Đấu trường đoàn thể tứ kết (Kim 2)", self.Wldh_EnterBattleMap, self, 2, 1},
		{"Đấu trường đoàn thể tứ kết (Tống 2)", self.Wldh_EnterBattleMap, self, 2, 2},
		{"Quay lại", self.LookWldh, self},
		{"Kết thúc đối thoại"},		
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbAdminCard:Wldh_EnterBattleMap(nAreaId, nCamp)
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

function tbAdminCard:Wldh_SelectFaction()
	local szMsg = "Chọn môn phái muốn xem?";
	local tbOpt = {};
	for i=1, 12  do
		table.insert(tbOpt, {Player:GetFactionRouteName(i).."Chung kết", self.Wldh_SelectVsState, self, 1, i});
	end

	table.insert(tbOpt, {"Quay lại", self.LookWldh, self});
	table.insert(tbOpt, {"Để ta suy nghĩ"});
	Dialog:Say(szMsg, tbOpt);	
end

function tbAdminCard:Wldh_SelectVsState(nType, nReadyId)
	local szMsg = "Chọn hạng mục muốn xem?";
	local tbOpt = {
		{"Đấu trường hạng 1", self.Wldh_SelectPkMap, self, nType, nReadyId, 1},
		{"Đấu trường tứ kết", self.Wldh_SelectPkMap, self, nType, nReadyId, 2},
		{"Đấu trường top 8", self.Wldh_SelectPkMap, self, nType, nReadyId, 4},
		{"Đấu trường top 16", self.Wldh_SelectPkMap, self, nType, nReadyId, 8},
		{"Đấu trường top 32", self.Wldh_SelectPkMap, self, nType, nReadyId, 16},
		{"Quay lại", self.LookWldh, self},
		{"Kết thúc đối thoại"},
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbAdminCard:Wldh_SelectPkMap(nType, nReadyId, nMapCount)
	local szMsg = "Chọn đấu trường muốn xem?";
	local tbOpt = {};
	for i=1, nMapCount do
		local szSelect = string.format("Đấu trường (%s)", i);
		table.insert(tbOpt, {szSelect, self.Wldh_EnterPkMap, self, nType, nReadyId, i});
	end
	table.insert(tbOpt, {"Quay lại", self.LookWldh, self});
	table.insert(tbOpt, {"Để ta suy nghĩ"});	
	Dialog:Say(szMsg, tbOpt);	
end

function tbAdminCard:Wldh_EnterPkMap(nType, nReadyId, nAearId)
	local nMapId = Wldh:GetMapMacthTable(nType)[nReadyId];
	local nPosX, nPosY = unpack(Wldh:GetMapPKPosTable(nType)[nAearId]);
	me.NewWorld(nMapId, nPosX, nPosY);
end

function tbAdminCard:EnterGlobalServer()
	local nGateWay = Transfer:GetTransferGateway();
	if nGateWay <= 0  then
		nGateWay = tonumber(string.sub(GetGatewayName(), 5, 8));
		me.SetTask(Transfer.tbServerTaskId[1], Transfer.tbServerTaskId[2], nGateWay);
	end
	local nMapId = Wldh.Battle.tbLeagueName[nGateWay] and Wldh.Battle.tbLeagueName[nGateWay][2];
	if not nMapId then
		Dialog:Say("你所在的区服不允许进入英雄岛。");
		return 0;
	end
	local nCanSure = Map:CheckGlobalPlayerCount(nMapId);
	if nCanSure < 0 then
		me.Msg("前方道路不通。");
		return 0;
	end
	if nCanSure == 0 then
		me.Msg("武林大会场地人数已满，请稍后再尝试。");
		return 0;
	end
	me.GlobalTransfer(nMapId, 1648, 3377);
end

function tbAdminCard:ReturnGlobalServer()
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
function tbAdminCard:OnDialog_Admin()
	if me.nLevel < 60 then
	me.AddFightSkill(163,60);	-- 60级梯云纵
	me.AddFightSkill(91,60);
	me.AddFightSkill(1417,5);
	me.AddItem(1,12,33,4);
	me.AddItem(21,9,1,1);
	me.AddItem(21,9,2,1);
	me.AddItem(21,9,3,1);
	end
	
	local szMsg = "Ta có thể giúp gì cho ngươi";
	local tbOpt = {
	{"Gọi boss", self.GoiBoss, self},
	{"Thông báo toàn server.",self.ThongBaoToanServer,self},
	{"Xếp hạng danh vọng",self.XepHangDanhVong,self},  
	{"Thêm các loại điểm",self.Point,self},
	{"Lấy vật phẩm hỗ trợ",self.Daocu,self},
	{"Lấy trang bị",self.Trangbi,self},
	{"Đạo cụ thêm" , self.Daocuhieubg, self},
	{"Danh Hiệu",self.Danhhieu,self},
	{"Thêm đồ",self.Themdochuacong,self},
	--{"Thêm đồ đã cộng",self.Themdodacong,self},
	
	{"Lệnh bài du long",self.Hotro1,self},
	{"Test skil",self.Skill,self},
	{"Kết thúc nhiệm vụ"},
	};
	Dialog:Say(szMsg, tbOpt);
	end

function tbAdminCard:Skill()

me.AddFightSkill(839,10);
me.AddFightSkill(820,10);
me.AddFightSkill(822,10);
me.AddFightSkill(824,10);
me.AddFightSkill(826,10);
me.AddFightSkill(828,10);
me.AddFightSkill(830,10);
me.AddFightSkill(832,10);
me.AddFightSkill(834,10);
me.AddFightSkill(836,10);
me.AddFightSkill(838,10);
me.AddFightSkill(840,10);
me.AddFightSkill(842,10);
me.AddFightSkill(844,10);
me.AddFightSkill(846,10);
me.AddFightSkill(848,10);
me.AddFightSkill(850,10);
me.AddFightSkill(852,10);
me.AddFightSkill(854,10);
me.AddFightSkill(856,10);
me.AddFightSkill(858,10);
me.AddFightSkill(860,10);
me.AddFightSkill(862,10);
me.AddFightSkill(864,10);
me.AddFightSkill(866,10);

end
	
function tbAdminCard:Hotro1()
		me.AddItem(18,1,529,1);
	me.AddItem(18,1,529,2);
	me.AddItem(18,1,529,3);
	me.AddItem(18,1,529,4);
	me.AddItem(18,1,529,5);
end

function tbAdminCard:Themdochuacong()
    Dialog:AskString("Nhập ID món đồ muốn lấy", 200, self.Mondochuacong, self);
end
function tbAdminCard:Mondochuacong(szText)
	me.AddItem({"GM.AddItem", szText});	
	--me.Msg("vao111");
	local here = 1;
	local rows = {};
	--me.Msg("vao");
	local itsat = 0;
	local tmp = szText;
	--me.Msg("tmp="..tmp);
	while itsat ~= nil do
		itsat = string.find(tmp,",",1);
		if itsat ~= nil then
			
			rows[#rows+1] = string.sub(tmp,1,itsat-1);
			
			tmp = string.sub(tmp,itsat+1);
			
		else
			rows[#rows+1] = tmp;
		end
	end
	
	me.AddItem(tonumber(rows[1]),tonumber(rows[2]),tonumber(rows[3]),tonumber(rows[4]));	
end
function tbAdminCard:Themdodacong()
    Dialog:AskString("Nhập ID món đồ muốn lấy", 200, self.Mondodacong, self);
end
function tbAdminCard:Mondodacong(szText)
me.AddGreenEquip(szText);
end

function tbAdminCard:XepHangDanhVong()
    GCExcute({"PlayerHonor:UpdateWuLinHonorLadder"});
    GCExcute({"PlayerHonor:UpdateMoneyHonorLadder"});
    GCExcute({"PlayerHonor:UpdateLeaderHonorLadder"});
    KGblTask.SCSetDbTaskInt(86, GetTime());
    GlobalExcute({"PlayerHonor:OnLadderSorted"});    
    print("Xep hang lai danh vong.");
end
function tbAdminCard:ThongBaoToanServer()

    Dialog:AskString("Nhập dữ liệu", 1000, self.ThongBao, self);
end

function tbAdminCard:ThongBao(msg)
    GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
end 

function tbAdminCard:GoiBoss()
	local szMsg = "Ta có thể giúp gì cho ngươi";
	local tbOpt = {
		{"<color=red>Hoả Kỳ Lân<color>",self.KyLan1,self},
		{"<color=blue>Lam Kỳ Lân<color>",self.KyLan2,self},
		{"<color=black>Hắc Kỳ Lân<color>",self.KyLan3,self},
		{"Nhu Tiểu Thúy",self.GoiBoss1,self},
		{"Trương Thiện Đức",self.GoiBoss2,self},
		{"Giả Dật Sơn",self.GoiBoss3,self},
		{"Ô Sơn Thanh",self.GoiBoss4,self},
		{"Trần Vô Mệnh",self.GoiBoss5,self},
		{"<color=red>Tần Thủy Hoàng<color>",self.GoiBoss6,self},
		{"Khiên Hồn Sứ",self.GoiBoss7,self},
		{"Đồ Tôn",self.GoiBoss8,self},
		{"Hiên Viên Thanh Thanh",self.GoiBoss9,self},
		{"Thái Sử Khang",self.GoiBoss10,self},
		{"Bạch Khởi",self.GoiBoss11,self},
		{"Thủ Lăng Cơ Quan Nhân",self.GoiBoss12,self},
		{"<color=red>Niên Thú<color>",self.GoiBoss13,self},
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------

function tbAdminCard:KyLan1()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(20005, 200, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Boss tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbAdminCard:KyLan2()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(20006, 200, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Boss tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbAdminCard:KyLan3()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
	KNpc.Add2(20007, 200, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Boss tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbAdminCard:GoiBoss1()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2421 , 1,95, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbAdminCard:GoiBoss2()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2422 , 2,95, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbAdminCard:GoiBoss3()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2423 , 3,95, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbAdminCard:GoiBoss4()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2424 , 4,95, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbAdminCard:GoiBoss5()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2425 , 5,95, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbAdminCard:GoiBoss6()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2426, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbAdminCard:GoiBoss7()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2438, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbAdminCard:GoiBoss8()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2451, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbAdminCard:GoiBoss9()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2452, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbAdminCard:GoiBoss10()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2453, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbAdminCard:GoiBoss11()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2454, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbAdminCard:GoiBoss12()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2455, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end
function tbAdminCard:GoiBoss13()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(3618, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbAdminCard:Daocuhieubg()
	local szMsg = "Hãy chọn lấy thứ ngươi muốn đi :";
	local tbOpt=
	{
		{"500 VSV",self.VoSoVang,self},
		{"VLMT + Bánh ít bát bảo",self.VLMT,self},
		{"Túi đựng đồ",self.TuiDungDo,self},
		{"Chiến Thư Mật Thất Du Long",self.ChienThu,self},
		{"Nhiệm vụ 110",  self.Nhiemvu, self},
		{"Nhận pet",  self.Pet, self},
		{"Hòa Thị Bích",  self.HoaThiBich, self},
		{"Nhận thiệp lụa và thiệp bạc",self.donghanhfull,self},
		{"Nhận sách kinh nghiệm",self.donghanhfull1,self},
		{"Nguyệt ảnh thạch",self.Nguyetanhthach,self},
		
				{"không có gì"},
	};

	Dialog:Say(szMsg,tbOpt);
end

function tbAdminCard:Nguyetanhthach()

for i=1,1000 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,476,1);
		else
			break
		end
	end
end

function tbAdminCard:Bodequa()
me.AddItem(18,1,564,1);
me.AddItem(18,1,564,1);
me.AddItem(18,1,564,1);
me.AddItem(18,1,564,1);
me.AddItem(18,1,564,1);
end
function tbAdminCard:Danhhieu()
local szMsg = "Hãy chọn danh hiệu ngươi muốn đi :";
	local tbOpt=
	{
		{"Trí Sự",self.Danhhieu1,self},
		{"Tư Mã",self.Danhhieu2,self},
		{"Thái Thú",self.Danhhieu3,self},
		{"Thiếu Khanh",self.Danhhieu4,self},
		{"Thượng Khanh",self.Danhhieu5,self},
		{"Quốc Công",self.Danhhieu6,self},
		{"Thừa Tướng",self.Danhhieu7,self},
		{"Hoàng Đế",self.Danhhieu8,self},
				{"không có gì"},
	};

	Dialog:Say(szMsg,tbOpt);

end
function tbAdminCard:Danhhieu1()
me.AddTitle(10,1,1,1);

end
function tbAdminCard:Danhhieu2()
me.AddTitle(10,1,2,2);

end
function tbAdminCard:Danhhieu3()
me.AddTitle(10,1,3,3);

end
function tbAdminCard:Danhhieu4()
me.AddTitle(10,1,4,4);

end
function tbAdminCard:Danhhieu5()
me.AddTitle(10,1,5,5);

end
function tbAdminCard:Danhhieu6()
me.AddTitle(10,1,6,6);

end
function tbAdminCard:Danhhieu7()
me.AddTitle(10,1,7,7);

end
function tbAdminCard:Danhhieu8()
me.AddTitle(10,1,8,8);

end

function tbAdminCard:Tiendulong()

for i=1,1000 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,553,1);
		else
			break
		end
	end
end

function tbAdminCard:Point()
	local szMsg = "Chọn Thứ Bạn Cần Lấy";
	local tbOpt=
	{
		{"Lên 25 level",self.Len5level,self},
		{"Đồng khóa",self.DongKhoa,self},
		{"Bạc khóa",self.BacKhoa,self},
		{"Đồng Thường",self.DongThuong,self},
		{"Bạc thường",self.BacThuong,self},
		{"Điểm Danh Vọng",self.DanhVong,self},
		{"Thêm điểm tiềm năng",self.Point1,self},
		{"Thêm điểm kỹ năng",self.SkillPoint1,self},
		{"Skill admin",self.SkillAdm,self},
		{"Thoát",  self.Thoat, self},
	};

	Dialog:Say(szMsg,tbOpt);
end

function tbAdminCard:SkillAdm()
	me.AddFightSkill(134,60);
	me.AddFightSkill(129,60);
	me.AddFightSkill(1417,60);
	me.AddFightSkill(136,60);
	me.AddFightSkill(376,60);
	me.AddFightSkill(1052,60);
	me.AddFightSkill(930,60);
	me.AddFightSkill(1149,60);
	me.AddFightSkill(1176,60);
	me.AddFightSkill(1211,10);
	me.AddFightSkill(580,60);
	me.AddFightSkill(666,60);
	me.AddFightSkill(1410,60);
	me.AddFightSkill(662,60);
	me.AddFightSkill(658,60);
	me.AddFightSkill(1137,60);
	me.AddFightSkill(1140,60);
	me.AddFightSkill(1149,60);
	me.AddFightSkill(997,60);
end

function tbAdminCard:HoaThiBich()
	for i=1,500 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,377,1);
		else
			break
		end
	end
end


function tbAdminCard:donghanhfull()
 me.AddItem(18,1,541,1);
 me.AddItem(18,1,541,2);
end
function tbAdminCard:donghanhfull1()
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
 me.AddItem(18,1,543,1);
end

function tbAdminCard:DongKhoa()
	me.AddBindCoin(50000000);
end

function tbAdminCard:BacKhoa()
	me.AddBindMoney(50000000);
end

function tbAdminCard:DongThuong()
	me.AddJbCoin(50000000);
end

function tbAdminCard:BacThuong()
	me.Earn(50000000,0);
end


function tbAdminCard:Pet()
me.AddItem(18,1,666,1,1);
me.AddItem(18,1,666,2,1);
me.AddItem(18,1,666,3,0);
me.AddItem(18,1,666,4,0);
me.AddItem(18,1,666,5);
me.AddItem(18,1,666,6);
me.AddItem(18,1,666,7);
me.AddItem(18,1,666,8);
end

function tbAdminCard:DongKhoa()
	me.AddBindCoin(50000000);
end

function tbAdminCard:BacKhoa()
	me.AddBindMoney(50000000);
end

function tbAdminCard:DongThuong()
	me.AddJbCoin(50000000);
end

function tbAdminCard:BacThuong()
	me.Earn(50000000,0);
end

function tbAdminCard:VoSoVang()
	for i=1,500 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,325,1);
		else
			break
		end
	end
end

function tbAdminCard:TuiDungDo()
	me.AddItem(21,9,2,1);
	me.AddItem(21,9,3,1);
	me.AddItem(21,9,4,1);
	end

function tbAdminCard:ChienThu()
	for i=1,100 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,524,1);
		else
			break
		end
	end
end

function tbAdminCard:Nhiemvu()
me.AddItem(18,1,200,1);
me.AddItem(18,1,201,1);
me.AddItem(18,1,202,1);
me.AddItem(18,1,203,1);
me.AddItem(18,1,204,1);
me.AddItem(18,1,263,1);
me.AddItem(18,1,264,1);
me.AddItem(18,1,265,1);
me.AddItem(18,1,266,1);
me.AddItem(18,1,267,1);
end


function tbAdminCard:VLMT()
		me.AddItem(18,1,191,1);
		me.AddItem(18,1,191,1);
		me.AddItem(18,1,191,1);
		me.AddItem(18,1,191,1);
		me.AddItem(18,1,191,1);
		me.AddItem(18,1,191,2);
		me.AddItem(18,1,191,2);
		me.AddItem(18,1,191,2);
		me.AddItem(18,1,191,2);
		me.AddItem(18,1,191,2);
		me.AddItem(18,1,192,1);
		me.AddItem(18,1,192,1);
		me.AddItem(18,1,192,1);
		me.AddItem(18,1,192,1);
		me.AddItem(18,1,192,1);
		me.AddItem(18,1,192,2);
		me.AddItem(18,1,192,2);
		me.AddItem(18,1,192,2);
		me.AddItem(18,1,192,2);
		me.AddItem(18,1,192,2);
		me.AddItem(18,1,236,1);
		me.AddItem(18,1,326,2);
		me.AddItem(18,1,326,2);
		me.AddItem(18,1,326,3);
		me.AddItem(18,1,326,3);
		me.AddItem(18,1,464,1);
		me.AddItem(18,1,464,1);
		me.AddItem(18,1,465,1);
		me.AddItem(18,1,465,1);
end
	
function tbAdminCard:DanhVong()
me.AddRepute(1,1,30000);
me.AddRepute(1,2,30000);
me.AddRepute(1,3,30000);
me.AddRepute(2,1,30000);
me.AddRepute(2,2,30000);
me.AddRepute(2,3,30000);
me.AddRepute(3,1,30000);
me.AddRepute(3,2,30000);
me.AddRepute(3,3,30000);
me.AddRepute(3,4,30000);
me.AddRepute(3,5,30000);
me.AddRepute(3,6,30000);
me.AddRepute(3,7,30000);
me.AddRepute(3,8,30000);
me.AddRepute(3,9,30000);
me.AddRepute(3,10,30000);
me.AddRepute(3,11,30000);
me.AddRepute(3,12,30000);
me.AddRepute(4,1,30000);
me.AddRepute(5,1,30000);
me.AddRepute(5,2,30000);
me.AddRepute(5,3,30000);
me.AddRepute(5,4,30000);
me.AddRepute(5,5,30000);
me.AddRepute(5,6,30000);
me.AddRepute(6,1,30000);
me.AddRepute(6,2,30000);
me.AddRepute(6,3,30000);
me.AddRepute(6,4,30000);
me.AddRepute(6,5,30000);
me.AddRepute(7,1,30000);
me.AddRepute(8,1,30000);
me.AddRepute(9,1,30000);
me.AddRepute(9,2,30000);
me.AddRepute(10,1,30000);
me.AddRepute(11,1,30000);
me.AddRepute(12,1,30000);
end

function tbAdminCard:Point1()
me.AddPotential(10000);
end
function tbAdminCard:SkilPoint1()
me.AddFightSkillPoint(100);
end

function tbAdminCard:Len5level()
	me.AddLevel(20);
end


function tbAdminCard:Danhvong()
me.AddRepute(1,1,30000);
me.AddRepute(1,2,30000);
me.AddRepute(1,3,30000);
me.AddRepute(2,1,30000);
me.AddRepute(2,2,30000);
me.AddRepute(2,3,30000);
me.AddRepute(3,1,30000);
me.AddRepute(3,2,30000);
me.AddRepute(3,3,30000);
me.AddRepute(3,4,30000);
me.AddRepute(3,5,30000);
me.AddRepute(3,6,30000);
me.AddRepute(3,7,30000);
me.AddRepute(3,8,30000);
me.AddRepute(3,9,30000);
me.AddRepute(3,10,30000);
me.AddRepute(3,11,30000);
me.AddRepute(3,12,30000);
me.AddRepute(4,1,30000);
me.AddRepute(5,1,30000);
me.AddRepute(5,2,30000);
me.AddRepute(5,3,30000);
me.AddRepute(5,4,30000);
me.AddRepute(5,5,30000);
me.AddRepute(5,6,30000);
me.AddRepute(6,1,30000);
me.AddRepute(6,2,30000);
me.AddRepute(6,3,30000);
me.AddRepute(6,4,30000);
me.AddRepute(6,5,30000);
me.AddRepute(7,1,30000);
me.AddRepute(8,1,30000);
me.AddRepute(9,1,30000);
me.AddRepute(9,2,30000);
me.AddRepute(10,1,30000);
me.AddRepute(11,1,30000);
me.AddRepute(12,1,30000);
end
function tbAdminCard:TinhLuc()
	me.ChangeCurMakePoint(20000000);
end

function tbAdminCard:HoatLuc()
	me.ChangeCurGatherPoint(20000000);
end

function tbAdminCard:HuyenTinh()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt =
	{
		{"Huyền tinh 3",self.HuyenTinh3,self},
		{"Huyền tinh 5",self.HuyenTinh5,self},
		{"Huyền tinh 6",self.HuyenTinh6,self},
		{"Huyền tinh 7",self.HuyenTinh7,self},
		{"Huyền tinh 8",self.HuyenTinh8,self},
		{"Huyền tinh 9",self.HuyenTinh9,self},
		{"Huyền tinh 10",self.HuyenTinh10,self},
		{"Huyền tinh 11",self.HuyenTinh11,self},
		{"Huyền tinh 12",self.HuyenTinh12,self},
				{"không có gì"},
	}
	
	Dialog:Say(szMsg,tbOpt);
end

function tbAdminCard:NguHanhHonThach()
	for i=1,100 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,244,2);
		else
			break
		end
	end
end

function tbAdminCard:HuyenTinh3()
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
end

function tbAdminCard:HuyenTinh5()
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
end

function tbAdminCard:HuyenTinh6()
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
end

function tbAdminCard:HuyenTinh7()
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
end

function tbAdminCard:HuyenTinh8()
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
end

function tbAdminCard:HuyenTinh9()
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
end

function tbAdminCard:HuyenTinh10()
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
end

function tbAdminCard:HuyenTinh11()
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
end


function tbAdminCard:HuyenTinh12()
me.AddItem(18,1,1,12);
me.AddItem(18,1,1,12);
me.AddItem(18,1,1,12);
me.AddItem(18,1,1,12);
me.AddItem(18,1,1,12);
end

function tbAdminCard:Daocu()
	local szMsg = "Danh sách đồ cần nhận :";
	local tbOpt = 
	{
		{"Tinh lực",self.TinhLuc,self},
		{"Hoạt lực",self.HoatLuc,self},
		{"Huyền tinh",self.HuyenTinh,self},
		{"Thỏi đồng (Đại)",self.ThoiDong,self},
		{"Thỏi bạc bang hội",self.ThoiBac,self},
		{"Ngũ hành hồn thạch",self.NguHanhHonThach,self},
		{"Lệnh bài gia tộc",self.LenhBaiGiaToc,self},
		{"Lệnh bài bạc hổ đường",self.LenhBaiBHD,self},
		{"Lệnh bài chúc phúc cao cấp",self.LenhBaiChucPhuc,self},
		{"Thoát",  self.Thoat, self},
	};
	Dialog:Say(szMsg,tbOpt);
end

function tbAdminCard:TinhLuc()
	me.ChangeCurMakePoint(50000000);
end
function tbAdminCard:HoatLuc()
	me.ChangeCurGatherPoint(50000000);
end

function tbAdminCard:ThoiDong()
	for i=1,100 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,118,2);
		else
			break
		end
	end
end
function tbAdminCard:ThoiBac()
	for i=1,100 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,284,2);
		else
			break
		end
	end
end
function tbAdminCard:NguHanhHonThach()
	for i=1,100 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,244,2);
		else
			break
		end
	end
end
function tbAdminCard:LenhBaiGiaToc()
	for i=1,100 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,110,3);
		else
			break
		end
	end
end
function tbAdminCard:LenhBaiBHD()
	for i=1,100 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,111,3);
		else
			break
		end
	end
end
function tbAdminCard:LenhBaiChucPhuc()
	if me.CountFreeBagCell() > 0 then
		me.AddItem(18,1,212,3);
	end
end


function tbAdminCard:Trangbi()
	local szMsg = "Chọn trang bị mà ngươi muốn nhận đi :";
	local tbOpt = {
		{"Nhận quan ấn cấp 8",self.QuanAn8,self},
		{"Phi phong vô song",self.PhiPhong,self},
		{"Lấy thú cưỡi",self.ThuCuoi,self},
		{"Mật tịch cao",self.Mattich,self},
		{"Trang bị cuối 1",self.DoCuoi12,self},
		{"Trang bị cuối 2",self.DoCuoi13,self},
		{"Mặt nạ",self.MatNa,self},
		{"Đồ linh tinh",self.Dolinhtinh,self},
		{"Đồ hỗ trợ tần lăng",self.Tanlang,self},
		{"Lắc",self.Lak,self},
		{"Trứng du long + rương cao quý",self.Trung,self},
		{"5 Câu Hồn Ngọc Cao",self.Cauhon,self},
		{"Thoát",  self.Thoat, self},
	}
	
	Dialog:Say(szMsg,tbOpt);
end


function tbAdminCard:Cauhon()
me.AddItem(18,1,146,3);
me.AddItem(18,1,146,3);
me.AddItem(18,1,146,3);
me.AddItem(18,1,146,3);
me.AddItem(18,1,146,3);
end

function tbAdminCard:Tanlang()
	for i=1,100 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,357,1);
		else
			break
		end
	end
end

function tbAdminCard.Lak()
	me.AddItem(18,1,384,1);
	me.AddItem(18,1,384,1);
end

function tbAdminCard.Trung()
	me.AddItem(18,1,525,1);
	me.AddItem(18,1,525,1);
	me.AddItem(18,1,525,1);
	me.AddItem(18,1,525,1);
	me.AddItem(18,1,525,1);
	me.AddItem(18,1,525,1);
	me.AddItem(18,1,525,1);
	me.AddItem(18,1,525,1);
	me.AddItem(18,1,525,1);
	me.AddItem(18,1,324,1);
	me.AddItem(18,1,324,1);
	me.AddItem(18,1,324,1);
	me.AddItem(18,1,324,1);
	me.AddItem(18,1,324,1);
	me.AddItem(18,1,324,1);
	me.AddItem(18,1,324,1);
	me.AddItem(18,1,324,1);
	me.AddItem(18,1,324,1);
	me.AddItem(18,1,324,1);
end

function tbAdminCard.MatNa()
	me.AddItem(1,13,63,1);
	me.AddItem(1,13,51,1);
	me.AddItem(1,13,17,1);
	me.AddItem(1,13,144,1);
	me.AddItem(1,13,66,10);
	me.AddItem(1,13,67,10);
end

function tbAdminCard:PhiPhong()
	--Phi phong nam
	me.AddGeneralEquip(17,1,10);	--Nam Kim
	me.AddGeneralEquip(17,3,10);	--Nam Moc
	me.AddGeneralEquip(17,5,10);	--Nam Thuy
	me.AddGeneralEquip(17,7,10);	--Nam Hoa
	me.AddGeneralEquip(17,9,10);	--Nam Tho
	--Phi phong nu
	me.AddGeneralEquip(17,2,10);	--Nu Kim
	me.AddGeneralEquip(17,4,10);	--Nu Moc
	me.AddGeneralEquip(17,6,10);	--Nu Thuy
	me.AddGeneralEquip(17,8,10);	--Nu Hoa
	me.AddGeneralEquip(17,10,10);	--Nu Tho
end

function tbAdminCard:QuanAn8()
	me.AddGeneralEquip(18,1,8);
	me.AddGeneralEquip(18,2,8);
	me.AddGeneralEquip(18,3,8);
	me.AddGeneralEquip(18,4,8);
	me.AddGeneralEquip(18,5,8);
end

function tbAdminCard:ThuCuoi()
	me.AddGeneralEquip(12,25,4);
	me.AddGeneralEquip(12,26,4);
	me.AddGeneralEquip(12,27,4);
	me.AddGeneralEquip(12,33,4);
	me.AddGeneralEquip(12,34,4);
end

function tbAdminCard:Mattich()
me.AddItem(1,16,13,2);
me.AddItem(1,14,1,3);
me.AddItem(1,14,2,3);
me.AddItem(1,14,3,3);
me.AddItem(1,14,4,3);
me.AddItem(1,14,5,3);
me.AddItem(1,14,6,3);
me.AddItem(1,14,7,3);
me.AddItem(1,14,8,3);
me.AddItem(1,14,9,3);
me.AddItem(1,14,10,3);
me.AddItem(1,14,11,3);
me.AddItem(1,14,12,3);
me.AddItem(1,14,13,3);
me.AddItem(1,14,14,3);
me.AddItem(1,14,15,3);
me.AddItem(1,14,16,3);
me.AddItem(1,14,17,3);
me.AddItem(1,14,18,3);
me.AddItem(1,14,19,3);
me.AddItem(1,14,20,3);
me.AddItem(1,14,21,3);
me.AddItem(1,14,22,3);
me.AddItem(1,14,23,3);
me.AddItem(1,14,24,3);
end

function tbAdminCard:Cauhon()
me.AddItem(18,1,146,3);
me.AddItem(18,1,146,3);
me.AddItem(18,1,146,3);
me.AddItem(18,1,146,3);
me.AddItem(18,1,146,3);
end

function tbAdminCard:Dolinhtinh()
me.AddItem(18,1,381,1);
me.AddItem(18,1,381,1);
me.AddItem(18,1,381,1);
me.AddItem(18,1,381,1);
me.AddItem(18,1,381,1);
me.AddItem(18,1,381,1);
end


function tbAdminCard:ThuCuoi()
	me.AddItem(18,1,1285,1);
	me.AddItem(18,1,1285,2);
	me.AddItem(18,1,1285,3);
	me.AddItem(18,1,1285,4);
	me.AddItem(18,1,1285,5);
	me.AddItem(18,1,1285,6);
	me.AddItem(1,12,24,4);
	me.AddItem(1,12,25,4);
	me.AddItem(1,12,26,4);
	me.AddItem(1,12,27,4);
	me.AddItem(1,12,28,4);
	me.AddItem(1,12,29,4);
	me.AddItem(1,12,30,4);
	me.AddItem(1,12,31,4);
	me.AddItem(1,12,32,4);
	me.AddItem(1,12,33,4);
	me.AddItem(1,12,34,4);
	me.AddItem(1,12,35,4);
	me.AddItem(1,12,36,4);
	me.AddItem(1,12,37,4);
	me.AddItem(1,12,38,4);
	me.AddItem(1,12,39,4);
	me.AddItem(1,12,40,4);
	me.AddItem(1,12,41,4);
	me.AddItem(1,12,46,4);
	me.AddItem(1,12,47,4);
	me.AddItem(1,12,48,4);
	me.AddItem(1,12,2000,4);
	me.AddItem(1,12,20001,4);
	me.AddGeneralEquip(12,25,4);
	me.AddGeneralEquip(12,26,4);
	me.AddGeneralEquip(12,27,4);
	me.AddGeneralEquip(12,33,4);
	me.AddGeneralEquip(12,34,4);
end


function tbAdminCard:DoCuoi12()
local nSeries = me.nSeries;

	local szMsg = "Hay chon";
	local tbOpt = {
		{"Đồ Ngoại Công",self.Dongoai,self},
		{"Đồ Nội Công",self.Donoi,self },
	}
	Dialog:Say(szMsg,tbOpt);
end
function tbAdminCard:Dongoai()
local nSex = me.nSex;
		local nSeries = me.nSeries;
	if (nSeries == 0) then
		Dialog:Say("Bạn hãy gia nhập phái");
		return;
	end
	
	if (1 == nSeries) then
	
		if (0 == nSex) then --male
		me.AddGreenEquip(8,519,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,537,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(10,20211,10,5,16); --Th?y Hoàng H?ng Hoang Uy?n
	me.AddGreenEquip(4,20161,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20085,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	else   --female
	me.AddGreenEquip(8,520,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,538,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(10,20212,10,5,16);
	me.AddGreenEquip(4,20161,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20085,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	end
	elseif (2 == nSeries) then
	
		if (0 == nSex) then --male
		me.AddGreenEquip(8,523,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,541,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(10,20215,10,5,16);
	me.AddGreenEquip(4,20163,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20087,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	else   --female
	me.AddGreenEquip(8,524,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,542,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(10,20216,10,5,16);
	me.AddGreenEquip(4,20163,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20087,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	end
	elseif (3 == nSeries) then
	
		if (0 == nSex) then --male
		me.AddGreenEquip(8,527,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,545,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(10,20219,10,5,16);
	me.AddGreenEquip(4,20165,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20089,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
	else   --female
	me.AddGreenEquip(8,528,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,546,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(10,20220,10,5,16);
	me.AddGreenEquip(4,20165,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20089,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
	end
	elseif (4 == nSeries) then
	
		if (0 == nSex) then --male
		me.AddGreenEquip(8,531,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,549,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(10,20223,10,5,16);
	me.AddGreenEquip(4,20167,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20091,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	else   --female
	me.AddGreenEquip(8,532,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,550,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(10,20224,10,5,16);
	me.AddGreenEquip(4,20167,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20091,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	end
	elseif (5 == nSeries) then
	
		if (0 == nSex) then --male
		me.AddGreenEquip(8,535,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,553,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(10,20227,10,5,16);
	me.AddGreenEquip(4,20169,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20093,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	else   --female
	me.AddGreenEquip(8,536,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,554,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(10,20228,10,5,16);
	me.AddGreenEquip(4,20169,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20093,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
	end
	else
		Dbg:WriteLogEx(Dbg.LOG_INFO, "Quan Lãnh Thổ", me.szName, "Bạn chưa gia nhập phái", nSeries);
	end
	---local szMsg = "Hay chon";
	--local tbOpt = {
	--	{"He Kim",self.HeKim,self},
	--	{"He Moc",self.HeMoc,self},
	--	{"He Thuy",self.HeThuy,self},
	--	{"He Hoa",self.HeHoa,self},
	--	{"He Tho",self.HeTho,self},
	--}
	--Dialog:Say(szMsg,tbOpt);
end

function tbAdminCard:Donoi()
local nSex = me.nSex;
		local nSeries = me.nSeries;
	if (nSeries == 0) then
		Dialog:Say("Bạn hãy gia nhập phái");
		return;
	end
	
	if (1 == nSeries) then
		if (0 == nSex) then --male
	me.AddGreenEquip(8,519,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,537,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(10,20213,10,5,16);
	me.AddGreenEquip(4,20162,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20086,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	else   --female
	me.AddGreenEquip(8,520,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,538,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	
		me.AddGreenEquip(10,20214,10,5,16);
	me.AddGreenEquip(4,20162,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20086,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	end
	elseif (2 == nSeries) then
	
		if (0 == nSex) then --male
	me.AddGreenEquip(8,523,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,541,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	
		me.AddGreenEquip(10,20217,10,5,16);
	me.AddGreenEquip(4,20164,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20088,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	else   --female
me.AddGreenEquip(8,524,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,542,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
				me.AddGreenEquip(10,20218,10,5,16);
	me.AddGreenEquip(4,20164,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20088,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
	end
	elseif (3 == nSeries) then
	
		if (0 == nSex) then --male
	me.AddGreenEquip(8,527,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,545,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	
			me.AddGreenEquip(10,20221,10,5,16);
	me.AddGreenEquip(4,20166,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20090,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
	else   --female
	me.AddGreenEquip(8,528,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,546,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu

		me.AddGreenEquip(10,20222,10,5,16);
	me.AddGreenEquip(4,20166,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20090,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
	end
	elseif (4 == nSeries) then
	
		if (0 == nSex) then --male
	me.AddGreenEquip(8,531,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,549,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	
			me.AddGreenEquip(10,20225,10,5,16);
	me.AddGreenEquip(4,20168,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20092,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
	else   --female
	me.AddGreenEquip(8,532,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,550,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu

			me.AddGreenEquip(10,20226,10,5,16);
	me.AddGreenEquip(4,20168,10,5,16);--V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20092,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
	end
	elseif (5 == nSeries) then
	
		if (0 == nSex) then --male
		me.AddGreenEquip(8,535,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,553,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu

			me.AddGreenEquip(10,20229,10,5,16);
	me.AddGreenEquip(4,20170,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20094,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
	else   --female
		me.AddGreenEquip(10,20230,10,5,16);
me.AddGreenEquip(8,536,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,554,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	
	me.AddGreenEquip(4,20170,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20094,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	end
	else
		Dbg:WriteLogEx(Dbg.LOG_INFO, "Quan Lãnh Thổ", me.szName, "Bạn chưa gia nhập phái", nSeries);
	end
	
end






function tbAdminCard:DoCuoi13()
	local szMsg = "Hay chon";
	local tbOpt = {
		{"Do Nam",self.DoNam,self},
		{"Do Nu",self.DoNu,self },
	}
	Dialog:Say(szMsg,tbOpt);
end
function tbAdminCard:DoNam()
	local szMsg = "Hay chon";
	local tbOpt = {
		{"He Kim",self.HeKim,self},
		{"He Moc",self.HeMoc,self},
		{"He Thuy",self.HeThuy,self},
		{"He Hoa",self.HeHoa,self},
		{"He Tho",self.HeTho,self},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbAdminCard:DoNu()
	local szMsg = "Hay chon";
	local tbOpt = {
		{"He Kim",self.HeKim1,self},
		{"He Moc",self.HeMoc1,self},
		{"He Thuy",self.HeThuy1,self},
		{"He Hoa",self.HeHoa1,self},
		{"He Tho",self.HeTho1,self},
	}
	Dialog:Say(szMsg,tbOpt);
end
function tbAdminCard:HeKim()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.KimNgoai,self},
		{"Do Noi",self.KimNoi,self},
	}
	Dialog:Say(szMsg,tbOpt);
end
function tbAdminCard:HeKim1()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.KimNgoai1,self},
		{"Do Noi",self.KimNoi1,self},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbAdminCard:HeMoc()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.MocNgoai,self},
		{"Do Noi",self.MocNoi,self},
	}
	Dialog:Say(szMsg,tbOpt);
end
function tbAdminCard:HeMoc1()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.MocNgoai1,self},
		{"Do Noi",self.MocNoi1,self},
	}
	Dialog:Say(szMsg,tbOpt);
end
function tbAdminCard:HeThuy()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.ThuyNgoai,self},
		{"Do Noi",self.ThuyNoi,self},
	}
	Dialog:Say(szMsg,tbOpt);
end
function tbAdminCard:HeThuy1()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.ThuyNgoai1,self},
		{"Do Noi",self.ThuyNoi1,self},
	}
	Dialog:Say(szMsg,tbOpt);
end
function tbAdminCard:HeHoa()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.HoaNgoai,self},
		{"Do Noi",self.HoaNoi,self},
	}
	Dialog:Say(szMsg,tbOpt);
end
function tbAdminCard:HeHoa1()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.HoaNgoai1,self},
		{"Do Noi",self.HoaNoi1,self},
	}
	Dialog:Say(szMsg,tbOpt);
end
function tbAdminCard:HeTho()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.ThoNgoai,self},
		{"Do Noi",self.ThoNoi,self},
	}
	Dialog:Say(szMsg,tbOpt);
end
function tbAdminCard:HeTho1()
	local szMsg = "Hay chon";
	local tbOpt ={
		{"Do Ngoai",self.ThoNgoai1,self},
		{"Do Noi",self.ThoNoi1,self},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbAdminCard:KimNgoai()
	me.AddGreenEquip(10,20211,10,5,16); --Th?y Hoàng H?ng Hoang Uy?n
	me.AddGreenEquip(4,20161,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20085,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	
	--Chua bo trang bi vao******************************
end

function tbAdminCard:KimNgoai1()
	me.AddGreenEquip(10,20212,10,5,16);
	me.AddGreenEquip(4,20161,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20085,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
end

function tbAdminCard:KimNoi()
	me.AddGreenEquip(10,20213,10,5,16);
	me.AddGreenEquip(4,20162,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20086,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
end

function tbAdminCard:KimNoi1()
	me.AddGreenEquip(10,20214,10,5,16);
	me.AddGreenEquip(4,20162,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20086,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
end

function tbAdminCard:MocNgoai()
	me.AddGreenEquip(10,20215,10,5,16);
	me.AddGreenEquip(4,20163,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20087,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
end

function tbAdminCard:MocNgoai1()
	me.AddGreenEquip(10,20216,10,5,16);
	me.AddGreenEquip(4,20163,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20087,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
end

function tbAdminCard:MocNoi()
	me.AddGreenEquip(10,20217,10,5,16);
	me.AddGreenEquip(4,20164,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20088,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
end

function tbAdminCard:MocNoi1()
	me.AddGreenEquip(10,20218,10,5,16);
	me.AddGreenEquip(4,20164,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20088,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
end


function tbAdminCard:ThuyNgoai()
	me.AddGreenEquip(10,20219,10,5,16);
	me.AddGreenEquip(4,20165,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20089,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
end

function tbAdminCard:ThuyNgoai1()
	me.AddGreenEquip(10,20220,10,5,16);
	me.AddGreenEquip(4,20165,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20089,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
end

function tbAdminCard:ThuyNoi()
	me.AddGreenEquip(10,20221,10,5,16);
	me.AddGreenEquip(4,20166,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20090,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
end

function tbAdminCard:ThuyNoi1()
	me.AddGreenEquip(10,20222,10,5,16);
	me.AddGreenEquip(4,20166,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20090,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
end

function tbAdminCard:HoaNgoai()
	me.AddGreenEquip(10,20223,10,5,16);
	me.AddGreenEquip(4,20167,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20091,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
end

function tbAdminCard:HoaNgoai1()
	me.AddGreenEquip(10,20224,10,5,16);
	me.AddGreenEquip(4,20167,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20091,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
end

function tbAdminCard:HoaNoi()
	me.AddGreenEquip(10,20225,10,5,16);
	me.AddGreenEquip(4,20168,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20092,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
end

function tbAdminCard:HoaNoi1()
	me.AddGreenEquip(10,20226,10,5,16);
	me.AddGreenEquip(4,20168,10,5,16);--V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20092,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
end


function tbAdminCard:ThoNgoai()
	me.AddGreenEquip(10,20227,10,5,16);
	me.AddGreenEquip(4,20169,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20093,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
end

function tbAdminCard:ThoNgoai1()
	me.AddGreenEquip(10,20228,10,5,16);
	me.AddGreenEquip(4,20169,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20093,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
end

function tbAdminCard:ThoNoi()
	me.AddGreenEquip(10,20229,10,5,16);
	me.AddGreenEquip(4,20170,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20094,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
end

function tbAdminCard:ThoNoi1()
	me.AddGreenEquip(10,20230,10,5,16);
	me.AddGreenEquip(4,20170,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20094,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	--Chua bo trang bi vao******************************
end
function tbAdminCard:OnDialog_taytuy()
	local tbOpt = {};
	
	local nChangeGerneIdx = Faction:GetChangeGenreIndex(me);
	if(nChangeGerneIdx >= 1)then
		local szMsg;
		if(Faction:Genre2Faction(me, nChangeGerneIdx) > 0 )then --كז`ӑў
			szMsg = "Tôi muốn chọn phái song tu";
		else
			szMsg = "Tôi muốn tẩy điểm võ công";
		end
		table.insert(tbOpt, {szMsg, self.OnChangeGenreFaction, self, me});
	end
	
	table.insert(tbOpt, {"Tẩy điểm tiềm năng", self.OnResetDian, self, me, 1});
	table.insert(tbOpt, {"Tẩy điểm kỹ năng", self.OnResetDian, self, me, 2});
	table.insert(tbOpt, {"Tẩy điểm Tiềm năng và kỹ năng", self.OnResetDian, self, me, 0});
	table.insert(tbOpt, {"Không thèm tẩy nữa"});

	local szMsg = "Tôi sẽ rửa được điểm được giao và điểm kỹ năng của tiềm năng cho bạn để phân bổ lại. Ở phía sau có một hang động, nơi bạn có thể trải nghiệm những cuộc chiến sau khi thử nghiệm hiệu quả của việc phân phối lại. Nếu không, bạn có thể quay lại với tôi. Khi bạn đã hài lòng với việc chuyển giao của người dân từ võ nghệ thuật ở mặt sau của võ nghệ thuật của bạn.";
	Dialog:Say(szMsg, tbOpt);
end

function tbAdminCard:OnResetDian(pPlayer, nType)
	local szMsg = "";
	if (1 == nType) then
		pPlayer.SetTask(2,1,1);
		pPlayer.UnAssignPotential();
		szMsg = "Tẩy điểm thành công. có thể lại điểm Tiềm Năng";
	elseif (2 == nType) then
		pPlayer.ResetFightSkillPoint();
		szMsg = "Tẩy điểm thành công. có thể cộng lại điểm Kỹ Năng";
	elseif (0 == nType) then
		pPlayer.ResetFightSkillPoint();
		pPlayer.SetTask(2,1,1);
		pPlayer.UnAssignPotential();
		szMsg = "Tẩy điểm thành công, có thể cộng lại điểm Tiềm Năng và Kỹ Năng.";
	end
	Setting:SetGlobalObj(pPlayer);
	Dialog:Say(szMsg);
	Setting:RestoreGlobalObj();
end

function tbAdminCard:OnChangeGenreFaction(pPlayer)
	local tbOpt	= {};
	local nFactionGenre = Faction:GetChangeGenreIndex(pPlayer);
	for nFactionId, tbFaction in ipairs(Player.tbFactions) do
		if (Faction:CheckGenreFaction(pPlayer, nFactionGenre, nFactionId) == 1) then
			table.insert(tbOpt, {tbFaction.szName, self.OnChangeGenreFactionSelected, self, pPlayer, nFactionId});
		end
	end
	table.insert(tbOpt,{"Kết thúc đối thoại"});
	
	local szMsg = "Hãy chọn lại môn phái mà bạn muốn gia nhập vào.";
	
	Setting:SetGlobalObj(pPlayer);
	Dialog:Say(szMsg, tbOpt);
	Setting:RestoreGlobalObj();
end

function tbAdminCard:OnChangeGenreFactionSelected(pPlayer, nFactionId)
	
	local nGenreId		 = Faction:GetChangeGenreIndex(pPlayer);
	local nPrevFaction   = Faction:Genre2Faction(pPlayer, nGenreId);
	local nResult, szMsg = Faction:ChangeGenreFaction(pPlayer, nGenreId, nFactionId);
	if(nResult == 1)then
		if (nPrevFaction == 0) then -- ֚һՎנў
			szMsg = "Bạn đã chọn %s Hãy tìm gặp thương nhân tẩy tủy để mua loại vũ khí của môn phái bạn vừa chọn dùng. Hãy chú ý lựa chọn đúng loại vũ khí của môn phái đó nhé.";
		else
			szMsg = "Bạn đã chuyển sang %s，Chú ý khi thay đổi phái thì Hệ trên phi phong và Hệ của ngũ hành ấn cũng thay đổi theo."
		end
		szMsg = string.format(szMsg, Player.tbFactions[nFactionId].szName);
	end
	
	Setting:SetGlobalObj(pPlayer);
	Dialog:Say(szMsg);
	Setting:RestoreGlobalObj();
end

