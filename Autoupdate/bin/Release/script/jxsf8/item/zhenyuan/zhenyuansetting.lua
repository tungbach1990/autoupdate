------------------------------------------------------
-- �ļ�������zhenyuansetting.lua
-- �����ߡ���dengyong
-- ����ʱ�䣺2010-07-05 14:58:24
-- ����    ����Ԫ�����ñ����
------------------------------------------------------
Item.tbZhenYuanSetting  = {};

local tbZhenYuanSetting = Item.tbZhenYuanSetting;

tbZhenYuanSetting.PATH_SETTING		= "\\setting\\item\\001\\zhenyuansetting\\";

tbZhenYuanSetting.ATTRIB_SETTING	= "attribsetting.txt";  -- �������ñ�
tbZhenYuanSetting.LEVEL_SETTING		= "levelsetting.txt";   -- ���Եȼ���
tbZhenYuanSetting.MIN_LEVEL				= 1;			-- �ȼ�����
tbZhenYuanSetting.MAX_LEVEL				= 500;			-- �ȼ�����

-- �����Щ�������ݵ��ڴ��
tbZhenYuanSetting.tbAttribSetting 			= {};	-- ���Լ�ֵ���ͳɳ���
tbZhenYuanSetting.tbAttribNameToId 			= {};	-- ħ����������ħ������IDӳ���
tbZhenYuanSetting.m_LevelExp = {};
tbZhenYuanSetting.m_LevelValue = {};


-- �������ñ���ֵ�������ʳɳ���
-- tbAttribSetting = 
-- {
--		[AttribId] = {szDesc, nWeight, StarLevel1Value, ..., StarLevel20Value, StarLevel1Growth, ..., StarLevel20Growth}
-- }
-- tbAttribNameToId =
-- {
-- 		[Desc] = {AttribId},
-- }
function tbZhenYuanSetting:LoadAttribSetting()
	local tbFile = Lib:LoadTabFile(self.PATH_SETTING..self.ATTRIB_SETTING);
	if not tbFile then
		print("�������ñ�����ʧ�ܣ�");
		return;
	end
	
	self.tbAttribSetting = {};
	self.tbAttribNameToId = {};
	
	for _, tbValue in pairs(tbFile) do
		local nAttribId = tonumber(tbValue.AttribId);
		if not nAttribId then
			assert(false);
		end
		
		self.tbAttribSetting[nAttribId] = self.tbAttribSetting[nAttribId] or {};
		
		self.tbAttribSetting[nAttribId].szDesc = tbValue.Desc;
		self.tbAttribSetting[nAttribId].szTipText = tbValue.TipText;
		self.tbAttribSetting[nAttribId].szTipDesc = tbValue.TipDesc;
			
		self.tbAttribNameToId[tbValue.Desc] = {};
		self.tbAttribNameToId[tbValue.Desc] = nAttribId;
	end
end

function tbZhenYuanSetting:LoadLevelSetting()
	local tbFile = Lib:LoadTabFile(self.PATH_SETTING..self.LEVEL_SETTING);

	if not tbFile then
		print("�������ñ�����ʧ�ܣ�");
		return;
	end
	
	self.m_LevelExp = {};
	self.m_LevelValue = {};

	for _, tbValue in pairs(tbFile) do
		local nLevel = tonumber(tbValue['Level']);
		self.m_LevelExp[nLevel] = tonumber(tbValue['UpgardeExp']);
		self.m_LevelValue[nLevel] = tonumber(tbValue['Value']);
	end
end
tbZhenYuanSetting:LoadAttribSetting();
tbZhenYuanSetting:LoadLevelSetting();