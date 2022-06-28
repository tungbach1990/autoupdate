

local tbNpc = Npc:GetClass("baihutangchuansong");
tbNpc.nTopLevel = 90;
tbNpc.nBottomLevel = 50;

function tbNpc:Init()
	self.tbShopID =
	{
		[1] = 89, -- 少林
		[2] = 90, --天王掌门
		[3] = 91, --唐门掌门
		[4] = 93, --五毒掌门
		[5] = 95, --峨嵋掌门
		[6] = 96, --翠烟掌门
		[7] = 98, --丐帮掌门
		[8] = 97, --天忍掌门
		[9] = 99, --武当掌门
		[10] = 100, --昆仑掌门
		[11] = 92, --明教掌门
		[12] = 94, --大理段氏掌门
	}
end

tbNpc:Init();

function tbNpc:OnDialog()
	local nMapId	= me.nMapId;
	local tbOpt		= {};
	
	if (me.nLevel < tbNpc.nBottomLevel) then
		tbOpt[1] = {"Bạch Hổ Đường quá nguy hiểm, hãy luyện đến cấp 50 rồi tính!"};
	elseif (me.nFaction == 0) then
		tbOpt[1] = {"Hãy gia nhập môn phái rồi đến tham gia Bạch Hổ Đường."};
	else
				
		
		if (me.nLevel >= tbNpc.nBottomLevel and me.nLevel < tbNpc.nTopLevel) then
			table.insert(tbOpt, {"Ta muốn vào Bạch Hổ Đường (sơ 1)", self.OnTrans, self, BaiHuTang.ChuJi});
			if (TimeFrame:GetStateGS("CloseBaiHuTangChu2") == 0 )then 
				table.insert(tbOpt, {"Ta muốn vào Bạch Hổ Đường (sơ 2)", self.OnTrans, self, BaiHuTang.ChuJi2});
			end
		else
			table.insert(tbOpt, {"Ta muốn vào Bạch Hổ Đường (cao)", self.OnTrans, self, BaiHuTang.GaoJi});
			if BaiHuTang:IsOpenGolden() == 1 and me.nLevel >= 120 then
				table.insert(tbOpt, {"Bạn muốn vào Bạch Hổ (Hoàng Kim)", self.OnTrans, self, BaiHuTang.Goldlen});
			end
		end
		
		table.insert(tbOpt, {"[Quy tắc hoạt động]", self.Rule, self});
		table.insert(tbOpt, {"Mua trang bị danh vọng Bạch Hổ Đường", self.BuyReputeItem, self});
		table.insert(tbOpt, {"Kết thúc đối thoại"});
	end
	Dialog:Say("Dạo này trong Bạch Hổ Đường xuất hiện đầy bọn trộm cắp, bọn ta không đủ sức đối phó với chúng. Ngươi có thể giúp một tay không? Ta có thể đưa ngươi đến \"Đại Điện Bạch Hổ Đường\", sự việc cụ thể ngươi có thể tìm hiểu ở chỗ \"Môn Đồ Bạch Hổ Đường\".", tbOpt);
	
end

function tbNpc:Rule()
	local tbOpt = {};
	tbOpt[1] = {"Trở về đối thoại trước đó", self.OnDialog, self};
	tbOpt[2] =  {"Kết thúc đối thoại"};
	local szMsg = string.format("Thời gian báo danh <color=green>30<color> phút, thời gian hoạt động <color=green>30<color> phút. Sau khi hoạt động bắt đầu, trong Bạch Hổ Đường sẽ xuất hiện rất nhiều <color=red>Sấm Đường Tặc<color>, đánh bại chúng sẽ nhặt được vật phẩm và kinh nghiệm, sau một thời gian nhất định sẽ xuất hiện <color=red>Thủ Lĩnh Sấm Đường Tặc<color>, " .. 
"Đánh bại <color=red>Thủ Lĩnh Sấm Đường Tặc<color> sẽ xuất hiện lối vào tầng 2, Bạch Hổ Đường có 3 tầng, nếu bạn đánh bại thủ lĩnh ở cả 3 tầng thì sẽ mở được lối ra. Lưu ý: Khi vào Bạch Hổ Đường sẽ tự động bật chế độ chiến đấu, nên tốt nhất hãy tham gia hoạt động này cùng với hảo hữu, gia tộc hoặc bang hội. (Mỗi ngày chỉ được tham gia tối đa <color=red>%s lần<color>)", BaiHuTang.MAX_ONDDAY_PKTIMES);
	Dialog:Say(szMsg, tbOpt);
end
function tbNpc:OnTrans(nMapId)
	local nRect		= MathRandom(#BaiHuTang.tbPKPos);
	local tbPos		= BaiHuTang.tbPKPos[nRect];
	me.NewWorld(nMapId, tbPos.nX / 32, tbPos.nY / 32);
end

function tbNpc:BuyReputeItem()
		local nFaction = me.nFaction;
		if nFaction <= 0 then
			Dialog:Say("Người chơi chữ trắng không mua được trang bị nghĩa quân");
			return 0;
		end
		me.OpenShop(self.tbShopID[nFaction], 1, 100, me.nSeries) --使用声望购买
end
