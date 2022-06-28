--KNpc.GetNameByTemplateId
--GetMapNameFormId(nMapId)
local NhiemVuChinhTuyen = Ui:GetClass("NhiemVuChinhTuyen");
NhiemVuChinhTuyen.state = 0
local tbSelectNpc = Ui(Ui.UI_SELECTNPC);
local timer = 0
local pTransmit = KIo.OpenTabFile("\\setting\\map\\transmit.txt");
local pMapCity = KIo.OpenTabFile("\\setting\\map\\maplist.txt");
local nHeight_trans = pTransmit.GetHeight();
local nHeight_city = pMapCity.GetHeight();
local nNoiChuyenVoiNpc = 0

local TASK = {
{581,1,3511,"Trừng Quang",0,0,0,0,0},
{581,3,3511,"Trừng Quang",0,60,0,0,0},
{576,1,3502,"Hùng Đỉnh",0,0,0,0,0},
{576,3,3502,"Hùng Đỉnh",0,30,30,30,0},
{578,1,3521,"Hàn Phá Sơn",0,0,0,0,0},
{578,3,3521,"Hàn Phá Sơn",0,30,30,30,0},
{584,1,3517,"Đường Ngộ",0,0,0,0,0},
{584,3,3517,"Đường Ngộ",0,30,30,30,0},
--{600,1,3511,"Trừng Quang",0,0,0,0,0},
{603,1,3511,"Trừng Quang",0,0,0,0,0},
{603,3,3511,"Trừng Quang",0,30,30,30,0},
--{609,1,}
{610,1,3502,"Hùng Đỉnh",0,0,0,0,0},
{610,3,3502,"Hùng Đỉnh",0,30,30,30,0},
{611,1,3539,"Lãnh Thu Vân",0,0,0,0,0},
{611,3,3539,"Lãnh Thu Vân",0,30,30,30,0},
{615,1,3511,"Trừng Quang",0,0,0,0,0},
{615,3,3511,"Trừng Quang",0,30,30,30,0},
{615,3,3511,"Trừng Quang",0,30,60,0,0},
------------------------------------------------------------------
{306,1,3570,"Bạch Thu Lâm",0,0,0,0,0},
{306,2,3571,"Long Ngũ Thái Gia",0,0,0,0,0},
{306,3,3570,"Bạch Thu Lâm",0,0,0,0,0},
{306,4,3561,"Điềm Tửu Thúc",0,0,0,0,0},
{306,5,3561,"Điềm Tửu Thúc",0,0,0,0,0},
{307,1,3561,"Điềm Tửu Thúc",0,0,0,0,0},
{307,2,3562,"Thẩm Hà Diệp",0,0,0,0,0},
{307,3,3563,"Hách Phiêu Tịnh",0,0,0,0,0},
{307,4,3564,"Trương Trảm Kinh",0,0,0,0,0},
{307,5,3565,"Bất Động Tiên Sinh",0,0,0,0,0},
--{307,6,3566,"Đại Lão Bạch",0,0,0,0,0},
{307,7,3566,"Đại Lão Bạch",0,0,0,0,0},
{307,8,3565,"Bất Động Tiên Sinh",0,0,0,0,0},
{308,2,3565,"Bất Động Tiên Sinh",0,0,0,0,0},
{308,3,3561,"Điềm Tửu Thúc",0,0,0,0,0},
{309,1,3561,"Điềm Tửu Thúc",0,0,0,0,0},
{309,2,3582,"Thẩm Thiết Thạch",0,0,0,0,0},
{309,4,3583,"Hứa Sĩ Vĩ",0,0,0,0,0},
{317,2,3583,"Hứa Sĩ Vĩ",0,0,0,0,0},
{318,2,3583,"Hứa Sĩ Vĩ",0,0,0,0,0},
{319,2,3583,"Hứa Sĩ Vĩ",0,0,0,0,0},
{319,3,3562,"Thẩm Hà Diệp",0,0,0,0,0},
{319,4,3570,"Bạch Thu Lâm",0,0,0,0,0},
-------------------------------------------------------
{310,1,3507,"Tịch Huyễn",0,0,0,0,0},
{310,2,3501,"Bùi Viễn",0,0,0,0,0},
{310,3,3513,"Đường Tế Dân",0,0,0,0,0},
{310,4,3519,"Biên Nhất Xuân",0,0,0,0,0},
{310,5,3525,"Huyền Tịnh",0,0,0,0,0},
{310,6,3531,"Tô Nhã",0,0,0,0,0},
{310,7,3537,"La Tuấn",0,0,0,0,0},
{310,8,3543,"Tạ Phi Kinh",0,0,0,0,0},
{310,9,3549,"Minh Tuệ",0,0,0,0,0},
{310,10,3555,"Quy Kinh Tinh",0,0,0,0,0},
{310,11,3480,"Đoàn Tu Tịnh",0,0,0,0,0},
{310,12,3474,"Đồng Lăng",0,0,0,0,0},
----------------------------------------------------------
{310,1,3507,"Tịch Huyễn",1,0,0,0,0},
{310,2,3501,"Bùi Viễn",1,0,0,0,0},
{310,3,3513,"Đường Tế Dân",1,0,0,0,0},
{310,4,3519,"Biên Nhất Xuân",1,0,0,0,0},
{310,5,3525,"Huyền Tịnh",1,0,0,0,0},
{310,6,3531,"Tô Nhã",1,0,0,0,0},
{310,7,3537,"La Tuấn",1,0,0,0,0},
{310,8,3543,"Tạ Phi Kinh",1,0,0,0,0},
{310,9,3549,"Minh Tuệ",1,0,0,0,0},
{310,10,3555,"Quy Kinh Tinh",1,0,0,0,0},
{310,11,3480,"Đoàn Tu Tịnh",1,0,0,0,0},
{310,12,3474,"Đồng Lăng",1,0,0,0,0},
-----------------------------------------------------------
{310,13,3570,"Bạch Thu Lâm",0,1,0,0,0},
{310,15,3570,"Bạch Thu Lâm",1,1,0,0,0},
{311,1,3570,"Bạch Thu Lâm",0,0,0,0,0},
{311,5,3584,"Giới Sơn Tông",0,0,0,0,0},--217 194
{320,3,3584,"Giới Sơn Tông",0,0,0,0,0},
{320,4,3570,"Bạch Thu Lâm",0,0,0,0,0},
{312,1,3561,"Điềm Tửu Thúc",0,0,0,0,0},
{312,4,3562,"Thẩm Hà Diệp",0,0,0,0,0},
{312,7,3563,"Hách Phiêu Tịnh",0,0,0,0,0},
{312,10,3564,"Trương Trảm Kinh",0,0,0,0,0},
{312,13,3565,"Bất Động Tiên Sinh",0,0,0,0,0},
{312,16,3565,"Bất Động Tiên Sinh",0,0,0,0,0},
{313,1,3567,"Tạ Hiền",0,0,0,0,0},
{313,2,3578,"Rương cũ nát 1",0,0,0,0,0},
{313,2,3579,"Rương cũ nát 2",1,0,0,0,0},
{313,2,3580,"Rương cũ nát 3",1,1,0,0,0},
{313,3,3581,"Rương kỳ lạ",0,1,1,0,0},
{313,4,3570,"Bạch Thu Lâm",0,1,1,0,0},
{313,5,2599,"Trâu Đức Khoái",0,1,1,0,0},
{313,6,3570,"Bạch Thu Lâm",0,1,1,0,0},
{321,1,3590,"Cao Thăng",0,0,0,0,0},
{321,3,3591,"Thôi Kiếm",0,0,0,0,0},
{322,2,3585,"Bạch Cương",0,0,0,0,0},
{323,1,3590,"Cao Thăng",0,0,0,0,0},
{323,3,3591,"Thôi Kiếm",0,0,0,0,0},
{323,5,3585,"Bạch Cương",0,0,0,0,0},
{323,6,3590,"Cao Thăng",0,0,0,0,0},--Het nhiem vu den 20
{314,1,3590,"Cao Thăng",0,0,0,0,0},
{314,2,3504,"Quý Thúc Ban",0,0,0,0,0},
{314,-1,3504,"Quý Thúc Ban",0,0,0,0,0},
{1,1,3504,"Quý Thúc Ban",0,0,0,0,0},
{1,2,8,"Thuyền Phu",0,0,0,0,0},
{1,3,5,"Quý Thúc Ban",0,0,0,0,0},
{1,6,1,"Dương Anh",0,1,1,0,0},
{2,1,2,"Dương Thiết Tâm",0,0,0,0,0},
{2,2,4,"Dương Thiết Tâm",0,0,0,0,0},
{2,4,4,"Dương Thiết Tâm",0,0,0,0,0},
{2,5,14,"Đệ Tử Phân Đà Thành Đ",0,0,0,0,0},
{2,7,12,"Bùi Dực Phi",0,0,0,0,0},
{3,1,15,"Hoa Tử Lý Tuyền",0,0,0,0,0},
{3,3,15,"Hoa Tử Lý Tuyền",0,1,0,0,0},
{3,5,12,"Bùi Dực Phi",0,1,0,0,0},
{3,6,4,"Dương Thiết Tâm",0,1,0,0,0},
{4,2,18,"Lư Tiếu Bần",0,0,0,0,0},
{4,4,18,"Lư Tiếu Bần",0,1,0,0,0},
{4,5,19,"Bang Chúng Kính Trang",1,1,0,0,0},
{5,4,4,"Dương Thiết Tâm",0,0,0,0,0},
{6,2,4,"Dương Thiết Tâm",0,1,1,1,0},
{8,1,4,"Dương Thiết Tâm",0,0,0,0,0},
{8,4,29,"Ngư Phu",0,0,0,0,0},
{8,5,3541,"La Phong",0,0,0,0,0},-------------het nv 30
{9,1,3541,"La Phong",0,1,0,0,0},
{9,2,30,"Thạch Hiên Viên",0,1,0,0,0},
{9,3,31,"Cầu Chỉ Thủy",0,1,0,0,0},
{9,4,33,"Môn đồ Không Động",0,0,0,0,0},
{9,4,34,"Môn đồ Thanh Thành",1,0,0,0,0},
{9,4,35,"Môn đồ Tích Lịch Hỏa L",1,1,0,0,0},
{9,5,1504,"Hộp quà Thần Thương Phư",0,0,0,0,0},
{9,5,1505,"Hộp quà Thúy Yên Môn",1,0,0,0,0},
{9,5,1506,"Hộp quà Thiếu Lâm Phái",1,1,0,0,0},
{9,5,1507,"Hộp quà Võ Đang Phái",1,1,1,0,0},
{9,5,1508,"Hộp quà Diêm Bang",1,1,1,1,0},
{9,6,31,"Cầu Chỉ Thủy",0,1,1,1,1},
{10,1,36,"Đệ Tử Chấp Sự Cái Ban",0,0,0,0,0},
--{10,2,38,"Lục Trầm Châu",0,0,0,0},
{10,3,30,"Thạch Hiên Viên",0,0,0,0,0},
{11,2,30,"Thạch Hiên Viên",0,0,0,0,0},
{11,3,3542,"Thạch Hiên Viên",0,0,0,0,0},
------------------------------------------
{11,4,40,"Hàn Thác Trụ",0,0,0,0,0},
{11,5,40,"Hàn Thác Trụ",0,0,0,0,0},
{11,6,30,"Thạch Hiên Viên",0,0,0,0,0},
{12,1,41,"Lục Trầm Châu",0,0,0,0,0},
{12,3,41,"Lục Trầm Châu",0,0,0,0,0},
{12,4,30,"Thạch Hiên Viên",0,0,0,0,0},
{13,1,44,"Đệ Tử Chấp Pháp",0,0,0,0,0},
{13,2,46,"Thạch Hiên Viên",0,0,0,0,0},
{13,3,46,"Thạch Hiên Viên",0,0,0,0,0},
{13,5,46,"Thạch Hiên Viên",0,0,0,0,0},
{13,7,46,"Thạch Hiên Viên",0,1,1,1,0},
{14,1,31,"Cầu Chỉ Thủy",0,1,0,0,0},
{14,2,48,"Đệ Tử Thủ Sơn",1,1,0,0,0}, --NV 32
{15,1,50,"Củng Thiếu Trăn",0,0,0,0,0},
{15,2,52,"Lãnh Thu Vân",0,0,0,0,0},
{15,4,52,"Lãnh Thu Vân",0,0,0,0,0},
{16,4,52,"Lãnh Thu Vân",0,3,0,0,0},
{17,3,50,"Củng Thiếu Trăn",0,0,0,0,0},
--{18,2,61,"Thợ Săn",0,1,0,0,0},
--{18,3,62,"Thợ Săn",0,1,0,0,0},
{18,4,51,"La Phong",0,1,0,0,0},
{19,2,65,"Tướng Lĩnh Kim Quốc",0,0,0,0},
{19,3,51,"La Phong",0,0,0,0,0},
{19,4,52,"Lãnh Thu Vân",0,0,0,0,0},
{19,5,30,"Thạch Hiên Viên",0,0,0,0,0},
{20,1,69,"Thạch Hiên Viên",0,0,0,0,0},
{20,2,66,"La Phong",1,0,0,0,0},
{21,1,70,"Thái Lão Đầu",0,0,0,0,0},
{22,1,72,"Thần Toán Liễu Quỷ",0,1,0,0,0}, --NV 38
--{22,3,72,"Thần Toán Liễu Quỷ",1,1,0,0,0},
{22,2,72,"Thần Toán Liễu Quỷ",0,1,0,0,0},
{22,4,72,"Thần Toán Liễu Quỷ",0,1,0,0,0},
{22,5,72,"Thần Toán Liễu Quỷ",0,1,0,0,0},
{23,1,30,"Thạch Hiên Viên",0,0,0,0,0},
{24,2,30,"Thạch Hiên Viên",0,0,0,0,0},
{24,3,30,"Thạch Hiên Viên",0,0,0,0,0},
{24,4,75,"Người bắt rắn",0,0,0,0,0},
{25,1,75,"Người bắt rắn",0,1,0,0,0},
{25,2,76,"Cơ Chú",0,1,0,0,0},
{25,4,76,"Cơ Chú",0,1,0,0,0},
{26,2,81,"Ân Đồng",0,0,0,0,0},
{26,3,82,"Điệp Phiêu Phiêu",0,0,0,0,0},
{26,5,82,"Điệp Phiêu Phiêu",0,0,0,0,0},
{26,7,82,"Điệp Phiêu Phiêu",0,0,0,0,0},
{27,1,84,"Quan Vạn Sơn",0,0,0,0,0},
{27,5,84,"Quan Vạn Sơn",0,0,0,0,0}, --HET nv 42
{28,1,82,"Điệp Phiêu Phiêu",0,1,0,0,0},
{28,2,88,"Ân Đồng",0,1,0,0,0},
{28,7,88,"Ân Đồng",0,1,0,0,0}, --het NV 44
{29,2,89,"Đồng Tử",0,1,1,1,1},
{29,6,98,"Ân Đồng",0,1,1,1,1},
{30,1,82,"Điệp Phiêu Phiêu",0,0,0,0,0},
{30,3,99,"Ngư Tàng Phong",0,1,1,1,0},
{30,4,82,"Điệp Phiêu Phiêu",0,1,1,1,0},
{30,6,76,"Cơ Chú",0,1,1,1,0},
{30,7,82,"Điệp Phiêu Phiêu",0,1,1,1,0}, ---het NV 46
{31,1,88,"Ân Đồng",0,1,0,0,0},
{31,3,88,"Ân Đồng",0,1,0,0,0},
{32,1,99,"Ngư Tàng Phong",0,0,0,0,0},
{32,4,107,"Cơ Chú",0,12,1,0,0},
{32,5,99,"Ngư Tàng Phong",0,12,1,0,0},
{32,6,82,"Điệp Phiêu Phiêu",0,12,1,0,0},
{33,1,82,"Điệp Phiêu Phiêu",0,0,0,0,0},
{33,2,3524,"Cổ Yên Nhiên",0,0,0,0,0},
{33,3,3524,"Cổ Yên Nhiên",0,0,0,0,0},
{33,4,110,"Lan Tùng Lâm",0,0,0,0,0},
{33,6,89,"Đồng Tử",0,0,0,0,0},
{33,7,88,"Ân Đồng",0,0,0,0,0}, -- xong NV 47
{34,3,114,"Bùi Dực Phi",0,2,0,0,0},
{34,5,116,"Đệ Tử Hồng Kỳ",0,2,0,0,0},
{35,2,121,"La Phong",0,0,0,0,0},
{35,3,82,"Điệp Phiêu Phiêu",0,0,0,0,0},
{36,1,76,"Cơ Chú",0,0,0,0,0},
{36,2,122,"Cơ Chú",0,0,0,0,0},
{36,3,124,"Ân Đồng",0,0,0,0,0},
{36,5,122,"Cơ Chú",0,0,0,0,0}, ------den NV 48
{37,6,134,"La Phong",0,1,0,0,0},
{38,1,138,"Cổ Yên Nhiên",0,0,0,0,0},
{38,2,136,"Thạch Hiên Viên",0,0,0,0,0},
{38,3,139,"Thạch Hiên Viên",0,0,0,0,0},
{38,4,3570,"Bạch Thu Lâm",0,0,0,0,0},--het NV 50

---------------------------------------------------------------------------------------------------------------------------
{39,2,80,"Ân Phương",0,0,0,0,0},
{39,3,82,"Điệp Phiêu Phiêu",0,0,0,0,0},
{39,5,82,"Điệp Phiêu Phiêu",0,0,0,0,0},
{39,7,82,"Điệp Phiêu Phiêu",0,0,0,0,0},
{40,1,84,"Quan Vạn Sơn",0,0,0,0,0},
{40,5,84,"Quan Vạn Sơn",0,0,0,0,0}, --HET nv 42
{41,1,82,"Điệp Phiêu Phiêu",0,0,0,0,0},
{41,1,82,"Điệp Phiêu Phiêu",1,0,0,0,0},
{41,2,87,"Ân Phương",0,1,0,0,0},
{41,7,87,"Ân Phương",0,1,0,0,0}, --het NV 44
{42,2,89,"Đồng Tử",0,1,1,1,1},
{42,6,97,"Ân Phương",0,1,1,1,1},
{43,1,82,"Điệp Phiêu Phiêu",0,0,0,0,0},
{43,3,99,"Ngư Tàng Phong",0,1,1,1,0},
{43,4,82,"Điệp Phiêu Phiêu",0,1,1,1,0},
{43,6,76,"Cơ Chú",0,1,1,1,0},
{43,7,82,"Điệp Phiêu Phiêu",0,1,1,1,0}, ---het NV 46
{44,1,87,"Ân Phương",0,1,0,0,0},
{44,3,87,"Ân Phương",0,1,0,0,0},
{45,1,99,"Ngư Tàng Phong",0,0,0,0,0},
{45,4,107,"Cơ Chú",0,12,1,0,0},
{45,5,99,"Ngư Tàng Phong",0,12,1,0,0},
{45,6,82,"Điệp Phiêu Phiêu",0,12,1,0,0},
{46,1,82,"Điệp Phiêu Phiêu",0,0,0,0,0},
{46,2,3524,"Cổ Yên Nhiên",0,0,0,0,0},
{46,3,3524,"Cổ Yên Nhiên",0,0,0,0,0},
{46,4,110,"Lan Tùng Lâm",0,0,0,0,0},
{46,6,89,"Đồng Tử",0,0,0,0,0},
{46,7,87,"Ân Phương",0,0,0,0,0}, -- xong NV 47
{47,3,114,"Bùi Dực Phi",0,2,0,0,0},
{47,5,116,"Đệ Tử Hồng Kỳ",0,2,0,0,0},
{48,2,121,"La Phong",0,0,0,0,0},
{48,3,82,"Điệp Phiêu Phiêu",0,0,0,0,0},
{49,1,76,"Cơ Chú",0,0,0,0,0},
{49,2,122,"Cơ Chú",0,0,0,0,0},
--{49,3,124,"Ân Đồng",0,0,0,0,0},
{49,5,122,"Cơ Chú",0,0,0,0,0},
{50,6,134,"La Phong",0,1,0,0,0},
{51,1,138,"Cổ Yên Nhiên",0,0,0,0,0},
{51,2,136,"Thạch Hiên Viên",0,0,0,0,0},
{51,3,139,"Thạch Hiên Viên",0,0,0,0,0},
{51,4,3570,"Bạch Thu Lâm",0,0,0,0,0},--het NV 50
----------------------------------------------------------------------------------------------------
{10001,1,3571,"Long Ngũ Thái Gia",0,0,0,0,0},
--{10001,1,1800,"Kiếm Nô",0,0,0,0,0},
}

local TASK_SAY = {
--"[Nhiệm vụ] Chúng Ta Là Bạn",
"[Nhiệm vụ] Sồ Phượng Thanh Minh",
"[Nhiệm vụ] Nghĩa Quân",
"[Nhiệm vụ] Kỳ Môn Độn Giáp",
"[Nhiệm vụ] Sơ Thượng Sa Trường",
"[Nhiệm vụ] Bệnh Lạ",
"[Nhiệm vụ] Yêu Cầu Vô Lý",
"[Nhiệm vụ] Bất Kham Hồi Thủ",
"[Nhiệm vụ] Thập Nhị Môn Phái",
"[Nhiệm vụ] Tiểu Thí Ngưu Đao",
"[Nhiệm vụ] Cơ Quan Đại Sư",
"[Nhiệm vụ] Tầm Sư Học Nghệ",
"[Nhiệm vụ] Kỳ Trân Mê",
"[Nhiệm vụ] Người Mất Tích",
"[Nhiệm vụ] Chung Trừng Nguyên Hung",
"[Nhiệm vụ] Nhất Ngữ Thành Sấm",
"[Nhiệm vụ] Yên Vũ Giang Nam",
"[Nhiệm vụ] Anh Cô Trở Về",
"[Nhiệm vụ] Thông Địch Phản Bang",
"[Nhiệm vụ] Tín Sứ Thần Bí",
"[Nhiệm vụ] Sát Cơ Trùng Trùng",
"[Nhiệm vụ] Bằng Chứng Thép",
"[Nhiệm vụ] Vi Đảo Chi Khốn",
"[Nhiệm vụ] Tứ Diện Sở Ca",
"[Nhiệm vụ] Tấm Lòng Trung Nghĩa",
"[Nhiệm vụ] Tế Lễ",
"[Nhiệm vụ] Biến Loạn Chi Cục",
"[Nhiệm vụ] Ý Ngoại Trùng Phùng",
"[Nhiệm vụ] Cao Hạ Lập Phán",
"[Nhiệm vụ] Đông Sơn Tái Khởi",
"[Nhiệm vụ] Bạch Sơn Thạch Trường",
"[Nhiệm vụ] Hộ tống Lâm Đông Sơn",
"[Nhiệm vụ] Mãnh Hổ Hạng",
"[Nhiệm vụ] Bí Mật Ảnh Xã",
"[Nhiệm vụ] Ảnh Giả Bỏ Trốn",
"[Nhiệm vụ] Thợ Săn Kỳ Lạ",
"[Nhiệm vụ] Võ Sĩ Kim Quốc",
"[Nhiệm vụ] Kinh Thiên Chi Biến",
"[Nhiệm vụ] Hãn Huyết Bảo Mã",
"[Nhiệm vụ] Quẻ Quỷ Thần",
"[Nhiệm vụ] Di Hận",
"[Nhiệm vụ] Tế Kỳ",
"[Nhiệm vụ] Mật Lâm Thâm Xứ",
"[Nhiệm vụ] Hồng kỳ Kỳ chủ",
"[Nhiệm vụ] Di Nhân Phục Kích",
"[Nhiệm vụ] Xà Huyệt Hung Hiểm",
"[Nhiệm vụ] Bí Mật Bảo Đồ",
"[Nhiệm vụ] Ám Độ Trần Thương",
"[Nhiệm vụ] Tuyệt Bích Kỳ Hoa",
"[Nhiệm vụ] Ly Kỳ Thủ Thư",
"[Nhiệm vụ] Thiềm Cung Hội",
"[Nhiệm vụ] Tái Kiến Thiên Vương",
"[Nhiệm vụ] Khổ Chiến",
"[Nhiệm vụ] Vấn Tâm Nhất Kiếm",
"[Nhiệm vụ] Sinh Tử Quyết Chiến",
"[Nhiệm vụ] Vô Phương Hướng",
"Dương Trang đánh bại ta,lại đây!",
------------------------------------------
"[Nhiệm vụ] Nhiệm vụ Thiếu Lâm (cấp 20)",
"[Nhiệm vụ] Nhiệm vụ Thiếu Lâm (cấp 30)",
"[Nhiệm vụ] Nhiệm vụ Thiếu Lâm (cấp 40)",
"[Nhiệm vụ] Nhiệm vụ Thiên Vương (cấp 20)",
"[Nhiệm vụ] Nhiệm vụ Thiên Vương (cấp 30)",
"[Nhiệm vụ] Nhiệm vụ Thiên Vương (cấp 40)",
"[Nhiệm vụ] Nhiệm vụ Đường Môn (cấp 20)",
"[Nhiệm vụ] Nhiệm vụ Đường Môn (cấp 30)",
"[Nhiệm vụ] Nhiệm vụ Đường Môn (cấp 40)",
"[Nhiệm vụ] Nhiệm vụ Ngũ Độc (cấp 20)",
"[Nhiệm vụ] Nhiệm vụ Ngũ Độc (cấp 30)",
"[Nhiệm vụ] Nhiệm vụ Ngũ Độc (cấp 40)",
"[Nhiệm vụ] Nhiệm vụ Minh Giáo (cấp 30)",
"[Nhiệm vụ] Nhiệm vụ Minh Giáo (cấp 40)",
"[Nhiệm vụ] Nhiệm vụ Cái Bang (cấp 30)",
"[Nhiệm vụ] Nhiệm vụ Cái Bang (cấp 40)",
"[Nhiệm vụ] Nhiệm vụ Đoàn Thị (cấp 30)",
"[Nhiệm vụ] Nhiệm vụ Đoàn Thị (cấp 40)",

---------------------tren 50-----------------------------
"[Nhiệm vụ] Chuyện Cũ Thần Châu",
----------------------------------------------------------
"Bắt đầu trả lời",
"Có nhiệm vụ có thể nhận",
"Phím Tab",
"Giao diện 'Nhân vật'",
"Giao diện 'Túi'",
"Giao diện 'Kỹ năng'",
"Giao diện 'Kỹ năng sống'",
"Giao diện 'Nhiệm vụ'",
"Giao diện 'Quan hệ'",
"Giao diện 'Tổ đội'",
"Giao diện 'Bang hội gia tộc'",
"Giao diện 'Hệ thống'",
"Meo meo",
"Có thể mua phòng cụ, sửa trang bị",
"Đẹp",
"Có thể mua trang sức, sửa trang bị",
"Tinh lực dùng để chế tạo các loại đạo cụ trong kỹ năng sống",
"Hoạt lực dùng để gia công các loại đạo cụ trong kỹ năng sống",
"Thông qua làm nhiệm vụ thế giới, nhiệm vụ chính tuyến",

}
local TASK_FIGHT = {
------------------------NV phai 20------------
{581,2,46,1732,3572,"Phạm Giới Tăng Nhân",60,0,0,0},
{581,2,46,1688,3609,"Phạm Giới Đầu Đà",60,60,0,0},
{576,2,50,1749,3164,"Cường Đạo",0,0,30,0},
{576,2,50,1695,3357,"Trú Thủ Thương Sĩ",30,0,30,0},
{576,2,50,1678,3496,"Trú Thủ Cung Binh",30,30,30,0},
{576,2,50,1788,3580,"Ẩn Sĩ Sơn Lâm",30,30,30,30},
{584,2,53,1799,3228,"Hắc Long",30,0,0,0},
{584,2,53,1782,3380,"Độc Xà",30,30,0,0},
{584,2,53,1724,3367,"Bạch Linh",30,30,0,30},
{584,2,53,1710,3624,"Đằng Lực Sĩ",30,30,30,30},
-------------------40 TV--------------------------------
{610,2,75,1826,3731,"Khoái Đao Khách",30,0,0,0},
{610,2,75,1795,3609,"Tà Ác Bảng Phi",0,0,0,30},
{610,2,75,1676,3522,"Khoái Kiếm Khách",0,30,0,0},
{610,2,75,1878,3272,"Phỉ Đồ Bang Hung",0,0,30,0},
--------------------40 CB------------------------------
{611,2,70,1654,2849,"Nam Ảnh",0,30,0,0},
{611,2,70,1647,3086,"Nữ Ảnh",30,0,0,0},
{611,2,70,1360,3046,"Khinh Nõ Thủ",0,0,30,0},
{611,2,70,1302,3002,"Trọng Giáp Binh",0,0,0,30},
----------------------40 TL----------------------------------
{615,2,68,1695,3248,"Huyệt Cư Nữ Dã Nhân",30,0,0,0},
{615,2,68,1702,3064,"Huyệt Cư Tiểu Dã Nhân",0,0,60,0},
{615,2,68,1755,2950,"Huyệt Cư Nam Dã Nhân",0,30,0,0},
-----------------------------------------------------------
{603,2,56,1950,3273,"Cơ Quan Mộc Nhân",0,30,0,0},
{603,2,56,1760,3520,"Đồng Giác Thú",0,30,30,0},
{603,2,56,1740,3615,"Cơ Quan Đồng Nhân",0,30,30,30},
{603,2,56,1802,3690,"Cơ Quan Lang",30,30,30,30},
---------------------------------------------------------nhiem vu phai 30
{309,3,30,1758,3861,"Hươu Thuần Dưỡng"}, 
{317,1,30,1682,3600,"Khỉ Hoang Con"},
{318,1,30,1838,3693,"Hổ Vàng"},
{319,1,30,1757,3968,"Gấu Con"},
{311,2,38,1592,3442,"Nghĩa Quân Phản Đồ"},
{311,3,38,1592,3442,"Nghĩa Quân Phản Đồ"},
{311,4,38,1728,3166,"Cường Tặc"},
{320,1,38,1820,3392,"Cơ Quan Nhân Thô"}, --danh lay 10 vat pham
{320,2,38,1752,3531,"Tiểu Cơ Quan Thú"}, --danh lay 10 vat pham
{321,2,38,1955,3643,"Võ Sĩ Tây Hạ"},-- \vinh lac
{322,1,38,1940,3784,"Võ Sĩ Kim Quốc"},
{323,2,38,1854,3590,"Võ Sĩ Nam Tống"},
{323,4,38,1909,3551,"Võ Sĩ Mông Cổ"},-------het nv 20
{1,4,401,1569,3247,"Tần Công Xích",1,0,0,0},
{1,4,401,1591,3225,"Lê Việt",1,1,0,0},
{1,4,401,1612,3207,"Lưu Mặc",1,1,1,0},
{1,5,402,1612,3235,"Dương Thiết Tâm",0,1,1,1},
{3,2,55,1805,3728,"Lãnh Huyết Sát Thủ",0,1,0,0},
{3,2,55,1805,3728,"Sát Thủ Thần Bí",15,1,0,0},
{4,3,55,1900,3556,"Lãnh Nguyệt Sứ",1,0,0,0},
{4,3,55,1889,3626,"Viêm Dương Sứ",1,1,0,0},
{5,1,55,1812,3652,"Sát Thủ Thần Bí"},
{6,1,55,1726,3547,"Tổng Quản Đại Nội",1,0,0,0},
{7,1,55,1635,3444,"Thương Nhân Thần Bí"},
{7,5,55,1951,3319,"Sát Thủ Diêm Bang",20,0,0,0},
{7,5,55,1951,3319,"Trưởng Lão Diêm Bang",20,1,0,0},
{8,2,55,1575,3341,"Tống Đao Binh"},
{8,3,55,1555,3362,"Tống Thống Lĩnh Lưu Khoá"},
{10,2,60,1572,2875,"Lục Trầm Châu"},
{12,2,60,1563,3031,"Tô Hữu Tưởng"},
{12,5,60,1434,3080,"Túy Hán"},
{13,4,405,1638,3155,"Thôi Xuất Trần"},
{15,3,407,1579,3225,"Mãnh Hổ"},
{16,1,60,1385,2878,"Cơ Quan Thú"},
{16,2,60,1353,2886,"Bạch Hổ",0,9,0,0},
{16,2,60,1353,2888,"Bạch Hổ Vương",0,9,1,0},
{16,3,60,1393,2839,"Đái Kiếm Dị Giả",9,0,0,0},
{17,2,407,1579,3225,"Mãnh Hổ"},
{18,1,60,1418,2813,"Gấu Đen",1,0,0,0},
{18,1,60,1414,2772,"Sài Cẩu",1,1,0,0},
{18,3,60,1357,2738,"Thợ Săn",0,1,0,0},
{19,1,409,1596,3393,"Sĩ Binh Kim Quốc"},
{19,2,409,1597,3375,"Tướng Lĩnh Kim Quốc"},
{21,2,60,1316,2794,"Hãn Huyết Bảo Mã"},
{22,3,60,1404,3269,"Hươu",1,1,1,0},
{22,3,60,1404,3269,"Sói Vàng",1,1,0,0},
{23,2,406,1631,3097,"Sĩ Binh Kim Quốc"},
{25,3,425,1630,3159,"Mộc Nhất Lâu"},
{25,3,425,1569,3163,"Mộc Dung Thanh"},
{26,1,74,1862,3637,"Di Nhân Đao Khách"},
{26,4,74,1852,3273,"Võ Lâm Cao Thủ"},
{27,2,74,1713,3504,"Võ Sĩ Di Nhân"},
{27,4,74,1636,3544,"Thủ Lĩnh Di Nhân"},
{28,5,412,1631,3089,"Xích Luyện Xà Vương"},
{29,4,414,1695,3239,"Người Nuôi Ong"},
{29,5,415,1695,3239,"Kim Tiền Báo"},
{30,5,74,1890,3588,"Thám Tử Trường Ca Môn"},
{32,2,413,1717,3675,"Thủ Lĩnh Bạch Kỳ",0,0,1,0},
{32,2,413,1717,3675,"Đệ Tử Ngũ Độc",0,12,1,0},
{32,2,413,1703,3720,"Đăng Sát Khẩu Tiêu Binh",9,12,1,1},
{32,3,413,1715,3657,"Xe chuyển thư",9,12,1,1},
{34,2,74,1615,3331,"Tướng Lĩnh Thiên Vương",0,2,0,0},
{34,2,74,1615,3331,"Võ Sĩ Thiên Vương",1,2,1,0},
{34,4,426,1609,3243,"Bùi Dực Phi",0,2,1,0},
{35,1,74,1676,3302,"Võ Sĩ Cái Bang"},
{36,4,418,1638,3184,"Ân Đồng"},
{37,2,74,1741,3395,"Lan Tùng Lâm",1,0,0,0},
{37,2,74,1707,3390,"Ngư Tàng Phong",1,1,0,0},
{37,3,74,1724,3339,"Điệp Phiêu Phiêu",0,1,1,0},
{37,5,74,1749,3288,"Đệ Tử Hoàng Kỳ",9,0,0,0},
{37,5,74,1749,3288,"Hồ Hiến Cơ"},
-----------------
{39,1,74,1862,3637,"Di Nhân Đao Khách"},
{39,4,74,1852,3273,"Võ Lâm Cao Thủ"},
{40,2,74,1713,3504,"Võ Sĩ Di Nhân"},
{40,4,74,1636,3544,"Thủ Lĩnh Di Nhân"},
{41,5,412,1631,3089,"Xích Luyện Xà Vương"},
{42,4,414,1695,3239,"Người Nuôi Ong"},
{42,5,415,1695,3239,"Kim Tiền Báo"},
{43,5,74,1890,3588,"Thám Tử Trường Ca Môn"},
{45,2,413,1717,3675,"Thủ Lĩnh Bạch Kỳ",0,0,1,0},
{45,2,413,1717,3675,"Đệ Tử Ngũ Độc",0,12,1,0},
{45,2,413,1703,3720,"Đăng Sát Khẩu Tiêu Binh",9,12,1,1},
{45,3,413,1715,3657,"Xe chuyển thư",9,12,1,1},
{47,2,74,1615,3331,"Tướng Lĩnh Thiên Vương",0,2,0,0},
{47,2,74,1615,3331,"Võ Sĩ Thiên Vương",6,0,0,0},
{47,4,427,1609,3243,"Bùi Dực Phi",0,2,1,0},
{48,1,74,1676,3302,"Võ Sĩ Cái Bang"},
{49,4,419,1638,3184,"Ân Phương"},
{50,2,74,1737,3387,"Lan Tùng Lâm",1,0,0,0},
{50,2,74,1707,3390,"Ngư Tàng Phong",1,1,0,0},
{50,3,74,1724,3339,"Điệp Phiêu Phiêu",0,1,1,0},
{50,5,74,1749,3288,"Đệ Tử Hoàng Kỳ",9,0,0,0},
{50,5,74,1749,3288,"Hồ Hiến Cơ"},
}

local TASK_USE_ITEM = {
{307,6,20,1,406,1,1,1406,3096}, -- phao bong cua bat dong tien sinh ^^
{6,1,20,1,219,1,55,1718,3575},
{6,1,20,1,220,1,55,1687,3573},
{6,1,20,1,221,1,55,1591,3557},
{7,3,20,1,223,1,0,0,0},
{13,6,20,1,446,1,405,1671,3167},
{13,6,20,1,206,1,405,1624,3215},
{13,6,20,1,207,1,405,1575,3167},
{13,6,20,1,208,1,405,1624,3118},
{24,1,20,1,153,1,60,1451,2989},
{26,6,20,1,155,1,74,1804,3297},
{39,6,20,1,155,1,74,1804,3297},
{37,1,20,1,145,1,74,1735,3425},
{50,1,20,1,145,1,74,1735,3425},
}

local ITEM_GIFT = {
{2,3,20,1,132,1,13,"Cầu Chỉ Thủy",0,0,0},
{2,6,20,1,133,1,4,"Dương Thiết Tâm",0,0,0},
{3,4,20,1,134,1,4,"Dương Thiết Tâm",0,1,0},
{5,2,20,1,135,1,4,"Dương Thiết Tâm",0,0,0},--het nv 27
{7,2,20,1,222,1,1166,"Hùng Đỉnh",0,0,0},
{7,4,20,1,224,1,1166,"Hùng Đỉnh",0,1,0},
{7,6,20,1,122,1,4,"Dương Thiết Tâm",0,0,0},
{11,2,20,1,143,1,30,"Thạch Hiên Viên",0,0,0,0,0},
{12,6,20,1,144,1,30,"Thạch Hiên Viên",0,0,0,0,0},
{21,3,20,1,205,1,30,"Thạch Hiên Viên",0,0,0,0,0},
{23,3,20,1,153,1,30,"Thạch Hiên Viên",0,0,0,0,0},
{28,4,20,1,156,1,89,"Đồng Tử",0,1,0,0,0},
{41,4,20,1,156,1,89,"Đồng Tử",0,1,0,0,0},

--{25,4,20,1,154,1,76,"Cơ Chú",0,1,0,0,0},
}
local tbHO_TONG = {
{4,1,55,1924,3191,"Hàn Thác Trụ",0,0,0},
{4,5,55,1870,3610,"Hàn Thác Trụ",0,1,0},
{14,2,60,1476,2967,"Lâm Đông Sơn",0,1,0},
{20,2,60,1492,3151,"Hàn Thác Trụ",0,0,0},
{28,6,412,1638,3072,"Ân Đồng",0,1,0},
{33,5,74,1627,3498,"Xe Dược Thảo",0,0,0},
{41,6,412,1638,3072,"Ân Phương",0,1,0},
{46,5,74,1632,3505,"Xe Dược Thảo",0,0,0},
}

local TASK_CHETAO = {
{312,2,22,1,22,1},
{312,3,1,1,7,1},
{312,5,22,1,30,1},
{312,6,1,7,3,1},
{312,8,22,1,28,1},
{312,9,1,6,2,1},
{312,11,22,1,26,1},
{312,12,18,1,54,1},
{312,14,22,1,24,1},
{312,15,18,1,55,1},

}
local tbTHUTHAP = {
{16,3,60,1368,2844,"Mảnh Phượng Nhãn Châu",9,0,0,0,0},
{16,3,60,1368,2844,"Mảnh Phượng Nhãn Châu",9,1,0,0,0},
{16,3,60,1368,2844,"Mảnh Phượng Nhãn Châu",9,2,0,0,0},
{28,3,74,1758,3662,"Chu hồng quả",9,1,0,0,0},
{29,1,74,1810,3272,"Liên Chu Thảo",0,0,0,0,1},
{29,1,74,1900,3322,"Liên Chu Thảo",0,1,0,0,1},
{29,1,74,1873,3681,"Liên Chu Thảo",0,1,0,1,1},
{29,1,74,1656,3716,"Liên Chu Thảo",0,1,1,1,1},
{30,2,74,1700,3681,"Rương thư ải phía tây",0,0,0,0,0},
{30,2,74,1736,3692,"Rương thư ải trung tâm",1,0,0,0,0},
{30,2,74,1791,3670,"Rương thư ải phía đông",1,1,0,0,0},
{30,2,74,1751,3712,"Rương Thư Đăng Sát Khẩu",1,1,1,0,0},
{31,2,74,1860,3627,"Hoa Lục Thiểm Nhi",9,1,0,0,0},
--------------------------------------------
{41,3,74,1820,3436,"Chu hồng quả",9,1,0,0,0},
{42,1,74,1810,3272,"Liên Chu Thảo",0,0,0,0,1},
{42,1,74,1900,3322,"Liên Chu Thảo",0,1,0,0,1},
{42,1,74,1873,3681,"Liên Chu Thảo",0,1,0,1,1},
{42,1,74,1656,3716,"Liên Chu Thảo",0,1,1,1,1},
{43,2,74,1700,3681,"Rương thư ải phía tây",0,0,0,0,0},
{43,2,74,1736,3692,"Rương thư ải trung tâm",1,0,0,0,0},
{43,2,74,1791,3670,"Rương thư ải phía đông",1,1,0,0,0},
{43,2,74,1751,3712,"Rương Thư Đăng Sát Khẩu",1,1,1,0,0},
{44,2,74,1859,3505,"Hoa Lục Thiểm Nhi",9,1,0,0,0},
}

local tbTHUONG = {
{7,4,"Dương Thiết Tâm"},
{13,46,"Thạch Hiên Viên"},
}


NhiemVuChinhTuyen.MonPhaiGiaNhap = 0
NhiemVuChinhTuyen.tbMonPhai = {
{"Đao Thiếu",21,22,3512},
{"Côn Thiếu",29,30,3512},
{"Thương Thiên",38,40,3506},
{"Chùy Thiên",50,52,3506},
{"Hãm Tĩnh",69,70,3518},
{"Tụ Tiễn",59,60,3518},
{"Đao Độc",76,77,3524},
{"Chưởng Độc",86,87,3524},
{"Chưởng Nga",96,97,3530},
{"Phụ Trợ",107,106,3530},
{"Kiếm Thúy",111,112,3536},
{"Đao Thúy",120,121,3536},
{"Chưởng Cái",128,129,3542},
{"Côn Cái",137,138,3542},
{"Chiến Nhẫn",143,144,3548},
{"Ma Nhẫn",151,152,3548},
{"Khí Võ",159,160,3554},
{"Kiếm Võ",167,168,3554},
{"Đao Côn",175,176,3560},
{"Kiếm Côn",188,189,3560},
{"Chùy Minh",194,196,3479},
{"Kiếm Minh",205,206,3479},
{"Chỉ Đoàn",213,215,3500},
{"Kiếm Đoàn",226,227,3500},
}
local uiSayPanel	= Ui(Ui.UI_SAYPANEL);
NhiemVuChinhTuyen.Say_bak = NhiemVuChinhTuyen.Say_bak or uiSayPanel.OnOpen;

function NhiemVuChinhTuyen.OnOpen()
	ClearComboBoxItem("UI_NVCT","ChonPhai");
	for i = 1,12 do
		ComboBoxAddItem("UI_NVCT","ChonPhai",i,Player:GetFactionRouteName(i))
	end
end

local tbTL = {0,0,3,2,3,2,0,1,2,0,1}
local nTL = 1
function uiSayPanel:OnOpen(tbParam)
	NhiemVuChinhTuyen.Say_bak(uiSayPanel,tbParam);
	if NhiemVuChinhTuyen.state == 1 then
		if  me.GetTask(1001,2) == 306 and me.GetTask(1001,3) == 5 then
			--me.Msg("Trả lời câu hỏi")
			if nTL <= 11 then
				me.AnswerQestion(tbTL[nTL])
				nTL = nTL + 1
			else
				nTL = 1
			end
			return
		end
		nTL = 1
		for i = 1,table.getn(tbParam[2]) do
			for k = 1,table.getn(TASK_SAY) do
				if string.find(tbParam[2][i],"Nhận thưởng") then
					me.AnswerQestion(i-1)
					return
				end
				if tbParam[2][i] == TASK_SAY[k] then
					me.AnswerQestion(i-1)
					for l = 0,10 do
						local Task2 = me.GetTask(1001+l,2)
						local Task3 = me.GetTask(1001+l,3)
						if Task2 == 314 and Task3 == 1 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 10001 and Task3 == 1 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 46 and Task3 == 1 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 46 and Task3 == 3 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 1 and Task3 == 1 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 1 and Task3 == 2 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 2 and Task3 == 1 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 1 and Task3 == 3 and tbParam[2][i] == "Ta muốn đến chiến thuyền" then
							me.AnswerQestion(0)
							break
						elseif Task2 == 8 and Task3 == 4 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 9 and Task3 == 1 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 11 and Task3 == 5 then
							me.AnswerQestion(0)	
							break
						elseif Task2 == 24 and Task3 == 3 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 25 and Task3 == 1 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 37 and Task3 == 5 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 51 and Task3 == 2 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 38 and Task3 == 2 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 33 and (Task3 == 1 or Task3 == 3 )then
							me.AnswerQestion(0)
							break
						elseif Task2 == 603 and Task3 == 1 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 609 and Task3 == 1 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 611 and Task3 == 1 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 581 and Task3 == 1 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 584 and Task3 == 1 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 576 and Task3 == 1 then
							me.AnswerQestion(0)
							break
						elseif Task2 == 615 and Task3 == 1 then
							me.AnswerQestion(0)
							break
						end
					end
				end
			end
		end
	end
end
function NhiemVuChinhTuyen.USE_ITEM(a,b,c,d)
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 0 then
		local tbItemList = me.FindItemInBags(a,b,c,d);
		if((not tbItemList) or (#tbItemList == 0)) then
			local tbItemList = me.FindItemInBags(a,b,c,d);
			if((not tbItemList) or (#tbItemList == 0)) then
				return false;
			end
		end
	--	me.Msg(tostring("co vat pham"))
		local pItem = tbItemList[1].pItem;
		if(me.CanUseItem(pItem)) then
			me.UseItem(pItem);
		end
	end
end

function NhiemVuChinhTuyen.State()
	if NhiemVuChinhTuyen.state == 0 then
		NhiemVuChinhTuyen.state = 1
		timer = Ui.tbLogic.tbTimer:Register(18,NhiemVuChinhTuyen.Start);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Bật chức năng làm nhiệm vụ chính tuyến [Shift+T]");
		if NhiemVuChinhTuyen.ChonPhai == 0 and me.nFaction <= 0 then
			me.Msg("<color=yellow>Bạn chưa chọn môn phái gia nhập, nếu làm đến nhiệm vụ nhập phái sẽ không thực hiện được.Ấn 'F10' vào hệ thống để thiết lập ")
		end
	else
		NhiemVuChinhTuyen.state = 0
		Ui.tbLogic.tbTimer:Close(timer);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt chức năng làm nhiệm vụ chính tuyến [Shift+T]");
		timer = 0
		if me.nAutoFightState == 1 then
			me.AutoFight(0)
		end
	end
end

function NhiemVuChinhTuyen.Start()
	
	-------------------------------------
	if me.nAutoFightState == 0 then
		local tbFind = me.FindClassItemInBags("equip");
		local nSize = Lib:CountTB(tbFind); -- 背包内装备数量
		if (nSize == 0) and (nAutoClose == 1) then
			--print("Không có thiết bị có thể được loại bỏ rác!");
		else
			for index, tbItem in ipairs(tbFind) do
				if tbItem and tbItem.pItem.IsBind() ~= 1 then
					local pItem = tbItem.pItem;	
					local nPrice = GetSalePrice(pItem);
					local nMaxLevel = AutoAi:GetMaxBreakUpStuff(pItem);
					local nNeededMagic = AutoAi:GetNeededMagicStatus(pItem);
					local nNeededDarkMagic = AutoAi:GetNeededDarkMagicStatus(pItem);
					if nPrice == 0 and nNeededMagic == 0 and nNeededDarkMagic == 0 and nMaxLevel < 9 then
						me.Msg(tostring("Vứt bỏ <color=green>"..pItem.szName..""))
						me.ThrowAway(tbItem.nRoom, tbItem.nX, tbItem.nY);
					end
				end
			end
		end
	end
	-----------------------------------------
	if me.GetItemCountInBags(18,1,71,1) > 0 then
		local tbFind = me.FindItemInBags(18,1,71,1);
		for _, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
	end
	if me.GetItemCountInBags(18,1,71,2) > 0 then
		local tbFind = me.FindItemInBags(18,1,71,2);
		for _, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
	end
	-----------------------------------------
	local nMyMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos()
	if me.IsDead() == 1 then
		me.SendClientCmdRevive(0)
		return
	end
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	------------------------------------tu cong diem skill---------
	
	if me.nFaction ~= 0 and me.nRemainFightSkillPoint > 0 then --KFightSkill.GetSkillInfo(me.nLeftSkill,1).nthen
		if me.nRouteId ~= 0 and me.nLevel-10 >= me.GetFightSkillList(1)[1].nLevel and me.GetFightSkillList(1)[1].nLevel < me.GetFightSkillList(1)[1].nMaxLevel then
			me.LevelUpFightSkill(me.nRouteId,me.GetFightSkillList(1)[1].uId,1);
			me.Msg("Tự tăng max điểm kĩ năng cho skill cấp 10")
		elseif me.nRouteId == 0 and NhiemVuChinhTuyen.MonPhaiGiaNhap ~= 0 then
			me.Msg("Tự xác định hướng tu luyện")
			if math.mod(NhiemVuChinhTuyen.MonPhaiGiaNhap,2) == 1 then
				me.LevelUpFightSkill(1,NhiemVuChinhTuyen.tbMonPhai[NhiemVuChinhTuyen.MonPhaiGiaNhap][2],1);
			elseif math.mod(NhiemVuChinhTuyen.MonPhaiGiaNhap,2) == 0 then
				me.LevelUpFightSkill(2,NhiemVuChinhTuyen.tbMonPhai[NhiemVuChinhTuyen.MonPhaiGiaNhap][2],1);
			end
		elseif me.nRouteId == 0 and NhiemVuChinhTuyen.MonPhaiGiaNhap == 0 then
			--me.Msg("Bạn có thể tăng skill nhưng chưa chọn môn phái sẽ gia nhập, vui lòng ấn <color=yellow>F10 -> Hệ Thống<color>để chọn.")
		end
	end
	--------------------------------
	if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
		local uiGutAward = Ui(Ui.UI_GUTAWARD)
		uiGutAward.OnButtonClick(uiGutAward,"ObjOptional1")
		uiGutAward.OnButtonClick(uiGutAward, "zBtnAccept");
		UiManager:CloseWindow(Ui.UI_GUTAWARD)
		return
	end

	if not NhiemVuChinhTuyen.TimNPC_TEN() then
		if me.nAutoFightState == 1 then
			me.AutoFight(0)
		end
	end
	--if me.nAutoFightState == 1 then
	--	for Space=0,1000 do
	--		AutoAi.PickAroundItem(Space);
	--	end
	--end
	if me.CanCastSkill(66) and me.nLeftSkill ~= 66 then
		me.nLeftSkill = 66
	end
	if nMyMapId == 38 and NhiemVuChinhTuyen.KhoangCach(nCurWorldPosX,nCurWorldPosY,1832,3558) <= 2 then
		me.StartAutoPath(1832,3577)
		return
	end
	
	for k = 0,10 do
		if me.GetTask(1001+k,2) == 29 and me.GetTask(1001+k,3) == 1 then
			if nMyMapId == 74 and NhiemVuChinhTuyen.KhoangCach(nCurWorldPosX,nCurWorldPosY,1798,3402) <= 2 then
				me.StartAutoPath(1800,3424)
				return
			end
		end
	end
	
	--local str = ""
	--for i = 0,10 do
	--	if me.GetTask(1001,i) ~= 0 then
			--str = str..tostring("<color=yellow>"..i.."<color> = <color=yellow>"..me.GetTask(1001,i).."<color>;	")
			--me.Msg(tostring("[<color=yellow>"..i.."<color>] = <color=yellow>"..me.GetTask(1001,i)))
	--	end
	--end
	--me.Msg(str)
	for k = 0,10 do
		local npc = NhiemVuChinhTuyen.TimNPC_TEN("Cao Thăng")
		if npc and me.nLevel == 20 and me.GetTask(1001+k,2) == 0 and nMyMapId == 38 then
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 0 then
				AutoAi.SetTargetIndex(npc.nIndex)
				break
			end
		end
		local npc = NhiemVuChinhTuyen.TimNPC_TEN("Quý Thúc Ban")
		if npc and me.nLevel == 20 and me.GetTask(1001+k,2) == 0 and nMyMapId == 22 then
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 0 then
				AutoAi.SetTargetIndex(npc.nIndex)
				break
			end
		end
	end
	for i = 1,table.getn(tbTHUONG) do
		for k = 0,10 do
			if me.GetTask(1001+k,2) == tbTHUONG[i][1] and me.GetTask(1001+k,3) == -1 then
				me.Msg("Nhận thưởng")
				local npc = NhiemVuChinhTuyen.TimNPC_TEN(tbTHUONG[i][3])
				if npc and npc.nTemplateId == tbTHUONG[i][2] then
					if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 0 then
						AutoAi.SetTargetIndex(npc.nIndex)
					end
				else
					NhiemVuChinhTuyen.DiDenNpc(tbTHUONG[i][2])
				end
			end
		end
	end


	---------------------------------truong hop dac biet-----------------------------------------
		for k = 0,10 do
			if me.GetTask(1001+k,2) == 25 and me.GetTask(1001+k,3) == 3 then
				local npcname = "Mộc Nhất Lâu"
				if nMyMapId ~= 425 then
					NhiemVuChinhTuyen.GoTo(425,100,100)
				else
					if me.GetItemCountInBags(20,1,154,1) > 0 then -- da danh moc nhat lau
						npcname = "Mộc Dung Thanh"
					end
					local Npc_Task_Fight = NhiemVuChinhTuyen.TimNPC_TEN(npcname)
					if Npc_Task_Fight then
						AutoAi.SetTargetIndex(Npc_Task_Fight.nIndex)
						if me.nAutoFightState == 0 then
							me.AutoFight(1)
						end
						local tbSkillInfo = KFightSkill.GetSkillInfo(me.nLeftSkill,1);
						if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then
							Switch("horse")
						end
					else
						if me.nAutoFightState == 1 then
							me.AutoFight(0)
						end
						if npcname == "Mộc Nhất Lâu" then
							me.StartAutoPath(1630,3159)
						else
							me.StartAutoPath(1569,3163)
						end
					end
				end
				return
			elseif me.GetTask(1001,2) == 10001 and me.GetTask(1001,3) == 1 then
				if nMyMapId == 477 then
					local kiemno = NhiemVuChinhTuyen.TimNPC_TEN("Kiếm Nô")
					if kiemno then
						if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 0 then
							AutoAi.SetTargetIndex(kiemno.nIndex)
						end
					else
						me.StartAutoPath(1665,3039)
					end
					return
				end
			elseif (me.GetTask(1001+k,2) == 26 or me.GetTask(1001+k,2) == 39) and me.GetTask(1001+k,3) == 7 then
				if nMyMapId == 74 and NhiemVuChinhTuyen.KhoangCach(nCurWorldPosX,nCurWorldPosY,1797,3402) <= 3 then
					me.StartAutoPath(1797,3417)
					return
				end
			elseif (me.GetTask(1001+k,2) == 27 or me.GetTask(1001+k,2) == 40) and me.GetTask(1001+k,3) == 3 then -- chay den Tam tien nham
				if me.nAutoFightState == 1 then
					me.AutoFight(0)
				end
				if nMyMapId ~= 74 then
					NhiemVuChinhTuyen.GoTo(74,100,100)
				else
					me.StartAutoPath(1636,3544)
				end
				return
			elseif me.GetTask(1001+k,2) == 47 and me.GetTask(1001+k,3) == 1 then
				if me.nAutoFightState == 1 then
					me.AutoFight(0)
				end
				if nMyMapId ~= 74 then
					NhiemVuChinhTuyen.GoTo(74,100,100)
				else
					me.StartAutoPath(1647,3440)
				end
				return
			elseif me.GetTask(1001+k,2) == 36 and me.GetTask(1001+k,3) == 3 then
				--me.Msg("di den noi chi dinh")
				if me.nAutoFightState == 1 then
					me.AutoFight(0)
				end
				if nMyMapId ~= 418 then
					NhiemVuChinhTuyen.GoTo(418,100,100)
				else
					me.StartAutoPath(1638,3186)
				end
				return
			elseif me.GetTask(1001+k,2) == 49 and me.GetTask(1001+k,3) == 3 then
				--me.Msg("di den noi chi dinh")
				if me.nAutoFightState == 1 then
					me.AutoFight(0)
				end
				if nMyMapId ~= 419 then
					NhiemVuChinhTuyen.GoTo(419,100,100)
				else
					me.StartAutoPath(1638,3186)
				end
				return
			elseif (me.GetTask(1001+k,2) == 37 or me.GetTask(1001+k,2) == 50) and me.GetTask(1001+k,3) == 4 then
				if me.nAutoFightState == 1 then
					me.AutoFight(0)
				end
				if nMyMapId ~= 74 then
					NhiemVuChinhTuyen.GoTo(74,100,100)
				else
					me.StartAutoPath(1761,3319)
				end
				return
			elseif me.GetTask(1001+k,2) == 22 and me.GetTask(1001+k,3) == 3 and  me.GetTask(1001+k,5) == 1 and  me.GetTask(1001+k,6) == 1 then
				if nMyMapId ~= 60 then
					NhiemVuChinhTuyen.GoTo(60,100,100)
					return
				end
				local npcname = "Hươu"
				if me.GetItemCountInBags(20,1,152,1) >= 9 then
					npcname = "Sói Vàng"
				end
				local Npc_Task_Fight = NhiemVuChinhTuyen.TimNPC_TEN(npcname)
				if Npc_Task_Fight then
					AutoAi.SetTargetIndex(Npc_Task_Fight.nIndex)
					if me.nAutoFightState == 0 then
						me.AutoFight(1)
					end
					local tbSkillInfo = KFightSkill.GetSkillInfo(me.nLeftSkill,1);
					if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then
						Switch("horse")
					end
				else
					if me.nAutoFightState == 1 then
						me.AutoFight(0)
					end
					if npcname == "Hươu" then
						me.StartAutoPath(1401,3284)
					else
						me.StartAutoPath(1423,3272)
					end
				end
				NhiemVuChinhTuyen.DongCuaSo()
				return
			elseif me.GetTask(1001+k,2) == 18 and (me.GetTask(1001+k,3) == 2 or me.GetTask(1001+k,3) == 3) then

				if nMyMapId == 60 then
					me.StartAutoPath(1361,2744)
				else
					NhiemVuChinhTuyen.GoTo(60,1361*32,2744*32)
				end
				local thosan = NhiemVuChinhTuyen.GetAroundNpc(62)
				if thosan then
					if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 0 then
						AutoAi.SetTargetIndex(thosan.nIndex)
					end
				else
					thosan = NhiemVuChinhTuyen.GetAroundNpc(61)
					if thosan then
						if me.nAutoFightState == 0 then
							me.AutoFight(1)
						end
						local tbSkillInfo = KFightSkill.GetSkillInfo(me.nLeftSkill,1);
						if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then
							Switch("horse")
						end
						return
					end
					me.StartAutoPath(1361,2744)
				end
				
				return
			elseif me.GetTask(1001+k,2) == 314 and me.GetTask(1001+k,3) == 3 and nMyMapId == 55 then
				--me.Msg("Đi đến nơi chỉ định")
				local thuyenphu = NhiemVuChinhTuyen.GetAroundNpc(8)
				if thuyenphu then
					if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 0 then
						AutoAi.SetTargetIndex(thuyenphu.nIndex)
					end
				else
					NhiemVuChinhTuyen.GoTo(55,1608*32,3206*32)
				end
				return
			elseif me.GetTask(1001+k,2) == 10 and me.GetTask(1001+k,3) == 2 and nMyMapId == 60 then
				local luctramchau = NhiemVuChinhTuyen.GetAroundNpc(39)
				if luctramchau then
					if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 0 then
						AutoAi.SetTargetIndex(luctramchau.nIndex)
					end
					return
				end
				--return
			elseif (me.GetTask(1001+k,2) == 29 or me.GetTask(1001+k,2) == 42) and me.GetTask(1001+k,3) == 3 then
				--me.Msg("Đi đến nơi chỉ định")
				NhiemVuChinhTuyen.GoTo(414,100,100)
				return
			elseif me.GetTask(1001+k,2) == 34 and me.GetTask(1001+k,3) == 1 then
				--me.Msg("Đi đến nơi chỉ định")
				NhiemVuChinhTuyen.GoTo(74,1647*32,3440*32)
				me.StartAutoPath(1647,3440)
				return
			elseif me.GetTask(1001+k,2) == 1 and me.GetTask(1001+k,3) == 5 and me.GetTask(1001+k,6) == 1 and me.GetTask(1001+k,7) == 1 then
				local duongthiettamchienthuyen = NhiemVuChinhTuyen.TimNPC_TEN("Dương Thiết Tâm")
				if nMyMapId == 402 and duongthiettamchienthuyen then
					if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 0 and AutoAi.AiTargetCanAttack(duongthiettamchienthuyen.nIndex) == 0 then
						AutoAi.SetTargetIndex(duongthiettamchienthuyen.nIndex)
						if me.nAutoFightState == 1 then
							me.AutoFight(0)
						end
					end
				end
			end
		end

	-----------------------
	for i = 1,table.getn(TASK_FIGHT) do
		for k = 0,10 do
			if me.GetTask(1001+k,2) == TASK_FIGHT[i][1] and me.GetTask(1001+k,3) == TASK_FIGHT[i][2] then
				if not TASK_FIGHT[i][7] or (me.GetTask(1001+k,5) < TASK_FIGHT[i][7]) or (me.GetTask(1001+k,6) < TASK_FIGHT[i][8]) or (me.GetTask(1001+k,7) < TASK_FIGHT[i][9]) or (me.GetTask(1001+k,8) < TASK_FIGHT[i][10]) then
					--me.Msg("Đánh bại <color=yellow>"..TASK_FIGHT[i][6])
					if nMyMapId ~= TASK_FIGHT[i][3] then
						if me.GetNpc().IsRideHorse() == 0 then
							Switch([[horse]])
						end
						NhiemVuChinhTuyen.GoTo(TASK_FIGHT[i][3],TASK_FIGHT[i][4],TASK_FIGHT[i][5])
						NhiemVuChinhTuyen.DongCuaSo()
						return
					end
					if NhiemVuChinhTuyen.KhoangCach(nCurWorldPosX*32,nCurWorldPosY*32,TASK_FIGHT[i][4]*32,TASK_FIGHT[i][5]*32) < 1000 then
					-------------------------------------------------------------------------------------------------------
						local Npc_Task_Fight = NhiemVuChinhTuyen.TimNPC_TEN(TASK_FIGHT[i][6])
						if Npc_Task_Fight and NhiemVuChinhTuyen.KhoangCach(TASK_FIGHT[i][4]*32,TASK_FIGHT[i][5]*32,Npc_Task_Fight.GetMpsPos()) < 1000 then
							local ToaDoDanhX,ToaDoDanhY = Npc_Task_Fight.GetMpsPos()
							--AutoAi.SetTargetIndex(Npc_Task_Fight.nIndex)
							if Npc_Task_Fight.nKind == 3 then
								if me.nAutoFightState == 1 then
									me.AutoFight(0)
								end
								
								AutoAi.SetTargetIndex(Npc_Task_Fight.nIndex)
								return
							end
							
							if NhiemVuChinhTuyen.KhoangCach(nCurWorldPosX*32,nCurWorldPosY*32,Npc_Task_Fight.GetMpsPos()) >= 450 then
								if me.nAutoFightState == 1 then
									me.AutoFight(0)
								end
								AutoAi.SetTargetIndex(0)
								me.StartAutoPath(ToaDoDanhX/32,ToaDoDanhY/32)
							elseif NhiemVuChinhTuyen.KhoangCach(nCurWorldPosX*32,nCurWorldPosY*32,Npc_Task_Fight.GetMpsPos()) <= 100 then
								if me.nAutoFightState == 0 then
									me.AutoFight(1)
								end
								local tbSkillInfo = KFightSkill.GetSkillInfo(me.nLeftSkill,1);
								if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then
									Switch("horse")
								end
							
								return
							elseif me.nAutoFightState == 0 then
								AutoAi.SetTargetIndex(0)
								me.StartAutoPath(ToaDoDanhX/32,ToaDoDanhY/32)
							end
						else
							if me.nAutoFightState == 1 then
								me.AutoFight(0)
							end
							AutoAi.SetTargetIndex(0)
							me.StartAutoPath(TASK_FIGHT[i][4],TASK_FIGHT[i][5])	
						end
					---------------------------------------------------------------------------------------------------------
					else
						if me.nAutoFightState == 1 then
							me.AutoFight(0)
						end
						AutoAi.SetTargetIndex(0)
						--me.Msg("Chạy đến tọa độ mặc định")
						me.StartAutoPath(TASK_FIGHT[i][4],TASK_FIGHT[i][5])
					end
					NhiemVuChinhTuyen.DongCuaSo()
					return
				end
			end
		end
	end
	
	if NhiemVuChinhTuyen.NoiChuyenVoiNpc() == 1 then
		if nNoiChuyenVoiNpc == 0 then
			NhiemVuChinhTuyen.DongCuaSo()
		end
		return 
	end
	nNoiChuyenVoiNpc = 0
	if NhiemVuChinhTuyen.ThuThap() then
		NhiemVuChinhTuyen.DongCuaSo()
		return 
	end
	NhiemVuChinhTuyen.HoDiepThao()
	for m = 1,table.getn(ITEM_GIFT) do
		for k = 0,10 do
			if me.GetTask(1001+k,2) == ITEM_GIFT[m][1] and me.GetTask(1001+k,3) == ITEM_GIFT[m][2] then
				if me.nAutoFightState == 1 then
					me.AutoFight(0)
				end
				--me.Msg("Giao vật phẩm nhiệm vụ cho <color=yellow>"..ITEM_GIFT[m][8])
				local NPC = NhiemVuChinhTuyen.TimNPC_TEN(ITEM_GIFT[m][8])
				if NPC and NPC.nTemplateId == ITEM_GIFT[m][7] then
					local myx,myy = me.GetNpc().GetMpsPos()
					if NhiemVuChinhTuyen.KhoangCach(myx,myy,NPC.GetMpsPos()) < 100 then
						if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 0 then
							AutoAi.SetTargetIndex(NPC.nIndex);
						end
					else
						NhiemVuChinhTuyen.DiDenNpc(ITEM_GIFT[m][7])
						NhiemVuChinhTuyen.DongCuaSo()
						return
					end
				else
					NhiemVuChinhTuyen.DiDenNpc(ITEM_GIFT[m][7])
					NhiemVuChinhTuyen.DongCuaSo()
					return
				end
				if (UiManager:WindowVisible(Ui.UI_ITEMBOX) ~= 1) then		
					UiManager:SwitchWindow(Ui.UI_ITEMBOX); 
				else
					for i = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nLine - 1 do
						for j = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRow - 1 do
							local pItem = me.GetMainBagItem(j,i);
							if pItem then
								local tbObj =Ui(Ui.UI_ITEMBOX).tbMainBagCont.tbObjs[i][j];
								if pItem.nGenre == ITEM_GIFT[m][3] and pItem.nDetail == ITEM_GIFT[m][4] and pItem.nParticular == ITEM_GIFT[m][5] and pItem.nLevel == ITEM_GIFT[m][6] then
									--me.Msg("Giao vat pham")
									Ui(Ui.UI_ITEMBOX).tbMainBagCont:UseObj(tbObj,j,i);
									local uiGift = Ui(Ui.UI_ITEMGIFT)
									uiGift.OnButtonClick(uiGift,"BtnOk")
									UiManager:CloseWindow(Ui.UI_ITEMGIFT)
									UiManager:CloseWindow(Ui.UI_ITEMBOX); 
									NhiemVuChinhTuyen.DongCuaSo()
									return
								end
							end
						end
					end
				end
			end
		end
	end

-----------------------------------------------------
for i = 1,table.getn(TASK_USE_ITEM) do
	for k = 0,10 do
		if me.GetTask(1001+k,2) == TASK_USE_ITEM[i][1] and me.GetTask(1001+k,3) == TASK_USE_ITEM[i][2] and me.GetItemCountInBags(TASK_USE_ITEM[i][3],TASK_USE_ITEM[i][4],TASK_USE_ITEM[i][5],TASK_USE_ITEM[i][6]) >= 1 then
			if TASK_USE_ITEM[i][7] == 0 and TASK_USE_ITEM[i][8] == 0 and TASK_USE_ITEM[i][9] == 0 then
				NhiemVuChinhTuyen.USE_ITEM(TASK_USE_ITEM[i][3],TASK_USE_ITEM[i][4],TASK_USE_ITEM[i][5],TASK_USE_ITEM[i][6])
				NhiemVuChinhTuyen.DongCuaSo()
				return
			end
			if nMyMapId ~= TASK_USE_ITEM[i][7] then
				NhiemVuChinhTuyen.GoTo(TASK_USE_ITEM[i][7],100,100)
			else
				if nCurWorldPosX == TASK_USE_ITEM[i][8] and nCurWorldPosY == TASK_USE_ITEM[i][9] then
					local muctieu = NhiemVuChinhTuyen.TimNPC_TEN()
					if muctieu and muctieu.nDoing == 7 then
						if me.nAutoFightState == 0 then
							me.AutoFight(1)
						end
						local tbSkillInfo = KFightSkill.GetSkillInfo(me.nLeftSkill,1);
						if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then
							Switch("horse")
						end
						return
					end
					
					NhiemVuChinhTuyen.USE_ITEM(TASK_USE_ITEM[i][3],TASK_USE_ITEM[i][4],TASK_USE_ITEM[i][5],TASK_USE_ITEM[i][6])
				else
					me.StartAutoPath(TASK_USE_ITEM[i][8],TASK_USE_ITEM[i][9])
				end
			end
			if me.nAutoFightState == 1 then
				me.AutoFight(0)
			end
			NhiemVuChinhTuyen.DongCuaSo()
			return
		end
	end
end
	for i = 1,table.getn(TASK_CHETAO) do
		if me.GetTask(1001,2) == TASK_CHETAO[i][1] and me.GetTask(1001,3) == TASK_CHETAO[i][2] then
			me.DoRecipe(NhiemVuChinhTuyen.CheTao(TASK_CHETAO[i][3],TASK_CHETAO[i][4],TASK_CHETAO[i][5],TASK_CHETAO[i][6]))
			return
		end
	end
	-------------mua 2 thuc an-----------------------
	for k = 0,5 do
		if me.GetTask(1001+k,2) == 308 and me.GetTask(1001+k,3) == 1 then
			local NPC = NhiemVuChinhTuyen.TimNPC_TEN("Đại Lão Bạch")
			if NPC then
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
					me.AnswerQestion(0)
				else
					AutoAi.SetTargetIndex(NPC.nIndex)
				end
				if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
					local bOK, szMsg = me.ShopBuyItem(820+1,2)
					UiManager:CloseWindow(Ui.UI_SHOP);
					UiManager:CloseWindow(Ui.UI_ITEMBOX);
				end
			else
				NhiemVuChinhTuyen.DiDenNpc(3566)
			end
			return
		end
	end
	for k = 0,10 do
		if me.GetTask(1001+k,2) == 310 and me.GetTask(1001+k,3) == 14 then
			me.Msg("Nhập Phái")
			if NhiemVuChinhTuyen.MonPhaiGiaNhap ~= 0 then
				local NpcTruongMon = NhiemVuChinhTuyen.GetAroundNpc(NhiemVuChinhTuyen.tbMonPhai[NhiemVuChinhTuyen.MonPhaiGiaNhap][4])
				if NpcTruongMon then
					if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 0 then
						AutoAi.SetTargetIndex(NpcTruongMon.nIndex)
					else
						me.AnswerQestion(0)
					end
				else
					NhiemVuChinhTuyen.DiDenNpc(NhiemVuChinhTuyen.tbMonPhai[NhiemVuChinhTuyen.MonPhaiGiaNhap][4])
				end
			else
				me.Msg("Bạn chưa chọn môn phái sẽ ra nhập")
			end
			NhiemVuChinhTuyen.DongCuaSo()
			return
		end
	end
	
	-----------------------------------------------------
	
	local hotong = NhiemVuChinhTuyen.HoTong()
	if hotong ~= nil then
		NhiemVuChinhTuyen.DongCuaSo()
		
		return
	end
	if me.nAutoFightState == 1 then
		--me.Msg("Tắt tự động đánh")
		me.AutoFight(0)
	end
	NhiemVuChinhTuyen.DongCuaSo()
--	NhiemVuChinhTuyen.GoTo(425,100,100)
end

function NhiemVuChinhTuyen.NoiChuyenVoiNpc()
	nNoiChuyenVoiNpc = 1
	if me.nAutoFightState == 1 then
		AutoAi.SetTargetIndex(0)
		me.AutoFight(0)
	end
	local mymapid, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos()
	for i = 1,table.getn(TASK) do
		for k = 0,10 do
			if me.GetTask(1001+k,2) == TASK[i][1] and me.GetTask(1001+k,3) == TASK[i][2] then
				if me.GetTask(1001+k,5) == TASK[i][5] and me.GetTask(1001+k,6) == TASK[i][6] and me.GetTask(1001+k,7) == TASK[i][7] and me.GetTask(1001+k,8) == TASK[i][8] and me.GetTask(1001+k,9) == TASK[i][9] then
					if me.GetNpc().IsRideHorse() == 0 then
						Switch([[horse]])
					end
					AutoAi.SetTargetIndex(0)
					--me.Msg("Tìm gặp npc : <color=yellow>"..TASK[i][4])
					local NPC = NhiemVuChinhTuyen.TimNPC_TEN(TASK[i][4])
					local npc = NhiemVuChinhTuyen.TimNPC_TEN("Thuyền Phu")
					if me.GetTask(1001+k,2) == 1 and me.GetTask(1001+k,3) == 3 and npc then 
						if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
							me.AnswerQestion(0)
						else
							AutoAi.SetTargetIndex(npc.nIndex)
						end
						NhiemVuChinhTuyen.DongCuaSo()
						return 1
					end
					if NPC and NPC.nTemplateId == TASK[i][3] and NhiemVuChinhTuyen.KhoangCach(nCurWorldPosX,nCurWorldPosY,KNpc.ClientGetNpcPos(me.GetMapTemplateId(),TASK[i][3])) <= 3 then
						if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 0 then
							AutoAi.SetTargetIndex(NPC.nIndex);
						else
							--if me.GetTask(1001+k,2) == 310 and me.GetTask(1001+k,3) < 13 then
							--	me.AnswerQestion(3)
							--end
							if me.GetTask(1001+k,2) == 310 and me.GetTask(1001+k,3) == 3 and me.GetTask(1001+k,5) == 1 then
								me.AnswerQestion(1)
								me.AnswerQestion(0)
								me.AnswerQestion(1)
							elseif me.GetTask(1001+k,2) == 310 and me.GetTask(1001+k,3) < 13 then
								me.AnswerQestion(3)
							end
						end
					else
						AutoAi.SetTargetIndex(0)
						NhiemVuChinhTuyen.DiDenNpc(TASK[i][3])
					end	
					NhiemVuChinhTuyen.DongCuaSo()
					return 1
				end
			end
		end
	end
end
function NhiemVuChinhTuyen.HoTong()
	local mymapid, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos()
	local NPC
	local xeduocthao
	for i = 1,table.getn(tbHO_TONG) do
		for k = 0,10 do
			if me.GetTask(1001+k,2) == tbHO_TONG[i][1] and me.GetTask(1001+k,3) == tbHO_TONG[i][2] and me.GetTask(1001+k,5) == tbHO_TONG[i][7] and me.GetTask(1001+k,6) == tbHO_TONG[i][8]  and me.GetTask(1001+k,7) == tbHO_TONG[i][9] then
				--me.Msg("Hộ tống NPC <color=yellow>"..tbHO_TONG[i][6])
				if mymapid ~= tbHO_TONG[i][3] then
					NhiemVuChinhTuyen.GoTo(tbHO_TONG[i][3],100,100)
				else
					if (me.GetTask(1001+k,2) == 33 or me.GetTask(1001+k,2) == 46) and me.GetTask(1001+k,3) == 5 then
						NPC = NhiemVuChinhTuyen.GetAroundNpc(111) or NhiemVuChinhTuyen.GetAroundNpc(795)
						--if not NPC then
						--	NPC = NhiemVuChinhTuyen.TimNPC_TEN(tbHO_TONG[i][6])
						--	
						--end
					else
						NPC = NhiemVuChinhTuyen.TimNPC_TEN(tbHO_TONG[i][6])
					end
					
					if NPC then
					
						if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 0 and NPC.nKind == 3 then
							AutoAi.SetTargetIndex(NPC.nIndex);
							--UiManager:CloseWindow(Ui.UI_SAYPANEL);
							return 1
						end
						
						local XNPC,YNPC = NPC.GetMpsPos()
						
						if NhiemVuChinhTuyen.KhoangCach(nCurWorldPosX, nCurWorldPosY,XNPC/32,YNPC/32) < 7 then
							
							local muctieu = NhiemVuChinhTuyen.TimNPC_TEN()
							--me.Msg(tostring(muctieu))
							if muctieu and (muctieu.nDoing == 7 or muctieu.nDoing == 6) then
								
								if me.nAutoFightState == 0 then
									me.AutoFight(1)
								end
								local tbSkillInfo = KFightSkill.GetSkillInfo(me.nLeftSkill,1)
								if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then
									Switch("horse")
								end
								
								return 7
							end
							--AutoAi.SetTargetIndex(0)
							me.StartAutoPath(XNPC/32,YNPC/32)
							return 1
						else
							AutoAi.SetTargetIndex(0)
							if me.nAutoFightState == 1 then
								me.AutoFight(0)
							end
							
							if me.StartAutoPath(XNPC/32,YNPC/32) == 0 then
								AutoAi.AiAutoMoveTo(NPC.GetMpsPos())
							end
							
							return 2
						end
					else
						--me.Msg("ko thay npc tro lai dia diem cu")
						AutoAi.SetTargetIndex(0)
						if me.nAutoFightState == 1 then
							me.AutoFight(0)
						end
						if me.GetTask(1001+k,2) == 33 and me.GetTask(1001+k,3) == 5 then
							xeduocthao = NhiemVuChinhTuyen.GetAroundNpc(793)
							if xeduocthao then
								AutoAi.SetTargetIndex(xeduocthao.nIndex);
								return 1
							end
						elseif me.GetTask(1001+k,2) == 46 and me.GetTask(1001+k,3) == 5 then
							xeduocthao = NhiemVuChinhTuyen.GetAroundNpc(794)
							if xeduocthao then
								AutoAi.SetTargetIndex(xeduocthao.nIndex);
								return 1
							end
						end
						
						if me.StartAutoPath(tbHO_TONG[i][4],tbHO_TONG[i][5]) == 0 then
							AutoAi.AiAutoMoveTo(tbHO_TONG[i][4]*32,tbHO_TONG[i][5]*32)
						end
						return 1
					end	
				end
				return 1
			end
		end
	end
end
function NhiemVuChinhTuyen.MyFindItemAndGift(self,g,d,p,l)
	for j = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nLine - 1 do
		for i = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRow - 1 do
			local pItem = me.GetItem(Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRoom, i, j);
			if pItem then
				if pItem.nGenre == g and pItem.nDetail == d and pItem.nParticular == p and pItem.nLevel == l and pItem.nCount == 1 then
					me.Msg("Co vat pham de giao")
					me.UseItem(pItem);
				
				end
			end
		end
	end
	if (UiManager:WindowVisible(Ui.UI_EXTBAG1) == 1) then
		for j = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nLine - 1 do
			for i = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRoom, i, j);
				if pItem then
					if pItem.nGenre == g and pItem.nDetail == d and pItem.nParticular == p and pItem.nLevel == l and pItem.nCount == 1 then
						me.UseItem(pItem);
					end
				end
			end
		end
	end
	if (UiManager:WindowVisible(Ui.UI_EXTBAG2) == 1) then
		for j = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nLine - 1 do
			for i = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRoom, i, j);
				if pItem then
					if pItem.nGenre == g and pItem.nDetail == d and pItem.nParticular == p and pItem.nLevel == l and pItem.nCount == 1 then
						me.UseItem(pItem);
					end
				end
			end
		end
	end
	if (UiManager:WindowVisible(Ui.UI_EXTBAG3) == 1) then
		for j = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nLine - 1 do
			for i = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRoom, i, j);
				if pItem then
					if pItem.nGenre == g and pItem.nDetail == d and pItem.nParticular == p and pItem.nLevel == l  and pItem.nCount == 1 then
						me.UseItem(pItem);
					end
				end
			end
		end
	end
	return 0;
end

function NhiemVuChinhTuyen.ThuThap()
	local mymapid, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos()
	for i = 1,table.getn(tbTHUTHAP) do
		for k = 0,10 do
			if me.GetTask(1001+k,2) == tbTHUTHAP[i][1] and me.GetTask(1001+k,3) == tbTHUTHAP[i][2] and me.GetTask(1001+k,5) <= tbTHUTHAP[i][7] and me.GetTask(1001+k,6) == tbTHUTHAP[i][8] and me.GetTask(1001+k,7) == tbTHUTHAP[i][9] and me.GetTask(1001+k,8) == tbTHUTHAP[i][10] and me.GetTask(1001+k,9) == tbTHUTHAP[i][11] then 
				me.Msg("Thu Thập <color=yellow>"..tbTHUTHAP[i][6])
				if mymapid ~= tbTHUTHAP[i][3] then
					NhiemVuChinhTuyen.GoTo(tbTHUTHAP[i][3],tbTHUTHAP[i][4],tbTHUTHAP[i][5])
				else
					local NPC = NhiemVuChinhTuyen.TimNPC_TEN(tbTHUTHAP[i][6])
					if NPC then
						local XNPC,YNPC = NPC.GetMpsPos()
						if NhiemVuChinhTuyen.KhoangCach(nCurWorldPosX, nCurWorldPosY,tbTHUTHAP[i][4],tbTHUTHAP[i][5]) < 50 then
							if NhiemVuChinhTuyen.KhoangCach(nCurWorldPosX, nCurWorldPosY,XNPC,YNPC) < 10 then
								if me.nAutoFightState == 1 then
									me.AutoFight(0)
								end
								me.StartAutoPath(XNPC,YNPC)
								return
							end
							local muctieu = NhiemVuChinhTuyen.TimNPC_TEN()
							--me.Msg(tostring(muctieu.nDoing))
							if muctieu and (muctieu.nDoing == 6 or muctieu.nDoing == 7 ) then
								if me.nAutoFightState == 0 then
									me.AutoFight(1)
								end
								local tbSkillInfo	= KFightSkill.GetSkillInfo(me.nLeftSkill, 1);
								if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then
									Switch("horse")
								end
								return 2
							else
								if me.nAutoFightState == 1 then
									me.AutoFight(0)
								end
								AutoAi.SetTargetIndex(NPC.nIndex);
								return 1
							end
						else
							
							if me.nAutoFightState == 1 then
								me.AutoFight(0)
							end
							me.StartAutoPath(tbTHUTHAP[i][4],tbTHUTHAP[i][5])
						end
					else
						if me.nAutoFightState == 1 then
							me.AutoFight(0)
						end
						me.StartAutoPath(tbTHUTHAP[i][4],tbTHUTHAP[i][5])
					end	
				end
				return 1
			end
		end
	end
end
function NhiemVuChinhTuyen.DongCuaSo()
	if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
		local uiGutAward = Ui(Ui.UI_GUTAWARD)
		uiGutAward.OnButtonClick(uiGutAward, "zBtnAccept");
		UiManager:CloseWindow(Ui.UI_GUTAWARD)
	end
	if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
		UiManager:CloseWindow(Ui.UI_SHOP);
	end
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
	
end

function NhiemVuChinhTuyen.HoDiepThao()
	local nMyMapId	= me.GetMapTemplateId()
	for k = 0,10 do
	if me.GetTask(1001+k,2) == 11 and me.GetTask(1001+k,3) == 1 then
		if nMyMapId ~= 60 then
			NhiemVuChinhTuyen.GoTo(60,1595,3214)
		else
			local muctieu = NhiemVuChinhTuyen.TimNPC_TEN("Thái Nông")
			if muctieu and muctieu.nDoing == 7 then
				if me.nAutoFightState == 0 then
					me.AutoFight(1)
				end
				local tbSkillInfo = KFightSkill.GetSkillInfo(me.nLeftSkill,1);
				if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then
					Switch("horse")
				end
				return
			end
			local muctieu = NhiemVuChinhTuyen.TimNPC_TEN("Hồ điệp thảo")
			if muctieu then
				AutoAi.SetTargetIndex(muctieu.nIndex)	
				return
			else
				me.StartAutoPath(1595,3214)
			end
		end
	end
	end
end

function NhiemVuChinhTuyen.GetAroundNpc(tempID)
	local tbAroundNpc = KNpc.GetAroundNpcList(me,100);
	for _, pNpc in ipairs(tbAroundNpc) do
		if pNpc.nTemplateId == tempID then
			return pNpc
		end
	end
end

function NhiemVuChinhTuyen.MapID2Name(mapid)
	for i = 1,nHeight_city do
		if pMapCity.GetInt(i,2) == mapid then
			return pMapCity.GetStr(i,1)
		end
	end
end

function NhiemVuChinhTuyen.DiDenNpc(npcid)
		local Xnpc,Ynpc = KNpc.ClientGetNpcPos(me.GetMapTemplateId(),npcid);
		if Xnpc and Xnpc ~= 0 then
			me.StartAutoPath(Xnpc,Ynpc)
			return 1
		else
			for i = 1,nHeight_trans do
				local Xnpc,Ynpc = KNpc.ClientGetNpcPos(pTransmit.GetInt(i,1),npcid);
				if Xnpc and Xnpc ~= 0 then
					NhiemVuChinhTuyen.GoTo(pTransmit.GetInt(i,1),Xnpc,Ynpc)
					break
				end
			end
		end
end

function NhiemVuChinhTuyen.MucTieuGanNhat(tblistnpc)
	local npcgannhat = nil
	local khoanggannhat = 5000
	local nMyX, nMyY = me.GetNpc().GetMpsPos();
	for _, pNpc in ipairs(tblistnpc) do
		local Xnpc,Ynpc = pNpc.GetMpsPos();
		local kc_npc = NhiemVuChinhTuyen.KhoangCach(nMyX, nMyY,Xnpc,Ynpc)
		if kc_npc < khoanggannhat then
			npcgannhat = pNpc
			khoanggannhat = kc_npc
		end
	end
	return npcgannhat
end

function NhiemVuChinhTuyen.CheTao(a,b,c,d)
	local tbRecipeList = me.GetRecipeList();
	if (not tbRecipeList or #tbRecipeList == 0) then
		return nil;
	end
	for _, nRecipeId1 in ipairs(tbRecipeList) do
		local tbData = LifeSkill.tbRecipeDatas[nRecipeId1]
		if tbData.Produce1Genre== a and  tbData.Produce1Detail== b and tbData.Produce1Parti== c and tbData.Produce1Level == d then
			return nRecipeId1
		end
	end
	return nil
end

function NhiemVuChinhTuyen.GoTo(M,X,Y)
	local trap = NhiemVuChinhTuyen.TimNPC_TEN(NhiemVuChinhTuyen.MapID2Name(M))
	if trap then
		local Xnpc,Ynpc = trap.GetMpsPos();
		AutoAi.AiAutoMoveTo(Xnpc,Ynpc);
		return
	end
	local npc_fighting = NhiemVuChinhTuyen.TimNPC_TEN()
	if npc_fighting and (npc_fighting.nDoing == 6 or npc_fighting.nDoing == 7) then
		AutoAi.DoAttack(me.nLeftSkill,npc_fighting.nIndex);
		return
	end
	local tbPosInfo ={}
	tbPosInfo.szType = "pos"
	tbPosInfo.szLink = ","..M..","..X..","..Y
	Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,tbPosInfo)
end

function NhiemVuChinhTuyen.TimNPC_TEN(sName)
	local tbEnemyList = {}
	if not sName then
		local tbNpcList = KNpc.GetAroundNpcList(me,1000);
		for _, pNpc in ipairs(tbNpcList) do
			if AutoAi.AiTargetCanAttack(pNpc.nIndex) == 1 then
				table.insert(tbEnemyList, pNpc);			
			end
		end
		if table.getn(tbEnemyList) >=1 then
			return NhiemVuChinhTuyen.MucTieuGanNhat(tbEnemyList)
		end
	end
	------------------------------------------
	local tbNpcList = KNpc.GetAroundNpcList(me,1000);
	for _, pNpc in ipairs(tbNpcList) do
		if pNpc.szName == sName then
			table.insert(tbEnemyList, pNpc);			
		end
	end
	if table.getn(tbEnemyList) >=1 then
		return NhiemVuChinhTuyen.MucTieuGanNhat(tbEnemyList)
	end
end
function NhiemVuChinhTuyen.KhoangCach(myX,myY,keyX,keyY)
	local nDistance	= 0;
	nDistance = math.sqrt((myX-keyX)^2 + (myY-keyY)^2);
	return nDistance;
end
Ui:RegisterNewUiWindow("UI_NVCT_", "NhiemVuChinhTuyen", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});
local tCmd={"Ui(Ui.UI_NVCT_):State()", "NhiemVuChinhTuyen", "", "Shift+T", "Shift+T", "nvct"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
