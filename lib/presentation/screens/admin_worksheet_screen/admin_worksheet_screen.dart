import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/entity/user.dart';
import 'package:axis_crm/presentation/cubits/admin_worksheet/admin_worksheet_cubit.dart';
import 'package:axis_crm/presentation/widgets/app_button.dart';
import 'package:axis_crm/presentation/widgets/section_card.dart';
import 'package:axis_crm/presentation/widgets/app_date_picker_dialog.dart';

class AdminWorksheetScreen extends StatelessWidget {
  const AdminWorksheetScreen({super.key, this.userId, this.userName});

  final String? userId;
  final String? userName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminWorksheetCubit>(
      create: (_) => AdminWorksheetCubit(
        apiClient: getIt<ApiClient>(),
        preselectedUserId: userId,
        preselectedUserName: userName,
      ),
      child: const _AdminWorksheetView(),
    );
  }
}

class _AdminWorksheetView extends StatelessWidget {
  const _AdminWorksheetView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminWorksheetCubit, AdminWorksheetState>(
      listener: (context, state) {
        if (state.submitSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Gửi duyệt thành công'),
              backgroundColor: Colors.green,
            ),
          );
          context.read<AdminWorksheetCubit>().resetForm();
          Navigator.of(context).pop(true);
        }
        if (state.submitError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Lỗi: ${state.submitError}'),
              backgroundColor: Colors.red,
            ),
          );
          context.read<AdminWorksheetCubit>().clearError();
        }
      },
      builder: (context, state) {
        final cubit = context.read<AdminWorksheetCubit>();

        return Scaffold(
          backgroundColor: const Color(0xFFF4F7FC),
          appBar: AppBar(
            title: const Text('Chấm công cho công nhân'),
            backgroundColor: const Color(0xFFF4F7FC),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(18),
              children: <Widget>[
                const SizedBox(height: 16),
                SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (state.selectedWorkerId != null) ...<Widget>[
                        const Text(
                          'Công nhân',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF344054),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F7FC),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE5EAF3)),
                          ),
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                Icons.person,
                                color: Color(0xFF667299),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                state.selectedWorkerName ?? 'Công nhân',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF17233C),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else ...<Widget>[
                        const Text(
                          'Chọn công nhân',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF344054),
                          ),
                        ),
                        const SizedBox(height: 6),
                        _WorkerDropdown(
                          workers: state.workers,
                          selectedWorkerId: state.selectedWorkerId,
                          onChanged: cubit.workerChanged,
                          isLoading: state.isLoadingWorkers,
                        ),
                      ],
                      const SizedBox(height: 14),
                      const Text(
                        'Ngày chấm công',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF344054),
                        ),
                      ),
                      const SizedBox(height: 6),
                      _DateField(date: state.date, onPicked: cubit.dateChanged),
                      const SizedBox(height: 14),
                      const Text(
                        'Loại chấm công',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF344054),
                        ),
                      ),
                      const SizedBox(height: 6),
                      _ShiftTypeDropdown(
                        value: state.shiftType,
                        onChanged: cubit.shiftTypeChanged,
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Ghi chú',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF344054),
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Nhập ghi chú',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFFCDD1DE),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFFCDD1DE),
                            ),
                          ),
                        ),
                        onChanged: cubit.noteChanged,
                      ),
                      const SizedBox(height: 18),
                      AppButton(
                        label: 'Gửi duyệt',
                        isLoading: state.isSubmitting,
                        onPressed: state.selectedWorkerId == null
                            ? null
                            : () => cubit.submit(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _WorkerDropdown extends StatelessWidget {
  const _WorkerDropdown({
    required this.workers,
    required this.selectedWorkerId,
    required this.onChanged,
    required this.isLoading,
  });

  final List<User> workers;
  final String? selectedWorkerId;
  final ValueChanged<String?> onChanged;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFCDD1DE)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedWorkerId,
          hint: Text(isLoading ? 'Đang tải...' : 'Chọn công nhân'),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF667299)),
          items: workers.map((worker) {
            return DropdownMenuItem<String>(
              value: worker.id,
              child: Text(worker.name ?? worker.phone),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _ShiftTypeDropdown extends StatelessWidget {
  const _ShiftTypeDropdown({required this.value, required this.onChanged});

  final String value;
  final ValueChanged<String> onChanged;

  static const List<Map<String, String>> shiftTypes = <Map<String, String>>[
    {'value': 'full', 'label': 'Cả ngày'},
    {'value': 'half', 'label': 'Nửa ngày'},
    {'value': 'absent', 'label': 'Nghỉ'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFCDD1DE)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF667299)),
          items: shiftTypes.map((type) {
            return DropdownMenuItem<String>(
              value: type['value'],
              child: Text(type['label']!),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) onChanged(newValue);
          },
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({required this.date, required this.onPicked});

  final DateTime date;
  final ValueChanged<DateTime> onPicked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDialog<DateTime>(
          context: context,
          builder: (context) => AppDatePickerDialog(initialDate: date),
        );
        if (picked != null) onPicked(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFCDD1DE)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: <Widget>[
            const Icon(Icons.calendar_today_outlined, color: Color(0xFF667299)),
            const SizedBox(width: 12),
            Text(
              _formatDate(date),
              style: const TextStyle(fontSize: 14, color: Color(0xFF17233C)),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}
