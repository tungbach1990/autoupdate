
function Player:SetMaxLevelGC()
    if TimeFrame:GetState("OpenLevel180") == 1 then
        if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL180) == 0 then
            KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL180, GetTime());
        end	
        if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL165) == 0 then
            KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL165, GetTime());
        end
        if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL150) == 0 then
            KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL150, GetTime());
        end
        if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL99) == 0 then
            KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL99, GetTime());
        end
        if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL89) == 0 then
            KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL89, GetTime());
        end
        if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL79) == 0 then
            KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL79, GetTime());
        end                    
        Dbg:WriteLog("Player","Cap cao nhat 180"); 
        GlobalExcute({"Player:SetMaxLevelGC2GS", 180});
        GlobalExcute({"Player.tbOffline:OnUpdateLevelInfo"});
        Task.tbHelp:UpdateLevelOpenTimeNews(DBTASD_SERVER_SETMAXLEVEL180, 180);
        return 0;
    end
    if TimeFrame:GetState("OpenLevel165") == 1 then
        if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL165) == 0 then
            KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL165, GetTime());
        end
        if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL150) == 0 then
            KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL150, GetTime());
        end
        if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL99) == 0 then
            KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL99, GetTime());
        end
        if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL89) == 0 then
            KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL89, GetTime());
        end
        if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL79) == 0 then
            KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL79, GetTime());
        end                    
        Dbg:WriteLog("Player","Cap cao nhat 165"); 
        GlobalExcute({"Player:SetMaxLevelGC2GS", 165});
        GlobalExcute({"Player.tbOffline:OnUpdateLevelInfo"});
        Task.tbHelp:UpdateLevelOpenTimeNews(DBTASD_SERVER_SETMAXLEVEL165, 165);
        return 0;
    end
	if TimeFrame:GetState("OpenLevel150") == 1 then
		KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL165, 0);
		if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL150) == 0 then
			KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL150, GetTime());
		end	
		if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL99) == 0 then
			KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL99, GetTime());
		end
		if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL89) == 0 then
			KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL89, GetTime());
		end
		if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL79) == 0 then
			KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL79, GetTime());
		end					
		Dbg:WriteLog("Player","Cap cao nhat 150"); 
		GlobalExcute({"Player:SetMaxLevelGC2GS", 150});
		GlobalExcute({"Player.tbOffline:OnUpdateLevelInfo"});
		Task.tbHelp:UpdateLevelOpenTimeNews(DBTASD_SERVER_SETMAXLEVEL150, 150);
		Wlls:SetOpenNews();
		return 0;
	end
	if TimeFrame:GetState("OpenLevel99") == 1 then
		KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL165, 0);		
		KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL150, 0);		
		if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL99) == 0 then
			KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL99, GetTime());
		end
		if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL89) == 0 then
			KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL89, GetTime());
		end
		if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL79) == 0 then
			KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL79, GetTime());
		end		
		Dbg:WriteLog("Player","Cap cao nhat 99"); 
		GlobalExcute({"Player:SetMaxLevelGC2GS", 99});
		GlobalExcute({"Player.tbOffline:OnUpdateLevelInfo"});
		Task.tbHelp:UpdateLevelOpenTimeNews(DBTASD_SERVER_SETMAXLEVEL99, 99);
		return 0;
	end
	if TimeFrame:GetState("OpenLevel89") == 1 then
		KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL165, 0);		
		KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL99, 0);
		KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL150, 0);
		if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL89) == 0 then
			KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL89, GetTime());
		end
		if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL79) == 0 then
			KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL79, GetTime());
		end		
		Dbg:WriteLog("Player","Cap cao nhat 89"); 
		GlobalExcute({"Player:SetMaxLevelGC2GS", 89});
		GlobalExcute({"Player.tbOffline:OnUpdateLevelInfo"});
		Task.tbHelp:UpdateLevelOpenTimeNews(DBTASD_SERVER_SETMAXLEVEL89, 89);
		return 0;
	end
	if TimeFrame:GetState("OpenLevel79") == 1 then
		KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL165, 0);		
		KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL89, 0);
		KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL99, 0);
		KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL150, 0);
		if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL79) == 0 then
			KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL79, GetTime());
		end
		Dbg:WriteLog("Player","Cap cao nhat 79"); 
		GlobalExcute({"Player:SetMaxLevelGC2GS", 79});
		GlobalExcute({"Player.tbOffline:OnUpdateLevelInfo"});
		Task.tbHelp:UpdateLevelOpenTimeNews(DBTASD_SERVER_SETMAXLEVEL79, 79);
		return 0;
	end
	KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL150, 0);
	KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL99, 0);
	KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL89, 0);
	KGblTask.SCSetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL79, 0);
	GlobalExcute({"Player:SetMaxLevelGC2GS", 69});
	return 0;
end

function Player:SetMaxLevelGC2GS(nMaxLevel)
	if KPlayer.GetMaxLevel() < nMaxLevel then
		KPlayer.SetMaxLevel(nMaxLevel);
		Dbg:WriteLog("Player","Cap cao nhat "..nMaxLevel);
	end
end

function Player:SetMaxLevelGS()
	--if TimeFrame:GetState("OpenLevel99") == 1 then
        if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL180) ~= 0 then
            if KPlayer.GetMaxLevel() < 180 then
                KPlayer.SetMaxLevel(180);
                Dbg:WriteLog("Player","Cap cao nhat 180"); 
            end
            return 0;
        end
        if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL165) ~= 0 then
            if KPlayer.GetMaxLevel() < 165 then
                KPlayer.SetMaxLevel(165);
                Dbg:WriteLog("Player","Cap cao nhat 165"); 
            end
            return 0;
        end
		if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL150) ~= 0 then
			if KPlayer.GetMaxLevel() < 150 then
				KPlayer.SetMaxLevel(150);
				Dbg:WriteLog("Player","Cap cao nhat 150"); 
			end
			return 0;
		end		
		if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL99) ~= 0 then
			if KPlayer.GetMaxLevel() < 99 then
				KPlayer.SetMaxLevel(99);
				Dbg:WriteLog("Player","Cap cao nhat 99"); 
			end
			return 0;
		end
	--end
	--if TimeFrame:GetState("OpenLevel89") == 1 then	
		if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL89) ~= 0 then
			if KPlayer.GetMaxLevel() < 89 then
				KPlayer.SetMaxLevel(89);
				Dbg:WriteLog("Player","Cap cao nhat 89"); 
			end
			return 0;
		end
	--end
	--if TimeFrame:GetState("OpenLevel79") == 1 then
		if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL79) ~= 0 then
			if KPlayer.GetMaxLevel() < 79 then
				KPlayer.SetMaxLevel(79);
				Dbg:WriteLog("Player","Cap cao nhat 79"); 
			end
			return 0;
		end
	--end
	--if TimeFrame:GetState("OpenLevel69") == 1 then	
		if KPlayer.GetMaxLevel() < 69 then
			KPlayer.SetMaxLevel(69)
			Dbg:WriteLog("Player","Cap cao nhat 69"); 
		end
	--end
	return 0;
end
