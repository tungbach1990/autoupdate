
local tbItem = Item:GetClass("snowglove");

function tbItem:GetTip(nState)
	
	local szTip = "";
	local nNowCount = it.GetGenInfo(1, 0);
	nNowCount = 2 - nNowCount;	--VN次数调整为2
	szTip = string.format("Số lần tham gia hoạt động còn %d lần", nNowCount);
	return szTip;
end
