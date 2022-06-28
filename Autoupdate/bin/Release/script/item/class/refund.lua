-- 文件名　：refund.lua
-- 创建者　：xiewen
-- 创建时间：2008-12-03 14:50:40
-- 描述：内部返还功能道具：西山金锭，西山银锭。

local tbRefund	= Item:GetClass("refund");

tbRefund.SILVER = 260;
tbRefund.GOLD = 261;

tbRefund.DbgInfo = 
{
	Level = {[1] = ""; [2] = "(Đại)";};
	ItemName = {[260] = "Thỏi vàng"; [261] = "Thỏi vàng đại";};
	}

function tbRefund:OnUse()
	if self:CanUse() ~= 1 then
		--me.Msg("无权使用！"); -- 静默
		Dbg:WriteLog("fanhuan", me.szAccount, me.szName, me.GetPlayerIpAddress(),
			" với [" .. it.nPrice .. "]"..IVER_g_szCoinName.." mua [".. self.DbgInfo.ItemName[it.nParticular]
			.. self.DbgInfo.Level[it.nLevel] .."],");
		return 1;
	end
	
	if self.SILVER == it.nParticular then
		me.AddBindMoney(it.nPrice * jbreturn:GetRebateRate(1), Player.emKBINDMONEY_ADD_XISHANYIDING);
	elseif self.GOLD == it.nParticular then
		me.AddBindCoin(it.nPrice * jbreturn:GetRebateRate(2), Player.emKBINDCOIN_ADD_XISHANJINDING);
	end
	
	me.ApplyConsumeRebateCredit(it.nPrice);
	
	return 1;
end

function tbRefund:CanUse()
	if (jbreturn:IsPermitIp(me) ~= 1) then
		return 0;
	end
	if (jbreturn:GetMonLimit(me) <= 0) then
		return 0;
	end
	return 1;
end
