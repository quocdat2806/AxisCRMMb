import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/presentation/cubits/user_advance/user_advance_cubit.dart';
import 'package:axis_crm/presentation/widgets/app_button.dart';
import 'package:axis_crm/presentation/widgets/app_text_field.dart';
import 'package:axis_crm/presentation/widgets/page_title.dart';
import 'package:axis_crm/presentation/widgets/section_card.dart';
import 'package:axis_crm/presentation/widgets/empty_state.dart';
import 'package:axis_crm/presentation/widgets/app_date_picker_dialog.dart';
import 'package:axis_crm/presentation/widgets/money_input_formatter.dart';
import 'package:axis_crm/core/utils/date_until.dart';

class UserAdvanceScreen extends StatelessWidget {
  const UserAdvanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserAdvanceCubit>(
      create: (_) => UserAdvanceCubit(),
      child: const _AdvanceView(),
    );
  }
}

class _AdvanceView extends StatelessWidget {
  const _AdvanceView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAdvanceCubit, UserAdvanceState>(
      builder: (BuildContext context, UserAdvanceState state) {
        final UserAdvanceCubit cubit = context.read<UserAdvanceCubit>();

        return Scaffold(
          backgroundColor: const Color(0xFFF4F7FC),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(18),
                    children: <Widget>[
                      const PageTitle(title: 'Lịch sử ứng tiền'),
                      const SizedBox(height: 16),
                      _MonthSwitcher(
                        month: state.advanceMonth,
                        onPrevious: cubit.previousAdvanceMonth,
                        onNext: cubit.nextAdvanceMonth,
                      ),
                      const SizedBox(height: 14),
                      SectionCard(
                        child: Row(
                          children: <Widget>[
                            const Expanded(
                              child: Text(
                                'Tháng này đã ứng',
                                style: TextStyle(
                                  color: Color(0xFF667085),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              '${_formatMoney(state.monthlyAdvanceTotal)} vnđ',
                              style: const TextStyle(
                                color: Color(0xFF17233C),
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      if (state.isLoading)
                        const Center(child: CircularProgressIndicator())
                      else if (state.workerAdvances.isEmpty)
                        const EmptyState(
                          message: 'Chưa có khoản ứng nào trong tháng',
                        )
                      else ...<Widget>[
                        ...state.workerAdvances.map(_AdvanceItem.new),
                        if (state.hasMoreWorkerAdvances)
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: AppButton(
                              label: 'Tải thêm',
                              onPressed: () {
                                context
                                    .read<UserAdvanceCubit>()
                                    .loadMoreWorkerAdvances();
                              },
                            ),
                          ),
                        const SizedBox(height: 80),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AppButton(
                        label: 'Tạo đơn ứng tiền',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  BlocProvider<UserAdvanceCubit>.value(
                                    value: context.read<UserAdvanceCubit>(),
                                    child: const _CreateAdvanceScreen(),
                                  ),
                            ),
                          );
                        },
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

class _AdvanceItem extends StatelessWidget {
  const _AdvanceItem(this.item);

  final WorkerAdvanceItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SectionCard(
        child: Row(
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.payments_outlined,
                color: Color(0xFF2457D6),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _InfoRow(
                    label: 'Số tiền ứng',
                    value: '${_formatMoney(item.workerAmount ?? 0)} đ',
                  ),
                  const SizedBox(height: 4),
                  _InfoRow(
                    label: 'Ngày ứng',
                    value: _formatDateTime(item.date),
                  ),
                  if (item.workerNote != null &&
                      item.workerNote!.isNotEmpty) ...<Widget>[
                    const SizedBox(height: 4),
                    _InfoRow(label: 'Lý do ứng', value: item.workerNote!),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label: ',
          style: const TextStyle(
            color: Color(0xFF667085),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xFF17233C),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _MonthSwitcher extends StatelessWidget {
  const _MonthSwitcher({
    required this.month,
    required this.onPrevious,
    required this.onNext,
  });

  final DateTime month;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: onPrevious,
            icon: const Icon(Icons.chevron_left),
          ),
          Expanded(
            child: Text(
              AppDateUtils.formatLunarMonthHeader(month),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF17233C),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          IconButton(onPressed: onNext, icon: const Icon(Icons.chevron_right)),
        ],
      ),
    );
  }
}

class _CreateAdvanceScreen extends StatefulWidget {
  const _CreateAdvanceScreen();

  @override
  State<_CreateAdvanceScreen> createState() => _CreateAdvanceScreenState();
}

class _CreateAdvanceScreenState extends State<_CreateAdvanceScreen> {
  final TextEditingController _amountController = TextEditingController();
  bool _hasHandledSuccess = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _handleSuccessAndPop() {
    if (_hasHandledSuccess) return;
    _hasHandledSuccess = true;
    context.read<UserAdvanceCubit>().clearSubmitStatus();
    context.read<UserAdvanceCubit>().loadWorkerAdvances();
    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
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
            'Bạn có muốn ứng số tiền $formattedAmount vnđ này không ?Khi bạn chấp nhận sẽ không thể sửa lại số tiền đó',
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserAdvanceCubit, UserAdvanceState>(
      listener: (context, state) {
        if (state.submitSuccess && !_hasHandledSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ứng tiền thành công'),
              backgroundColor: Colors.green,
            ),
          );
          _handleSuccessAndPop();
        }
        if (state.submitError != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.submitError}'),
              backgroundColor: Colors.red,
            ),
          );
          context.read<UserAdvanceCubit>().clearSubmitStatus();
        }
      },
      builder: (BuildContext context, UserAdvanceState state) {
        final UserAdvanceCubit cubit = context.read<UserAdvanceCubit>();

        return Scaffold(
          backgroundColor: const Color(0xFFF4F7FC),
          appBar: AppBar(
            title: const PageTitle(title: 'Tạo đơn ứng tiền'),
            backgroundColor: const Color(0xFFF4F7FC),
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(18),
              children: <Widget>[
                SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                        controller: _amountController,
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
                        onChanged: (String value) {
                          final String cleaned = value.replaceAll(
                            RegExp(r'[^\d]'),
                            '',
                          );
                          if (cleaned.isEmpty) {
                            cubit.advanceAmountChanged('');
                            return;
                          }
                          final int? amount = int.tryParse(cleaned);
                          if (amount != null) {
                            cubit.advanceAmountChanged(amount.toString());
                          }
                        },
                      ),

                      const SizedBox(height: 14),

                      AppTextField(
                        label: 'Lý do ứng tiền',
                        hintText: 'Nhập lý do (nếu có)',
                        onChanged: cubit.advanceReasonChanged,
                      ),
                      const SizedBox(height: 14),
                      _DateField(
                        label: 'Ngày ứng tiền',
                        date: state.advanceDate,
                        onPicked: cubit.advanceDateChanged,
                      ),
                      const SizedBox(height: 18),
                      AppButton(
                        label: 'Xác nhận ứng tiền',
                        isLoading: state.isSubmitting,
                        onPressed: () => _showConfirmDialog(
                          context,
                          state.advanceAmount,
                          () => cubit.createAdvance(),
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

  String _formatMoney(int value) {
    final String raw = value.toString();
    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < raw.length; i++) {
      final int reverseIndex = raw.length - i;
      buffer.write(raw[i]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) {
        buffer.write('.');
      }
    }
    return buffer.toString();
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.date,
    required this.onPicked,
  });

  final String label;
  final DateTime date;
  final ValueChanged<DateTime> onPicked;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: label,
      hintText: _formatDate(date),
      controller: TextEditingController(text: _formatDate(date)),
      suffixIcon: Icons.keyboard_arrow_down,
      readOnly: true,
      onTap: () async {
        final DateTime? picked = await showDialog<DateTime>(
          context: context,
          builder: (context) => AppDatePickerDialog(initialDate: date),
        );
        if (picked != null) onPicked(picked);
      },
    );
  }

  String _formatDate(DateTime date) {
    return AppDateUtils.formatLunarDate(date);
  }
}

String _formatMoney(int value) {
  final String raw = value.toString();
  final StringBuffer buffer = StringBuffer();
  for (int i = 0; i < raw.length; i++) {
    final int reverseIndex = raw.length - i;
    buffer.write(raw[i]);
    if (reverseIndex > 1 && reverseIndex % 3 == 1) {
      buffer.write('.');
    }
  }
  return buffer.toString();
}

String _formatDateTime(String dateStr) {
  try {
    final DateTime date = DateTime.parse(dateStr);
    return AppDateUtils.formatLunarDate(date);
  } catch (_) {
    return dateStr;
  }
}
