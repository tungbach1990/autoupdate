-- �ļ�������coreclientmail.lua
-- �����ߡ���furuilei
-- ����ʱ�䣺2009-04-07 10:03:09

------------------------------------------------------
-- �ż����ݸ�ʽ˵��
-- nStartSendTime: �ʼ��Ŀ�ʼ����ʱ��														(����)
-- szCaption: �ʼ�����																		(����)
-- szContent: �ʼ�����																		(����)
------------------------------------------------------

Mail.MAX_MAIL_COUNT = 20;	-- ���20��ͻ���ϵͳ�ʼ�
Mail.MAIL_EXIST_TIME = 30 * 24 * 3600;	-- ÿ���ʼ��ӷ��ͳ�ȥ���Զ�ɾ���Ĵ���������1����
Mail.DONOT_SEND_TIME = 60 * 24 * 3600;	-- ÿ���ʼ��ӽ�����ʱ����2����֮�����������Σ�����Ҫ������
Mail.TASK_GROUP_MAIL_TIME = 2087;	-- �ʼ��Ľ���ʱ��
Mail.TASK_GROUP_MAIL_STAT = 2088;	-- �ʼ���״̬���(0.δ�� 1.�Ѷ� 2.ɾ��)
Mail.TASK_GROUP_MAIL_INDEX = 2089;	-- �ʼ���Ӧ�����к�

Mail.IdMap = {};	-- �������ĳһ���ʼ��Ƿ񱻼�����
Mail.nCoverIndex = 0;	-- �����������ʼ�������ʱ����Ը��ǵ��ʼ�Index
Mail.nMaxMailIndex = 0;	-- ��¼��ǰʱ���Ѿ������˵������ʼ���ID


Mail.tbMailList = 
{
------------------------------------------------------
-- 	һ����ʾʾ�����£�
--	[1] =
--	{
--		nStartSendTime = 20090408; -- �ʼ���ʼ����ʱ��
-- 		nExistTime = 60;			-- (��ѡ)���ʼ�����Ч�ڣ���������Ч�ڲ��ٷ��ͣ���λ����
--		szCaption = "�ʼ�ʾ��";
--		szContent = "�ʼ�����ʾ��";
--	},
------------------------------------------------------
-- Attention: ���Ҫ��ӿͻ���ϵͳ�ʼ����ʼ�������������ӣ�����


};

-- �����ʼ�״̬
function Mail:SetTaskDoubleBit(nIndex, nState)
	if (nIndex and nIndex >= 1 and nIndex <= self.MAX_MAIL_COUNT) then
		if (nState == 2) then
			me.SetTaskBit(self.TASK_GROUP_MAIL_STAT, 2 * nIndex - 1, 1);
			me.SetTaskBit(self.TASK_GROUP_MAIL_STAT, 2 * nIndex, 0);
		elseif (nState == 1) then
			me.SetTaskBit(self.TASK_GROUP_MAIL_STAT, 2 * nIndex - 1, 0);
			me.SetTaskBit(self.TASK_GROUP_MAIL_STAT, 2 * nIndex, 1);
		elseif (nState == 0) then
			me.SetTaskBit(self.TASK_GROUP_MAIL_STAT, 2 * nIndex - 1, 0);
			me.SetTaskBit(self.TASK_GROUP_MAIL_STAT, 2 * nIndex, 0);
		end
	end
end

-- ��ȡ�ʼ�״̬
function Mail:GetTaskDoubleBit(nIndex)
	local nTemp1 = me.GetTaskBit(self.TASK_GROUP_MAIL_STAT, 2 * nIndex - 1);
	local nTemp2 = me.GetTaskBit(self.TASK_GROUP_MAIL_STAT, 2 * nIndex);
	if (nTemp1 == 1 and nTemp2 == 0) then
		return 2;
	elseif (nTemp1 == 0 and nTemp2 == 1) then
		return 1;
	elseif (nTemp1 == 0 and nTemp2 == 0) then
		return 0;
	end
end

function Mail:FindNextCoverIndex()
	local nId = me.GetTask(self.TASK_GROUP_MAIL_INDEX, 1);
	for i = 1, self.MAX_MAIL_COUNT do
		local nIndex = me.GetTask(self.TASK_GROUP_MAIL_INDEX, i);
		if (nIndex <= nId) then
			nId = nIndex;
			self.nCoverIndex = i;
		end
	end
end

-- ������ЧTaskId����Ŀ
function Mail:CountAvailableTaskId()
	local nSum = 0;
	for i = 1, self.MAX_MAIL_COUNT do
		if (0 ~= me.GetTask(self.TASK_GROUP_MAIL_INDEX, i)) then
			nSum = nSum + 1;
		end
	end
	return nSum;
end

-- ���û�ж�Ӧ�����������ʾ�ʼ��Ļ���Ϊ���ʼ������������
-- ���ض�Ӧ�ʼ��ķ���ʱ���״̬
function Mail:CreateNewMail(nIndex)
	if (nIndex < 1 or not self.tbMailList[nIndex]) then
		return;
	end
	-- �Ƿ���ҪΪ���ʼ�����һ���µ��������
	if (self.tbMailList[nIndex]) then
		local tbMail = self.tbMailList[nIndex];
		local nExistTime = self.DONOT_SEND_TIME;
		if (tbMail.nExistTime) then
			nExistTime = tbMail.nExistTime * 24 * 3600;
		end
		if (Lib:GetDate2Time(tbMail.nStartSendTime) > GetTime()) then
			return;
		end
		if (GetTime() - Lib:GetDate2Time(tbMail.nStartSendTime) < nExistTime and self.nMaxMailIndex < nIndex and
			(not self.IdMap[nIndex] or (self.IdMap[nIndex] and 1 ~= self.IdMap[nIndex]))) then
			for i = 1, self.MAX_MAIL_COUNT do
				if (0 == me.GetTask(self.TASK_GROUP_MAIL_INDEX, i)) then
					me.SetTask(self.TASK_GROUP_MAIL_INDEX, i, nIndex);
					me.SetTask(self.TASK_GROUP_MAIL_TIME, i, GetTime());
					self:SetTaskDoubleBit(i, 0);
					self.IdMap[nIndex] = 1;
					if (self.nMaxMailIndex < nIndex) then
						self.nMaxMailIndex = nIndex;
					end
					return GetTime(), 0;
				end
			end
			-- �����������ܹ���ʾ���ʼ�����������ǰ����ʼ�
			if (self.MAX_MAIL_COUNT <= self:CountAvailableTaskId()) then
				self:FindNextCoverIndex();
				me.SetTask(self.TASK_GROUP_MAIL_INDEX, self.nCoverIndex, nIndex);
				me.SetTask(self.TASK_GROUP_MAIL_TIME, self.nCoverIndex, GetTime());
				self:SetTaskDoubleBit(self.nCoverIndex, 0);
				self.IdMap[nIndex] = 1;
				if (self.nMaxMailIndex < nIndex) then
					self.nMaxMailIndex = nIndex;
				end
				return GetTime(), 0;
			end
		end
	end
	return;
end


-- ����nTaskId����������Ƿ����
-- �ñ���������ż���ʼ����ʱ����2���º���ٴ�������ʾ�����ʼ�
function Mail:IsTaskIdAvailable(nTaskId)
	local nIndex = me.GetTask(self.TASK_GROUP_MAIL_INDEX, nTaskId);
	if (nIndex <= 0) then
		return 0;
	end
	if (self.tbMailList[nIndex]) then
		local tbMail = self.tbMailList[nIndex];
		if (tbMail.nExistTime) then
			local nExistTime = tbMail.nExistTime * 24 * 3600;
			if (GetTime() - Lib:GetDate2Time(tbMail.nStartSendTime) >= nExistTime) then
				return 0;
			end
		else
			if (GetTime() - Lib:GetDate2Time(tbMail.nStartSendTime) >= self.DONOT_SEND_TIME) then
				return 0;
			end
		end
		local nSendTime = me.GetTask(self.TASK_GROUP_MAIL_TIME, nTaskId);
		if (nSendTime ~= 0 and GetTime() - nSendTime >= self.MAIL_EXIST_TIME) then
			return 2;
		end
		return 1;
	end
	return 0;
end

function Mail:Init()
	self.IdMap = {};
	self.nMaxMailIndex = 0;
	for i = 1, self.MAX_MAIL_COUNT do
		local nCurIndex =  me.GetTask(self.TASK_GROUP_MAIL_INDEX, i)
		if (nCurIndex > self.nMaxMailIndex) then
			self.nMaxMailIndex = nCurIndex;
		end
		local bIsTaskIdAvailable = self:IsTaskIdAvailable(i)
		if (0 == bIsTaskIdAvailable) then
			me.SetTask(self.TASK_GROUP_MAIL_INDEX, i, 0);
			me.SetTask(self.TASK_GROUP_MAIL_TIME, i, 0);
			self:SetTaskDoubleBit(i, 2);
		elseif (2 == bIsTaskIdAvailable) then
			self:SetTaskDoubleBit(i, 2);
		end
	end
end

function Mail:ReadClientMail()
	local tbMailList = {};
	for i = self.nMaxMailIndex + 1, #self.tbMailList do
		self:CreateNewMail(i);
	end
	for i = 1, self.MAX_MAIL_COUNT do
		local nIndex = me.GetTask(self.TASK_GROUP_MAIL_INDEX, i);
		if (nIndex > 0 and self.tbMailList[nIndex]) then
			local tbMail = self.tbMailList[nIndex];
			local nSendTime = me.GetTask(self.TASK_GROUP_MAIL_TIME, i);
			local nState = self:GetTaskDoubleBit(i);
			if (tbMail.szCaption and tbMail.szContent and tbMail.nStartSendTime 
				and Lib:GetDate2Time(tbMail.nStartSendTime) < GetTime()) then
				tbMail.nId = -nIndex;
				tbMail.nState = nState or 0;
				tbMail.nType = 0;										-- �ʼ�������ϵͳ�ʼ���һ��Ϊ0
				tbMail.szReceiver = me.szName;
				local szSenderName = "ϵͳ";
				if IVER_g_nSdoVersion == 1 then
					szSenderName = "ʢ������";
				end
				tbMail.szSender = szSenderName;
				tbMail.nTime = math.floor((GetTime() - nSendTime) / (3600 * 24));
				if (nState ~= 2) then
					table.insert(tbMailList, tbMail);
				end
			end
		end
	end
	return tbMailList, Lib:CountTB(tbMailList);
end

-- ��tbMailList���еĵ�nIndex��������ΪnState״̬
function Mail:SetState(nIndex, nState)
	if (nIndex < 1 or not self.tbMailList[nIndex] or nState < 0 or nState > 2) then
		return;
	end
	for i = 1, self.MAX_MAIL_COUNT do
		local nMailIndex = me.GetTask(self.TASK_GROUP_MAIL_INDEX, i);
		if (nIndex == nMailIndex) then
			self:SetTaskDoubleBit(i, nState);
			return 1;
		end
	end
	return;
end

function Mail:SelectClientMail(nMailId)
	if (nMailId >= 0) then
		return;
	end
	local nIndex = -nMailId;
	if (self.tbMailList[nIndex]) then
		local tbMailTemp = self.tbMailList[nIndex];
		if (nIndex) then
			local tbMail = {};
			tbMail.nMailId = nMailId;
			tbMail.nPicId = 0;
			tbMail.szContent = tbMailTemp.szContent;
			tbMail.nMoney = 0;
			tbMail.nItemCount = 0;
			tbMail.nItemIdx = 0;
			self:AddMailContent(tbMail);
			self:SetState(nIndex, 1);
		end
	end
end

function Mail:DeleteMail(nMailId)
	if (nMailId >= 0) then
		return;
	end
	local nIndex = -nMailId;
	if (self.tbMailList[nIndex]) then
		for i = 1, self.MAX_MAIL_COUNT do
			local nId = me.GetTask(self.TASK_GROUP_MAIL_INDEX, i);
			if (nId == nIndex) then
				self:SetTaskDoubleBit(i, 2);
			end
		end
	end
end
