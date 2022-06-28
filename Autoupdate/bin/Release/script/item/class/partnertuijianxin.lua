------------------------------------------------------
-- �ļ�������partnertuijianxin.lua
-- �����ߡ���dengyong
-- ����ʱ�䣺2010-01-05 17:42:14
-- ��  ��  ��ͬ���Ƽ���
------------------------------------------------------

local tbItem = Item:GetClass("partnertuijianxin");

function tbItem:OnUse()
	if (Partner.bOpenPartner ~= 1) then
		Dialog:Say("����ͬ���Ѿ��رգ��޷�ʹ����Ʒ");
		return 0;
	end

	local szMsg = "ʹ���Ƽ��ţ�ͬ�齫���Ա����ף�<color=yellow>ͬʱͬ������ܶȺ�����ȶ���ָ���Ĭ��ֵ<color>��ȷ��ʹ����";
	local tbOpt = {};
	
	for i = 1, me.nPartnerCount do
		local pPartner = me.GetPartner(i - 1);
		-- ֻ��һ����ͬ��ſ���
		if pPartner and pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_LEVEL) == 1 then
			table.insert(tbOpt, {pPartner.szName, self.InsertAPartner, self, i - 1, it.dwId});
		end
	end
	
	if #tbOpt == 0 then
		me.Msg("���������û��1��ͬ�飡");
		Dialog:Say("���������û��1��ͬ�飡");
		return 0;
	end
	
	table.insert(tbOpt, {"ȡ��"});
	Dialog:Say(szMsg, tbOpt);
	return 0;
end

function tbItem:InsertAPartner(nIndex, dwId)
	local pPartner = me.GetPartner(nIndex);
	local pItem = KItem.GetObjById(dwId);
	
	if not pPartner or not pItem then
		return;
	end
	
	if pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_LEVEL) > 1 then
		me.Msg("��ֻ�ܸ�1����ͬ��д�Ƽ��ţ�");
		return;
	end
	
	-- ��ͬ��������۵�ͬ����֮ǰ���Ȱ�ͬ�����Ϣ��¼�����������ɹ�֮��д����־
	local nPartnerId = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_TEMPID);
	local nLevel = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_LEVEL);
	local nPotentialId = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_PotentialTemp);
	local nPotentialRemained = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_PotentialPoint);
	local nPartnerValue = Partner:GetPartnerValue(pPartner);
	
	local szMsg = string.format("%s��ͬ��%sд�Ƽ��ţ�", me.szName, pPartner.szName);
	szMsg = szMsg..string.format("%d, %d, %d, %d, %d, %d, %d, %d, %d",
		nPartnerId, nLevel, nPotentialId, nPotentialRemained, pPartner.GetAttrib(0),
		pPartner.GetAttrib(1), pPartner.GetAttrib(2), pPartner.GetAttrib(3),nPartnerValue
		);
		
	for i = 1, pPartner.nSkillCount do
		local tbSkill = pPartner.GetSkill(i - 1);
		szMsg = szMsg..string.format(", {%d, %d}", tbSkill.nId, tbSkill.nLevel);
	end
	
	local nRes, pAddItem = Partner:TurnPartnerToItem(me, pPartner);
	if nRes ~= 0 then
		Partner:ConsumePartnerItem(pItem, me);
		
		szMsg = szMsg..string.format("����˵���%s��", pAddItem.szName);
		local nParnterTempId, nPotentialTemp, tbSkillId = Item:GetClass("childpartner"):ParseGenInfo(pAddItem);
		szMsg = szMsg..string.format("ͬ��ģ��ID��%d, Ǳ��ģ��ID��%d, ����ID��{", nParnterTempId, nPotentialTemp);
		for _, nItemSkillId in pairs(tbSkillId) do
			szMsg = szMsg..string.format(" %d,", nItemSkillId);
		end
		szMsg = szMsg.."}";
		
		Dbg:WriteLog("ͬ��Log:", szMsg);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_REALTION, szMsg);
	end
end