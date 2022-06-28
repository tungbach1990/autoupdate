-----------------------------------------------------
--�ļ���		��	mail.lua
--������		��	zouying@kingsoft.net
--����ʱ��		��	2007-10-17
--��������		��	�ż�ϵͳ�ű���
------------------------------------------------------

Mail.nMailCount = 0;	

Mail.MAILCONDTYPE  = 0;
Mail.MAILOTHERTYPE = 1;

function Mail:SwitchWindow()
	if (UiManager:WindowVisible(Ui.UI_MAIL) ~= 0)then
		UiManager:CloseWindow(Ui.UI_MAIL);
		return;
	end
	-- ��ֹ�������
	if self.nLastOpenTime == os.clock() then
		return;
	end
	self.nLastOpenTime = os.clock();
		
	me.CallServerScript({ "MailCmd", "ApplyOpen" });
end

function Mail:OnAcceptOpen(nAccept)
	if nAccept ~= 1 then
		me.Msg("��ǰ��ͼ����������䣡")
		UiManager:CloseWindow(Ui.UI_MAIL);	-- �ر��������
	else
		UiManager:OpenWindow(Ui.UI_MAIL);
	end
end

function Mail:RequestMailList(nMailType)
	me.RequestMailList(nMailType);
end

function Mail:FilterInfo(szMsg)
	if szMsg then
		szMsg = string.gsub(szMsg, "<bclr=[^>]*>", "");
		szMsg = string.gsub(szMsg, "<color=[^>]*>", "");
	end
	return szMsg;
end

function Mail:SyncMailList(tbMailList)
	local tbTempData = me.GetTempTable("Mail");
	tbTempData.tbMailList = {};
	tbTempData.tbMailListID = {};
	
	self:Init();
	local tbClientMail, nClientMailCount = self:ReadClientMail();
	if (tbClientMail and 0 ~= nClientMailCount) then
		for i = 1, nClientMailCount do
			tbClientMail[i].byClient = 1;
			table.insert(tbTempData.tbMailList, tbClientMail[i]);
			-- tbTempData.tbMailList[i].byClient = 1;
			tbTempData.tbMailListID[tbClientMail[i].nId] = tbClientMail[i];
		end
	end
	
	for i = 1, #tbMailList do
		if tbMailList[i].nType == 1 then
			tbMailList[i].szCaption = self:FilterInfo(tbMailList[i].szCaption);
		end
		
		tbMailList[i].byClient = 0;
		table.insert(tbTempData.tbMailList, tbMailList[i]);
		-- tbTempData.tbMailList[i + nClientMailCount].byClient = 0;
		tbTempData.tbMailListID[tbMailList[i].nId] = tbMailList[i];
	end
	self.nMailCount = Lib:CountTB(tbTempData.tbMailList);
	CoreEventNotify(UiNotify.emCOREEVENT_SYNC_MAIL_LIST);
end

function Mail:AddMailContent(tbMailContent)
	local tbTempData = me.GetTempTable("Mail");
	tbTempData.tbMailContent = tbMailContent;
	UiManager:OpenWindow(Ui.UI_MAILVIEW);
	CoreEventNotify(UiNotify.emCOREEVENT_SHOW_MAILCONTENT);
end

function Mail:RequestOpenNewMail(tbParam)
	if me.IsAccountLock() ~= 0 then
		me.Msg("�˺Ŵ�������״̬�����ܷ����ż���");
		return 0;
	end
	self.tbParam = tbParam;
	me.CallServerScript({ "MailCmd", "ApplyOpenNewMail" });
	return 1;
end

function Mail:OnAcceptOpenNewMail()
	if (self.tbParam) then
		UiManager:OpenWindow(Ui.UI_MAILNEW, self.tbParam);
	else
		UiManager:OpenWindow(Ui.UI_MAILNEW);
	end
end

--	emKMAIL_ERR_BOXFULL = 1,			// ��������
--	emKMAIL_ERR_RECEIVER,				// �ռ��˴��� �ռ��˲���ȷ�����ռ��뷢������ͬ
--	emKMAIL_ERR_MONEY,					// ��Ǯ����
--	emKMAIL_ERR_ITEM,					// ��Ʒ����
--	emKMAIL_ERR_MONEY_TONG,				// ���Ǯ����
--	
function Mail:MailFailReason(nReason)
	local szMsg = "�����ż�ʧ�ܣ�";
	if (nReason == 1) then
		szMsg = szMsg .. "��������!";
	elseif (nReason == 2) then
		szMsg = szMsg .."�ռ��˲���ȷ�����ռ��뷢������ͬ!";
	elseif (nReason == 3) then
		szMsg = szMsg .. "�������㣡";
	elseif (nReason == 4) then
		szMsg = szMsg .. "��Ʒ����";
	elseif (nReason == 5) then
		szMsg = szMsg .. "���Ǯ����";
	end
	me.Msg(szMsg);
	return ;			
end

function Mail:MailBoxLoadOk(bShowMsg)
	if (bShowMsg and bShowMsg == 1) then
		me.Msg("�ż�������ɣ�");
	end
	me.SetMailBoxLoadOk();
	CoreEventNotify(UiNotify.emCOREEVENT_MAIL_LOADED);
end


-- ��ȡ��ͨ�ʼ�����
function Mail:RequireMail(nMailId, byClient)
	if (not nMailId or not byClient) then
		return 0;
	end
	if (byClient == 0) then
		me.RequestMail(nMailId);
	elseif (byClient == 1) then
		self:SelectClientMail(nMailId);
	end	
end

function Mail:DeleteMailRequest(nMailId, byClient)
	if (not nMailId or not byClient) then
		return 0;
	end
	if (byClient == 0) then
		me.DeleteMail(nMailId);
	elseif (byClient == 1) then
		self:DeleteMail(nMailId);
	end	
end
