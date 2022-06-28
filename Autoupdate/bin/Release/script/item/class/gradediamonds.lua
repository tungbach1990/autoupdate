local tbDiamonds = Item:GetClass("jxsf8_gradediamonds");

tbDiamonds.UpRate100PMax={
	[1] = 2,
	[2] = 7,
	[3] = 12,
	[4] = 17,
}

tbDiamonds.UpRateDiff={
	[1] = 40,
	[2] = 18,
	[3] = 12,
	[4] = 5,
	[5] = 3,
	[6] = 1,
	[7] = 0,
	[8] = 0,
	[9] = 0,
	[10] = 0,
	[11] = 0,
	[12] = 0,
	[13] = 0,
	[14] = 0,
	[15] = 0,
	[16] = 0,
	[17] = 0,
	[18] = 0,
	[19] = 0,
	[20] = 0,
}

function tbDiamonds:OnUse()
	local nLevel = it.nLevel;
	local nMaxPoint = tbDiamonds.UpRate100PMax[nLevel];
	local szMsg = "    请选择要加护的装备进行加护：";
	local tbOpt = {};
	
	for i = 20,21 do
		local pItem = me.GetEquip(i);
		if (pItem)then
			local ItemLevel = pItem.GetGenInfo(12);
			local szName = "<color=green>"..pItem.szName.."<color>";
			local nRandRate = 0;
			if ItemLevel <= nMaxPoint then
				nRandRate = 100;
			else
				nRandRate = tbDiamonds.UpRateDiff[ItemLevel - nMaxPoint];
			end
			szName = szName.."-><color=red>"..nRandRate.."%成功<color>";
			table.insert(tbOpt, {szName, self.DoAddEquipPoint, self, pItem,it});
		end
	end	
	if #tbOpt == 0 then 
		szMsg = szMsg.."\n\n没有可加护装备！";
	end
	table.insert(tbOpt, {"结束对话"});
	Dialog:Say(szMsg, tbOpt);
	return 0;
end

function tbDiamonds:DoAddEquipPoint(pItem,pThisItem)
	local szMsg = "";
	local tbOpt = {};
	print(pThisItem.szName);
	if pThisItem.nCount > 1 then
		pThisItem.SetCount(pThisItem.nCount-1);
	else
		me.DelItem(pThisItem)
	end
	
	local nLevel = pThisItem.nLevel;
	local nMaxPoint = tbDiamonds.UpRate100PMax[nLevel];
	local ItemLevel = pItem.GetGenInfo(12);
	local nRandRate = 0;
	if ItemLevel <= nMaxPoint then
		nRandRate = 100;
	else
		nRandRate = tbDiamonds.UpRateDiff[ItemLevel - nMaxPoint];
	end	
	local nRandom = MathRandom(1,100);
	local nNewLevel = ItemLevel;
	if nRandom < nRandRate then
		nNewLevel = nNewLevel + 1;
		szMsg = string.format("恭喜<color=yellow>[%s]<color>使用<color=green>%s<color>，将<color=green>%s<color>加护到<color=yellow>%d<color>钻。", me.szName,pThisItem.szName,pItem.szName,ItemLevel+1);
		me.Msg(szMsg);
		if ItemLevel+1 >=13 then
			KDialog.MsgToGlobal(szMsg);	
		end
	else
		nNewLevel = nNewLevel - 1;
		szMsg = "<color=red>加护失败，加护等级减少1级！<color>";
		me.Msg(szMsg);
	end
	Item:SetGradeEquipUpGradeLevel(pItem,nNewLevel);
	return 0;
end

	
	
	
	
	
	
	
	
	
	