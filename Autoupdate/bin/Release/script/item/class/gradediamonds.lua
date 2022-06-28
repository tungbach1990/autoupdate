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
	local szMsg = "    ��ѡ��Ҫ�ӻ���װ�����мӻ���";
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
			szName = szName.."-><color=red>"..nRandRate.."%�ɹ�<color>";
			table.insert(tbOpt, {szName, self.DoAddEquipPoint, self, pItem,it});
		end
	end	
	if #tbOpt == 0 then 
		szMsg = szMsg.."\n\nû�пɼӻ�װ����";
	end
	table.insert(tbOpt, {"�����Ի�"});
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
		szMsg = string.format("��ϲ<color=yellow>[%s]<color>ʹ��<color=green>%s<color>����<color=green>%s<color>�ӻ���<color=yellow>%d<color>�ꡣ", me.szName,pThisItem.szName,pItem.szName,ItemLevel+1);
		me.Msg(szMsg);
		if ItemLevel+1 >=13 then
			KDialog.MsgToGlobal(szMsg);	
		end
	else
		nNewLevel = nNewLevel - 1;
		szMsg = "<color=red>�ӻ�ʧ�ܣ��ӻ��ȼ�����1����<color>";
		me.Msg(szMsg);
	end
	Item:SetGradeEquipUpGradeLevel(pItem,nNewLevel);
	return 0;
end

	
	
	
	
	
	
	
	
	
	