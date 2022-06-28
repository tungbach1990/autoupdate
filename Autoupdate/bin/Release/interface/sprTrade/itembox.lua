local tbItemBox = Ui(Ui.UI_ITEMBOX);
local tbObject = Ui.tbLogic.tbObject;
local tbMouse = Ui.tbLogic.tbMouse;
local tbExtBagLayout = Ui.tbLogic.tbExtBagLayout;

local OBJ_MAINBAG			= "ObjMainBag";
local STATE_USE =					-- 该表注册所有需要鼠标右键快速放物品的状态
{
	UiManager.UIS_ACTION_GIFT,		-- 给予界面状态
	UiManager.UIS_EQUIP_BREAKUP, 	-- 装备拆解状态
	UiManager.UIS_EQUIP_ENHANCE,	-- 装备强化
	UiManager.UIS_EQUIP_PEEL,		-- 玄晶剥离
	UiManager.UIS_EQUIP_COMPOSE,	-- 玄晶合成
	UiManager.UIS_EQUIP_UPGRADE,	-- 印鉴升级
	UiManager.UIS_EQUIP_REFINE,		-- 装备炼化
	UiManager.UIS_TRADE_PLAYER,     -- 交易状态--非金山原版
	UiManager.UIS_OPEN_REPOSITORY,	-- 打开储物箱
};

tbItemBox.tbMainBagCont.CanSendStateUse=function(self)
	local bCanSendUse = 0;
	for i, nState in ipairs (STATE_USE) do
		if UiManager:GetUiState(nState) == 1 then
			bCanSendUse = 1;
			break;
		end
	end
	return bCanSendUse;
end
