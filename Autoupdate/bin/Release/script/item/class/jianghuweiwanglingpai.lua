--江湖威望令牌
--孙多良
--2008.10.30

local tbItem = Item:GetClass("jianghuweiwanglingpai");
tbItem.tbEffect = 
{
	[1] = 20;
}
function tbItem:OnUse()
	me.AddKinReputeEntry(self.tbEffect[it.nLevel]);
	me.Msg(string.format("Bạn nhận được <color=yellow>%s điểm <color> uy danh giang hồ.",self.tbEffect[it.nLevel]))
	return 1;
end
