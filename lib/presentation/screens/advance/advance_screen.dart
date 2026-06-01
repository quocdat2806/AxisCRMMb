import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/advance/advance_cubit.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/page_title.dart';

class AdvanceScreen extends StatelessWidget {
  const AdvanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdvanceCubit>(
      create: (_) => AdvanceCubit(),
      child: const _AdvanceView(),
    );
  }
}

class _AdvanceView extends StatelessWidget {
  const _AdvanceView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdvanceCubit, AdvanceState>(
      builder: (BuildContext context, AdvanceState state) {
        final AdvanceCubit cubit = context.read<AdvanceCubit>();
        final List<AdvanceRequest> advances = state.filteredAdvances;

        return Scaffold(
          backgroundColor: const Color(0xFFF4F7FC),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => BlocProvider<AdvanceCubit>.value(
                    value: context.read<AdvanceCubit>(),
                    child: const _CreateAdvanceScreen(),
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(18),
              children: <Widget>[
                const PageTitle(title: 'Danh sách ứng tiền'),
                const SizedBox(height: 16),
                _MonthSwitcher(
                  month: state.advanceMonth,
                  onPrevious: cubit.previousAdvanceMonth,
                  onNext: cubit.nextAdvanceMonth,
                ),
                const SizedBox(height: 14),
                _SectionCard(
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.account_balance_wallet_outlined),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Tổng ứng trong tháng',
                          style: TextStyle(
                            color: Color(0xFF667085),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        '${_formatMoney(state.monthlyAdvanceTotal)} đ',
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
                if (advances.isEmpty)
                  const _EmptyState(
                    message: 'Chưa có khoản ứng nào trong tháng',
                  )
                else
                  ...advances.map(_AdvanceItem.new),
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

  final AdvanceRequest item;

  @override
  Widget build(BuildContext context) {
    final Color statusColor = switch (item.status) {
      AdvanceStatus.pending => const Color(0xFFF59E0B),
      AdvanceStatus.approved => const Color(0xFF16A34A),
      AdvanceStatus.rejected => const Color(0xFFE5484D),
    };
    final String statusText = switch (item.status) {
      AdvanceStatus.pending => 'Đang chờ',
      AdvanceStatus.approved => 'Đã duyệt',
      AdvanceStatus.rejected => 'Từ chối',
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: _SectionCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text(
                    '${_formatMoney(item.amount)} đ',
                    style: const TextStyle(
                      color: Color(0xFF17233C),
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_formatDate(item.date)} • ${item.reason}',
                    style: const TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                statusText,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateAdvanceScreen extends StatelessWidget {
  const _CreateAdvanceScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdvanceCubit, AdvanceState>(
      builder: (BuildContext context, AdvanceState state) {
        final AdvanceCubit cubit = context.read<AdvanceCubit>();

        return Scaffold(
          backgroundColor: const Color(0xFFF4F7FC),
          appBar: AppBar(
            title: const Text('Tạo ứng tiền'),
            backgroundColor: const Color(0xFFF4F7FC),
          ),
          body: ListView(
            padding: const EdgeInsets.all(18),
            children: <Widget>[
              _SectionCard(
                child: Column(
                  children: <Widget>[
                    AppTextField(
                      label: 'Số tiền ứng',
                      hintText: 'Nhập số tiền',
                      prefixIcon: Icons.payments_outlined,
                      keyboardType: TextInputType.number,
                      onChanged: cubit.advanceAmountChanged,
                    ),
                    const SizedBox(height: 14),
                    AppTextField(
                      label: 'Lý do ứng tiền',
                      hintText: 'Nhập lý do nếu có',
                      prefixIcon: Icons.notes_outlined,
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
                      onPressed: state.advanceAmount.trim().isEmpty
                          ? null
                          : () {
                              cubit.createAdvance();
                              Navigator.of(context).pop();
                            },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
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
      prefixIcon: Icons.calendar_today_outlined,
      suffixIcon: Icons.keyboard_arrow_down,
      readOnly: true,
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2020),
          lastDate: DateTime(2035),
        );
        if (picked != null) onPicked(picked);
      },
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
    return _SectionCard(
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: onPrevious,
            icon: const Icon(Icons.chevron_left),
          ),
          Expanded(
            child: Text(
              'Tháng ${month.month}/${month.year}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF17233C),
                fontSize: 17,
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

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5EAF3)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0F101828),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF98A2B3),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
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

String _formatDate(DateTime date) {
  final String day = date.day.toString().padLeft(2, '0');
  final String month = date.month.toString().padLeft(2, '0');
  return '$day/$month/${date.year}';
}
