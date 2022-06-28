
-- ӡ����������
-- zhengyuhua

-- define

Item.SOULUPGRADE_EXP_PER_ITEM		= 100;				-- ÿ����ʯͷ�ľ���
Item.SOULUPGRADE_ITEM_CLASS			= "spiritstore"		-- ��ʯClassname
Item.SOULUPGRADE_EQUIP_CLASS		= "soulsignet"			-- ӡ��Classname

----------------------------------------------------------------------

function Item:SetSoulSignetMagic(pSignet, nMagicIndex, nLevel, nExp)
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
end

function Item:CalcSoulUpgrade(pSignet, nMagicIndex, nItemNum)
	if not pSignet or pSignet.szClass ~= self.SOULUPGRADE_EQUIP_CLASS then
		return 0;
	end
	if nMagicIndex <= 0 or nMagicIndex > self.SOULSIGNET_ATTRIB_NUM then
		return 0;
	end
	local nLevel 	= pSignet.GetGenInfo(nMagicIndex * 2 - 1, 0);
	local nExp		= pSignet.GetGenInfo(nMagicIndex * 2, 0);
	
	-- ��������ӡ�Ĳ�ͬ�����Եȼ�������Ҳ��ͬ
	local nLevelMax = self.tbMAX_SOULSIGNET_LEVEL[pSignet.nLevel or 1][nMagicIndex];
	
	
	nExp = nExp + math.floor(nItemNum * self.SOULUPGRADE_EXP_PER_ITEM / 100);
	local tbSetting = Item:GetExternSetting("soulsignet", pSignet.nVersion);
	if nLevel < self.MIN_SOULSIGNET_LEVEL then
		return 0;
	end
	while (nLevel < nLevelMax and nExp >= tbSetting["m_LevelExp"..nMagicIndex][nLevel]) do
		nExp = nExp - tbSetting["m_LevelExp"..nMagicIndex][nLevel];
		nLevel = nLevel + 1;
	end
	local nResCount = 0;
	-- ����ȼ��������޺󣬻��ж���ľ��飬����Щ����ת�ɻ�ʯ�������������
	if nLevel >= nLevelMax and  nExp > 0 then
		nResCount = math.floor(nExp / (self.SOULUPGRADE_EXP_PER_ITEM / 100));
	end
	return nLevel, nExp, tbSetting["m_LevelExp"..nMagicIndex][nLevel] or 0, nResCount;
end

-- ��������ӡ  
-- 		����˵����pSignet:����ӡָ�룬tbUpgradeItem:�����������ĵ��ߣ�nMagicIndex:ѡ��Ҫ����������
function Item:UpgradeSoulSignet(pSignet, tbUpgradeItem, nMagicIndex)
	if not pSignet or pSignet.szClass ~= self.SOULUPGRADE_EQUIP_CLASS then
		return 0;
	end

	-- ��������ӡ�Ĳ�ͬ�����Եȼ�������Ҳ��ͬ
	local nLevelMax = self.tbMAX_SIGNET_LEVEL[pSignet.nLevel or 1];
	local nItemNum = 0;
	for _, pItem in pairs(tbUpgradeItem) do
		if pItem.szClass == self.UPGRADE_ITEM_CLASS then	-- ����Ƿ��ǻ�ʯ
			local nCurCount = pItem.nCount;
			local nLevel, nExp, _, nResCount = self:CalcSoulUpgrade(pSignet, nMagicIndex, nCurCount);
			local nRet = 0;
			if nResCount > 0 then
				nRet = pItem.SetCount(nResCount, Item.emITEM_DATARECORD_REMOVE);
			elseif nResCount == 0 then
				nRet = me.DelItem(pItem, Player.emKLOSEITEM_SERIES_STONE);		-- �۳���ʯ
			end
			if nRet ~= 1 then
				Dbg:WriteLog("Upgrade", "��ɫ��:"..me.szName, "�ʺ�:"..me.szAccount, "�۳���ʯʧ�ܣ�������:", nCurCount);
			else
				nItemNum = nItemNum + nCurCount;
				self:SetSoulSignetMagic(pSignet, nMagicIndex, nLevel, nExp);
			end
			if nLevel >= nLevelMax then -- ������������
				break;
			end
		else
			Dbg:WriteLog("Upgrade", "��ɫ��:"..me.szName, "�ʺ�:"..me.szAccount, "���Ի���ǻ�ʯ������������ӡ")
		end
	end
	if nItemNum == 0 then
		return 0;
	end

	return 1;
end

function Item:UpgradeSoulSignetNoItem(pSignet, nCurCount, nMagicIndex)
	if not pSignet or pSignet.szClass ~= self.SOULUPGRADE_EQUIP_CLASS then
		return 0;
	end

	-- ��������ӡ�Ĳ�ͬ�����Եȼ�������Ҳ��ͬ
	local nLevelMax = self.tbMAX_SOULSIGNET_LEVEL[pSignet.nLevel or 1][nMagicIndex];

	local nLevel, nExp, _, nResCount = self:CalcSoulUpgrade(pSignet, nMagicIndex, nCurCount);
	print(nLevel,nExp,nResCount,nMagicIndex);
	if nLevel >= nLevelMax then -- ������������
		nExp=0;
	end
	local nRet = self:SetSoulSignetMagic(pSignet, nMagicIndex, nLevel, nExp);

	return nResCount; -- ���ر�������
end
