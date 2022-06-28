

local REQ_ROUTE		= 1;				-- 路线需求
local REQ_LEVEL		= 5;				-- 等级需求
local REQ_FACTION	= 6;				-- 门派需求
local REQ_SERIES	= 7;				-- 五行需求
local REQ_SEX		= 8;				-- 性别需求

local SATISFY_TEXT		= "%s%s";
local NOT_SATISFY_TEXT	= "<color=red>%s%s<color>";

Item.REQ_DESC_TABLE =
{
	[REQ_LEVEL]		= function(nValue, bSatisfy)
		return string.format("Yêu cầu cấp: "..(bSatisfy == 1 and SATISFY_TEXT or NOT_SATISFY_TEXT), tostring(nValue), "");
	end,
	[REQ_SERIES]	= function(nValue, bSatisfy)
		local szSeries = Env.SERIES_NAME[nValue];
		if (not szSeries) then
			szSeries = "";
		end
		return string.format("Yêu cầu ngũ hành: "..(bSatisfy == 1 and SATISFY_TEXT or NOT_SATISFY_TEXT), szSeries, "");
	end,
	[REQ_SEX]		= function(nValue, bSatisfy)
		local szSex = Env.SEX_NAME[nValue];
		if (not szSex) then
			szSex = "";
		end
		return string.format("Yêu cầu giới tính: "..(bSatisfy == 1 and SATISFY_TEXT or NOT_SATISFY_TEXT), szSex, "");
	end,
};

function Item:ReqDescRoute(nFaction, nRoute)
	local szDesc = ""
	if nFaction == 0 then
		return szDesc;
	end
	local tbFactionInfo = KPlayer.GetFactionInfo(nFaction)
	local nSatisfy = 0;
	if nRoute == 0 then
		nSatisfy = nSatisfy + me.SatisfyRequire(REQ_FACTION, nFaction);
		if tbFactionInfo then
			szDesc = string.format("Yêu cầu môn phái: "..(nSatisfy == 1 and SATISFY_TEXT or NOT_SATISFY_TEXT), tbFactionInfo.szName, "")
		end
	else
		nSatisfy = nSatisfy + me.SatisfyRequire(REQ_FACTION, nFaction);
		nSatisfy = nSatisfy + me.SatisfyRequire(REQ_ROUTE, nRoute);
		if tbFactionInfo and tbFactionInfo.tbRoutes[nRoute] then
			szDesc = string.format("Yêu cầu hệ phái: "..(nSatisfy == 2 and SATISFY_TEXT or NOT_SATISFY_TEXT), tbFactionInfo.tbRoutes[nRoute].szName, "")
		end
	end
	return szDesc;
end

function Item:GetRequireDesc(tbAttrib)
	local tbMsg = {}
	local nFaction = 0;
	local nRouteId = 0;
	for _, tbReq in ipairs(tbAttrib) do
		if tbReq.nReq == REQ_ROUTE then
			nRouteId = tbReq.nValue
		elseif tbReq.nReq == REQ_FACTION then
			nFaction = tbReq.nValue
		end
		local bSatisfy = me.SatisfyRequire(tbReq.nReq, tbReq.nValue);
		local fProc = self.REQ_DESC_TABLE[tbReq.nReq];
		local szDesc = ""
		if (fProc) then
			szDesc = fProc(tbReq.nValue, bSatisfy);
		end
		if (szDesc ~= "") then
			tbMsg[#tbMsg + 1] = szDesc;
		end
	end
	tbMsg[#tbMsg + 1] = self:ReqDescRoute(nFaction, nRouteId);
	return table.concat(tbMsg, "\n");
end
