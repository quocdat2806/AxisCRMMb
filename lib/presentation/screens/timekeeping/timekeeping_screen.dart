import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/leave/leave_cubit.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class TimekeepingScreen extends StatelessWidget {
  const TimekeepingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LeaveCubit>(
      create: (_) => LeaveCubit(),
      child: const _LeaveView(),
    );
  }
}

class _LeaveView extends StatelessWidget {
  const _LeaveView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeaveCubit, LeaveState>(
      listener: (context, state) {
        if (state.leaveSubmitted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Đã gửi yêu cầu nghỉ')));
          context.read<LeaveCubit>().clearLeaveMessage();
        }
      },
      builder: (BuildContext context, LeaveState state) {
        final LeaveCubit cubit = context.read<LeaveCubit>();

        return ListView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
          children: <Widget>[
            const _PageTitle(title: 'Đăng ký nghỉ'),
            const SizedBox(height: 16),
            _SectionCard(
              child: Column(
                children: <Widget>[
                  _DateField(
                    label: 'Ngày nghỉ',
                    date: state.leaveDate,
                    onPicked: cubit.leaveDateChanged,
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    label: 'Lý do nghỉ',
                    hintText: 'Nhập lý do nghỉ',
                    prefixIcon: Icons.edit_note_outlined,
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                    onChanged: cubit.leaveReasonChanged,
                  ),
                  const SizedBox(height: 18),
                  AppButton(
                    label: 'Gửi duyệt',
                    onPressed: state.leaveReason.trim().isEmpty
                        ? null
                        : cubit.submitLeaveRequest,
                  ),
                ],
              ),
            ),
          ],
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

class _PageTitle extends StatelessWidget {
  const _PageTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF17233C),
        fontSize: 24,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

String _formatDate(DateTime date) {
  final String day = date.day.toString().padLeft(2, '0');
  final String month = date.month.toString().padLeft(2, '0');
  return '$day/$month/${date.year}';
}
