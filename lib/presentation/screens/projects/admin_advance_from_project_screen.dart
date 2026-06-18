import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/core/utils/date_until.dart';
import 'package:axis_crm/presentation/cubits/session/session_cubit.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_date_picker_dialog.dart';
import '../../widgets/app_text_field.dart';

class AdminAdvanceFromProjectScreen extends StatefulWidget {
  const AdminAdvanceFromProjectScreen({
    super.key,
    required this.projectId,
    required this.projectName,
  });

  final String projectId;
  final String projectName;

  @override
  State<AdminAdvanceFromProjectScreen> createState() =>
      _AdminAdvanceFromProjectScreenState();
}

class _AdminAdvanceFromProjectScreenState
    extends State<AdminAdvanceFromProjectScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _isSubmitting = false;
  bool _isAmountValid = false;
  bool _hasHandledSuccess = false;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _onAmountChanged(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.isEmpty) {
      _amountController.text = '';
      setState(() => _isAmountValid = false);
      return;
    }
    final valueInt = int.tryParse(digitsOnly) ?? 0;
    if (valueInt <= 0) {
      setState(() => _isAmountValid = false);
      return;
    }
    final formatted = valueInt.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]}.',
        );
    _amountController.text = formatted;
    _amountController.selection = TextSelection.fromPosition(
      TextPosition(offset: formatted.length),
    );
    setState(() => _isAmountValid = true);
  }

  String _formatMoney(int amount) {
    return amount.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]}.',
        );
  }

  void _showConfirmDialog(
    BuildContext context,
    String rawAmount,
    VoidCallback onConfirm,
  ) {
    final int amount = int.tryParse(rawAmount) ?? 0;
    final formattedAmount = _formatMoney(amount);

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
            'Bạn có muốn ứng số tiền $formattedAmount vnđ này không? Khi bạn chấp nhận sẽ không thể sửa lại số tiền đó.',
            style: const TextStyle(fontSize: 14, color: Color(0xFF17233C)),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
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

  Future<void> _submit() async {
    final digitsOnly = _amountController.text.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.isEmpty) return;
    final amountDouble = double.tryParse(digitsOnly);
    if (amountDouble == null || amountDouble <= 0) return;

    setState(() => _isSubmitting = true);

    try {
      final userId = getIt<SessionCubit>().state.user?.id ?? '';
      final response = await getIt<ApiClient>().createProjectAdvance(
        CreateProjectAdvanceRequest(
          userId: userId,
          projectId: widget.projectId,
          amount: amountDouble,
          date: DateFormat('yyyy-MM-dd').format(_selectedDate),
          note: _noteController.text.trim().isEmpty
              ? null
              : _noteController.text.trim(),
        ),
      );

      if (mounted) {
        setState(() => _isSubmitting = false);
        if (response.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? 'Ứng tiền thành công'),
              backgroundColor: Colors.green,
            ),
          );
          context.pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? 'Ứng tiền thất bại'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F7FC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF17233C)),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Ứng tiền',
          style: TextStyle(
            color: Color(0xFF17233C),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Công trình',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF344054),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCDCED1)),
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFF4F7FC),
                ),
                child: Text(
                  widget.projectName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF17233C),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              AppTextField(
                label: 'Số tiền',
                hintText: 'Nhập số tiền',
                controller: _amountController,
                keyboardType: TextInputType.number,
                onChanged: _onAmountChanged,
              ),
              const SizedBox(height: 14),
              const Text(
                'Ngày ứng tiền',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF344054),
                ),
              ),
              const SizedBox(height: 6),
              InkWell(
                onTap: () async {
                  final date = await showDialog<DateTime>(
                    context: context,
                    builder: (_) => const AppDatePickerDialog(),
                  );
                  if (date != null) {
                    setState(() => _selectedDate = date);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFCDCED1)),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          AppDateUtils.formatDate(_selectedDate),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF17233C),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.calendar_today,
                        size: 20,
                        color: Color(0xFF667085),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              AppTextField(
                label: 'Ghi chú (tuỳ chọn)',
                hintText: 'Nhập ghi chú',
                controller: _noteController,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  label: _isSubmitting ? 'Đang gửi...' : 'Gửi',
                  onPressed: _isSubmitting || !_isAmountValid
                      ? null
                      : () {
                          final digitsOnly = _amountController.text
                              .replaceAll(RegExp(r'[^\d]'), '');
                          _showConfirmDialog(
                            context,
                            digitsOnly,
                            _submit,
                          );
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
