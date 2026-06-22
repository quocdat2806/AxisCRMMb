Hướng dẫn tích hợp API hỗ trợ Lịch Âm - AxisCRM
Tài liệu này hướng dẫn cách tích hợp các API của Backend AxisCRM sau khi đã được nâng cấp hỗ trợ lọc theo khoảng ngày Dương lịch (start_date và end_date). Thay đổi này cho phép Frontend quy đổi bất kỳ tháng âm lịch hay năm âm lịch nào thành khoảng ngày dương lịch tương ứng rồi gửi yêu cầu lên Backend.

1. Nguyên Tắc Hoạt Động Chung
Lưu trữ dữ liệu: Backend và Database luôn lưu trữ dưới dạng Dương lịch (YYYY-MM-DD).
Quy đổi thời gian: Frontend chịu trách nhiệm quy đổi ngày/tháng/năm âm lịch sang ngày dương lịch trước khi tương tác với API.
Tương thích ngược (Backward Compatibility): Các API được chỉnh sửa vẫn hỗ trợ các tham số cũ (month, year). Nếu chỉ truyền tham số cũ, Backend sẽ tự phân giải sang khoảng Dương lịch tiêu chuẩn.
2. API Chấm Công (Attendance APIs)
2.1. Lấy danh sách chấm công (Chủ thầu)
Endpoint: GET /v1/attendance
Tham số Query mới (Khuyên dùng cho Lịch Âm):
start_date (string, optional, dạng YYYY-MM-DD): Ngày bắt đầu Dương lịch đã quy đổi từ Âm lịch.
end_date (string, optional, dạng YYYY-MM-DD): Ngày kết thúc Dương lịch đã quy đổi từ Âm lịch.
Tham số Query cũ (Tương thích ngược):
month (string, optional, dạng YYYY-MM): Lọc trọn vẹn tháng Dương lịch.
Ví dụ gọi API cho tháng 5 Âm lịch năm 2026 (15/06/2026 - 13/07/2026 Dương lịch):
http

GET /v1/attendance?start_date=2026-06-15&end_date=2026-07-13&user_id=...
2.2. Thợ xem danh sách chấm công cá nhân
Endpoint: GET /v1/me/attendance
Tham số Query: tương tự như API trên (chấp nhận start_date, end_date hoặc month).
Ví dụ:
http

GET /v1/me/attendance?start_date=2026-06-15&end_date=2026-07-13
2.3. Đối soát chấm công giữa Thợ và Chủ thầu
Endpoint: GET /v1/me/attendance/reconcile
Tham số Query mới:
start_date (string, bắt buộc nếu không truyền month, dạng YYYY-MM-DD)
end_date (string, bắt buộc nếu không truyền month, dạng YYYY-MM-DD)
Tham số Query cũ:
month (string, bắt buộc nếu không truyền khoảng ngày, dạng YYYY-MM)
Ví dụ đối soát cho tháng 5 Âm lịch:
http

GET /v1/me/attendance/reconcile?start_date=2026-06-15&end_date=2026-07-13
3. API Tạm Ứng (Advance APIs)
3.1. Lấy danh sách thợ tạm ứng (Chủ thầu)
Endpoint: GET /v1/worker-advances
Tham số Query mới: start_date, end_date (dạng YYYY-MM-DD).
Tham số Query cũ: month (dạng YYYY-MM).
Ví dụ:
http

GET /v1/worker-advances?start_date=2026-06-15&end_date=2026-07-13&user_id=...
3.2. Thợ xem danh sách tạm ứng cá nhân
Endpoint: GET /v1/me/worker-advances
Tham số Query: start_date, end_date hoặc month.
Ví dụ:
http

GET /v1/me/worker-advances?start_date=2026-06-15&end_date=2026-07-13
3.3. Xem danh sách chi tiền công trình (Chủ thầu)
Endpoint: GET /v1/project-advances
Tham số Query: start_date, end_date hoặc month.
Ví dụ:
http

GET /v1/project-advances?start_date=2026-06-15&end_date=2026-07-13&project_id=...
3.4. Đối soát tiền tạm ứng giữa Thợ và Chủ thầu
Endpoint: GET /v1/me/worker-advances/reconcile
Tham số Query: start_date, end_date hoặc month.
Ví dụ:
http

GET /v1/me/worker-advances/reconcile?start_date=2026-06-15&end_date=2026-07-13
4. API Báo Cáo Tổng Kết (Summary Reports)
Dành cho nhu cầu tổng kết năm theo cả năm Dương lịch hoặc năm Âm lịch (tính từ ngày 1 tháng Giêng đến hết ngày 29 hoặc 30 tháng Chạp năm đó).

4.1. Xem tổng kết năm
Endpoint:
Chủ thầu xem thợ: GET /v1/yearly-summary
Thợ tự xem: GET /v1/me/yearly-summary
Tham số Query mới (Khuyên dùng cho Lịch Âm):
start_date (string, optional, dạng YYYY-MM-DD): Ngày bắt đầu năm (ví dụ mùng 1 Tết).
end_date (string, optional, dạng YYYY-MM-DD): Ngày kết thúc năm (ví dụ ngày 30 Tết).
Tham số Query cũ (Tương thích ngược):
year (string, optional, dạng YYYY): Gom dữ liệu từ 01/01 đến 31/12 Dương lịch của năm đó.
Ví dụ tổng kết năm Âm lịch 2026 Bính Ngọ (17/02/2026 - 05/02/2027 Dương lịch):
http

GET /v1/yearly-summary?start_date=2026-02-17&end_date=2027-02-05&user_id=...
4.2. Xem các ngày bị lệch công/tiền trong năm
Endpoint:
Chủ thầu xem thợ: GET /v1/yearly-mismatches
Thợ tự xem: GET /v1/me/yearly-mismatches
Tham số Query: start_date, end_date hoặc year.
Ví dụ:
http

GET /v1/yearly-mismatches?start_date=2026-02-17&end_date=2027-02-05&user_id=...
5. Các Lỗi Thường Gặp (Error Responses)
Nếu truyền sai định dạng hoặc thiếu khoảng ngày, hệ thống sẽ trả về lỗi:

Sai định dạng ngày (start_date / end_date):
Status Code: 400 Bad Request
Body:
json

{
  "success": false,
  "code": "INVALID_START_DATE_FORMAT",
  "message": "start_date must be YYYY-MM-DD"
}
Chỉ truyền một trong hai tham số start_date hoặc end_date:
Status Code: 400 Bad Request
Body:
json

{
  "success": false,
  "code": "DATE_RANGE_REQUIRED",
  "message": "both start_date and end_date are required"
}
Không truyền cả khoảng ngày lẫn tháng/năm ở các API đối soát/tổng kết:
Status Code: 400 Bad Request
Body:
json

{
  "success": false,
  "code": "DATE_OR_MONTH_REQUIRED",
  "message": "start_date/end_date or month is required"
}