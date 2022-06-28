local tbItemBox = Ui(Ui.UI_ITEMBOX);
local tbObject = Ui.tbLogic.tbObject;
local tbMouse = Ui.tbLogic.tbMouse;
local tbExtBagLayout = Ui.tbLogic.tbExtBagLayout;

local OBJ_MAINBAG			= "ObjMainBag";
local STATE_USE =					-- �ñ�ע��������Ҫ����Ҽ����ٷ���Ʒ��״̬
{
	UiManager.UIS_ACTION_GIFT,		-- �������״̬
	UiManager.UIS_EQUIP_BREAKUP, 	-- װ�����״̬
	UiManager.UIS_EQUIP_ENHANCE,	-- װ��ǿ��
	UiManager.UIS_EQUIP_PEEL,		-- ��������
	UiManager.UIS_EQUIP_COMPOSE,	-- �����ϳ�
	UiManager.UIS_EQUIP_UPGRADE,	-- ӡ������
	UiManager.UIS_EQUIP_REFINE,		-- װ������
	UiManager.UIS_TRADE_PLAYER,     -- ����״̬--�ǽ�ɽԭ��
	UiManager.UIS_OPEN_REPOSITORY,	-- �򿪴�����
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
