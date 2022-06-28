-- 文件名　：newyear_frendbox.lua
-- 创建者　：jiazhenwei
-- 创建时间：2010-01-21 10:44:47
-- 描  述  ：新年同伴

local tbItem = Item:GetClass("gamefriend1")

function tbItem:OnUse()
	if (Partner.bOpenPartner ~= 1) then
		Dialog:Say("Tính năng đồng hành chưa mở, không thể sử dụng.");
		return 0;
	end
	
	local szInfo = "Hãy chọn đồng hành:";
	if me.nLevel < 100 then
		me.Msg( "Cấp của bạn không đủ 100 hãy đạt đủ cấp rồi thử lại.");	
		return 0;
	end
	if me.nFaction == 0 then
		me.Msg( "Bạn chưa gia nhập môn phái không thể có đồng hành.");
		return 0;
	end
	if me.nPartnerCount >= me.nPartnerLimit then
		me.Msg("Số lượng đồng hành đã đủ.");	    	
		return 0;
	end		
	local tbOpt = {{"Chọn đồng hành nữ", self.SelectTemp, self, 6802, it.dwId},
			{"Chọn đồng hành nam", self.SelectTemp, self, 6801, it.dwId},
			{"Kết thúc"},
		};
	Dialog:Say(szInfo,tbOpt);
	return 0;
end

function tbItem:SelectTemp(nNpcTempId,nItemId)
	local szInfo = "Lựa chọn loại đồng hành bạn muốn:";
	local	tbOpt = {{"Thân pháp 50%，Ngoại công50%", self.SelectSeries, self, nNpcTempId, nItemId, 1},
			{"Ngoại công 50%，Nội công 50%", self.SelectSeries, self, nNpcTempId, nItemId, 2},
			{"Sức mạnh 30%，Thân pháp 30%，Ngoại công 40%", self.SelectSeries, self, nNpcTempId, nItemId, 3},
			{"Sức mạnh 30%，Thân pháp 20%，Ngoại công 50%", self.SelectSeries, self, nNpcTempId, nItemId, 4},
			{"Sức mạnh 40%，Thân pháp 20%，Ngoại công 40%", self.SelectSeries, self, nNpcTempId, nItemId, 5},
			{"Sức mạnh 40%，Thân pháp 30%，Ngoại công 30%", self.SelectSeries, self, nNpcTempId, nItemId, 6},
			{"Sức mạnh 40%，Thân pháp 10%，Ngoại công 50%", self.SelectSeries, self, nNpcTempId, nItemId, 7},
			{"Sức mạnh 40%，Thân pháp 10%，Ngoại công 10%，Nội công 40%", self.SelectSeries, self, nNpcTempId, nItemId, 8},
			{"Sức mạnh 50%，Thân pháp 20%，Ngoại công 30%", self.SelectSeries, self, nNpcTempId, nItemId, 9},
			{"Kết thúc"},
		};
	Dialog:Say(szInfo,tbOpt);
	return 0;
end

function tbItem:SelectSeries(nNpcTempId, nItemId, nPotenTemplId)
	local szInfo = "Lựa chọn các giá trị: \n  Bạn có thể lựa chọn bạn đồng hành theo <color=yellow>Ngũ hành<color>";
	local	tbOpt = {{"Kim", self.Select, self, nNpcTempId, nItemId, 1, nPotenTemplId},
			{"Mộc", self.Select, self, nNpcTempId, nItemId, 2, nPotenTemplId},
			{"Thủy", self.Select, self, nNpcTempId, nItemId, 3, nPotenTemplId},
			{"Hỏa", self.Select, self, nNpcTempId, nItemId, 4, nPotenTemplId},
			{"Thổ", self.Select, self, nNpcTempId, nItemId, 5, nPotenTemplId},			
			{"Kết thúc"},
		};
	Dialog:Say(szInfo,tbOpt);
	return 0;
end
function tbItem:Select(nNpcTempId, nItemId, nSeries, nPotenTemplId)	
	local pItem =  KItem.GetObjById(nItemId);
	if pItem then
		local nRes = Partner:AddPartner(me.nId, nNpcTempId, nSeries, nPotenTemplId);
		if nRes ~= 0 then			
			pItem.Delete(me);
			EventManager:WriteLog(string.format("[Sử dụng đạo cụ đồng hành] truy cập ID là：%s bạn đồng hành", nPotenTemplId), me);
			me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[Sử dụng đạo cụ đồng hành] truy cập ID là：%s bạn đồng hành", nPotenTemplId ));
		end
	end
end
