local tbItemHuangJinZhiGuo = Item:GetClass("huangjinzhiguo");

tbItemHuangJinZhiGuo.DAY_LIMIT			= 7*3600*24;
tbItemHuangJinZhiGuo.nExp				= 10000000;--1000w 

function tbItemHuangJinZhiGuo:OnUse()
	local nGetPlayerRank	= HuiHuangZhiGuo.GetPlayerRank();
	local nItemLevel		= it.nLevel;
	local nUseTime			= me.GetTask(HuiHuangZhiGuo.TSKG_HuiHuangZhiGuo_ACT,HuiHuangZhiGuo.TSK_HuangJinGuo_UseTime);
	local nNowTime			= GetTime();
	local nExp				= self.nExp;
	local nLevelExp			= me.GetUpLevelExp()-me.GetExp();
	
	if ((nNowTime - nUseTime) < self.DAY_LIMIT) then --不够7天
		me.Msg("Sự rèn luyện của bạn vẫn chưa đủ.");
		return 0;
	end
	if (nGetPlayerRank ~= nItemLevel) then -- 如果级别不对,不能使用
		if (1 == nItemLevel) then
			me.Msg("Quả này chỉ dành cho người cấp 70 đến 99 dùng!");
		end
		return 0;
	end
	
	if (nLevelExp < nExp) then
		nExp = nLevelExp;
	end
	me.AddExp(nExp);
	
	me.SetTask(HuiHuangZhiGuo.TSKG_HuiHuangZhiGuo_ACT,HuiHuangZhiGuo.TSK_HuangJinGuo_UseTime,GetTime());
	return 1;
end
