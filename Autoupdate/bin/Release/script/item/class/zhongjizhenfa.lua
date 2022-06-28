Require("\\script\\item\\class\\zhen.lua");

local tbItem = Item:NewClass("zhongjizhenfa", "zhen");

function tbItem:CalcValueInfo()
	local nType, nTime = it.GetTimeOut();
	if (nTime == 0) then
		local nLive_Time = 30 * 24 * 60 * 60; -- 秒 一个月
		it.SetTimeOut(0, GetTime() + nLive_Time);
	end;
	
	local nValue = it.nOrgValue;
	local nStarLevel, szNameColor, szTransIcon = Item:CalcStarLevelInfo(it.nVersion, it.nDetail, it.nLevel, nValue);
	return	nValue, nStarLevel, szNameColor, szTransIcon;
end
