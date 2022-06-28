-- 文件名　：guozi_summer.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-07-09 09:12:56
-- 描  述  ：

local tbItem = Item:GetClass("guozi_summer")
tbItem.tbBoss = {
	{"<color=gold>Võ lâm cao thủ (kim)<color>",100 , 1},
	{"<color=green>Võ lâm cao thủ (mộc)<color>",100, 2},
	{"<color=blue>Võ lâm cao thủ (thủy)<color>",100, 3},
	{"<color=red>Võ lâm cao thủ (hỏa)<color>",100, 4},
	{"<color=wheat>Võ lâm cao thủ (thổ)<color>",100, 5},
};

function tbItem:OnUse()
	local szMsg = "Mở quả thịnh hạ bạn có thể nhận được 100 điểm võ lâm cao thủ hoặc 1 Hòa thị ngọc. Mời bạn chọn: ";
	local tbOpt = {
		{"100 điểm võ lâm cao thủ",self.GetItem1, self, it.dwId},
		{"Hòa thị ngọc",self.GetItem2, self, it.dwId},
		{"Kết thúc đối thoại"},
	};
	local nType, nTime = it.GetTimeOut();
	if nType and nType >= 0 and nTime and nTime > 0 then
		table.insert(tbOpt, 3, {"Đổi lấy quả không có thời hạn.", self.ChangeItem, self, it.dwId});
	end
	
	Dialog:Say(szMsg, tbOpt);
end

function tbItem:ChangeItem(nItemId)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	if me.DelItem(pItem) ~= 1 then
		return;
	end
	local pItem1 = me.AddItem(18,1,380,1);
	if pItem1 then
		pItem1.Bind(1);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format(" sử dụng quả thịnh hạ."));
	end
end

function tbItem:GetItem1(nItemId)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	local szMsg = "Bạn có thể đổi lấy 100 điểm võ lâm cao thủ, hãy chọn loại điểm mà bạn muốn ？";
	local tbOpt = {};
	for _, tbBoss in ipairs(self.tbBoss) do
		table.insert(tbOpt, {tbBoss[1], self.GetItem1_1, self, nItemId, tbBoss[2], tbBoss[3]});
	end
	table.insert(tbOpt, {"Để ta nghĩ lại"});
	Dialog:Say(szMsg, tbOpt);
end

function tbItem:GetItem1_1(nItemId, nScore, nSeries)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	if me.IsHaveItemInBags(pItem) ~= 1 then
		return;
	end
	local nFlag = Player:AddRepute(me, 6, nSeries, nScore);
	if (0 == nFlag) then
		return;
	elseif (1 == nFlag) then
		me.Msg("Khiêu chiến võ lâm cao thủ（" .. Env.SERIES_NAME[nSeries] .. "）cấp cao nhất，không thể sử dụng lệnh bài（" .. Env.SERIES_NAME[nSeries] .. "）");
		return;
	end	
	me.DelItem(pItem);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("Quả thịnh hạ đổi khiêu chiến võ lâm cao thủ (%s)",Env.SERIES_NAME[nSeries]));
	if me.nSeries ~= nSeries then
		me.Msg("<color=yellow>Bạn đang sử dụng lệnh bài không đúng với ngũ hành, chú ý bảo vệ bản thân.")
	end	
end

function tbItem:GetItem2(nItemId)
	if TimeFrame:GetState("OpenBoss120") ~= 1 then
		Dialog:Say("Tính năng tần lăng chưa mở, vui lòng chọn lại phần thưởng.");
		return 0;
	end
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	if me.IsHaveItemInBags(pItem) ~= 1 then
		return;
	end
	if me.DelItem(pItem) ~= 1 then
		return;
	end
	local pItem = me.AddItem(22,1,81,1);
	if pItem then
		--pItem.Bind(1);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("quả thịnh hạ đổi hòa thị ngọc"));
	end
	me.Msg("Trao đổi thành công nhận được 1 <color=yellow>Hòa Thị Ngọc<color>");
end
