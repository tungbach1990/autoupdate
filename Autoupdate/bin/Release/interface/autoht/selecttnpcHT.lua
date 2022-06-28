local AimCommonHT	= Map.AimCommonHT or {};
Map.AimCommonHT	= AimCommonHT;

-- ͨ����ͼ[���书��]
local GetTempMap ={
	--����to���ִ�
	[23] = 1,
	[24] = 2,
	[25] = 8,
	[26] = 4,
	[27] = 5,
	[28] = 6,
	[29] = 7,
	--�һ���to����
}
-- ͨ��1: ��ͼ
function AimCommonHT:GotoDisMap(nDmapID,nDx,nDy)
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		--��������ʲôҲ����
		return 0;
	end
	local nChuanSong = self:GetChuanSong();
	local nHuiCheng = self:GetHuiCheng();
	local nMyMap,nMyX, nMyY = me.GetWorldPos();
	self.nDisMap = nDmapID;
	if (me.nAutoFightState == 1) then	--����ڹһ�,��ֹͣ��[ȱ���ܶ��ܹ�]
		AutoAi.ProcessHandCommand("auto_fight", 0);
		AutoAi.SetTargetIndex(0);
	end
	if (self.nDisMap == 556 or self.nDisMap == 558 or self.nDisMap == 559) and (nMyMap == 556 or nMyMap == 558 or nMyMap == 559) then
		self.nDisMap=nMyMap;
	end
	if (nChuanSong) or (nMyMap == self.nDisMap) then	--�����޴��ͣ���ͬͼ��
		local nMapName = GetMapNameFormId(self.nDisMap)
		local DisPosInfo ={}
		DisPosInfo.szType = "pos"
		DisPosInfo.szLink = nMapName..","..self.nDisMap..","..nDx..","..nDy
		Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,DisPosInfo);
	else
		-- �жϵ�ͼ[û�����޴���]
		if (nMyMap >= 1 and nMyMap <= 8) and (self.nDisMap == 556 or self.nDisMap == 558 or self.nDisMap == 559) then --�����ִ���Ŀ���Ǿ�Ӫ
			self:TalktoNpc("���Զ�",4042,1);
		elseif (nMyMap >= 23 and nMyMap <= 29) and (self.nDisMap == 556 or self.nDisMap == 558 or self.nDisMap == 559) then --�ڳ�����Ŀ���Ǿ�Ӫ
			local dTMap = GetTempMap[nMyMap];
			local nMapName = GetMapNameFormId(dTMap)
			local DisPosInfo ={}
			DisPosInfo.szType = "pos"
			DisPosInfo.szLink = nMapName..","..dTMap..",1500,3000"
			Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,DisPosInfo);
		else
			if (nHuiCheng) then
				if (nMyMap >= 1 and nMyMap <= 8) or (nMyMap >= 23 and nMyMap <= 29) then
					local nszMapName = GetMapNameFormId(nDmapID)
					local DisPosInfo ={}
					DisPosInfo.szType = "pos"
					DisPosInfo.szLink = nszMapName..","..nDmapID..",1500,3000"
					Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,DisPosInfo);
					return;
				else
					me.UseItem(nHuiCheng);
					return;
				end
			else
				me.Msg("û�д��ͷ�Ҳû�лس̷������ֹ���ͼ��")
				return;
			end
		end
	end
end
-- ͨ��2: NPC�Ի�

function AimCommonHT:TalktoNpc(dNpcName,dNpcID,dSayId)
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		if dSayId ~= -1 then	--��ID����-1,����ID�ش�
			me.AnswerQestion(dSayId-1);
		end
		local function fnDoClose()
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(2, fnDoClose);
	else
		local nMyMap,nMyX, nMyY = me.GetWorldPos();
		local nX1, nY1;
		nX1, nY1 = KNpc.ClientGetNpcPos(nMyMap, dNpcID);
		local tbPosInfo ={}
		tbPosInfo.szType = "pos"
		tbPosInfo.szLink = dNpcName..","..nMyMap..","..nX1..","..nY1
		Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,tbPosInfo);
	end
end

-- ͨ��2-3: �Ի��Զ��ش�
function AimCommonHT:AutoAnswer()
	me.Msg("dsklahlkj")
	if AutoAnswer[1] == 1 then
		me.AnswerQestion(AutoAnswer[2]-1);
		AutoAnswer[1] = 0;
		AutoAnswer[2] = 0;
		local function fnDoClose()
			UiManager:CloseWindow(MySayPanel);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnDoClose);
	end
end
-- ͨ��3: ������Ʒ���
-- ͨ��3-1:����"���޻س̷�"
function AimCommonHT:GetHuiCheng()
	local tbItem	= me.FindItemInBags(18,1,23,1)[1] or me.FindItemInBags(18,1,234,1)[1];
	return (tbItem or {}).pItem;
end
-- ͨ��3-2:����"���޴��ͷ�"
function AimCommonHT:GetChuanSong()
	local tbItem	= me.FindItemInBags(18,1,195,1)[1] or me.FindItemInBags(18,1,235,1)[1];
	return (tbItem or {}).pItem;
end
-- ͨ��3-3:����"��ҩ"
function AimCommonHT:GetHongYao()
local HONG = {
	[1] = {17,1,1,1},--��ҩС
	[2] = {17,1,1,2},--��ҩ��
	[3] = {17,1,1,3},--��ҩ��
	[4] = {17,1,1,4},--���쵤
	[5] = {17,1,1,5},--��ת���굤
	[6] = {17,1,1,6},--��֥������
	[7] = {17,3,1,1},--�����ۣ�С��
	[8] = {17,3,1,2},--�����ۣ��У�
	[9] = {17,3,1,3},--�����ۣ���
	[10] = {17,3,1,4},--���ɲ��ĵ�
	[11] = {17,3,1,5},--�廨��¶��
	[12] = {17,3,1,6},--���ش󻹵�
	[13] = {17,6,1,1},--��Ѫ��(С)
	[14] = {17,6,1,2},--��Ѫ��(��)
	[15] = {17,6,1,3},--��Ѫ��(��)
	[16] = {17,6,3,1},--Ǭ���컯��(С)
	[17] = {17,6,3,2},--Ǭ���컯��(��)
	[18] = {17,6,3,3},--Ǭ���컯��(��)
	[19] = {17,7,1,1},--����ս��Ѫ��(С)
	[20] = {17,7,1,2},--����ս��Ѫ��(��)
	[21] = {17,7,1,3},--����ս��Ѫ��(��)
	[22] = {17,7,3,1},--����սǬ���컯��(С)
	[23] = {17,7,3,2},--����սǬ���컯��(��)
	[24] = {17,7,3,3},--����սǬ���컯��(��)
	[25] = {17,8,1,1},--��ң��Ѫ��(С)
	[26] = {17,8,1,2},--��ң��Ѫ��(��)
	[27] = {17,8,1,3},--��ң��Ѫ��(��)
	[28] = {17,8,3,1},--��ңǬ���컯��(С)
	[29] = {17,8,3,2},--��ңǬ���컯��(��)
	[30] = {17,8,3,3},--��ңǬ���컯��(��)
};
	for i,tbHONG in pairs(HONG) do
		local tbFind = me.FindItemInBags(unpack(tbHONG));
		for j, tbItem in pairs(tbFind) do
			return tbItem.pItem;
		end
	end
end
-- ͨ��3-4:����"��ҩ"
function AimCommonHT:GetLanYao()
local LAN = {
	[1] = {17,2,1,1},--���񵤣�С��
	[2] = {17,2,1,2},--���񵤣��У�
	[3] = {17,2,1,3},--���񵤣���
	[4] = {17,2,1,4},--��ɢ ��ɢ
	[5] = {17,2,1,5},--���ڻ���
	[6] = {17,2,1,6},--ѩ�η�����
	[7] = {17,3,1,1},--�����ۣ�С��
	[8] = {17,3,1,2},--�����ۣ��У�
	[9] = {17,3,1,3},--�����ۣ���
	[10] = {17,3,1,4},--���ɲ��ĵ�
	[11] = {17,3,1,5},--�廨��¶��
	[12] = {17,3,1,6},--���ش󻹵�
	[13] = {17,6,2,1},--���ڵ�(С)
	[14] = {17,6,2,2},--���ڵ�(��)
	[15] = {17,6,2,3},--���ڵ�(��)
	[16] = {17,6,3,1},--Ǭ���컯��(С)
	[17] = {17,6,3,2},--Ǭ���컯��(��)
	[18] = {17,6,3,3},--Ǭ���컯��(��)
	[19] = {17,7,2,1},--����ս���ڵ�(С)
	[20] = {17,7,2,2},--����ս���ڵ�(��)
	[21] = {17,7,2,3},--����ս���ڵ�(��)
	[22] = {17,7,3,1},--����սǬ���컯��(С)
	[23] = {17,7,3,2},--����սǬ���컯��(��)
	[24] = {17,7,3,3},--����սǬ���컯��(��)
	[25] = {17,8,2,1},--��ң���ڵ�(С)
	[26] = {17,8,2,2},--��ң���ڵ�(��)
	[27] = {17,8,2,3},--��ң���ڵ�(��)
	[28] = {17,8,3,1},--��ңǬ���컯��(С)
	[29] = {17,8,3,2},--��ңǬ���컯��(��)
	[30] = {17,8,3,3},--��ңǬ���컯��(��)
};
	for i,tbLAN in pairs(LAN) do
		local tbFind = me.FindItemInBags(unpack(tbLAN));
		for j, tbItem in pairs(tbFind) do
			return tbItem.pItem;
		end
	end
end
-- ͨ��3-5:����"������"
function AimCommonHT:GetBFBook()
	local tbItem	= me.FindItemInBags(20,1,298,1)[1] or me.FindItemInBags(20,1,544,1)[1] or me.FindItemInBags(20,1,809,1)[1];
	return (tbItem or {}).pItem;
end
-- ͨ��3-6:����"������"	
function AimCommonHT:GetJGBook()
	local tbItem	= me.FindItemInBags(20,1,299,1)[1] or me.FindItemInBags(20,1,545,1)[1] or me.FindItemInBags(20,1,810,1)[1];
	return (tbItem or {}).pItem;
end
-- ͨ��3-7:����"���ô�"
function AimCommonHT:GetJunXiangBag()
	local tbItem	= me.FindItemInBags(18,1,193,1)[1] or me.FindItemInBags(18,1,285,1)[1];
	return (tbItem or {}).pItem;
end
--ͨ��3-8:����"��"
function AimCommonHT:GetJunMeat()
	local tbItem	= me.FindItemInBags(20,1,488,1)[1] or me.FindItemInBags(20,1,488,2)[1];
	return (tbItem or {}).pItem;
end
--ͨ��3-9:����"����"
function AimCommonHT:GetLuckBag()
	local tbItem	= me.FindItemInBags(18,1,80,1)[1];
	return (tbItem or {}).pItem;
end
--ͨ��3-10:����"�������"
function AimCommonHT:GetJiGuanLJ()
	local tbItem	= me.FindItemInBags(20,1,484,1)[1];
	return (tbItem or {}).pItem;
end
-- ͨ��4: �ر����
-- ͨ��4-1:�ر�SAY
function AimCommonHT:CloseSay()
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
		return 0;
	end
end
-- ͨ��4-2:�ر�����
function AimCommonHT:fnCPanel()
	if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
		local uiGutAward = Ui(Ui.UI_GUTAWARD)
		uiGutAward.OnButtonClick(uiGutAward,"ObjOptional1")
		uiGutAward.OnButtonClick(uiGutAward,"zBtnAccept")
	end
	UiManager:OnPressESC();
	UiManager:CloseWindow(Ui.UI_SYSTEM);
end

------------------------------End-----------------------------------