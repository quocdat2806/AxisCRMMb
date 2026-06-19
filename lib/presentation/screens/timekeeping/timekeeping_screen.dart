import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/time_keeping/time_keeping_cubit.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/section_card.dart';
import '../../widgets/page_title.dart';
import '../../widgets/app_date_picker_dialog.dart';

class TimekeepingScreen extends StatelessWidget {
  const TimekeepingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimeKeepingCubit>(
      create: (_) => TimeKeepingCubit(),
      child: const _TimeKeepingView(),
    );
  }
}

class _TimeKeepingView extends StatelessWidget {
  const _TimeKeepingView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimeKeepingCubit, TimeKeepingState>(
      listener: (context, state) {
        if (state.timeKeepingSubmitted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Chấm công thành công'),
              backgroundColor: Colors.green,
            ),
          );
          context.read<TimeKeepingCubit>().clearTimeKeepingMessage();
        }
        if (state.submitError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.submitError}'),
              backgroundColor: Colors.red,
            ),
          );
          context.read<TimeKeepingCubit>().clearTimeKeepingMessage();
        }
      },
      builder: (BuildContext context, TimeKeepingState state) {
        final TimeKeepingCubit cubit = context.read<TimeKeepingCubit>();

        return Scaffold(
          backgroundColor: const Color(0xFFF4F7FC),
          appBar: AppBar(
            title: const PageTitle(title: 'Chấm công'),
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
                SectionCard(
                  child: Column(
                    spacing: 18,
                    children: <Widget>[
                      _DateField(
                        label: 'Ngày chấm công',
                        date: state.timeKeepingDate,
                        onPicked: cubit.timeKeepingDateChanged,
                      ),
                      _TimeKeepingTypeDropdown(
                        label: 'Loại chấm công',
                        value: state.timeKeepingType,
                        onChanged: cubit.timeKeepingTypeChanged,
                      ),
                      AppTextField(
                        label: 'Ghi chú (nếu có)',
                        hintText: 'Nhập ghi chú',
                        prefixIcon: Icons.edit_note_outlined,
                        textInputAction: TextInputAction.done,
                        onChanged: cubit.timeKeepingReasonChanged,
                      ),
                      AppButton(
                        label: 'Chấm công',
                        isLoading: state.isSubmitting,
                        onPressed: state.isSubmitting
                            ? null
                            : cubit.submitTimeKeepingRequest,
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

class _TimeKeepingTypeDropdown extends StatelessWidget {
  const _TimeKeepingTypeDropdown({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String value;
  final ValueChanged<String> onChanged;

  static const List<String> types = <String>['Cả ngày', 'Nửa ngày', 'Nghỉ'];

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF344054),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFCDD1DE)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFF667299),
              ),
              items: types.map((String type) {
                return DropdownMenuItem<String>(value: type, child: Text(type));
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) onChanged(newValue);
              },
            ),
          ),
        ),
      ],
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
}

String _formatDate(DateTime date) {
  final String day = date.day.toString().padLeft(2, '0');
  final String month = date.month.toString().padLeft(2, '0');
  return '$day/$month/${date.year}';
}
