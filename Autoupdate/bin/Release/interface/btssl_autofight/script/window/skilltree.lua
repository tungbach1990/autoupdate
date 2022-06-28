-----------------------------------------------------
--文件名		：	skilltree.lua
--创建者		：	wuwuei1, tongxuehu
--创建时间		：	2007-04-19
--功能描述		：	左右键技能选择板
------------------------------------------------------

local uiSkillTree = Ui(Ui.UI_SKILLTREE);

uiSkillTree.OBJ_SKILLTREE	= "ObjSkillTree";
uiSkillTree.MAX_NUM_P_LINE	= 8;
uiSkillTree.DATA_KEY 		= "KeyConfigure";

uiSkillTree.MAIN_HEIGHT		= 126;
uiSkillTree.LINEHEIGHT 		= 42;
uiSkillTree.MAIN_WIDTH		= 330;

uiSkillTree.UpdateSkill=function(self)
	local Skills = me.GetImmeSkillList(1);
	if Skills == nil then
		return;
	end
	self.nSkillNum = #Skills;
	if self.nSkillNum == 0 then
		self.bShow = 0;
		UiManager:CloseWindow(Ui.UI_SKILLTREE);
		return;
	end

	local nLine = math.floor((self.nSkillNum - 1) / self.MAX_NUM_P_LINE);
	ObjMx_SetUnitSize(self.UIGROUP, self.OBJ_SKILLTREE, self.MAX_NUM_P_LINE, nLine + 1);

    ObjMx_Clear(self.UIGROUP, self.OBJ_SKILLTREE);

	local nCol = self.MAX_NUM_P_LINE;
	local nLine = 0;
	local i = 1;
	while i < self.nSkillNum + 1 do
		local szKey = nil;
		for nKey in pairs(self.tbKeyMap) do
			if self.tbKeyMap[nKey][1] == Skills[i] and self.tbKeyMap[nKey][2] == self.nPos then
				szKey = UiShortcutAlias:GetSkillShortcut(nKey);
			end
		end
		ObjMx_AddObject(self.UIGROUP, self.OBJ_SKILLTREE, Ui.CGOG_SKILL_SHORTCUT, Skills[i], nCol - 1, nLine, szKey);
		nCol = nCol - 1;
		if nCol < 1 then
			nCol = self.MAX_NUM_P_LINE;
			nLine = nLine + 1;
		end
		i = i + 1;
	end

	local nObjPosX = 0;
	local nObjPosY = 42 * 3 - (nLine + 1) * self.LINEHEIGHT;
	local nMainHeight = (nLine + 1) * self.LINEHEIGHT;
	if nLine == 0 then
		nObjPosX = nObjPosX - 20 * (self.MAX_NUM_P_LINE - self.nSkillNum);
	end
	Wnd_SetPos(self.UIGROUP, self.OBJ_SKILLTREE, nObjPosX, nObjPosY);
	Wnd_SetSize(self.UIGROUP, self.OBJ_SKILLTREE, self.MAIN_WIDTH, nMainHeight);
end

