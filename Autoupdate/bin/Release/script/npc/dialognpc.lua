

local function _OnDialog(self)
	local tbDailog	= self.tbMap[him.nMapId] or self.tbMap[0];
	if (tbDailog) then
    	Dialog:Say(tbDailog.szMsg, tbDailog.tbOpt);
    else
    	print(string.format("Npc[%d]@%d OnDialog not define!", him.nTemplateId, him.nMapId));
    end;
end;

local function _init()
	local tbData	= Lib:LoadTabFile("\\setting\\npc\\dialognpc.txt");
	for _, tbRow in pairs(tbData) do
		local tbOpt	= {};
		for i = 1, 9 do
			local szOption	= tbRow["Option"..i];
			if (string.sub(szOption,1,3) == '"""') then	-- 防止配置文件误出现引号
				szOption	= Lib:ReplaceStr(string.sub(szOption,2,-2), '""', '"');
			end;
			if (szOption ~= "") then
				local tb	= Lib:SplitStr(szOption);
				tbOpt[#tbOpt+1]	= {Lib:Str2Val(szOption)};
			end;
		end;
		if (tbOpt[#tbOpt] and tbOpt[#tbOpt][2]) then
			tbOpt[#tbOpt+1]	= {"Kết thúc đối thoại"};
		end;
		local tbClass	= Npc:GetClass(tbRow.ClassName);
		tbClass.OnDialog= rawget(tbClass, "OnDialog") or _OnDialog;
		if (not tbClass.tbMap) then
			tbClass.tbMap	= {};
		end;
		tbClass.tbMap[tonumber(tbRow.MapId) or 0]	= {
			tbOpt	= tbOpt,
			szMsg	= tbRow.Msg,
		};
	end;
end;

_init();
