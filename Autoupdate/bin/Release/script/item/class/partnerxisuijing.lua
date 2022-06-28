------------------------------------------------------
-- �ļ�������partnerxisuijing.lua
-- �����ߡ���dengyong
-- ����ʱ�䣺2009-12-30 14:45:11
-- ��  ��  �����·���ͬ��Ǳ��ģ��ĵ���
------------------------------------------------------

local tbItem = Item:GetClass("partnerxisuijing");

function tbItem:OnUse()
	if (Partner.bOpenPartner ~= 1) then
		Dialog:Say("����ͬ���Ѿ��رգ��޷�ʹ����Ʒ");
		return 0;
	end	
	
	self:OnSelectUse(it.dwId);
end

-- ����OnUse�ӿڵ�������ʱ��nParamӦ����Ĭ�ϲ�����bSureΪnil
-- �����Լ������Լ�ʱ��nParamΪͬ������
function tbItem:OnSelectUse(dwId, nParam, bSure)
	bSure = bSure or 0;
	
	if me.nPartnerCount <= 0 then
		me.Msg("����ǰ��û��ͬ�飡");
		return 0;
	end
	
	if bSure == 0 then
		local szMsg = "�����������λͬ��ϴǱ�ܣ�";
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
	
		-- ����ϴ�辭�Ĳ�ͬ��������ͬ����ʾ��Ϣ
		local szType = (pItem.GetExtParam(1) == 0) and "�������" or "ָ���µ�";	
		local szMsg = string.format("��ȷ��Ҫ��ͬ��%s%sǱ��ģ����", pPartner.szName, szType);
		local tbOpt = 
		{
			{"ȷ��", self.OnConfirmReset, self, nParam, dwId},
			{"��������"},
		}
	
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	
	return 1;
end

function tbItem:OnConfirmReset(nPartnerIndex, dwId)
	local pPartner = me.GetPartner(nPartnerIndex);
	local pItem = KItem.GetObjById(dwId);
		
	if not pPartner or not pItem then
		return 0;
	end
				
	if pItem.GetExtParam(1) == 0 then	-- �������Ǳ��ģ��
		local nPotentialTemp = Partner:RandomPotentialTemp(me);
		self:ResetPotential(pPartner.nPartnerIndex, dwId, nPotentialTemp);
	else	-- �����ѡ��ָ����Ǳ��ģ��
		local szMsg = "��ѡ��Ǳ��ģ�壺";
		local tbOpt = 
		{
			{"��50%���⹦50%", self.ResetPotential, self, pPartner.nPartnerIndex, dwId, 1},
			{"�⹦50%���ڹ�50%", self.ResetPotential, self, pPartner.nPartnerIndex, dwId, 2},
			{"����30%����30%���⹦40%", self.ResetPotential, self, pPartner.nPartnerIndex, dwId, 3},
			{"����30%����20%���⹦50%", self.ResetPotential, self, pPartner.nPartnerIndex, dwId, 4},
			{"����40%����20%���⹦40%", self.ResetPotential, self, pPartner.nPartnerIndex, dwId, 5},
			{"����40%����30%���⹦30%", self.ResetPotential, self, pPartner.nPartnerIndex, dwId, 6},
			{"����40%����10%���⹦50%", self.ResetPotential, self, pPartner.nPartnerIndex, dwId, 7},
			{"����40%����10%���⹦10%���ڹ�40%", self.ResetPotential, self, pPartner.nPartnerIndex, dwId, 8},
			{"����50%����20%���⹦30%", self.ResetPotential, self, pPartner.nPartnerIndex, dwId, 9},
			{"��������"},
		};
	
		Dialog:Say(szMsg, tbOpt);
		
		return 0;
	end	
end

function tbItem:ResetPotential(nPartnerIndex, dwId, nPotentialTemp)
	local pPartner = me.GetPartner(nPartnerIndex);
	local pItem = KItem.GetObjById(dwId);
	
	if not pPartner or not pItem then
		return;
	end
	
	local nPotentialTempOrg = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_PotentialTemp); -- ֮ǰ��Ǳ��ģ��ID
	local tbPotentialOrg = {};
	for nAttribIndex = 0, 3 do
		tbPotentialOrg[nAttribIndex] = pPartner.GetAttrib(nAttribIndex);		
	end
	local nPotentialBalanceOrg = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_PotentialPoint);
	
	local nRet = 0;
	nRet = Partner:ResetPartnerPotential(pPartner, nPotentialTemp);
	
	-- �۳�����
	if nRet ~= 0 then		
		local szItemName = pItem.szName;  --�ȼ�¼���ߵ����֣�дLOG��
		Partner:ConsumePartnerItem(pItem, me);
		
		local tbPotentialNow = {};
		for nAttribIndex = 0, 3 do
			tbPotentialNow[nAttribIndex] = pPartner.GetAttrib(nAttribIndex);
		end
		-- ϴ��֮��ʣ��δ�����Ǳ�ܵ���
		local nPotentialBalanceNow = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_PotentialPoint);
		
		local szMsg = string.format("%sʹ�õ���%s��ͬ��%s��Ǳ��ģ���{%d_%d_%d_%d_%d_%d}ϴ����{%d_%d_%d_%d_%d_%d}", 
			me.szName, szItemName, pPartner.szName,
			nPotentialTempOrg, tbPotentialOrg[0], tbPotentialOrg[1], tbPotentialOrg[2], tbPotentialOrg[3],
			nPotentialBalanceOrg,
			nRet, tbPotentialNow[0], tbPotentialNow[1], tbPotentialNow[2], tbPotentialNow[3],
			nPotentialBalanceNow);
			
		Dbg:WriteLog("ͬ��Log:", szMsg);
		
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_REALTION, szMsg);
		me.Msg(string.format("����ͬ��%sʹ����%s", pPartner.szName, szItemName));
	end
end
