


local tbItem = Item:GetClass("tongfunditem")
tbItem.ExReturnBindCoin = 0;	--返还获得银两的百分比绑定金币
function tbItem:OnUse()
	local nMoney = it.GetExtParam(1);
	if me.dwTongId == 0 then
		me.Msg("Bạn chưa vào bang hội, không thể sử dụng đạo cụ này!")
		return 0;
	end
	local pTong = KTong.GetTong(me.dwTongId)
	if not pTong then
		return 0;
	end
	if nMoney + pTong.GetBuildFund() > Tong.MAX_BUILD_FUND then
		me.Msg("Quỹ xây bang hội sắp đạt tối đa, không thể tăng thêm nữa.")
		return 0;
	end
	if nMoney + pTong.GetBuildFund() > Tong.MAX_BUILD_FUND then
		me.Msg("Quỹ xây bang hội sắp đạt tối đa, không thể tăng thêm nữa.")
		return 0;
	end
	local TASK_GROUPID	= 2081;
	local TASK_TONGFUND	= {2,3};
	local TASK_TONGFUNDDATA = {4,5};
	local tbTaskTimes_Max ={2,1};
	local nLevel = it.nLevel;
	
	local nDate = me.GetTask(TASK_GROUPID, TASK_TONGFUNDDATA[nLevel]);
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	if nDate ~= nNowDate then
		me.SetTask(TASK_GROUPID, TASK_TONGFUNDDATA[nLevel], nNowDate);
		me.SetTask(TASK_GROUPID, TASK_TONGFUND[nLevel], 0);
	end	
	local nTimes = me.GetTask(TASK_GROUPID, TASK_TONGFUND[nLevel]);			
	if nTimes >= tbTaskTimes_Max[nLevel] then
		me.Msg("Hôm nay bạn đã mở đủ rồi! Mai quay lại nhé!");
		return 0;
	end
	
	local nKinId, nMemberId = me.GetKinMember();
	if self.ExReturnBindCoin > 0 then
		me.AddBindCoin(math.floor(self.ExReturnBindCoin * nMoney / 1000), Player.emKBINDCOIN_ADD_TONG_JINTIAO);
	end
	Dbg:WriteLog("tongfunditem", me.szName, me.szAccount, nMoney, nKinId, nMemberId);
	PlayerHonor:AddConsumeValue(me, it.nValue, "tongfunditem");			-- 累加消耗型财富
	GCExcute{"Tong:AddBuildFund_GC", me.dwTongId, nKinId, nMemberId, nMoney, 0.8, 1, 0};
	me.SetTask(TASK_GROUPID, TASK_TONGFUND[nLevel],me.GetTask(TASK_GROUPID, TASK_TONGFUND[nLevel]) + 1);
	return 1;
end

function tbItem:GetTip()
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	local TASK_TONGFUND	= {2,3};
	local TASK_TONGFUNDDATA = {4,5};
	local tbTaskTimes_Max ={2,1};
	local nTimes = me.GetTask(2081, TASK_TONGFUND[it.nLevel]);	
	local nDate = me.GetTask(2081, TASK_TONGFUNDDATA[it.nLevel]);
	if nDate ~= nNowDate then
		nTimes = 0;
	end
	local tbColor = {[1] = {"green","green","gray"},[2] =  {"green","gray"}};
	return string.format("<color=%s>Hôm nay đã dùng %s/%s<color>", tbColor[it.nLevel][nTimes + 1], nTimes, tbTaskTimes_Max[it.nLevel]);	
end

