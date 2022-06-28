local tbLiGuan = Npc:GetClass("liguan");

function tbLiGuan:OnDialog()
	local szMsg = "Xin chào, ta có thể giúp được gì?";
	local tbOpt = 
	{
		{"Nhận phúc lợi", self.FuLi, self},
		{"Đoán hoa đăng",GuessGame.OnDialog,GuessGame},
		{"Kết thúc đối thoại"},
	}
	
	if Baibaoxiang:CheckChangeBack() == 1 then
		table.insert(tbOpt, 3, {"<color=yellow>Ta đến đổi Vỏ sò<color>", self.ChangeBack, self});
	end

	if Baibaoxiang:CheckState() == 1 then
		table.insert(tbOpt, 3, {"<color=yellow>Bách Bảo Rương<color>", self.Baibaoxiang, self});
	end
	
	if (VipPlayer:CheckPlayerIsVip(me.szAccount, me.szName) == 1) then
		table.insert(tbOpt, 3, {"Chiết khấu cho người chơi VIP", VipPlayer.OnDialog, VipPlayer, me});
	end
	
	if Wldh.Qualification:CheckChangeBack() == 1 then
		table.insert(tbOpt, 3, {"<color=yellow>Thu hồi Anh Hùng Thiếp<color>", Wldh.Qualification.ChangeBackDialog, Wldh.Qualification});
	end
	
	if me.nLevel >= 50 then
		table.insert(tbOpt, 2, {"Ta muốn chúc phúc",self.QiFu, self});
	end
	if SpecialEvent.CompensateGM:CheckOnNpc() > 0 then
		table.insert(tbOpt, 2, {"Nhận vật phẩm",SpecialEvent.CompensateGM.OnAwardNpc, SpecialEvent.CompensateGM});
	end
	
	if Esport:CheckState() == 1 then
		szMsg = "Năm mới tết đến, lão đi chúc tết khắp nơi, có duyên gặp nhau, tặng ngươi món quà làm kỷ niệm.";
		local tbNewYearNpc = Npc:GetClass("esport_yanruoxue");
		table.insert(tbOpt, 2, {"Tìm hiểu hoạt động Lễ Quan chúc tết, bắn pháo hoa",tbNewYearNpc.OnAboutYanHua, tbNewYearNpc});
		table.insert(tbOpt, 2, {"Tìm hiểu hoạt động năm mới",tbNewYearNpc.OnAboutNewYears, tbNewYearNpc});
	end
	
	if SpecialEvent.YuanXiao2009:CheckState() == 1 then
		table.insert(tbOpt, 2, {"Tặng quà người chơi mừng Nguyên Tiêu",SpecialEvent.YuanXiao2009.OnDialog, SpecialEvent.YuanXiao2009});		
	end	
	
	if (EventManager.ExEvent.tbPlayerCallBack:IsOpen(me, 4) == 1) then
		table.insert(tbOpt, 2, {"Hoạt động kêu gọi người chơi cũ",EventManager.ExEvent.tbPlayerCallBack.OnDialog, EventManager.ExEvent.tbPlayerCallBack});
	end
	
	if SpecialEvent.ChangeLive:CheckState() == 1 then
		table.insert(tbOpt, 1, {"Liên quan việc Võ Lâm chuyển Kiếm Thế",SpecialEvent.ChangeLive.OnDialog, SpecialEvent.ChangeLive});		
	end	
	
	if VipPlayer.VipTransfer:CheckQualification(me) > 0 then
		table.insert(tbOpt, 1, {"<color=yellow>Vip chuyển server<color>", VipPlayer.VipTransfer.DialogNpc.OnDialog, VipPlayer.VipTransfer.DialogNpc});
	end

	if (Player.tbOffline:CheckExGive() == 1) then
		table.insert(tbOpt, 1, {"Bồi thường thời gian ủy thác rời mạng khi gộp server", Player.tbOffline.GiveExOfflineTime, Player.tbOffline});
	end

	if (SpecialEvent.CompensateCozone:CheckFudaiCompenstateState(me) == 1) then
		table.insert(tbOpt, 1, {"Bồi thường gộp server_Túi Phúc", SpecialEvent.CompensateCozone.OnFudaiDialog, SpecialEvent.CompensateCozone});
	end

	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:QiFu()
	me.CallClientScript({"UiManager:OpenWindow", "UI_PLAYERPRAY"});
end

function tbLiGuan:Baibaoxiang()
	me.CallClientScript({"UiManager:OpenWindow", "UI_BAIBAOXIANG"});
end

function tbLiGuan:ChangeBack()
	local tbOpt = 
	{
		{"Vỏ sò vàng đổi Tinh Hoạt Hồn Thạch", self.DoChangeBack, self, 1},
		{"Vỏ sò thần bí đổi Hoạt Lực Hồn Thạch", self.DoChangeBack, self, 2},
		{"Vỏ sò thần bí-Rương đổi Hoạt Lực Hồn Thạch", self.DoChangeBack, self, 3},
		{"Kết thúc đối thoại"},
	}
	Dialog:Say("Ở đây có thể đổi Vỏ sò vàng/Vỏ sò thần bí/Vỏ sò thần bí-Rương đổi thành nguyên liệu", tbOpt);
end

function tbLiGuan:DoChangeBack(nType)
	
	local szMsg;
		
	if nType == 1 then
		szMsg = "Ta muốn đổi Vỏ sò vàng: <color=yellow>1 Vỏ sò vàng đổi được 2 Hồn Thạch, 225 Tinh lực, 200 Hoạt lực<color>";
	elseif nType == 2 then
		szMsg = "Ta muốn đổi Vỏ sò thần bí: <color=yellow>1 Vỏ sò thần bí đổi được 1 Hồn Thạch, 100 Hoạt lực<color>";
	elseif nType == 3 then
		szMsg = "Ta muốn đổi Vỏ sò thần bí-Rương: <color=yellow>1 Vỏ sò thần bí-Rương có thể đổi 200 Hồn thạch, 20000 điểm Hoạt lực<color>";
	end
		
	Dialog:OpenGift(szMsg, nil, {Baibaoxiang.OnChangeBack, Baibaoxiang, nType});
end

function tbLiGuan:FuLi()
	local tbOpt = 
	{
		{"Mua Tinh Khí Tán và Hoạt Khí Tán", SpecialEvent.BuyJingHuo.OnDialog, SpecialEvent.BuyJingHuo},
		{"Bạc khóa đổi bạc", SpecialEvent.CoinExchange.OnDialog, SpecialEvent.CoinExchange},
		{"Nhận lương", SpecialEvent.Salary.GetSalary, SpecialEvent.Salary},
	}
		table.insert(tbOpt, 3, {"Nhận Uy danh giang hồ",SpecialEvent.ChongZhiRepute.OnDialog,SpecialEvent.ChongZhiRepute});	
	if SpecialEvent.NewPlayerGift:ShowOption()==1 then
		table.insert(tbOpt, {"Nhận Túi quà Tân Thủ", SpecialEvent.NewPlayerGift.OnDialog, SpecialEvent.NewPlayerGift});
	end
	
	table.insert(tbOpt, {"Kết thúc đối thoại"});
	Dialog:Say("Chọn phúc lợi: ", tbOpt);
end
