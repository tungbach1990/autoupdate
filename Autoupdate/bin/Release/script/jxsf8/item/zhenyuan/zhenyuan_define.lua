------------------------------------------------------
-- �ļ�������zhenyuan_define.lua
-- �����ߡ���dengyong
-- ����ʱ�䣺2010-07-14 11:09:02
-- ����    ����Ԫ��ض���
------------------------------------------------------

Item.tbZhenYuan = Item.tbZhenYuan or {};
Item.ZHENYUAN_EQUIP_CLASS = "zhenyuan";
Item.ZHENYUAN_ATTRIB_NUM = 4;
Item.ZHENYUAN_EXP_PER_ITEM		= 100;				-- ÿ�����ߵľ���

--SoulSignet
Item.MIN_ZHENYUAN_LEVEL		= 1;
Item.tbMAX_ZHENYUAN_LEVEL =
{
	[1] = {
		[1] = 400,
		[2] = 400,
		[3] = 400,
		[4] = 400,
	}
}

local tbZhenYuan = Item.tbZhenYuan;

tbZhenYuan.MAPPINGVALUE_MIN		= 0;		-- ����ӳ�����Сֵ
tbZhenYuan.MAPPINGVALUE_MAX		= 1000;		-- ����ӳ������ֵ
tbZhenYuan.MAPPINGVALUE_MAX_ENHANCE = 960;	-- ���Գɳ�ӳ������ֵ

tbZhenYuan.CONVERT_COST_RATE	= 15;		-- ��Ԫ������Ҫ����ͬ���ֵ��15%������
tbZhenYuan.REFINE_COST_COUNT	= 20000;	-- ��Ԫ�����̶�ÿ������2W����

tbZhenYuan.bOpen				= 1;		-- ��Ԫ���أ�1��ʾ����0��ʾ��
