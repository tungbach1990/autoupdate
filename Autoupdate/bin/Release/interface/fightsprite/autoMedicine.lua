-----------------------------------------------------------
-- 作    者 ：  小虾米
-- 修改时间 ：	2009-08-05
-- 功能描述 ：	血量、内力低于设定值自动吃药、菜
--              PK时血量低于设定值后，连续吃3个药，然后4秒内不吃药
--              平时血量或内力低于设定值后，只吃1个药，然后1秒内不吃药
-----------------------------------------------------------

local tbTimer = Ui.tbLogic.tbTimer;
local uiAutoFight = Ui(Ui.UI_AUTOFIGHT);

--local tCmd = { "AutoAi:AutoEatRed();", "AutoEatRed", "", "F9", "F9", "自动吃红" };
--AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
--UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);  -- 吃红热键：F9   

--local tCmd = { "AutoAi:AutoEatBlue();", "AutoEatBlue", "", "F10", "F10", "自动吃蓝" };
--AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
--UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);  -- 吃蓝热键：F10 

local INTERVAl_RED	  = Env.GAME_FPS / 3;    -- 1/3秒检查一次血量
local INTERVAl_BLUE   = Env.GAME_FPS / 3;    -- 1/3秒检查一次内力
local nLifeRet        = 0;                   
local nManaLeft       = 30;                  -- 内剩下多少就补内（百分比）
local blife           = 0;
local bmana           = 0;
local bfood           = 1;                   -- 是否自动吃菜
local nFoodLifeRet    = 0.6;                 -- 血剩下多少就吃菜（即60%）
local nFoodManaRet    = 0.2;                 -- 内剩下多少就吃菜（即20%）
local nEatRedTimerId  = 0;
local nEatBlueTimerId = 0;
local nAutoSelect     = 0;                   -- 是否自动选择PK吃药模式,为1时“PK吃药模式”“PK连续吃红”“PK连续吃蓝”勾选无效
local TimeLastEatRed  = 0;                   -- 上次吃红时间
local TimeLastEatBlue = 0;                   -- 上次吃蓝时间
local nPkModel        = 0;                   -- PK吃药模式 1为PK模式 0为平常模式
local nSeriesRed      = 0;                   -- PK连续吃红
local nSeriesBlue     = 0;                   -- PK连续吃蓝
local INTERVAl_PK 	  = 4;                   -- PK时吃药间隔(秒)
local NUMBER_EAT	    = 3;                   -- PK时连续吃药数量
local INTERVAl_NORMAL	= 0.5;                 -- 平时吃药间隔(秒)
local nCurMapId       = 0;                   -- 记录当前地图ID
local nDomainFight    = 0;                   -- 记录当前征战状态
local nRedTimes       = 0;                   -- 记录已连续吃红药数量
local nBlueTimes      = 0;                   -- 记录已连续吃蓝药数量
local nMsgSwitch      = 0;                   -- 输出“吃红间隔还剩3秒”之类的开关(吃药间隔时间1秒以上才输出)
local num1 = 0;
local num2 = 0;
local RED  = {};
local BLUE = {};

-- 红药(包括双回药)
local MEDICINE_RED = {		
	{17,8,1,3},--逍遥回血丹(大)
	{17,8,1,2},--逍遥回血丹(中)
	{17,8,1,1},--逍遥回血丹(小)	
	{17,7,1,3},--领土战回血丹(大)
	{17,7,1,2},--领土战回血丹(中)
	{17,7,1,1},--领土战回血丹(小)	
	{17,6,1,3},--回血丹(大)
	{17,6,1,2},--回血丹(中)
	{17,6,1,1},--回血丹(小)      -- 宋金战场	
		
	{17,8,3,3},--逍遥乾坤造化丸(大)	
	{17,8,3,2},--逍遥乾坤造化丸(中)
	{17,8,3,1},--逍遥乾坤造化丸(小) 
	{17,7,3,3},--领土战乾坤造化丸(大)	
	{17,7,3,2},--领土战乾坤造化丸(中)
	{17,7,3,1},--领土战乾坤造化丸(小) 
	{17,6,3,3},--乾坤造化丸(大)	
	{17,6,3,2},--乾坤造化丸(中)
	{17,6,3,1},--乾坤造化丸(小)  -- 宋金战场	
	
	{17,1,1,6},--灵芝续命丸
	{17,1,1,5},--九转还魂丹
	{17,1,1,4},--回天丹
	{17,1,1,3},--金创药大
	{17,1,1,2},--金创药中
	{17,1,1,1},--金创药小
	
	{17,3,1,6},--瑶池大还丹	
	{17,3,1,5},--五花玉露丸
	{17,3,1,4},--七巧补心丹
	{17,3,1,3},--承仙蜜（大）
	{17,3,1,2},--承仙蜜（中）	
	{17,3,1,1},--承仙蜜（小）	
};

-- 蓝药(包括双回药)
local MEDICINE_BLUE = {		
	{17,8,2,3},--逍遥回内丹(大)
	{17,8,2,2},--逍遥回内丹(中)
	{17,8,2,1},--逍遥回内丹(小)
	{17,7,2,3},--领土战回内丹(大)
	{17,7,2,2},--领土战回内丹(中)
	{17,7,2,1},--领土战回内丹(小)
	{17,6,2,3},--回内丹(大)
	{17,6,2,2},--回内丹(中)
	{17,6,2,1},--回内丹(小)      -- 宋金战场	
	
	{17,8,3,3},--逍遥乾坤造化丸(大)	
	{17,8,3,2},--逍遥乾坤造化丸(中)
	{17,8,3,1},--逍遥乾坤造化丸(小) 
	{17,7,3,3},--领土战乾坤造化丸(大)	
	{17,7,3,2},--领土战乾坤造化丸(中)
	{17,7,3,1},--领土战乾坤造化丸(小) 
	{17,6,3,3},--乾坤造化丸(大)	
	{17,6,3,2},--乾坤造化丸(中)
	{17,6,3,1},--乾坤造化丸(小)  -- 宋金战场	
	
	{17,2,1,6},--雪参返气丸	
	{17,2,1,5},--首乌还神丹
	{17,2,1,4},--大补散
	{17,2,1,3},--凝神丹（大）
	{17,2,1,2},--凝神丹（中）
	{17,2,1,1},--凝神丹（小）
		
	{17,3,1,6},--瑶池大还丹	
	{17,3,1,5},--五花玉露丸
	{17,3,1,4},--七巧补心丹
	{17,3,1,3},--承仙蜜（大）
	{17,3,1,2},--承仙蜜（中）	
	{17,3,1,1},--承仙蜜（小）	
};

-- 功能:开启/关闭自动吃红
function AutoAi:AutoEatRed(nSwitch,nLifeValue,nMyPkModel,nPkSeriesRed,nMyAutoSelect)
	if nSwitch then
		blife = nSwitch;
	elseif (blife == 1) then
		blife = 0;
	else
		blife = 1;
	end
	if blife == 1 then	
		if (nEatRedTimerId > 0) then
			tbTimer:Close(nEatRedTimerId);
		end
		nEatRedTimerId  = 0;
		TimeLastEatRed  = 0;	
		nRedTimes = 0;	
		local tbPlus_Setting = Ui:GetClass("peresplus_setting"); -- 加载战斗精灵数据
		local tbSetting = {}; 
		if Lib:CountTB(tbPlus_Setting) > 0 then
			tbSetting = tbPlus_Setting:Load(tbPlus_Setting.DATA_KEY) or {};		
			nLifeRet = tbSetting.nLifeRet or 0;
			nPkModel = tbSetting.nPkModel or 0;
			nSeriesRed = tbSetting.nSeriesRed or 0;
			nAutoSelect = tbSetting.nAutoSelect or 0;
		end
		if nLifeValue then
			nLifeRet = nLifeValue;
		elseif (nLifeRet == 0) then
			uiAutoFight:LoadSetting(); -- 如果没有战斗精灵插件，则读取自动战斗设置
			nLifeRet = uiAutoFight.nLifeRet;
		end		
		if nMyPkModel then
			nPkModel = nMyPkModel;
		end	
		if nPkSeriesRed then
			nSeriesRed = nPkSeriesRed;
		end	
		if nMyAutoSelect then
			nAutoSelect = nMyAutoSelect;
		end
		if (nAutoSelect == 1) then
			if me.nPkModel == Player.emKPK_STATE_PRACTISE then
				nPkModel = 0;  -- 如果设置了自动选择PK吃药模式，则练功模式下为平常模式
			else
				nPkModel = 1;  -- 非练功模式为PK模式
				nSeriesRed = 1;
			end
		end
		RED = AutoAi:GetRedSuitable();
		nCurMapId = me.GetMapTemplateId();
		nDomainFight = me.GetNpc().GetRangeDamageFlag();
		me.Msg("<color=yellow>Kích hoạt tính năng tự dùng HP<color>");
		me.Msg("<color=lightblue>Uống HP khi còn <color=gold>"..nLifeRet.." %");
		if (nPkModel == 1) then
			me.Msg("<color=yellow>Mode thuốc: Mode PK<color>");
		else
			me.Msg("<color=yellow>Mode thuốc: Mode thường<color>");
		end
		if (nEatRedTimerId == 0) then
			nEatRedTimerId = tbTimer:Register(INTERVAl_RED, self.OnEatRedTimer, self);
		end		
	else
		if (nEatRedTimerId > 0) then
			tbTimer:Close(nEatRedTimerId);
		end
		nEatRedTimerId  = 0;
		TimeLastEatRed  = 0;	
		nRedTimes = 0;
		RED = {};
		BLUE = {};
		-- me.Msg("<color=green>Tắt tự uống HP<color>");
	end
end

-- 功能:开启/关闭自动吃蓝
function AutoAi:AutoEatBlue(nSwitch,nManaValue,nMyPkModel,nPkSeriesBlue,nMyAutoSelect)
	if nSwitch then
		bmana = nSwitch;
	elseif (bmana == 1) then
		bmana = 0;
	else
		bmana = 1;
	end
	if bmana == 1 then
		if (nEatBlueTimerId > 0) then
			tbTimer:Close(nEatBlueTimerId);
		end
		nEatBlueTimerId = 0;
		TimeLastEatBlue = 0; 		
		nBlueTimes = 0;
		local tbPlus_Setting = Ui:GetClass("peresplus_setting"); -- 加载战斗精灵数据
		local tbSetting = {}; 
		if Lib:CountTB(tbPlus_Setting) > 0 then
			tbSetting = tbPlus_Setting:Load(tbPlus_Setting.DATA_KEY) or {};		
			nManaLeft = tbSetting.nManaRet or 0;
			nPkModel = tbSetting.nPkModel or 0;
			nSeriesBlue = tbSetting.nSeriesBlue or 0;
			nAutoSelect = tbSetting.nAutoSelect or 0;
		end
		if nManaValue then
			nManaLeft = nManaValue;
		end		
		if nMyPkModel then
			nPkModel = nMyPkModel;
		end	
		if nPkSeriesBlue then
			nSeriesBlue = nPkSeriesBlue;
		end	
		if nMyAutoSelect then
			nAutoSelect = nMyAutoSelect;
		end
		if (nAutoSelect == 1) then
			if me.nPkModel == Player.emKPK_STATE_PRACTISE then
				nPkModel = 0;  -- 如果设置了自动选择PK吃药模式，则练功模式下为平常模式
			else
				nPkModel = 1;  -- 非练功模式为PK模式
				nSeriesRed = 1;
			end
		end
		BLUE = AutoAi:GetBlueSuitable();
		nCurMapId = me.GetMapTemplateId();
		nDomainFight = me.GetNpc().GetRangeDamageFlag();
		me.Msg("<color=yellow>Kích hoạt tính năng tự dùng MP<color>");
		me.Msg("<color=lightblue>Uống MP khi còn <color=gold>"..nManaLeft.." %");
		if (nPkModel == 1) then
			me.Msg("<color=yellow>Mode thuốc: Mode PK<color>");
		else
			me.Msg("<color=yellow>Mode thuốc: Mode thường<color>");
		end		
		if (nEatBlueTimerId == 0) then
			nEatBlueTimerId = tbTimer:Register(INTERVAl_BLUE, self.OnEatBlueTimer, self);
		end
	else
		if (nEatBlueTimerId > 0) then
			tbTimer:Close(nEatBlueTimerId);
		end
		nEatBlueTimerId = 0;
		TimeLastEatBlue = 0; 		
		nBlueTimes = 0;
		RED = {};
		BLUE = {};
		-- me.Msg("<color=green>Tắt tự uống MP<color>");
	end
end

-- 功能:根据血量自动吃红药、菜
function AutoAi:OnEatRedTimer()
	if (nAutoSelect == 1) then
		if me.nPkModel == Player.emKPK_STATE_PRACTISE then
			nPkModel = 0;  -- 如果设置了自动选择PK吃药模式，则练功模式下为平常模式
		else
			nPkModel = 1;  -- 非练功模式为PK模式
			nSeriesRed = 1;
		end
	end
	local nMyMapId = me.GetMapTemplateId();
	local nDomain = me.GetNpc().GetRangeDamageFlag();
	if (Lib:CountTB(RED) == 0 or Lib:CountTB(BLUE) == 0 or nMyMapId ~= nCurMapId or nDomain ~= nDomainFight) then
		RED = AutoAi:GetRedSuitable();  -- 地图或征战状态改变后才重新读取药品数据
		BLUE = AutoAi:GetBlueSuitable();
		nCurMapId = nMyMapId;
		nDomainFight = nDomain;
	end	
	if bfood == 1 and (me.nCurLife / me.nMaxLife < nFoodLifeRet or me.nCurMana / me.nMaxMana < nFoodManaRet) then
		AutoAi:AutoEatFood(); -- 吃菜
	end
	local nInterval = 0;
	local nNumberEat = 0;
	if (nPkModel == 1) then
		nInterval = INTERVAl_PK;
	else
		nInterval = INTERVAl_NORMAL;
	end
	if (nPkModel == 1 and nSeriesRed == 1) then
		nNumberEat = NUMBER_EAT;
	else
		nNumberEat = 1;
	end
	if (TimeLastEatRed + nInterval > os.time()) and (nRedTimes == nNumberEat) then
		num1 = num1 + 1;
		for i = 1, nInterval do
			if (nMsgSwitch == 1 and nInterval > 1 and TimeLastEatRed + i == os.time() and num1 % 3 == 0) then
				local nRest = nInterval - i;
				me.Msg("Uống HP khi còn <color=gold>"..nRest.." %");
			end
		end
		return;		        -- 吃药间隔时间内并且已吃药数量达到设定值时不吃药
	elseif TimeLastEatRed > 0 and TimeLastEatRed + nInterval <= os.time() then
		nRedTimes = 0;    -- 吃药间隔时间过后，将最后一次的吃药时间和已吃药数量清零
		TimeLastEatRed = 0;
		num1 = 0;
	end	
	if (me.nCurLife * 100 / me.nMaxLife < nLifeRet) or (TimeLastEatRed > 0 and nRedTimes < nNumberEat) then	
		for i,tbYAO in pairs(RED) do
			local tbFind = me.FindItemInBags(unpack(tbYAO));
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
				TimeLastEatRed = os.time();
				nRedTimes = nRedTimes + 1;
				return;
			end
		end
	end
end

-- 功能:根据内力自动吃蓝药、菜
function AutoAi:OnEatBlueTimer()
	if (nAutoSelect == 1) then
		if me.nPkModel == Player.emKPK_STATE_PRACTISE then
			nPkModel = 0;  -- 如果设置了自动选择PK吃药模式，则练功模式下为平常模式
		else
			nPkModel = 1;  -- 非练功模式为PK模式
			nSeriesRed = 1;
		end
	end
	local nMyMapId = me.GetMapTemplateId();
	local nDomain = me.GetNpc().GetRangeDamageFlag();
	if (Lib:CountTB(RED) == 0 or Lib:CountTB(BLUE) == 0 or nMyMapId ~= nCurMapId or nDomain ~= nDomainFight) then
		RED = AutoAi:GetRedSuitable();  -- 地图或征战状态改变后才重新读取药品数据
		BLUE = AutoAi:GetBlueSuitable();
		nCurMapId = nMyMapId;
		nDomainFight = nDomain;
	end
	if bfood == 1 and (me.nCurLife / me.nMaxLife < nFoodLifeRet or me.nCurMana / me.nMaxMana < nFoodManaRet) then
		AutoAi:AutoEatFood(); -- 吃菜
	end
	local nInterval = 0;
	local nNumberEat = 0;
	if (nPkModel == 1) then
		nInterval = INTERVAl_PK;
	else
		nInterval = INTERVAl_NORMAL;
	end
	if (nPkModel == 1 and nSeriesBlue == 1) then
		nNumberEat = NUMBER_EAT;
	else
		nNumberEat = 1;
	end
	if (TimeLastEatBlue + nInterval > os.time()) and (nBlueTimes == nNumberEat) then
		num2 = num2 + 1;
		for i = 1, nInterval do
			if (nMsgSwitch == 1 and nInterval > 1 and TimeLastEatRed + i == os.time() and num2 % 3 == 0) then
				local nRest = nInterval - i;
				me.Msg("Uống MP khi còn <color=gold>"..nRest.." %");
			end
		end
		return;		        -- 吃药间隔时间内并且已吃药数量达到设定值时不吃药
	elseif TimeLastEatBlue > 0 and TimeLastEatBlue + nInterval <= os.time() then
		nBlueTimes = 0;   -- 吃药间隔时间过后，将最后一次的吃药时间和已吃药数量清零
		TimeLastEatBlue = 0;
		num2 = 0;
	end	
	if (me.nCurMana * 100 / me.nMaxMana < nManaLeft) or (TimeLastEatBlue > 0 and nBlueTimes < nNumberEat) then			
		for i,tbYAO in pairs(BLUE) do
			local tbFind = me.FindItemInBags(unpack(tbYAO));
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
				TimeLastEatBlue = os.time();
				nBlueTimes = nBlueTimes + 1;
				return;
			end
		end
	end
end

-- 功能:吃菜
function AutoAi:AutoEatFood()
	if me.IsCDTimeUp(3) == 1 and 0 == AutoAi.Eat(3) then	-- 先吃短效食物
		local nLevel, nState, nTime = me.GetSkillState(AutoAi.FOOD_SKILL_ID); 
		if (not nTime or nTime < 36) then
			AutoAi.nLastFood = nCurTime;
			if 0 == AutoAi.Eat(4) then -- 长效食物
				-- me.Msg("没有菜吃了!");
			end
		end
	end
end

-- 功能:获取适合当前地图使用的红药
function AutoAi:GetRedSuitable()
	local nMyMapId = me.GetMapTemplateId();
	local szMapType = AutoAi:GetMapTypeByMapId(nMyMapId);
	local RED_TEMP = {};
	if (me.GetNpc().GetRangeDamageFlag() == 1) then
		RED_TEMP  = self:GetRedByType(7);  -- 征战状态
	elseif(szMapType == "xoyogame") then
		RED_TEMP  = self:GetRedByType(8);  -- 逍遥谷地图
	elseif(szMapType == "battle") then
		RED_TEMP  = self:GetRedByType(6);  -- 宋金战场地图
	else
		RED_TEMP  = self:GetRedByType(0);  -- 其他地图
	end
	return RED_TEMP;
end

-- 功能:获取适合当前地图使用的蓝药
function AutoAi:GetBlueSuitable()
	local nMyMapId = me.GetMapTemplateId();
	local szMapType = AutoAi:GetMapTypeByMapId(nMyMapId);
	local BLUE_TEMP = {};
	if (me.GetNpc().GetRangeDamageFlag() == 1) then
		BLUE_TEMP = self:GetBlueByType(7);
	elseif(szMapType == "xoyogame") then
		BLUE_TEMP = self:GetBlueByType(8);
	elseif(szMapType == "battle") then
		BLUE_TEMP = self:GetBlueByType(6);
	else
		BLUE_TEMP = self:GetBlueByType(0);
	end
	return BLUE_TEMP;
end

-- 功能:按地图类型获取红药集合
function AutoAi:GetRedByType(nType)
	local j = 0;
	local TEMP = {};
	for i,tbYAO in pairs(MEDICINE_RED) do
		local g = tbYAO[1];
		local d = tbYAO[2];
		local p = tbYAO[3];
		local l = tbYAO[4];
		if (d == nType and (p == 1 or p == 3)) or d == 1 or d == 3 then
			j = j + 1;
			TEMP[j] = tbYAO;
		end
	end
	return TEMP;
end

-- 功能:按地图类型获取蓝药集合
function AutoAi:GetBlueByType(nType)
	local j = 0;
	local TEMP = {};
	for i,tbYAO in pairs(MEDICINE_BLUE) do
		local g = tbYAO[1];
		local d = tbYAO[2];
		local p = tbYAO[3];
		local l = tbYAO[4];
		if (d == nType and (p == 2 or p == 3)) or d == 2 or d == 3 then
			j = j + 1;
			TEMP[j] = tbYAO;
		end
	end
	return TEMP;
end

-- 功能:按地图模板ID获取地图类型
function AutoAi:GetMapTypeByMapId(nMyMapId)
	local szMapType = "";
	local pTabFile = KIo.OpenTabFile("\\setting\\map\\maplist.txt");
	if (not pTabFile) then
		return 0;
	end
	local nHeight = pTabFile.GetHeight();
	for i = 3, nHeight do
		local nMapId = pTabFile.GetInt(i, 2);
		if nMapId == nMyMapId then
			szMapType = pTabFile.GetStr(i, 5);
			break;
		end
	end
	KIo.CloseTabFile(pTabFile);
	return szMapType;
end