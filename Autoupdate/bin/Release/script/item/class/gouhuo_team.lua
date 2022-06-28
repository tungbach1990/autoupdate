-------------------------------------------------------------------
--File: 
--Author: sunduoliang
--Date: 2008-5-21 21:59
--Describe: 篝火物品脚本
-------------------------------------------------------------------

local tbGouhuoItem	= Item:GetClass("firewood_team");

tbGouhuoItem.nDelayTime		= 5;	-- 拾取篝火时会延时5(秒) 

-- 功能:	判断篝火能否被拾取(没有组队不能拾取)
-- 参数:	nObjId	物品ID
function tbGouhuoItem:IsPickable(nObjId)
	if (0 == me.nTeamId) then
		me.Msg("Chỉ có tổ đội mới có thể đốt lửa trại.");
		me.CallClientScript({"AutoAi:Resume"}); -- 通知client可以继续执行ai(如果是ai模式)
		return 0;
	end
	self:DelayTime(me, nObjId);
	return 0;
end

-- 功能:	篝火拾取了以后的操作
-- 参数:	nX, nY	被拾取的篝火的坐标
function tbGouhuoItem:PickUp(nX, nY)
	local nExistentTime = it.GetExtParam(1);	--持续时间
	local nBaseMultip = it.GetExtParam(2);		--经验倍率
	if nExistentTime == 0 then
		nExistentTime = 900;
	end
	if nBaseMultip == 0 then
		nBaseMultip = 150;
	end
	self:CallGouhuoNpc(nX, nY, nExistentTime, nBaseMultip);
	
	me.Msg("Bạn đốt lửa trại, các thành viên trong nhóm có thể chia sẻ kinh nghiệm xung quanh lửa trại!");
	local nTeamId = me.nTeamId;
	if (nTeamId > 0) then
		KTeam.Msg2Team(nTeamId, "Lửa trại đã được đốt, có thể dùng thêm rượu để tăng thêm kinh nghiệm");
	end
	return	0;
end


local tbEvent = 
{
	Player.ProcessBreakEvent.emEVENT_MOVE,
	Player.ProcessBreakEvent.emEVENT_ATTACK,
	Player.ProcessBreakEvent.emEVENT_SITE,
	Player.ProcessBreakEvent.emEVENT_USEITEM,
	Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
	Player.ProcessBreakEvent.emEVENT_DROPITEM,
	Player.ProcessBreakEvent.emEVENT_SENDMAIL,
	Player.ProcessBreakEvent.emEVENT_TRADE,
	Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
	Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
	Player.ProcessBreakEvent.emEVENT_LOGOUT,
	Player.ProcessBreakEvent.emEVENT_DEATH,
}
-- 功能:	拾取篝火进度条，执行self.nDelayTime秒的延时
-- 参数:	pPlayer 拾取篝火的玩家对象
-- 参数:	nObjId	物品ID
function tbGouhuoItem:DelayTime(pPlayer, nObjId)
	GeneralProcess:StartProcess("Đang đốt lửa...", self.nDelayTime * Env.GAME_FPS,
		{self.DoPickUp, self, pPlayer.nId, nObjId},
		{self.PickUpInterrupted, self}, tbEvent);
end

-- 功能:	进度条结束后执行拾取物品
-- 参数:	pPlayer	拾取的玩家，
-- 参数:	nObjId	物品ID
function tbGouhuoItem:DoPickUp(nPlayerId, nObjId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	if (not pPlayer) then
		return;
	end
	local nRet = pPlayer.PickUpItem(nObjId, 0);
	me.CallClientScript({"AutoAi:Resume"}); -- 通知client可以继续执行ai
end

function tbGouhuoItem:PickUpInterrupted()
	me.CallClientScript({"AutoAi:Resume"}); -- 通知client可以继续执行ai
end

-- 功能:	call出篝火Npc
-- 参数:	nX, nY	被拾取的篝火的坐标
function tbGouhuoItem:CallGouhuoNpc(nX, nY, nExistentTime, nBaseMultip)
	local tbNpc	= Npc:GetClass("gouhuonpc");
	local nMapIdx		= SubWorldID2Idx(me.nMapId);
	local pNpc	= KNpc.Add(tbNpc.nNpcId, 1, -1, nMapIdx, nX, nY);		-- 获得篝火Npc
	tbNpc:InitGouHuo(pNpc.dwId, 1,	nExistentTime, 5, 40, nBaseMultip, 1)
	tbNpc:SetTeamId(pNpc.dwId, me.nTeamId)
	tbNpc:StartNpcTimer(pNpc.dwId)
	
	me.SendMsgToFriend("Hảo hữu của bạn [" ..me.szName.. "] đã đốt lửa trại.");
	Player:SendMsgToKinOrTong(me, " đã đốt lửa trại.", 0);
	self:ExEvent();
end

--点完篝火额外事件.
function tbGouhuoItem:ExEvent()
	local nFreeCount, tbFunExecute = SpecialEvent.ExtendAward:DoCheck("PickGouhuoTeam", me); 
	SpecialEvent.ExtendAward:DoExecute(tbFunExecute);
end
