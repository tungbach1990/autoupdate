-- 文件名　：qifuhebao.lua
-- 创建者　：jiazhenwei

local tbItem = Item:GetClass("qifuhebao");

tbItem.TSK_GROUP 	= 2121;  
tbItem.TSK_ITEM		= 4;
tbItem.TSK_DAY		= 5;
tbItem.TSK_ISGETBUFF = 6;
tbItem.TIME_START	= 20100420;
tbItem.TIME_END		= 20100511;
tbItem.TIME_START_QIANG = 20100501;
tbItem.TIME_END_QIANG = 20100505;
tbItem.ITEM_TIME	= 12* 60; -- 实效
tbItem.DIALOGMSG	= "    Trân trọng, một mã thông báo đánh giá cao cho người dân vùng thiên tai tất cả các thời gian, bạn cũng có thể nhận được phần thưởng!";

tbItem.ITEM_AWARD   = {
	[1] = {nSec = 15*60, tbAward = {18,1,80,1},  nCount = 1, szName = "[Online 15 phút]Nhận 1 túi phúc hoàng kim",},
	[2] = {nSec = 60*60, tbAward = {18,1,80,1},  nCount = 3, szName = "[Online 60 phút]Nhận 3 túi phúc hoàng kim",},
	[3] = {nSec = 90*60, tbAward = {18,1,189,1}, nCount = 1, szName = "[Online 90 phút]Nhận 1 thùng rượu",},	
	};
	
function tbItem:OnUse()	
	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	if nDate < self.TIME_START then
		Dialog:Say("Hoạt động này chưa mở.");
		return;
	end
	if nDate > self.TIME_END then
		Dialog:Say("Hoạt động đã kết thúc.");
		return;
	end	
	local nTskItem = nil;
	if me.GetTask(self.TSK_GROUP,self.TSK_DAY) ~= nDate then
		me.SetTask(self.TSK_GROUP,self.TSK_DAY,nDate);
		me.SetTask(self.TSK_GROUP,self.TSK_ITEM,0);
		nTskItem = 0;
	else
		nTskItem = me.GetTask(self.TSK_GROUP,self.TSK_ITEM);	
	end	
		
	local nOnLineTime = GetTime() -  me.GetTask(2063,2);
	local tbOpt = {};
	for i , tbAward in ipairs(self.ITEM_AWARD) do
		if nOnLineTime < tbAward.nSec or Lib:LoadBits(nTskItem,i,i) == 1  then
			table.insert(tbOpt,{string.format("<color=gray>%s<color>",tbAward.szName),self.OnAward,self,i});
		else
			table.insert(tbOpt,{tbAward.szName,self.OnAward,self,i});
		end
	end
	if nDate >= self.TIME_START_QIANG and nDate <= self.TIME_END_QIANG then
		if me.GetTask(self.TSK_GROUP,self.TSK_ISGETBUFF) == 1 then
			table.insert(tbOpt,{"<color=gray>Nhận ưu đãi<color>",self.GetBuffEquit,self});
		else
			table.insert(tbOpt,{"Nhận ưu đãi",self.GetBuffEquit,self});
		end
	end
	table.insert(tbOpt,{"Để ta suy nghĩ chút"});
	Dialog:Say(self.DIALOGMSG, tbOpt); 
end

function tbItem:GetBuffEquit()	
	Dialog:Say("Bạn chắc chắn muốn nhận phần thưởng ưu đãi ?", {
		{"Ta đồng ý nhận",self.GetBuffEquitEx,self},
		{"Để ta suy nghĩ chút"}}); 	
end

function tbItem:GetBuffEquitEx()
	if me.GetTask(self.TSK_GROUP,self.TSK_ISGETBUFF) == 1 then
		Dialog:Say("Bạn đã nhận phần thưởng.");
		return;
	end	
	me.AddSkillState(892, 1, 2, 5 * 24 * 3600 * Env.GAME_FPS, 1, 0, 1);
	me.SetTask(self.TSK_GROUP,self.TSK_ISGETBUFF,1);	
end

function tbItem:OnAward(nPos)
	local nTskItem = nil;
	local nDate = tonumber(GetLocalDate("%Y%m%d"));	
	if me.GetTask(self.TSK_GROUP,self.TSK_DAY) ~= nDate then
		me.SetTask(self.TSK_GROUP,self.TSK_DAY,nDate);
		me.SetTask(self.TSK_GROUP,self.TSK_ITEM,0);
		nTskItem = 0;
	else
		nTskItem = me.GetTask(self.TSK_GROUP,self.TSK_ITEM);	
	end		
		
	local tbAward = self.ITEM_AWARD[nPos];
	
	if not tbAward then
		return;
	end
	
	if Lib:LoadBits(nTskItem,nPos,nPos) == 1 then
		Dialog:Say("Bạn đã nhận phần thưởng.");
		return;
	end			
	
	if 	(GetTime() -  me.GetTask(2063,2)) < tbAward.nSec then
		Dialog:Say("Thời gian online không đủ, không thể nhận thưởng");
		return;
	end
			
	if 	me.CountFreeBagCell() < tbAward.nCount  then
		Dialog:Say("Hành trang đã đầy, vui lòng thử lại.");
		return;
	end	
	nTskItem = Lib:SetBits(nTskItem, 1, nPos, nPos);
	me.SetTask(self.TSK_GROUP,self.TSK_ITEM,nTskItem);	
	for i = 1 , tbAward.nCount do
		local pItem = me.AddItem(unpack(tbAward.tbAward));
		if pItem then
			pItem.Bind(1);
			me.SetItemTimeout(pItem, self.ITEM_TIME, 0);
		end	
	end	
end
