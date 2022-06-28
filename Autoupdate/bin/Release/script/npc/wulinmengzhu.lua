
local tbWuLinMengZhu = Npc:GetClass("wulinmengzhu");

function tbWuLinMengZhu:OnDialog()
	Dialog:Say("Chỉ cần độ thân mật đạt đến 100, đẳng cấp đạt đến 50 thì đến chỗ ta lập gia tộc. Trên 3 gia tộc thì đến chỗ ta lập bang hội.", 
		{
			{"Lập gia tộc", Kin.DlgCreateKin, Kin},
			{"Lập bang hội", Tong.DlgCreateTong, Tong},
			{"Đổi phe gia tộc", Kin.DlgChangeCamp, Kin},
			{"Đổi phe bang hội", Tong.DlgChangeCamp, Tong},
			{"Nhận Lệnh Bài Gia Tộc", Kin.DlgKinExp, Kin},
			{"Nhận lợi tức bang hội", Tong.DlgTakeStock, Tong},
			{"Hoạt động tuần của gia tộc", Kin.DlgAboutWeeklyAction, Kin},
			{"Thưởng ưu tú bang", Tong.DlgGreatBonus, Tong},
			{"Nhận phần thưởng thi đấu gia tộc", EPlatForm.GetKinAward, EPlatForm},
			{"Đóng"}		
		})
end

function tbWuLinMengZhu:NoAccept()
	Dialog:Say("Tạm không thụ lý việc này, xin trở lại sau.")
end
