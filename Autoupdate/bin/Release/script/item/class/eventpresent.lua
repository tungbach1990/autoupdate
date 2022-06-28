local tbItem = Item:GetClass("eventpresent");

tbItem.SZITEMFILE = "\\setting\\item\\001\\other\\eventpresent.txt";

function tbItem:OnUse()
	if self.tbItemList == nil then
		self.tbItemList = self:GetItemList();
	end

	local nTaskGroup 	= tonumber(it.GetExtParam(1));
	local nTaskId		= tonumber(it.GetExtParam(2));
	local tbTask		= { nTaskGroup, nTaskId };

	local nPresentType	= self:GetPresentType(me, tbTask);
	if (nPresentType <= 0) then
		Dialog:Say("Xin lỗi, gói quà của bạn chưa được kích hoạt.");
		return;
	end

	self:ShowItemList(nPresentType, tbTask, it);
end

function tbItem:ShowItemList(nPresentType, tbTask, pItem)
	if (not nPresentType or nPresentType <= 0) then
		return;
	end

	local tbPList = self.tbItemList[nPresentType];
	if (not tbPList or not tbPList.tbItemList) then
		return 0;
	end	

	local tbOpt = {};
	
	for nId, tbInfo in ipairs(tbPList.tbItemList) do
		local nFlag = self:GetPresentItemFlag(me, tbTask, nId);
		if (nFlag >= 0) then
			local szShowName = "";
			local szItemName = ""; 
			local tbItem = {};
			if (tbInfo[2]) then
				tbItem = tbInfo[2];
			elseif (tbInfo[me.nSex]) then
				tbItem = tbInfo[me.nSex];
			end

			local nPlayerLevel = tbItem.nPlayerLevel or 0;

			if (nPlayerLevel > me.nLevel) then
				nFlag = 1;
			end

			if (nFlag == 0) then
				szShowName = "<color=yellow>%s<color>";
			else
				szShowName = "<color=gray>%s<color>";
			end
			tbOpt[nId] = { string.format(szShowName, tbItem.szName), self.OnGiveDetailPresent, self, tbTask, tbItem, nPresentType, nId, pItem};
		end
	end
	tbOpt[#tbOpt + 1] = {"Để tôi xem lại"};
	Dialog:Say(string.format("<color=yellow>Xin chào %s<color> %s Bạn có thể nhận：", me.szName, tbPList.szDesc), tbOpt);
end

function tbItem:OnGiveDetailPresent(tbTask, tbPresent, nPresentType, nId, pItem)
	if (not tbPresent) then
		return;
	end
	
	local nFlag = self:GetPresentItemFlag(me, tbTask, nId);
	
	if (-1 >= nFlag) then
		return 0;
	end
	
	if (0 ~= nFlag) then
		Dialog:Say(string.format("Bạn đã nhận thưởng rồi!"));
		return 0;
	end
	
	local nPlayerLevel = tbPresent.nPlayerLevel or 0;
	
	if (nPlayerLevel > me.nLevel) then
		Dialog:Say(string.format("Nhận <color=yellow>%s<color> cần <color=green>cấp %d<color>，Vui lòng thử lại sau.", tbPresent.szName, nPlayerLevel));
		return 0;
	end	
	
	local szMsg = string.format("Bạn chắc chắn sẽ nhận <color=yellow>%s<color> ？", tbPresent.szName);
	Dialog:Say(szMsg, 
	{
		{"Ta đồng ý", self.GetItem, self, me, tbTask, tbPresent, nPresentType, nId, pItem},
		{"Để ta xem lại"},	
	}	
	);
end

function tbItem:GetPresentType(pPlayer, tbTask)
	if (not tbTask or #tbTask < 2) then
		return 0;
	end
	local nKeyNum		= pPlayer.GetTask(tbTask[1], tbTask[2]);
	local nPresentType	= PresendCard:GetPresentTypeFlag(nKeyNum)
	return nPresentType;
end

function tbItem:GetPresentItemFlag(pPlayer, tbTask, nId)
	if (not tbTask or #tbTask < 2) then
		return -1;
	end

	local nKeyNum		= pPlayer.GetTask(tbTask[1], tbTask[2]);

	if (nId > 16 or nId <= 0) then
		return -1;
	end		
	
	local nFlag = Lib:LoadBits(nKeyNum, nId - 1, nId - 1);
	return nFlag;
end

function tbItem:SetPresentItemFlag(pPlayer, tbTask, nId, nFlag)
	if (not tbTask or #tbTask < 2) then
		return -1;
	end
	local nKeyNum		= pPlayer.GetTask(tbTask[1], tbTask[2]);

	if (nId > 16 or nId <= 0) then
		return -1;
	end		
	
	nKeyNum = Lib:SetBits(nKeyNum, 1, nId - 1, nId - 1);
	pPlayer.SetTask(tbTask[1], tbTask[2], nKeyNum);
	
	return 1;
end

function tbItem:GetItem(pPlayer, tbTask, tbitem, nPresentType, nPresentId, pMyItem)
	local nFlag = self:GetPresentItemFlag(pPlayer, tbTask, nPresentId);

	if (-1 >= nFlag) then
		return 0;
	end
	
	if (0 ~= nFlag) then
		pPlayer.Msg(string.format("<color=yellow>%s<color>	bạn đã nhận qua phần thưởng.", tbitem.szName));
		return 0;
	end
	
	local nPlayerLevel = tbitem.nPlayerLevel or 0;
	
	if (nPlayerLevel > me.nLevel) then
		pPlayer.Msg(string.format("Nhận <color=yellow>%s<color> cần đạt đến cấp %d，vui lòng thử lại sau.", tbitem.szName, nPlayerLevel));
		return 0;
	end

	local nSucFlag = 0;

	if tbitem.nBindMoney ~= 0 then
		if (pPlayer.GetBindMoney() + tbitem.nBindMoney > pPlayer.GetMaxCarryMoney()) then
			pPlayer.Msg("Xin lỗi số tiền mang theo không được quá lớn, hãy thử lại sau.");
			return 0;
		else
			nSucFlag = 1;
			pPlayer.AddBindMoney(tbitem.nBindMoney, Player.emKBINDMONEY_ADD_EVENT);
			local szAnnouce = string.format("Bạn nhận được <color=yellow>%s<color> bạc khóa", tbitem.nBindMoney);
			pPlayer.Msg(szAnnouce);
			self:WriteLog("Hop qua",  pPlayer.szName, szAnnouce);
		end
	end
	if tbitem.nMoney ~= 0 then
		if pPlayer.nCashMoney + tbitem.nMoney > pPlayer.GetMaxCarryMoney() then
			pPlayer.Msg("Xin lỗi số tiền mang theo không được quá lớn, hãy thử lại sau.");
		else
			local nAddMoney = pPlayer.Earn(tbitem.nMoney, Player.emKEARN_EVENT);
			local szAnnouce = string.format("Bạn nhận được <color=yellow>%s<color> bạc", tbitem.nMoney);
			pPlayer.Msg(szAnnouce);
			if nAddMoney == 1 then
				nSucFlag = 1;
				self:WriteLog("Hop qua",  pPlayer.szName,  string.format("nhan duoc %s bac khoa", tbitem.nMoney));
			else
				self:WriteLog("Hop qua",  pPlayer.szName,  string.format("nhan duoc %s bac khoa", tbitem.nMoney));
			end
		end
	end
	if tbitem.nCoin ~= 0 then
		local nAddCoin = pPlayer.AddBindCoin(tbitem.nCoin, Player.emKBINDCOIN_ADD_EVENT); -- 只会加绑金
		local szAnnouce = string.format("Bạn nhận được <color=yellow>%s<color> đồng khóa", tbitem.nCoin);
		pPlayer.Msg(szAnnouce);
		if nAddCoin == 1 then
			nSucFlag = 1;
			self:WriteLog("Hop qua",  pPlayer.szName,  string.format("nhan duoc %s dong khoa", tbitem.nCoin));
		else
			self:WriteLog("Hop qua",  pPlayer.szName,  string.format("%s nhan duoc %s khoa %s khoa", IVER_g_szCoinName, tbitem.nCoin, IVER_g_szCoinName));
		end
	end
	if tbitem.nGenre ~= 0 and tbitem.nDetailType ~= 0 and tbitem.nParticularType ~= 0 then
		if self:CheckItemFree(me, tbitem.nCount) == 0 then
			return 0;
		end
		
		for i = 1, tbitem.nCount do
			local pItem = pPlayer.AddItem(tbitem.nGenre, tbitem.nDetailType, tbitem.nParticularType, tbitem.nLevel, tbitem.nSeries, tbitem.nEnhTimes);
			if pItem == nil then
				local szMsg = string.format("Trong hộp quà có chứa：%s,%s,%s",tbitem.nGenre, tbitem.nDetailType, tbitem.nParticularType);
				self:WriteLog("Hop qua",  pPlayer.szName, szMsg);
				return 0;
			else
				if tbitem.nBind ~= 0 then
					pItem.Bind(1);
				end
				if tbitem.szTimeLimit ~= "" then
					self:LimitTime(pPlayer, tbitem.szTimeLimit, pItem);
				end
			end
			local szAnnouce = string.format("Bạn nhận được 1 <color=yellow>%s<color>", pItem.szName);
			pPlayer.Msg(szAnnouce);
			self:WriteLog("Hop qua",  pPlayer.szName, string.format("doi duoc %s", pItem.szName));					
		end
		nSucFlag = 1;
	end
	
	if tbitem.nExp ~= 0 then
		nSucFlag = 1;
		pPlayer.AddExp(tbitem.nExp)
		local szAnnouce = string.format("Bạn nhận được <color=yellow>%s<color> kinh nghiệm",tbitem.nExp);
		pPlayer.Msg(szAnnouce);
		self:WriteLog("Hop qua",  pPlayer.szName, string.format("nhan duoc%s kinh nghiem", tbitem.nExp));
	end
	
	if tbitem.nMKP ~= 0 then
		nSucFlag = 1;
		pPlayer.ChangeCurMakePoint(tbitem.nMKP)
		local szAnnouce = string.format("Bạn nhận được <color=yellow>%s<color> tinh lực",tbitem.nMKP);
		pPlayer.Msg(szAnnouce);
		self:WriteLog("Hop qua",  pPlayer.szName, string.format("nhan duoc%s tinh luc", tbitem.nMKP));
	end
	
	if tbitem.nGTP ~= 0 then
		nSucFlag = 1;
		pPlayer.ChangeCurGatherPoint(tbitem.nGTP)
		local szAnnouce = string.format("Bạn nhận được <color=yellow>%s<color> hoạt lực",tbitem.nGTP);
		pPlayer.Msg(szAnnouce);
		self:WriteLog("Hop qua",  pPlayer.szName, string.format("nhan duoc %s hoat luc", tbitem.nGTP));		
	end

	if tbitem.nAnnounce == 1 then
		local szMsg = string.format("%s mở %s nhận được %s thật may mắn.", pPlayer.szName, tbitem.szDesc, tbitem.szName);
		KDialog.NewsMsg(1, Env.NEWSMSG_NORMAL, szMsg);
		Player:SendMsgToKinOrTong(pPlayer, " mở "..tbitem.szDesc.." nhận được "..tbitem.szName.."", 1);
	end
	
	if tbitem.nFriendMsg == 1 then
		pPlayer.SendMsgToFriend("Hảo hữu của bạn [<color=yellow>"..pPlayer.szName.."<color>] mở "..tbitem.szDesc..
			" nhận được <color=yellow>"..tbitem.szName.."<color>");		
	end

	if (nSucFlag == 1) then
		self:SetPresentItemFlag(pPlayer, tbTask, nPresentId, 1);

		local nCount = 0;
	
		if (not self.tbItemList[nPresentType]) then
			return 0;
		end
	
		local tbOneItemList = self.tbItemList[nPresentType].tbItemList or {};
		for i=1, 24 do
			local nFlag = self:GetPresentItemFlag(pPlayer, tbTask, i);
			if (nFlag == 0) then
				break;
			end
			nCount = nCount + 1;
		end
		if nCount >= #tbOneItemList then
			if (pMyItem) then
				pMyItem.Delete(pPlayer);
				pPlayer.Msg("Bạn đã nhận tất cả các phần thưởng.");
			end
		end
		
	end	

	return 1;
end

function tbItem:CheckItemFree(pPlayer, nCount)
	if pPlayer.CountFreeBagCell() < nCount then
		local szAnnouce = "Hãy thu xếp "..nCount.." ô trống, rồi thử lại.";
		pPlayer.Msg(szAnnouce);
		return 0;
	end
	return 1;
end

function tbItem:LimitTime(pPlayer, szParam, pItem)
	if szParam == nil then
		return 1;
	end
	if not pItem then
		return 0;
	end
	if tonumber(szParam) ~= nil then
		local szDate = os.date("%Y/%m/%d/%H/%M/%S", GetTime() + tonumber(szParam) * 60);
		pPlayer.SetItemTimeout(pItem,szDate);
	else
		local tbStr = Lib:SplitStr(szParam, "/");
		if #tbStr == 3 then
			--当天H:M:S消失
			local nNowDate = GetLocalDate("%Y/%m/%d");
			local szTime = string.format("%s/%s", nNowDate, szParam);
			pPlayer.SetItemTimeout(pItem,szTime);
		elseif #tbStr == 4 then
			--d天后H:M:S消失
			if tonumber(tbStr[1]) > 0 then
				local nNowDate = GetLocalDate("%Y/%m");
				local nHour = tonumber(GetLocalDate("%H"));
				local nMin = tonumber(GetLocalDate("%M"));
				local nSecond = tonumber(GetLocalDate("%S"));
				local nLastTime = 24 * 3600 - (nHour * 3600 + nMin *60 + nSecond);
				local nLastTime2 = tonumber(tbStr[2]) * 3600 + tonumber(tbStr[3]) * 60 + tonumber(tbStr[4]);
				local nLimitTime = nLastTime + ((tonumber(tbStr[1]) - 1)* 24 * 3600) + nLastTime2;
				local szDate = os.date("%Y/%m/%d/%H/%M/%S", GetTime() + nLimitTime);
				pPlayer.SetItemTimeout(pItem,szDate);
			else
				local nNowDate = GetLocalDate("%Y/%m/%d");
				local szTime = string.format("%s/%s/%s/%s", nNowDate, tonumber(tbStr[2]), tonumber(tbStr[3]), tonumber(tbStr[4]));
				pPlayer.SetItemTimeout(pItem,szTime);				
			end			
		elseif #tbStr == 6 then
			--Y-m-d H:M:S后消失
			pPlayer.SetItemTimeout(pItem,szParam);
		end
	end
	return 0;
end

function tbItem:InitGenInfo()
	-- 设定有效期限
	local nkind = tonumber(it.GetExtParam(3));
	if nkind == 1 then
		local nDate = tonumber(GetLocalDate("%Y%m%d2400"));
		local nSec = Lib:GetDate2Time(nDate);
		it.SetTimeOut(0, nSec);
	elseif nkind == 2 then
		it.SetTimeOut(0, GetTime() + 3600 * 24 * 7);
	end
	return	{ };
end

function tbItem:GetItemList()
	
	local tbsortpos = Lib:LoadTabFile(self.SZITEMFILE);
	local nLineCount = #tbsortpos;
	local tbClassItemList = {};
	
	for nLine=2, nLineCount do
		local nPresentType = tonumber(tbsortpos[nLine].PresentType);
		local szPreName		= tbsortpos[nLine].PreName;
		local nPresentId = tonumber(tbsortpos[nLine].PresentId) or 0;
		local szName = tbsortpos[nLine].Name;
		local szDesc = tbsortpos[nLine].Desc;
		local nBindMoney = tonumber(tbsortpos[nLine].BindMoney) or 0;
		local nMoney = tonumber(tbsortpos[nLine].Money) or 0;
		local nGenre = tonumber(tbsortpos[nLine].Genre) or 0;
		local nDetailType = tonumber(tbsortpos[nLine].DetailType)or 0;
		local nParticularType = tonumber(tbsortpos[nLine].ParticularType) or 0;
		local nLevel = tonumber(tbsortpos[nLine].Level)or 0;
		local nSeries = tonumber(tbsortpos[nLine].Series) or 0;
		local nEnhTimes = tonumber(tbsortpos[nLine].EnhTimes) or 0;
		local nExp = tonumber(tbsortpos[nLine].Exp) or 0;
		local nMKP = tonumber(tbsortpos[nLine].MKP) or 0;
		local nGTP = tonumber(tbsortpos[nLine].GTP) or 0;
		local szTimeLimit = tbsortpos[nLine].TimeLimit;
		local nBind = tonumber(tbsortpos[nLine].Bind) or 0;
		local nCoin = tonumber(tbsortpos[nLine].Coin) or 0;
		local nAnnounce = tonumber(tbsortpos[nLine].Announce) or 0;
		local nFriendMsg = tonumber(tbsortpos[nLine].FriendMsg) or 0;
		local nCount = tonumber(tbsortpos[nLine].Count) or 0;
		local nSex	= tonumber(tbsortpos[nLine].ItemSex) or 2;
		local nPlayerLevel = tonumber(tbsortpos[nLine].PlayerLevel) or 0;
		
		if tbClassItemList[nPresentType] == nil then
			tbClassItemList[nPresentType] = {};
			tbClassItemList[nPresentType].szPreName = szPreName;
			tbClassItemList[nPresentType].szDesc = szDesc;
			tbClassItemList[nPresentType].tbItemList = {};
		end
 
		if (nPresentId > 0) then
			tbClassItemList[nPresentType].tbItemList[nPresentId] = tbClassItemList[nPresentType].tbItemList[nPresentId] or {};
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex] = {};
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex].szName = szName;
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex].nPlayerLevel = nPlayerLevel;
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex].nBindMoney = nBindMoney;
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex].nMoney = nMoney;
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex].nGenre = nGenre;
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex].nDetailType = nDetailType;
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex].nParticularType = nParticularType;
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex].nLevel = nLevel;
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex].nSeries = nSeries;
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex].nEnhTimes = nEnhTimes;
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex].nExp = nExp;
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex].nMKP = nMKP;
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex].nGTP = nGTP;
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex].szTimeLimit = szTimeLimit;
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex].nBind = nBind;
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex].nCoin = nCoin;
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex].nAnnounce = nAnnounce;
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex].nFriendMsg = nFriendMsg;
			tbClassItemList[nPresentType].tbItemList[nPresentId][nSex].nCount = nCount;
		end
	end
	return tbClassItemList;
end

function tbItem:WriteLog(...)
	if (MODULE_GAMESERVER) then
		Dbg:WriteLogEx(Dbg.LOG_INFO, "eventpresent", "tbitem", unpack(arg));	
	end	
end

tbItem.tbItemList = tbItem:GetItemList()