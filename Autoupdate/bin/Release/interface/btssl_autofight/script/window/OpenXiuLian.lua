--ˣˣ������ͨ�ð档

function AutoAi:OpenXiuLian()
	local tbFind = me.FindItemInBags(18, 1, 16, 1);
	local pItem = tbFind[1].pItem;
	if (not pItem) then
		me.Msg("�û�������飡")
		return 0;
	end

	local tbItem = Item:GetClass("xiulianzhu");
	local nRemain = tbItem:GetRemainTime();

	if (nRemain < 0.5) then
--		me.Msg("������ʣ��ʱ�䲻��");
		return;
	end
	me.UseItem(pItem);
	local function fnSelect()
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then		
			local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
			for i, tbInfo in ipairs(tbAnswers) do
				if string.find(tbInfo, "��Ҫ��������") or string.find(tbInfo, "���뿴����������") then
					me.AnswerQestion(i -1);
				end
			end
		end
			local function myopen()
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then		
					local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
					for i, tbInfo in ipairs(tbAnswers) do
						if string.find(tbInfo, "��Ҫ��������") or string.find(tbInfo, "��Ҫ����0.5Сʱ") then
							me.AnswerQestion(i -1);
						end
					end
					return 0;
				end
			end
			local function myopen1()
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
					me.AnswerQestion(0);
				end
				return 0;
			end

			local function myclose()
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
				return 0;
			end

		Ui.tbLogic.tbTimer:Register(12, myopen);	-- �ӳ�ѡ��
		Ui.tbLogic.tbTimer:Register(28, myopen1);	-- �ӳ�ѡ��
		Ui.tbLogic.tbTimer:Register(44, myclose);	-- �ӳٹش���
		return 0;
	end
	Ui.tbLogic.tbTimer:Register(8, fnSelect);
end
