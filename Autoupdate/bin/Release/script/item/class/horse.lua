
Require("\\script\\item\\class\\equip.lua");


local tbHores = Item:NewClass("horse", "equip");
if not tbBook then
	tbHores = Item:GetClass("horse");
end


function tbHores:GetTitle(nState, nEnhNameColor)	
	local szTip = string.format("<color=0x%x>", it.nNameColor);
	szTip = szTip..it.szName;
	return	szTip.."<color>\n";
end

function tbHores:CalcEnhanceAttrib(nState)
	local pTemp = KItem.CreateTempItem(
		it.nGenre,
		it.nDetail,
		it.nParticular,
		it.nLevel,
		it.nSeries,
		it.nEnhTimes + 1,
		it.nLucky,
		it.GetGenInfo(),
		0,
		it.dwRandSeed,
		it.nIndex
	);

	if (not pTemp) then
		return;
	end

	local tbRandMASS = pTemp.GetRandMASS();
	local tbEnhMASS  = pTemp.GetEnhMASS();
	local nStarLevel = pTemp.nStarLevel;
	local nNameColor = pTemp.nNameColor;
	pTemp.Remove();
	return tbRandMASS, tbEnhMASS, nStarLevel, nNameColor;
end

function tbHores:GetTip(nState, tbEnhRandMASS, tbEnhEnhMASS)		
	local szTip = "";
	szTip = szTip..self:Tip_ReqAttrib();
	szTip = szTip..self:Tip_Durability();
	szTip = szTip..self:Tip_Level();
	szTip = szTip..self:Tip_Series(nState);
	szTip = szTip.."<color>";
	local szBaseAttrib = self:Tip_BaseAttrib(nState);
	if szBaseAttrib and szBaseAttrib ~= "" then
		szTip = szTip.."\n\n<color=blue>Thuộc tính trang bị: <color>"..szBaseAttrib;
	end
	szTip = szTip..tbHores:Tip_RandAttrib(nState, tbEnhRandMASS);
	szTip = szTip..self:Tip_EnhAttrib(nState, tbEnhEnhMASS);
	szTip = szTip..self:Tip_Maker();
	szTip = szTip..self:Tip_RepairInfo(nState);
	szTip = szTip..self:GetBreakUpStuffTips();
	
	return	Lib:StrTrim(szTip, "\n");
end

function tbHores:Tip_RandAttrib(nState, tbEnhRandMASS)	
	local szTip = "";
	local nPos1, nPos2 = KItem.GetEquipActive(KItem.EquipType2EquipPos(it.nDetail));
	local tbMASS = it.GetRandMASS();			-- 获得道具随机魔法属性

	if (nState == Item.TIPS_PREVIEW) or (nState == Item.TIPS_GOODS) then	-- 属性预览状态，显示魔法属性范围
		local nSeries = it.nSeries;
		local tbGenInfo = it.GetGenInfo(0, 1);

		for _, tbMA in ipairs(tbGenInfo) do
			local tbMAInfo = KItem.GetRandAttribInfo(tbMA.szName, tbMA.nLevel, it.nVersion);
			if tbMAInfo then
				szTip = szTip.."\n"..self:GetMagicAttribDescEx(tbMA.szName, self:BuildMARange(tbMAInfo.tbRange));
			end
		end
	else										-- 其他状态，显示魔法属性具体值
		for i = 1, #tbMASS do		
			local tbMA = tbMASS[i];
			local szDesc = "";
			if tbEnhRandMASS then
				szDesc = self:GetMagicAttribDescEx2(tbMA.szName, tbMA.tbValue, tbEnhRandMASS[i].tbValue);
			else
				szDesc = self:GetMagicAttribDesc(tbMA.szName, tbMA.tbValue);
			end
			if (szDesc ~= "") and (tbMA.bVisible == 1) then
				if (tbMA.bActive ~= 1) then
					szTip = szTip..string.format("\n<color=gray>%s<color>", szDesc);
				else
					szTip = szTip.."\n"..szDesc;
				end
			end
		end
	end
	if szTip ~= "" then
		return	"\n\n<color=blue>Thuộc tính thú cưỡi: <color>\n<color=green>"..szTip.."<color>";
	end
	return szTip;
end
