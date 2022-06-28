local tbItem = Item:GetClass("fuxiulingpai");   --增加洗辅修机会道具

tbItem.TSK_GROUP    = 2027;  
tbItem.TSK_USETIME  = 90;
tbItem.CD_TIME = 7*24*60*60; -- 辅修令使用间隔时间7天

function tbItem:OnUse()	
	local nCheck, nSec = self:CheckItemCD();
	if nCheck == 0 then
		local szTime = Lib:TimeFullDesc(nSec);
		me.Msg("Thời gian sử dụng Bổ Tu Lệnh cách nhau 7 ngày, còn "..szTime);
		return;
	end 	
	local nCount = Faction:GetMaxModifyTimes(me) - Faction:GetModifyFactionNum(me);
	local tbOpt = {}
	table.insert(tbOpt, {"Xác nhận sử dụng", self.UseItem, self, it.dwId});
	table.insert(tbOpt, {"Để ta suy nghĩ đã"});
	local szMsg = string.format("Bạn muốn dùng đạo cụ này? Hiện còn %s lần tẩy phụ tu", nCount);
	Dialog:Say(szMsg, tbOpt); 
end

function tbItem:UseItem(nItemId)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	if me.DelItem(pItem , Player.emKLOSEITEM_USE) ~= 1 then
		return 0;
	end
	Faction:AddExtraModifyTimes(me , 1);
	local nCount = Faction:GetMaxModifyTimes(me) - Faction:GetModifyFactionNum(me);
	local szMsg = string.format("Bạn được thêm 1 lần phụ tu cơ hội, hiện còn %s lần tẩy phụ tu", nCount);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[Hoạt động] Tăng %s lần cơ hội sửa chữa",nCount));		
	Dbg:WriteLog(string.format("[Sử dụng vật phẩm] Tăng %s lần cơ hội phụ tu ",nCount), me.szName);
	me.Msg(szMsg);
	local nCurTime = GetTime(); 
	me.SetTask(self.TSK_GROUP, self.TSK_USETIME, nCurTime);
	return 1;
end

function tbItem:GetTip(nState)
	local nCount = Faction:GetMaxModifyTimes(me) - Faction:GetModifyFactionNum(me);
	local szTip = "";
	szTip = szTip..string.format("<color=yellow>Hiện còn %s lần tẩy phụ tu<color>", nCount);	
	return	szTip;
end

function tbItem:CheckItemCD()
	local nEndTime = me.GetTask(self.TSK_GROUP, self.TSK_USETIME) + self.CD_TIME;
	local nRemainSec = nEndTime -  GetTime();	
	if nRemainSec < 0   then
	 	return 1 , 0;
	end
	return 0 , nRemainSec;			
end
