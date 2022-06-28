local tbZhenzhus = Item:GetClass("jxsf8_zhenyuanzhu");

function tbZhenzhus :OnUse()
	local szMsg = "Chân nguyên tu luyện, hộ thể cường thân. Phát quang thiên hạ.";
	local tbOpt = {
		{"<color=green>Ta muốn tu luyện Chân Nguyên<color>", self.tuluyen, self},
		{"Kết thúc đối thoại"},
	};
end


function tbZhenzhus :tuluyen()
	local szMsg = "Chân nguyên tu luyện, hộ thể cường thân. Phát quang thiên hạ.";
	local tbOpt = {
		{"Tu Luyện thuộc tính <color=gold>Thứ Nhất<color>", self.tuluyen1, self},
		{"Tu Luyện thuộc tính <color=gold>Thứ Hai<color>", self.tuluyen2, self},
		{"Tu Luyện thuộc tính <color=gold>Thứ Thứ Ba<color>", self.tuluyen3, self},
		{"Tu Luyệnthuộc tính <color=gold>Thứ Tư<color>", self.tuluyen4, self},
		{"Kết thúc đối thoại"},
	};
end



function tbZhenzhus :tuluyen1()
	local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_MAIN);
	if pItem == nil then
	me.Msg("Ngươi không trang bị Chân Nguyên. Vui lòng trang bị sau đó mới có thể Tu Luyện");
	return 0;
	end
	Item:UpgradeZhenYuanNoItem(pItem,100,1);
	me.Msg(string.format("Chúc mừng <color=gold>%s<color> tu luyện Chân Nguyên thành công thuộc tính thứ nhất tăng <color=gold> %d điểm<color>.", me.szName, chiphi));
	
end

	
	
	
	
	
	
	
	
	
	