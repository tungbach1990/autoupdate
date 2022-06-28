
local tbHuiHuangGuoBase = {};
tbHuiHuangGuoBase._tbBase	= Npc:GetClass("default");
tbHuiHuangGuoBase.nTimeout	= 3600*24*7; --设置得到的果子有效期为7天
tbHuiHuangGuoBase.TSK_LIMITWEIWANG	= 5;
tbHuiHuangGuoBase.TSKGID			= 2002;
tbHuiHuangGuoBase.LIMITWEIWANG		= 20;

function tbHuiHuangGuoBase:OnDialog()
	if (0 == me.GetCamp()) then
		me.Msg("Hiện bạn chưa gia nhập môn phái, không thể hái quả.")
		return 0;
	end
	local tbNpcInfo	= him.GetTempTable("Npc");
	if (tbNpcInfo.nIsCollected ~= nil and tbNpcInfo.nIsCollected == 1) then --已经被别人采集了
		me.Msg("Đã bị người khác thu thập.");
		return 0;
	end
	
	if (me.CountFreeBagCell() < 1) then
		me.Msg("Túi đã không còn chỗ.");
		return 0;
	end
	local nGetPlayerRank = HuiHuangZhiGuo.GetPlayerRank();
	
	if (nGetPlayerRank ~= him.nLevel) then -- 如果级别不对,不能进行拾取
		if (1 == him.nLevel) then
			me.Msg("Quả ở đây chỉ người chơi từ cấp 70 - 99 mới được hái!");
		end
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
	
	GeneralProcess:StartProcess("Đang thu thập...", self.nTime * Env.GAME_FPS, {self.GetFruit, self,him.dwId,me.nId}, nil, tbEvent);
	
end

function tbHuiHuangGuoBase:GetFruit(dwNpcId, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	local pNpc = KNpc.GetById(dwNpcId);
	if (pPlayer.nCurLife <= 0) then
		pPlayer.Msg("Thu thập thất bại");
		return 0;
	end
	if (pNpc == nil) then
		pPlayer.Msg("Thu thập thất bại");
		return 0;
	end
	local tbNpcInfo	= pNpc.GetTempTable("Npc");
	if (tbNpcInfo.nIsCollected == 1) then
		pPlayer.Msg("Thu thập thất bại");
		return 0;
	end
	tbNpcInfo.nIsCollected = 1;
	local pGuoZi = me.AddItemEx(Item.SCRIPTITEM, self.tbItemGuoZi.nDetail,self.tbItemGuoZi.nParticular,self.tbItemGuoZi.nLevel,{bTimeOut = 1});
	if(pGuoZi ~= nil ) then --果子得到了
		pPlayer.SetItemTimeout(pGuoZi,os.date("%Y/%m/%d/%H/%M/%S",GetTime()+self.nTimeout));
		pGuoZi.Sync();
		self:AwardWeiWang(pPlayer, self.tbItemGuoZi.szName);		
	end
	pNpc.Delete();
	
end

function tbHuiHuangGuoBase:AwardWeiWang(pPlayer, szGuoName)
	assert(szGuoName);
	local nWeiWang = 0;
	local nGongXian = 0;
	if ("Quả Huy Hoàng" == szGuoName) then
		nWeiWang = 1;
		nGongXian = 5;
	elseif ("Quả Hoàng Kim" == szGuoName) then
		nWeiWang = 5;
		nGongXian = 30;
	end
	pPlayer.AddKinReputeEntry(nWeiWang, "huihuangzhiguo");
end

local tbHuiHuangZhiGuo			= Npc:GetClass("huihuangzhiguo");
tbHuiHuangZhiGuo._tbBase		= tbHuiHuangGuoBase;
tbHuiHuangZhiGuo.tbItemGuoZi	= {szName = "Quả Huy Hoàng",nGenre = 18,nDetail = 1,nParticular = 25,nLevel = 1,};
tbHuiHuangZhiGuo.nTime			= 10;
local tbHuangJinZhiGuo			= Npc:GetClass("huangjinzhiguo");
tbHuangJinZhiGuo._tbBase		= tbHuiHuangGuoBase;
tbHuangJinZhiGuo.tbItemGuoZi	= {szName = "Quả Hoàng Kim",nGenre = 18,nDetail = 1,nParticular = 26,nLevel = 1,};
tbHuangJinZhiGuo.nTime			= 60;
