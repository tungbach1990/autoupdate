local tbNpc = Npc:GetClass("baihutangbaoming");
tbNpc.tbRVPos	= {};
tbNpc.MAX_NUMBER = 100;
tbNpc.HIGHLEVEL  = 90;
tbNpc.tbTimeKey = {};

function tbNpc:Init()
	self.tbTimeKey[7]  = 8;		self.tbTimeKey[18] = 21;
	self.tbTimeKey[19] = 21;	self.tbTimeKey[20] = 21;
end

function tbNpc:OnDialog(szParam)
	local tbOpt = {};	
	local szMsg = "";
	local nTime = self:GetTime();
	
	if (self:CheckClose() == 1) then
		return;
	end
	
	if (BaiHuTang.nActionState == BaiHuTang.FIGHTSTATE) then
		local nMinute = 30 - tonumber(GetLocalDate("%M"));
		if (nMinute < 0) then
			szMsg = string.format("Hoạt động Bạch Hổ Đường chưa mở, thời gian bắt đầu báo danh trận sau là %d: 30, hãy quay lại sau.", nTime);
		else
			szMsg = string.format("Bây giờ một đoàn dũng sĩ đã tiến vào Bạch Hổ Đường, cổng đường đã đóng, %d phút sau hãy quay lại", nMinute);
		end
		tbOpt[1] = {"Kết thúc đối thoại"};
	elseif (BaiHuTang.nActionState == BaiHuTang.RESTSTATE) then
		szMsg = string.format("Hoạt động Bạch Hổ Đường chưa mở, thời gian bắt đầu báo danh trận sau là %d: 30, hãy quay lại sau.", nTime);
		tbOpt[1] = {"Kết thúc đối thoại"};
	else
		
		local tbMap = self:GetMapList();
		if (not tbMap)then
			return;
		end
		
		local tbMapInfo = {};
		if (szParam == "dong") then
			tbMapInfo.nMapId = tbMap[1][1];
			tbMapInfo.szName =  "Đông Bạch Hổ Đường";
		elseif (szParam == "nan") then
			tbMapInfo.nMapId = tbMap[1][2];
			tbMapInfo.szName =  "Nam Bạch Hổ Đường";
		elseif (szParam == "xi") then
			tbMapInfo.nMapId = tbMap[1][3];
			tbMapInfo.szName =  "Tây Bạch Hổ Đường";
		elseif (szParam == "bei") then	
			tbMapInfo.nMapId = tbMap[1][4];
			tbMapInfo.szName =  "Bắc Bạch Hổ Đường";
		end
		local nRet = MathRandom(#BaiHuTang.tbPKPos);
		tbMapInfo.tbSect = BaiHuTang.tbPKPos[nRet];
		tbOpt[1]	= {"Đúng vậy, ta muốn tham gia!", self.JoinAction, self, tbMapInfo};
		tbOpt[2]	= {"[Quy tắc hoạt động]", self.Rule, self, szParam};
		tbOpt[3]	= {"Nguy hiểm lắm, ta không tham gia đâu."};
		szMsg = "Dạo này không hiểu sao trong Bạch Hổ Đường đầy bọn trộm cắp, chúng ta phải diệt trừ bọn chúng, khi đã vào đó, ngươi phải dẹp yên cả 3 tầng Bạch Hổ Đường mới được ra ngoài. Nếu sau nửa tiếng ta thấy ngươi không có động tĩnh gì thì sẽ vào đó cứu ngươi, ngươi muốn tham gia không?";
	end
	Dialog:Say(szMsg, tbOpt);
end


function tbNpc:CheckClose()
	
	if (TimeFrame:GetStateGS("OpenLevel99") == 0) then
		return 0;
	end
	
	local nNowHour = tonumber(GetLocalDate("%H"));
	if (nNowHour >= 1 and nNowHour <= 7) then
		if (me.nLevel < self.HIGHLEVEL) then
			Dialog:Say("Bây giờ trễ rồi, ngươi đi nghỉ sớm đi!", 
				{
					{"Kết thúc đối thoại"}
				});
			return 1;
		end
	end
	return 0;
end

function tbNpc:Rule(szParam)
	local tbOpt = {};
	tbOpt[1] = {"Trở về đối thoại trước đó", self.OnDialog, self, szParam};
	tbOpt[2] =  {"Kết thúc đối thoại"};
	local szMsg = string.format("Thời gian báo danh <color=green>30<color> phút, thời gian hoạt động <color=green>30<color> phút. Sau khi hoạt động bắt đầu, trong Bạch Hổ Đường sẽ xuất hiện rất nhiều <color=red>Sấm Đường Tặc<color>, đánh bại chúng sẽ nhặt được vật phẩm và kinh nghiệm, sau một thời gian nhất định sẽ xuất hiện <color=red>Thủ Lĩnh Sấm Đường Tặc<color>, " .. 
"Sau khi đánh bại <color=red>Thủ Lĩnh Sấm Đường Tặc<color> sẽ xuất hiện cổng lên tầng 2, Bạch Hổ Đường có 3 tầng, nếu ngươi đánh bại thủ lĩnh của 3 tầng thì sẽ mở được lối ra. Khi bắt đầu thời gian Bạch Hổ Đường thì những người tham gia sẽ bị cưỡng chế mở trạng thái chiến đấu, cho nên tốt nhất nên đi tạo nhóm hoặc đi cùng gia tộc, bang hội thì sẽ thuận lợi hơn. (Hoạt động này mỗi ngày có thể tham gia <color=red>%s lần<color>)", BaiHuTang.MAX_ONDDAY_PKTIMES);
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetTime()
	local nNowHour = tonumber(GetLocalDate("%H"));
	local nNowMinute = tonumber(GetLocalDate("%M"));
	
	local nHour = nNowHour;
	
	if (nNowHour == 7) then
		nHour = 8;
	elseif (nNowHour == 18 or nNowHour == 19 or nNowHour == 20) then
		nHour = 21;
	elseif (nNowHour == 6) then
		if (nNowMinute >= 30) then
			nHour = 8;
		end
	elseif (nNowHour == 17) then
		if (nNowMinute >= 30) then
			nHour = 21;
		end
	else
		if (nNowMinute >= 30) then
			nHour = nHour + 1;
		end
	end
	if (nHour == 24) then
		nHour = 0;
	end
	return nHour;
end
function tbNpc:JoinAction(tbMapInfo)
	if me.GetTiredDegree1() == 2 then
		Dialog:Say("Bạn đã quá mệt, hãy nghỉ ngơi!");
		return;
	end
	if (BaiHuTang.nActionState == BaiHuTang.FIGHTSTATE) then
		me.Msg("Hoạt động Bạch Hổ Đường đã bắt đầu, không thể báo danh được nữa.");
		return;
	end
	
	local nDead = me.IsDead() or 1;
	if nDead == 1 then
		return;
	end
	
	local nTimes = me.GetTask(BaiHuTang.TSKG_PVP_ACT, BaiHuTang.TSK_BaiHuTang_PKTIMES) or 0;
	local szNowDate =  GetLocalDate("%y%m%d");
	local nDate = math.floor(nTimes / 10);
	local nPKTimes = nTimes % 10;
	local nNowDate = tonumber(szNowDate);
	if (nDate == nNowDate) then
		if (nPKTimes >= BaiHuTang.MAX_ONDDAY_PKTIMES) then
			local nTime = tonumber(GetLocalDate("%H%M"));
			if (nTime < 2330) then
				me.Msg(string.format("Hoạt động này một ngày chỉ được tham gia %s lần, mai hãy đến.", BaiHuTang.MAX_ONDDAY_PKTIMES));
				return;
			else
				me.SetTask(BaiHuTang.TSKG_PVP_ACT, BaiHuTang.TSK_BaiHuTang_PKTIMES, 0);
			end
		end
	else
		me.SetTask(BaiHuTang.TSKG_PVP_ACT, BaiHuTang.TSK_BaiHuTang_PKTIMES, 0);
	end
	local nTotal  = BaiHuTang.tbNumber[tbMapInfo.nMapId];
	if (nTotal and nTotal >= tbNpc.MAX_NUMBER) then
		me.Msg("Bản đồ này đã đủ người, xin hãy báo danh ở nơi khác!");
		return;
	end
	self:OnTrans(tbMapInfo);	
end
function tbNpc:OnTrans(tbMapInfo)
	local tbSect	= tbMapInfo.tbSect;
	me.Msg("Đi "..tbMapInfo.szName);
	local nMapId = tbMapInfo.nMapId
	local nTotal = BaiHuTang.tbNumber[nMapId] or 0;
	BaiHuTang.tbNumber[nMapId] = nTotal + 1;
	if(1 == BaiHuTang:JoinGame(me.nMapId, me)) then
		me.NewWorld(nMapId, tbSect.nX / 32, tbSect.nY / 32);
	else
		me.Msg("Bạch Hổ Đường đang bảo trì!");
	end
end

function tbNpc:GetMapList()
	local tbMap = {};
	if (me.nMapId == 821) then
		tbMap = BaiHuTang.tbBatte[BaiHuTang.Goldlen].MapId;
	elseif (me.nLevel >= 90) then
		tbMap = BaiHuTang.tbBatte[BaiHuTang.GaoJi].MapId;
	elseif (me.nMapId == 225) then
		tbMap = BaiHuTang.tbBatte[BaiHuTang.ChuJi].MapId;
	elseif (me.nMapId == BaiHuTang.ChuJi2) then
		if (TimeFrame:GetStateGS("CloseBaiHuTangChu2") == 0 ) then
			tbMap = {{275, 276, 277, 278}};
		else
			tbMap = nil;
		end
	end	
	return tbMap;
end
tbNpc:Init();
