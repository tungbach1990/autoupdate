------------------------------------------------------
-- 文件名　：putiguo.lua
-- 创建者　：dengyong
-- 创建时间：2010-01-05 15:40:46
-- 描  述  ：一个菩提果
------------------------------------------------------

local tbItem = Item:GetClass("putiguo");

tbItem.nLimitLevel 		= 120;	-- 120级以下的同伴不能洗等级
tbItem.nLimitStarLevel  = 6.5;	-- 6.5星以上包括6.5星的同伴洗等级需要去龙五太爷那里申请

function tbItem:OnUse()
	if me.IsAccountLock() == 1 then
		local szMsg = "Tài khoản của bạn đang khóa không thể tái sinh đồng hành, vui lòng thử lại.";
		me.Msg(szMsg);
		me.CallClientScript({"UiManager:OpenWindow", "UI_INFOBOARD", szMsg});
		return 0;
	end
	
	local szMsg = "Bồ Đề Quả giúp tái sinh PET 120 hoặc đưa PET về LV1 để cất giữ bạn muốn chọn thao tác nào ?";
	local tbOpt = {};
	for i = 1, me.nPartnerCount do
		local pPartner = me.GetPartner(i - 1);
		if pPartner and pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_LEVEL) >= self.nLimitLevel then		-- 80级以下的同伴不能洗等级
			table.insert(tbOpt, {pPartner.szName, self.OnSelectPartner, self, i - 1, it.dwId});
		end
	end
	
	if #tbOpt == 0 then
		Dialog:Say("Không tái sinh được đồng hành");
		return 0;
	end

	table.insert(tbOpt, {"Để tôi nghĩ lại"});
	Dialog:Say(szMsg, tbOpt);
	
	return 0;
end

function tbItem:OnSelectPartner(nIndex, dwId)
	local pPartner = me.GetPartner(nIndex);
	local pItem = KItem.GetObjById(dwId);
	
	if not pPartner or not pItem then
		return;
	end
	
	if Partner:GetSelfStartCount(pPartner) >= self.nLimitStarLevel * 2 then  -- 配置表中的星级是实际星级的2倍
		local nApplyTime = me.GetTask(Partner.TASK_PEEL_PARTNER_GROUPID, Partner.TASK_PEEL_PARTNER_SUBID);
		if nApplyTime == 0 then
			local szMsg = string.format("Đồng hành trên 6.5 sao có thể tái sinh thêm 1 lần nữa.", Partner.PEELLIMITSTARLEVEL);
			me.Msg(szMsg);
			me.CallClientScript({"UiManager:OpenWindow", "UI_INFOBOARD", szMsg});
			return;
		end
		
		local nDiffTime = GetTime() - nApplyTime;
		if nDiffTime < Partner.PEEL_USABLE_MINTIME then
			local szMsg = string.format("Bạn đã gửi yêu cầu tài sinh đồng hành，sau %0.1f có thể giúp tái sinh đồng hành %0.1f.", 
				(Partner.PEEL_USABLE_MINTIME - nDiffTime)/3600, Partner.PEELLIMITSTARLEVEL);
			me.Msg(szMsg);
			me.CallClientScript({"UiManager:OpenWindow", "UI_INFOBOARD", szMsg});
			return;
		elseif nDiffTime > Partner.PEEL_USABLE_MAXTIME then
			local szMsg = "Yêu cầu tái sinh đồng hành đã hết hạn, vui lòng thử lại.";
			me.Msg(szMsg);
			me.CallClientScript({"UiManager:OpenWindow", "UI_INFOBOARD", szMsg});
			return;
		end	
	end
	
	local tbRetItem = Partner:CalPeelRetItem(pPartner);
	
	local szMsg = string.format("Sau khi tái sinh，Đồng hành của bạn: %s sẽ xuống cấp 1. \n", pPartner.szName);
	for nLevel = 1, 4 do 
		local szItemName = KItem.GetNameById(Partner.tbPartnerJinghua.nGenre, Partner.tbPartnerJinghua.nDetail,
			Partner.tbPartnerJinghua.nParticular, nLevel);
		szMsg = szMsg..string.format("<color=yellow>%d - %s<color>\n", tbRetItem[nLevel] or 0, szItemName);
	end
	
	local tbOpt = 
	{
		{"Ta đồng ý", self.OnConfirmPeel, self, nIndex, dwId},
		{"Kết thúc đối thoại."},
	}
	
	Dialog:Say(szMsg, tbOpt);
end
	
function tbItem:OnConfirmPeel(nIndex, dwId)
	local pPartner = me.GetPartner(nIndex);
	local pItem = KItem.GetObjById(dwId);
	
	if not pPartner or not pItem then
		return;
	end
	
	if pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_LEVEL) < self.nLimitLevel then
		return;
	end
	
	-- 在剥离同伴之前，保存这个同伴的相关信息，操作成功后写入到LOG
	local nPartnerId = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_TEMPID);
	local nLevel = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_LEVEL);
	local nPotentialId = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_PotentialTemp);
	local nPotentialRemained = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_PotentialPoint);
	local nPartnerValue = Partner:GetPartnerValue(pPartner);
	
	local szMsg = string.format("%s	sử dụng %s đưa đồng hành %s về cấp 1", me.szName, pItem.szName, pPartner.szName)
	szMsg = szMsg..string.format("%d, %d, %d, %d, %d, %d, %d, %d, %d",
		nPartnerId, nLevel, nPotentialId, nPotentialRemained, pPartner.GetAttrib(0),
		pPartner.GetAttrib(1), pPartner.GetAttrib(2), pPartner.GetAttrib(3),nPartnerValue
		);
		
	for i = 1, pPartner.nSkillCount do
		local tbSkill = pPartner.GetSkill(i - 1);
		szMsg = szMsg..string.format(", {%d, %d}", tbSkill.nId, tbSkill.nLevel);
	end
		
	local nRes, szLog = Partner:PeelPartner(pPartner);
	if nRes ~= 0 then
		szMsg = szMsg.."。"..szLog;
		Dbg:WriteLog("同伴Log:", szMsg);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_REALTION, szMsg);
		
		me.DelItem(pItem);
	end
end
