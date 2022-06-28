
local tbNpc = Npc:GetClass("yayi");

tbNpc.nLinanYayiId		= 29;		-- 临安府衙役的地图ID
tbNpc.nBianjingYayiId 	= 23;		-- 汴京府衙役的地图ID
tbNpc.nYayiX_Linan		= 1688;		-- 临安府衙役的X坐标
tbNpc.nYayiY_Linan		= 3771;		-- 临安府衙役的Y坐标
tbNpc.nYayiX_Bianjing	= 1639;		-- 汴京府衙役的X坐标
tbNpc.nYayiY_Bianjing	= 3094;		-- 汴京府衙役的Y坐标

tbNpc.nLinanDalaoId		= 223;		-- 临安府大牢的地图ID
tbNpc.nBianjingDalaoId	= 222;		-- 汴京府大牢的地图ID
tbNpc.nDalaoX			= 1651;		-- 大牢的X坐标
tbNpc.nDalaoY			= 3260;		-- 大牢的Y坐标

function tbNpc:OnDialog()
	Dialog:Say("Nha Môn gần đây có rất nhiều Bổ Khoái đi truy bắt hung thủ giết người, thế đạo giờ không còn thái bình nữa!",
				{
					{"Ta đến tự thú", self.Zishou, self},
					{"Không có gì"}
				});
end

function tbNpc:Zishou()
	local nExpPercent = math.floor(me.GetExp() * (-100) / me.GetUpLevelExp());
	
	if (me.nPKValue <= 0) then
		Dialog:Say("Người chơi: Trước đây ta lỡ đả thương người khác, nay đến tự thú.<enter><enter>"..
			"Nha Dịch: Đại nhân ta đã phái người đi điều tra, ngươi phòng vệ chính đáng, lần sau nên cẩn thận hơn. Đi đi.");
		return;
	end
	if (me.GetTempTable("Npc").nNpcYuzuTimerId ~= nil) then
		Dialog:Say("Nha Dịch: Nghiệp chướng chưa hết, về đại lao tiếp tục hối lỗi!");
		self:TransferPos(me.GetMapId(), me);
		return;
	end
	if (nExpPercent > 50) then
		me.Msg("Triều đình có lệnh: Người có kinh nghiệm âm hơn 50%, không được tự thú chuộc tội!");
		Dialog:Say("Nha Dịch: Nợ máu chồng chất như ngươi mà cũng tự thú chuộc tội sao? Hừ, đợi người ta truy sát đi!");
		return;
	end
	Dialog:Say("Người chơi: Trước đây ta lỡ ngộ thương người khác, nay đến tự thú, mong đại nhân nương tay",  {"Tiếp tục đối thoại", self.FollowWithYayiDialog, self});
end

function tbNpc:FollowWithYayiDialog()
	local tbNpcYuzu 					= Npc:GetClass("yuzu");
	local nReduceOnePkHour, nSumTimer	= tbNpcYuzu:OnePkTime(me.nPKValue);
	local szXiaoshi, szShichen			= Lib:GetCnTime(nSumTimer);
	local szMsg = string.format("Nha Dịch: Tay ngươi đã nhuốm máu, phải qua xét xử, ở trong đại lao tịnh tâm hối lỗi chuộc tội. Thấy ngươi thành tâm nhận tội, xét xử như sau: %s trị PK là: %s, tống giam vào đại lao tịnh tâm hối lỗi: %s.", me.szName, me.nPKValue, szXiaoshi);
	Dialog:Say(szMsg,
				{
					{"Cúi đầu nhận tội, vào đại lao", self.Renzui, self},
					{"Bỏ trốn tại chỗ"}
				});
end

function tbNpc:Renzui()
	local tbNpcYuzu = Npc:GetClass("yuzu");
	me.SetTask(tbNpcYuzu.tbTaskIdReduceOnePkSec[1], tbNpcYuzu.tbTaskIdReduceOnePkSec[2], 0);
	self:TransferPos(me.GetMapId(), me);
end

function tbNpc:TransferPos(nMapId, pPlayer)
	if (nMapId == self.nLinanYayiId) then						-- 从临安府衙役处进大牢
		pPlayer.NewWorld(self.nLinanDalaoId, self.nDalaoX, self.nDalaoY);
	elseif (nMapId == self.nBianjingYayiId) then				-- 从汴京府衙役处进大牢
		pPlayer.NewWorld(self.nBianjingDalaoId, self.nDalaoX, self.nDalaoY);
	elseif (nMapId == self.nLinanDalaoId) then					-- 从临安府大牢处出来至临安符的衙役处
		pPlayer.NewWorld(self.nLinanYayiId, self.nYayiX_Linan, self.nYayiY_Linan);
	else														-- 从汴京府大牢处出来至汴京府的衙役处
		pPlayer.NewWorld(self.nBianjingYayiId, self.nYayiX_Bianjing, self.nYayiY_Bianjing);
	end
	
	me.SetFightState(0);
end
