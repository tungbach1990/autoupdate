-- �ļ�������partnermiji.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2010-01-19 11:32:29
-- ��  ��  ��ͬ���ؼ�

local tbItem = Item:GetClass("miji_tb");

tbItem.tbBookValue =  
{                          
	600000,    --����      
	3000000,  --�м�       
	18000000 --�߼�        
};         

--��Ӧ�ȼ���Ҫ���Ǽ���(2��ֵ)
tbItem.tbGradeRequire =  
{       
	0,                   
	12,
	16
}; 

function tbItem:OnUse()
	if (Partner.bOpenPartner ~= 1) then
		Dialog:Say("����ͬ���Ѿ��رգ��޷�ʹ����Ʒ");
		return 0;
	end	
	
	self:OnSelectUse(it.dwId);
end

function tbItem:OnSelectUse(dwId, nParam, bSure)
	bSure = bSure or 0;
	
	if me.nPartnerCount <= 0 then
		me.Msg("����ǰ��û��ͬ�飡");
		return 0;
	end
	
	if bSure == 0 then
		local szMsg = "�����������λͬ�����Ӽ��ܵȼ���";
		local tbOpt = {};
		for i = 1, me.nPartnerCount do
			local pPartner = me.GetPartner(i - 1);
			if pPartner then
				table.insert(tbOpt, {pPartner.szName, self.OnSelectUse, self, dwId, i - 1, 1});
			end
		end
		
		table.insert(tbOpt, {"��������"});
		Dialog:Say(szMsg, tbOpt);
		
		return 0;
	else
		local pPartner = me.GetPartner(nParam);
		local pItem = KItem.GetObjById(dwId);
		if not pPartner or not pItem then
			return 0;
		end
		local nCount = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_SKILLBOOK);   --�ø�λ��ʮλ����λ��ʾ��������ļ��������
		if nCount < 0 then
			nCount = 0;
		end
		--���ʹ��ͬ����Ʒ�Ĵ���
		if self:CheckSkillBookCount(nCount) == 1 then
			Dialog:Say("��ͬ���Ѿ�ʹ�ù������ؼ���", {"֪����"});
			return 0;
		end
		
		--�ȼ��ж�
		if pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_LEVEL) < 120 then
			Dialog:Say("ͬ��ȼ�û�дﵽ120��������ʹ�ø���Ʒ��", {"֪����"});
			return 0;
		end
		
		--���ܼ��
		if self:CheckSkill(nParam)  == 1 then
			Dialog:Say("��ͬ��û�е���6���ļ��ܣ�", {"֪����"});
			return 0;
		end		
		
		--6�Ǽ����µ�ͬ��ֻ�ܳԳ����ؼ�6�ǰ뵽8�ǵ�ͬ��ֻ�ܳ��м��ؼ�8�ǰ����ϲ��ܳԸ߼��ؼ�
		if self:CheckPartnerGrade(nParam, dwId) == 1 then
			Dialog:Say("ͬ���ؼ�ʹ�ù���<color=yellow>6�Ǽ�����<color>��ͬ��ֻ�ܳԳ����ؼ�,<color=yellow>6�ǰ뵽8��<color>��ͬ��ֻ�ܳ��м��ؼ�,<color=yellow>8�ǰ�����<color>ֻ�ܳԸ߼��ؼ�,����ͬ�鲻�����Ȿ�ؼ���Ҫ��", {"֪����"});
			return 0;
		end
		self:AddPartnerSkillLevel(nParam, dwId);
	end
	
	return 1;
end

--�����û��С��6���ļ���
function tbItem:CheckSkill(nParam)
	local pPartner = me.GetPartner(nParam);
	if pPartner then
		for i = 1, pPartner.nSkillCount do
			local tbSkill = pPartner.GetSkill(i - 1);
			if tbSkill.nLevel < 6 then
				return 0;
			end
		end
	end
	return 1;
end

--���һ��С��6���ļ��ܼ�һ��
function tbItem:AddPartnerSkillLevel(nParam, dwId)
	local pPartner = me.GetPartner(nParam);
	local pItem = KItem.GetObjById(dwId);
	local tbStatisSkil = {};
	if not pPartner or not pItem then
		return 0;
	end
	local nLevel = pItem.nLevel;
	local szName = pItem.szName;
	--�ҵȼ�С��6�ļ���
	for i = 1, pPartner.nSkillCount do
		local tbSkill = pPartner.GetSkill(i - 1);
		if tbSkill.nLevel < 6 then
			table.insert(tbStatisSkil, {i - 1, tbSkill.nId, tbSkill.nLevel});
		end
	end
	local nAddSkillIndex = MathRandom(#tbStatisSkil); --���һ����������
	pPartner.SetSkill(tbStatisSkil[nAddSkillIndex][1],{["nId"] = tbStatisSkil[nAddSkillIndex][2], ["nLevel"] = tbStatisSkil[nAddSkillIndex][3] + 1});
	me.Msg(string.format("��ʹ��ͬ���ؼ�ʹ����<color=yellow>%s<color>������һ��",KFightSkill.GetSkillName(tbStatisSkil[nAddSkillIndex][2])));
	pItem.Delete(me);
	local nCount = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_SKILLBOOK);
	if nCount < 0 then
		nCount = 0;
	end
	nCount = nCount + 10 ^ (nLevel - 1);
	pPartner.SetValue(Partner.emKPARTNERATTRIBTYPE_SKILLBOOK, nCount);
	PlayerHonor:UpdatePartnerValue(me, 0);
	Dbg:WriteLog("ͬ��Log:", me.szName, "��ͬ��", pPartner.szName,"ʹ��:", szName,"���Ӽ�ֵ��", self.tbBookValue[nLevel]);
	return 1;
end

--���ʹ��ͬ����Ʒ�Ĵ���
function tbItem:CheckSkillBookCount(nCount)
	local nCountEx = 0;
	local nNum = 0;
	for i = 1, 3 do
		nNum = math.fmod(nCount, 10 ^ i);
		nCountEx = nCountEx + math.floor(nNum / (10 ^ (i - 1)));
	end
	if nCountEx >= 2 then
		return 1;
	end
	return 0;
end

function tbItem:CheckPartnerGrade(nParam, dwId)
	local pPartner = me.GetPartner(nParam);
	local pItem = KItem.GetObjById(dwId);
	if not pPartner or not pItem then
		return 1;
	end
	local nLevel = pItem.nLevel;
	local nGradeXing = Partner:GetSelfStartCount(pPartner);
	if nGradeXing > self.tbGradeRequire[nLevel] and (not self.tbGradeRequire[nLevel + 1] or nGradeXing <= self.tbGradeRequire[nLevel + 1]) then		
		return 0;
	end
	return 1;
end
