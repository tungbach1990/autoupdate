
local tbNpcHuiHuangZhiZhong = Npc:GetClass("huihuangzhizhong");

tbNpcHuiHuangZhiZhong.nGrowTime			= 5; --成熟的时间

function tbNpcHuiHuangZhiZhong:OnDialog()
	
	local tbNpcInfo	= him.GetTempTable("HuiHuangZhiGuo");
	local nFiveMinute = 300 --单位(秒)
	local nTime = nFiveMinute - GetTime() + tbNpcInfo.nPlantTime
	local nHour, nMinute, nSecond = Lib:TransferSecond2NormalTime(nTime)
	local szTime = ""
	if (nHour ~= 0) then
		szTime = string.format("%s%d giờ",szTime,nHour)
	end
	if (nMinute ~= 0) then
		szTime = string.format("%s%d phút",szTime,nMinute)
	end
	szTime = string.format("%s%d giây",szTime,nSecond)
	me.Msg(string.format("Hiện nay hạt giống vẫn chưa chín mùi, cần thêm <color=yellow>%s<color> nữa.", szTime));
end;
