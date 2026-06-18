import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/entity/user.dart';
import 'package:axis_crm/presentation/cubits/admin_advance/admin_advance_cubit.dart';
import 'package:axis_crm/presentation/widgets/app_button.dart';
import 'package:axis_crm/presentation/widgets/section_card.dart';
import 'package:axis_crm/presentation/widgets/app_date_picker_dialog.dart';
import 'package:axis_crm/presentation/widgets/money_input_formatter.dart';

class AdminAdvanceScreen extends StatelessWidget {
  const AdminAdvanceScreen({super.key, this.userId, this.userName});

  final String? userId;
  final String? userName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminAdvanceCubit>(
      create: (_) => AdminAdvanceCubit(
        apiClient: getIt<ApiClient>(),
        preselectedUserId: userId,
        preselectedUserName: userName,
      ),
      child: const _AdminAdvanceView(),
    );
  }
}

class _AdminAdvanceView extends StatelessWidget {
  const _AdminAdvanceView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminAdvanceCubit, AdminAdvanceState>(
      listener: (context, state) {
        if (state.submitSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Gửi duyệt thành công'),
              backgroundColor: Colors.green,
            ),
          );
          context.read<AdminAdvanceCubit>().resetForm();
          Navigator.of(context).pop(true);
        }
        if (state.submitError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Lỗi: ${state.submitError}'),
              backgroundColor: Colors.red,
            ),
          );
          context.read<AdminAdvanceCubit>().clearError();
        }
      },
      builder: (context, state) {
        final cubit = context.read<AdminAdvanceCubit>();

        return Scaffold(
          backgroundColor: const Color(0xFFF4F7FC),
          appBar: AppBar(
            title: const Text('Ghi ứng cho công nhân'),
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
                        'Số tiền ứng',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF344054),
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [MoneyInputFormatter()],
                        decoration: InputDecoration(
                          hintText: 'Nhập số tiền',
                          prefixIcon: const Icon(Icons.payments_outlined),
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
                        onChanged: cubit.amountChanged,
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Ngày ứng',
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
                        'Lý do',
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
                          hintText: 'Nhập lý do',
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
                        onPressed:
                            (state.selectedWorkerId == null ||
                                state.amount.isEmpty)
                            ? null
                            : () => _showConfirmDialog(
                                  context,
                                  state.amount,
                                  () => cubit.submit(),
                                ),
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

  void _showConfirmDialog(BuildContext context, String formattedAmount, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: const Text(
            'Xác nhận',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF17233C),
            ),
          ),
          content: Text(
            'Bạn có muốn ứng số tiền $formattedAmount vnđ này không ?Khi bạn chấp nhận sẽ không thể sửa lại số tiền đó',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF17233C),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text(
                'Hủy',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                onConfirm();
              },
              child: const Text(
                'Đồng ý',
                style: TextStyle(
                  color: Color(0xFF2457D6),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
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
