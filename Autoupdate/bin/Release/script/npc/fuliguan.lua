local tbFuLiGuan = Npc:GetClass("fuliguan");


function tbFuLiGuan:OnDialog()
	Dialog:Say("Xin chào, có việc gì không?",
		{
			{"Kiểm tra chi tiết nộp thuế", self.Demand, self},
			{"Kết thúc đối thoại"}
		})
end

function tbFuLiGuan:ApplyWelfare()
	local nRet = TradeTax:ApplyWelfare(me);
	if nRet ~= 1 then
		if nRet == 0 then
			Dialog:Say("Uy danh giang hồ của bạn không đủ "..TradeTax.MIN_WEIWANG..", không thể xin lãnh phúc lợi");
			return 0; 
		elseif nRet == 2 then
			Dialog:Say("Bạn đã xin lãnh rồi")
		elseif nRet == 3 then
			Dialog:Say("Bạn chưa nhận phúc lợi tuần rồi nên không được xin thêm phúc lợi tuần này. Phải nhận phúc lợi tuần rồi trước đã.");
		end
		return 0;
	end
	Dialog:Say("Bạn đã có tư cách nhận phúc lợi tuần này, hãy đến nhận trong vòng thứ 2 đến chủ nhật tuần sau, quá hạn sẽ vô hiệu.");
end

function tbFuLiGuan:TakeWelfare(bConfirm)
	if bConfirm == 1 then
		TradeTax:TakeWelfare(me, 1);
		return 0;
	end
	local nWelfare = TradeTax:TakeWelfare(me);
	if nWelfare < 0 then
		if nWelfare == -1 then
			Dialog:Say("Tuần rồi bạn chưa xin nhận phúc lợi hoặc đã nhận rồi, không được nhận thêm nữa.");
		end
		return 0;
	end
	local szMsg = string.format("Phúc lợi tuần trước của bạn là %s lượng. Nếu muốn nhận phúc lợi tuần này, phải làm thủ tục xin nhận.", nWelfare);
	Dialog:Say(szMsg,
		{
			{"Đồng ý", self.TakeWelfare, self, 1};
		});
end

function tbFuLiGuan:Demand()
	TradeTax:Check(me);
	
	TradeTax:CheckTaxReagion();
		
	local nRemain = 0;
	local nTaxCount = 0;
	local nAmount = me.GetTask(TradeTax.TAX_TASK_GROUP, TradeTax.TAX_AMOUNT_TASK_ID);	-- 本周交易额
	if nAmount > TradeTax.TAX_REGION[1][1] then
		nTaxCount = me.GetTask(TradeTax.TAX_TASK_GROUP, TradeTax.TAX_ACCOUNT_TASK_ID)
	else
		nRemain = TradeTax.TAX_REGION[1][1] - nAmount;
	end
	local nTaxRate = 0;
	for i = 1, #TradeTax.TAX_REGION do
		if nAmount >= TradeTax.TAX_REGION[i][1] then
			if TradeTax.TAX_REGION[i + 1] then
				nTaxRate = TradeTax.TAX_REGION[i + 1][2];
			else
				nTaxRate = TradeTax.TAX_REGION_MAXNUMBER; --最后的一个税率
			end
		end
	end
	local szMsg = string.format("Ngạch miễn thuế của ngươi trong tuần còn <color=red>%s<color> lượng, mức nộp thuế là <color=red>%s<color> lượng, thuế suất hiện nay là <color=red>%s<color>", nRemain, nTaxCount, nTaxRate*100).."%";
	Dialog:Say(szMsg);
end

