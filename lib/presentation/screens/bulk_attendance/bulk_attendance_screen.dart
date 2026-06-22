import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/entity/user.dart';
import 'package:axis_crm/presentation/widgets/app_button.dart';
import 'package:axis_crm/presentation/widgets/page_title.dart';
import 'package:axis_crm/presentation/widgets/section_card.dart';
import 'package:axis_crm/presentation/widgets/app_date_picker_dialog.dart';
import 'package:axis_crm/core/events/event_bus.dart';
import 'package:axis_crm/core/utils/date_until.dart';

class BulkAttendanceScreen extends StatefulWidget {
  const BulkAttendanceScreen({
    required this.users,
    super.key,
  });

  final List<User> users;

  @override
  State<BulkAttendanceScreen> createState() => _BulkAttendanceScreenState();
}

class _BulkAttendanceScreenState extends State<BulkAttendanceScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedShift = 'full'; // default to full (Cả ngày)
  final Set<String> _selectedUserIds = {};
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Default to select all users on init
    for (final user in widget.users) {
      _selectedUserIds.add(user.id);
    }
  }

  void _toggleUserSelection(String userId) {
    setState(() {
      if (_selectedUserIds.contains(userId)) {
        _selectedUserIds.remove(userId);
      } else {
        _selectedUserIds.add(userId);
      }
    });
  }

  void _toggleSelectAll(bool? checked) {
    setState(() {
      if (checked == true) {
        for (final user in widget.users) {
          _selectedUserIds.add(user.id);
        }
      } else {
        _selectedUserIds.clear();
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (context) => AppDatePickerDialog(initialDate: _selectedDate),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _submit() async {
    if (_selectedUserIds.isEmpty) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final response = await getIt<ApiClient>().createBulkAttendance(
        CreateBulkAttendanceRequest(
          date: DateFormat('yyyy-MM-dd').format(_selectedDate),
          shift: _selectedShift,
          userIds: _selectedUserIds.toList(),
        ),
      );

      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });

        if (response.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? 'Chấm công hàng loạt thành công'),
              backgroundColor: const Color(0xFF2E7D32),
            ),
          );
          getIt<EventBus>().fire(WorksheetUpdatedEvent());
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? 'Chấm công hàng loạt thất bại'),
              backgroundColor: const Color(0xFFC62828),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã xảy ra lỗi: ${e.toString()}'),
            backgroundColor: const Color(0xFFC62828),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isAllSelected = _selectedUserIds.length == widget.users.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        title: const PageTitle(title: 'Chấm công hàng loạt'),
        backgroundColor: const Color(0xFFF4F7FC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF17233C)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: <Widget>[
            // Date Selector Card
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Ngày chấm công',
                    style: TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE4E7EC)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Icon(Icons.calendar_month_rounded, color: Color(0xFF2457D6)),
                              const SizedBox(width: 10),
                              Text(
                                AppDateUtils.formatLunarHeaderDate(_selectedDate),
                                style: const TextStyle(
                                  color: Color(0xFF17233C),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_drop_down, color: Color(0xFF667085)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Shift Selector Card
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Chọn loại chấm công',
                    style: TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildShiftChip('full', 'Cả ngày', const Color(0xFF2E7D32)),
                      _buildShiftChip('half', 'Nửa ngày', const Color(0xFF1565C0)),
                      _buildShiftChip('absent', 'Vắng/Nghỉ', const Color(0xFFC62828)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Workers List Selection Card
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Danh sách thợ áp dụng',
                        style: TextStyle(
                          color: Color(0xFF17233C),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Đã chọn: ${_selectedUserIds.length}/${widget.users.length}',
                        style: const TextStyle(
                          color: Color(0xFF2457D6),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  CheckboxListTile(
                    title: const Text(
                      'Chọn tất cả thợ',
                      style: TextStyle(
                        color: Color(0xFF17233C),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    value: isAllSelected,
                    onChanged: _toggleSelectAll,
                    activeColor: const Color(0xFF2457D6),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                  const Divider(color: Color(0xFFE4E7EC), height: 12),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.users.length,
                    separatorBuilder: (_, __) => const Divider(color: Color(0xFFF4F7FC), height: 8),
                    itemBuilder: (BuildContext context, int index) {
                      final user = widget.users[index];
                      final isSelected = _selectedUserIds.contains(user.id);
                      final displayName = '${user.name}${user.nickname != null && user.nickname!.isNotEmpty ? ' (${user.nickname})' : ''}';

                      return CheckboxListTile(
                        title: Text(
                          displayName,
                          style: const TextStyle(
                            color: Color(0xFF17233C),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          'SĐT: ${user.phone}',
                          style: const TextStyle(
                            color: Color(0xFF667085),
                            fontSize: 12,
                          ),
                        ),
                        value: isSelected,
                        onChanged: (_) => _toggleToggleSelection(user.id),
                        activeColor: const Color(0xFF2457D6),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: AppButton(
            label: _selectedUserIds.isEmpty
                ? 'Chọn thợ để chấm công'
                : 'Chấm công cho ${_selectedUserIds.length} thợ',
            isLoading: _isSubmitting,
            onPressed: _selectedUserIds.isEmpty ? null : _submit,
          ),
        ),
      ),
    );
  }

  void _toggleToggleSelection(String userId) {
    _toggleUserSelection(userId);
  }

  Widget _buildShiftChip(String value, String label, Color activeColor) {
    final isSelected = _selectedShift == value;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ChoiceChip(
          label: Container(
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF667085),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          selected: isSelected,
          onSelected: (bool selected) {
            if (selected) {
              setState(() {
                _selectedShift = value;
              });
            }
          },
          selectedColor: activeColor,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isSelected ? activeColor : const Color(0xFFE4E7EC),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          labelPadding: EdgeInsets.zero,
          showCheckmark: false,
        ),
      ),
    );
  }
}
