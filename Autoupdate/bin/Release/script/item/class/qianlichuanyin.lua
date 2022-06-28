
local tbItem = Item:GetClass("qianlichuanyin");
local nParticular = 924;
-- 道具可增加公聊的次数
local tbUseCount = 
{
	[nParticular] = 2,
	[nParticular + 1] = 11,
};

function tbItem:OnUse()
	if (me.nLevel < 30) then
		me.Msg("Nhân vật đẳng cấp nhỏ 30 không thể sử dụng đạo cụ này.");
		return 0;
	end
	local nCount = me.GetTask(ChatChannel.TASK_CHAT, 4);
	local nAdd = tbUseCount[it.nParticular];
	if (nAdd == nil or nAdd <= 0) then
		return 0;
	end
	nCount = nCount + nAdd;
	me.SetTask(ChatChannel.TASK_CHAT, 4, nCount);
	me.Msg(string.format("Số lần trò chuyện trên kênh thế giới tăng %d lần，Tổng cộng còn %d lần.", nAdd, nCount));
	return 1;
end
