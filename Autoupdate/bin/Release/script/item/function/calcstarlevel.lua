

function Item:CalcStarLevelInfo(nVersion, nDetailType, nLevel, nValue)
	local tbSetting = Item:GetExternSetting("value", nVersion);
	if (not tbSetting) then
		return 1, "white", "";
	end
	local tbStarLevelInfo = nil;
	for i = #tbSetting.m_tbStarLevelInfo, 1, -1 do
		tbStarLevelInfo = tbSetting.m_tbStarLevelInfo[i];
		if (tbStarLevelInfo.tbEquipLvlVal[nDetailType] and tbStarLevelInfo.tbEquipLvlVal[nDetailType][nLevel]) then
			if (nValue >= tbStarLevelInfo.tbEquipLvlVal[nDetailType][nLevel]) then
				break;
			end
		end
	end
	return tbStarLevelInfo.nStarLevel, tbStarLevelInfo.szNameColor, tbStarLevelInfo.szTransIcon;
end
