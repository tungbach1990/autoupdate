


Item.UPGRADE_EXP_PER_ITEM		= 10;				-- 每个魂石头的经验
Item.UPGRADE_ITEM_CLASS			= "spiritstore"		-- 魂石Classname
Item.UPGRADE_EQUIP_CLASS		= "signet"			-- 印章Classname


function Item:SetSignetMagic(pSignet, nMagicIndex, nLevel, nExp)
	pSignet.SetGenInfo(nMagicIndex * 2 - 1, nLevel);
	pSignet.SetGenInfo(nMagicIndex * 2, nExp);
	local nRet = pSignet.Regenerate(
		pSignet.nGenre,
		pSignet.nDetail,
		pSignet.nParticular,
		pSignet.nLevel,
		pSignet.nSeries,
		pSignet.nEnhTimes,
		pSignet.nLucky,
		pSignet.GetGenInfo(),
		0,
		pSignet.dwRandSeed,
		0
	);
	if nRet == 1 then
		Dbg:WriteLog("Upgrade", "Tên nhân vật:"..me.szName, "Tài khoản:"..me.szAccount, "Đạo cụ:"..pSignet.szGUID, "Nâng cấp thuộc tính thứ "..nMagicIndex.." của Ngũ Hành Ấn thành ", nLevel, nExp);
	else
		Dbg:WriteLog("Upgrade", "Tên nhân vật:"..me.szName, "Tài khoản:"..me.szAccount, "Đạo cụ:"..pSignet.szGUID, "Nâng cấp Ngũ Hành Ấn thất bại, Regenerate");
	end
end

function Item:CalcUpgrade(pSignet, nMagicIndex, nItemNum)
	if not pSignet or pSignet.szClass ~= self.UPGRADE_EQUIP_CLASS then
		return 0;
	end
	if nMagicIndex <= 0 or nMagicIndex > self.SIGNET_ATTRIB_NUM then
		return 0;
	end
	local nLevel 	= pSignet.GetGenInfo(nMagicIndex * 2 - 1, 0);
	local nExp		= pSignet.GetGenInfo(nMagicIndex * 2, 0);
	
	local nLevelMax = pSignet.GetExtParam(1);
	
	local nMuti = 100;
	local nBufLevel = me.GetSkillState(881);
	local nBufLevel_vn = me.GetSkillState(2212)	--越南免死令牌
	if nBufLevel > 0 or nBufLevel_vn > 0 then
		nMuti = nMuti * 1.2
	end
	
	nExp = nExp + math.floor(nItemNum * self.UPGRADE_EXP_PER_ITEM * nMuti / 100);
	local tbSetting = Item:GetExternSetting("signet", pSignet.nVersion);
	if nLevel < self.MIN_SIGNET_LEVEL then
		return 0;
	end
	while (nLevel < nLevelMax and nExp >= tbSetting.m_LevelExp[nLevel]) do
		nExp = nExp - tbSetting.m_LevelExp[nLevel];
		nLevel = nLevel + 1;
	end
	local nResCount = 0;
	if nLevel >= nLevelMax and  nExp > 0 then
		nResCount = math.floor(nExp / (self.UPGRADE_EXP_PER_ITEM * nMuti / 100));
		nExp = 0;
	end
	return nLevel, nExp, tbSetting.m_LevelExp[nLevel] or 0, nResCount;
end

function Item:UpgradeSignet(pSignet, tbUpgradeItem, nMagicIndex)
	if not pSignet or pSignet.szClass ~= self.UPGRADE_EQUIP_CLASS then
		return 0;
	end

	local nLevelMax = pSignet.GetExtParam(1);
	local nItemNum = 0;
	for _, pItem in pairs(tbUpgradeItem) do
		if pItem.szClass == self.UPGRADE_ITEM_CLASS then	-- 检查是否是魂石
			local nCurCount = pItem.nCount;
			local nLevel, nExp, _, nResCount = self:CalcUpgrade(pSignet, nMagicIndex, nCurCount);
			local nRet = 0;
			if nResCount > 0 then
				nRet = pItem.SetCount(nResCount, Item.emITEM_DATARECORD_REMOVE);
			elseif nResCount == 0 then
				nRet = me.DelItem(pItem, Player.emKLOSEITEM_SERIES_STONE);		-- 扣除魂石
			end
			if nRet ~= 1 then
				Dbg:WriteLog("Upgrade", "Tên nhân vật:"..me.szName, "Tài khoản:"..me.szAccount, "Trừ Hồn Thạch thất bại! Số cộng dồn: ", nCurCount);
			else
				nItemNum = nItemNum + nCurCount;
				self:SetSignetMagic(pSignet, nMagicIndex, nLevel, nExp);
			end
			if nLevel >= nLevelMax then -- 升级到极限了
				break;
			end
		else
			Dbg:WriteLog("Upgrade", "Tên nhân vật:"..me.szName, "Tài khoản:"..me.szAccount, "Thử đặt vào không phải Hồn Thạch nâng cấp Ngũ Hành Ấn")
		end
	end
	if nItemNum == 0 then
		return 0;
	end

	return 1;
end


