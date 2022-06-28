 --武林世家腰牌
--zounan1@kingsoft.com
--2009-09-17 17:16

Require("\\script\\item\\class\\shijiayaopai_def.lua"); --定义的参数太多 故扔到另外一个文件
local tbItem = Item:GetClass("shijiayaopai");  

function tbItem:OnUse()	
	local tbOpt = {
		{"Nhận thời gian tu luyện", self.GetAwardXiulian,self},
		{"Nhận túi phúc",self.GetAwardFudai,self},
	};		
	if	me.GetTask(self.TASK_GROUP_ID, self.TASK_WEAPON) == 0 then	--领完不加
		table.insert(tbOpt, {"Cấp 50 có thể nhận vũ khí", self.OnGetAwardWeapon, self});
	end
	local nCount = me.GetTask(self.TASK_GROUP_ID, self.TASK_FANGJU_NUM) + me.GetTask(self.TASK_GROUP_ID, self.TASK_SHOUSHI_NUM);  
	if nCount < 4 then									--领完了就不加
		table.insert(tbOpt, {"Cấp 69 có thể nhận trang sức và phòng cụ", self.OnGetAwardEquip, self});
	end
	table.insert(tbOpt, {"Kết thúc đối thoại"});
	local szMsg = "Ngoài thời gian tu luyện và túi phúc hoàng kim có thể nhận được mỗi ngày. đạt đến cấp nhất định có thể nhận được phần thưởng có giá trị.";
	Dialog:Say(szMsg, tbOpt); 

end

function tbItem:GetAwardXiulian()
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	local nTaskDate = me.GetTask(self.TASK_GROUP_ID, self.TASK_DATE_XIULIAN);
	if nTaskDate >= nCurDate then
		Dialog:Say("Bạn đã nhận thêm thời gian tu luyện.");
		return;
	end
	local tbXiuLianZhu = Item:GetClass("xiulianzhu");
	if tbXiuLianZhu:GetReTime() >= tbXiuLianZhu.MAX_REMAINTIME then
		Dialog:Say("Thời gian tu luyện đã được tích lũy đầy, không thể nhận thêm");
		return;
	end
	tbXiuLianZhu:AddRemainTime(60);	
	me.Msg("Thời gian tu luyện tăng lên <color=green>1 giờ<color>");
	me.SetTask(self.TASK_GROUP_ID, self.TASK_DATE_XIULIAN, nCurDate);
	Dialog:Say("Bạn nhận được thêm 1 giờ tu luyện, có thể mở Tu Luyện Châu để sử dụng.");
end

function tbItem:GetAwardFudai()
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	local nTaskDate = me.GetTask(self.TASK_GROUP_ID, self.TASK_DATE_FUDAI);
	if nTaskDate >= nCurDate then
		Dialog:Say("Bạn nhận được phần thưởng túi phúc hoàng kim.");
		return;
	end 	
	if me.CountFreeBagCell()< self.FUDAI_COUNT then
		Dialog:Say("Hành trang đã đầy, vui lòng thử lại.");
		return;
	end
	for i = 1, self.FUDAI_COUNT do
		local pItem = me.AddItem(18, 1, 80, 1);
		if pItem then
			self:WriteLog(pItem.szName);
		end
	end
	me.SetTask(self.TASK_GROUP_ID, self.TASK_DATE_FUDAI, nCurDate);	
	Dialog:Say("Bạn có 2 túi phúc, mau mở ra xem được gì nào.");
end

function tbItem:OnGetAwardWeapon()
	local tbOpt ={
		{"Được ta nhận", self.GetAwardWeapon, self},
		{"Để ta suy nghĩ chút"},
		};
	local szMsg = "Khi cấp độ 50, bạn có thể có được kỹ năng sống vũ khí màu da cam.";
	Dialog:Say(szMsg, tbOpt);	
end

function tbItem:GetAwardWeapon()
	if me.nLevel < 50 then
		Dialog:Say("Đẳng cấp chưa đạt 50");
		return;
	end
	if me.nRouteId == 0 or me.nFaction == 0 then
		Dialog:Say("Bạn chưa ra nhập môn phái không thể nhận thưởng.");
		return;
	end
	if me.CountFreeBagCell()< 1 then
		Dialog:Say("Hành trang đã đầy, vui lòng thử lại.");
		return;
	end
	local tbWeaponItem = self.tbWeapon[me.nFaction][me.nRouteId];
	if not tbWeaponItem then
		Dialog:Say("Nhận thất bại.");
		return;
	end		
	local nG, nD, nP, nL = unpack(tbWeaponItem);
	local pItem = me.AddItem(nG, nD, nP, nL, -1, self.QIANGHUALEVEL_WEAPON);
	if not pItem then
		Dialog:Say("Nhận thất bại.");
		return;
	end
	pItem.Bind(1);
	me.SetTask(self.TASK_GROUP_ID, self.TASK_WEAPON, 1);
	self:WriteLog(pItem.szName);
	Dialog:Say("Bạn nhận được vũ khí thần bí.");
end

function tbItem:OnGetAwardEquip()
	local tbOpt ={
			{"Nhận phòng cụ", self.OnselectFangju, self},
			{"Nhận trang sức", self.OnselectShoushi, self},
			{"Để ta suy nghĩ chút"},
		}
	local szMsg = "Khi đẳng cấp đạt 69, bạn có thể nhận được hai áo giáp và đồ trang sức.";
	Dialog:Say(szMsg, tbOpt);	
end

function tbItem:OnselectFangju()
	if me.nLevel < 69 then
		Dialog:Say("Đẳng cấp chưa đủ 69");
		return;
	end
	if me.nRouteId == 0 or me.nFaction == 0 then
		Dialog:Say("Bạn chưa gia nhập môn phái, không thể nhận thưởng");
		return;
	end
	if me.GetTask(self.TASK_GROUP_ID, self.TASK_FANGJU_NUM)>= 2 then
		Dialog:Say("Nhận thành công");
		return;
	end	
	local tbOpt  = {};
	local szMsg = "";
	if me.GetTask(self.TASK_GROUP_ID, self.TASK_FANGJU_SEL) == 0 then 
		szMsg = "Bạn có thể chọn áo giáp sau đây ";
	else
		szMsg = "Bạn cũng có thể chọn từ áo giáp sau đây";
	end
	local tbTemp = {
		{"Nhận mũ", self.GetAwardEquip, self,1, 1},
		{"Nhận áo", self.GetAwardEquip, self,1, 2},
		{"Nhận lưng", self.GetAwardEquip, self,1, 3},
		{"Nhận giày", self.GetAwardEquip, self,1, 4},
		{"Nhận tay", self.GetAwardEquip, self,1, 5},
		};
	for i , tbP  in ipairs(tbTemp) do                         --把已经领取过了的装备剔除
		if i ~= me.GetTask(self.TASK_GROUP_ID, self.TASK_FANGJU_SEL) then
	    	table.insert(tbOpt , tbP);
		end
	end
	table.insert(tbOpt, {"Để ta xem lại"});
	Dialog:Say(szMsg , tbOpt);
end

function tbItem:OnselectShoushi()
	if me.nLevel <69 then
		Dialog:Say("Đẳng cấp chưa đủ 69");
		return;
	end
	if me.nRouteId == 0 or me.nFaction == 0 then
		Dialog:Say("请选择修行路线，以便赠送您合适的装备。");
		return;
	end
	if me.GetTask(self.TASK_GROUP_ID, self.TASK_SHOUSHI_NUM)>= 2 then
		Dialog:Say("首饰已经领取完毕。");
		return;
	end
	local tbOpt  = {};
	local szMsg = "";
	if me.GetTask(self.TASK_GROUP_ID, self.TASK_SHOUSHI_SEL) == 0 then 
		szMsg = "您可以从以下首饰中选择两件，请分两次领取。";
	else
		szMsg = "您还可以从以下首饰中选择一件。";
	end
	local tbTemp = {
		{"领取护身符", self.GetAwardEquip, self,2, 1},
		{"领取戒指", self.GetAwardEquip, self,2, 2},
		{"领取腰坠", self.GetAwardEquip, self,2, 3},
		{"领取项链", self.GetAwardEquip, self,2, 4},
		};
	for i , tbP  in ipairs(tbTemp) do                         --把已经领取过了的装备剔除
		if i ~= me.GetTask(self.TASK_GROUP_ID, self.TASK_SHOUSHI_SEL) then
	    	table.insert(tbOpt , tbP);
		end
	end
	table.insert(tbOpt, {"Để ta suy nghĩ chút"});
	Dialog:Say(szMsg , tbOpt);
end

function tbItem:GetAwardEquip(nType, nSelId)
	if me.CountFreeBagCell()< 1 then
		Dialog:Say("Hành trang đã đầy, vui lòng thử lại.");
		return;
	end
	local pItem = nil;
	if nType == 1 and nSelId <= 2 then  --用衣服和帽子是用门派分类的
		local nG, nD, nP, nL = unpack(self.tbEquip[1][nSelId][me.nFaction][me.nSex][me.nRouteId]);
		pItem = me.AddItem(nG, nD, nP, nL, -1,  self.QIANGHUALEVEL_EQUIP);
	else                               --用五行分类
		local nG, nD, nP, nL = unpack(self.tbEquip[nType][nSelId][me.nSeries][me.nSex]);
		pItem = me.AddItem(nG, nD, nP, nL, -1 , self.QIANGHUALEVEL_EQUIP);
	end	
	if not pItem then
		Dialog:Say("Nhận thất bại.");
		return;
	end
	pItem.Bind(1);
	local nCount = me.GetTask(self.TASK_GROUP_ID, self.tbTask[nType][1]); 
	me.SetTask(self.TASK_GROUP_ID, self.tbTask[nType][1], nCount + 1);
	me.SetTask(self.TASK_GROUP_ID, self.tbTask[nType][2], nSelId); 
	tbItem:WriteLog(pItem.szName);
	Dialog:Say("Nhận thành công");		
end

function tbItem:WriteLog(szName)
	local szMsg = "[Hoạt động] nhận được:"..szName;
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, szMsg);		
	Dbg:WriteLog(szMsg, me.szName);	
end
