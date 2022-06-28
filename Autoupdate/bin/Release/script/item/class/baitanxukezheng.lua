-------------------------------------------------------------------
--File: 	baitanxukezheng.lua
--Author: 	zouying
--Date: 	2008-6-9
--Describe:	摆摊许可证
-------------------------------------------------------------------
-- 一个许可证8小时

local tbBaiTan = Item:GetClass("baitanxukezheng");

function tbBaiTan:OnUse()
	local pPlayer = me;
	local nTotalTime	= pPlayer.GetTask(Stall.TASK_GROUP_ID, Stall.TASK_TOTAL_TIME);
	-- 大于64小时，就不能再使用许可证了
	if (nTotalTime > 3600 * 8 * 8)then 
		pPlayer.Msg("Bạn đã bày bán hơn 72 giờ, tạm thời không thể sử dụng giấy phép bày bán.");
		return 0;
	end
	-- 添加许可摆摊时间,一个许可证８小时
	nTotalTime = nTotalTime + 3600 * 8;  -- 测试用三分钟  8 * 60; 
	pPlayer.SetTask(Stall.TASK_GROUP_ID, Stall.TASK_TOTAL_TIME, nTotalTime, 0);

	local szTime	= Lib:TimeDesc(nTotalTime);
	pPlayer.Msg("Thời gian cho phép bán là "..szTime..".");
	return 1;
end

