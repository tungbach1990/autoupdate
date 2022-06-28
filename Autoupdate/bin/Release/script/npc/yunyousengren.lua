

local tbYunyousengren = Npc:GetClass("yunyousengren");

tbYunyousengren.nDelayTime			= 5;			-- 进度条延时的时间为5(秒)
tbYunyousengren.tbCibeiItem			= {				-- 慈悲心经
	["nGenre"] 				= 18,
	["nDetailType"]			= 1,
	["nParticularType"] 	= 18,
	["nLevel"]				= 1,
};

function tbYunyousengren:OnDialog()
	local tbCibeixinjing = Item:GetClass("cibeixinjing");
	local tbOpt = 
	{
		{"Ta phải sám hối để giảm nhẹ PK", self.Repent, self},
		{"Kết thúc đối thoại"}
	}
	Dialog:Say(him.szName..": Nhiều năm nay, ta ngao du khắp nơi, tụng kinh giảng đạo, mong muốn độ hóa chúng sinh, gột rửa nghiệp chướng, để thể hiện lòng từ bi của ta.", tbOpt);
end

function tbYunyousengren:Repent()
	local nCurMapId = me.GetMapId();
	if ((nCurMapId >= 167 and nCurMapId <= 180) or (nCurMapId >= 187 and nCurMapId <= 195)) then
		me.Msg("Nơi đây cấm sử dụng vật phẩm này.");
		return 0;
	end
	if (0 >= me.nPKValue) then
		Dialog:Say("Thí chủ vô tội, không cần phải tụng kinh sám hối.");
		return;
	end
	local nExpPercent = math.floor(me.GetExp() * (-100) / me.GetUpLevelExp());
	if (nExpPercent	> 50) then
		Dialog:Say(him.szName..": Điểm kinh nghiệm đã âm 50%, hối hận cũng không có ích gì, lần sau hãy đến!");
		return;
	end
	if (me.GetItemCountInBags(self.tbCibeiItem.nGenre, self.tbCibeiItem.nDetailType, self.tbCibeiItem.nParticularType, self.tbCibeiItem.nLevel) <= 0) then
		Dialog:Say(him.szName..": Thí chủ không có kinh văn, tốt nhất hãy mau đi lấy \"Từ Bi Tâm Kinh\" và tụng lại.");
		return;
	end	
	
	Dialog:Say(him.szName..": Thí chủ phải thành tâm tụng \"Từ Bi Tâm Kinh\", ăn năn hối lỗi, lòng đầy thiện ý, mới có thể giảm bớt PK. Tụng kinh ngay?", 
		{
			{"Tụng \"Từ Bi Tâm Kinh\"", self.DelayTime, self},
			{"Ta đi rồi sẽ quay lại"}
		});
end

function tbYunyousengren:DelayTime()
	local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SIT,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
	}
	GeneralProcess:StartProcess("Đang tụng Từ Bi Tâm Kinh…", self.nDelayTime * Env.GAME_FPS, {self.UseItem, self}, nil, tbEvent);		
end

function tbYunyousengren:UseItem()
	if (me.ConsumeItemInBags(1, self.tbCibeiItem.nGenre, self.tbCibeiItem.nDetailType, self.tbCibeiItem.nParticularType, self.tbCibeiItem.nLevel) ~= 0) then
		Dbg:WriteLogEx(Dbg.LOG_ERROR, "tbYunyousengren", "cibeixinjing not found!");
		return;
	end	
		me.AddPkValue(-1);
		me.Msg("Thành tâm tụng \"Từ Bi Tâm Kinh\", lòng đầy thiện ý, ăn năn hối lỗi, mới giảm được 1 PK!");
end
