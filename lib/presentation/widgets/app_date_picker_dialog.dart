import 'package:axis_crm/core/utils/date_until.dart';
import 'package:axis_crm/presentation/widgets/app_grid.dart';
import 'package:flutter/material.dart';

class AppDatePickerDialog extends StatefulWidget {
  final DateTime? initialDate;

  const AppDatePickerDialog({super.key, this.initialDate});

  @override
  State<AppDatePickerDialog> createState() => _AppDatePickerDialogState();
}

class _AppDatePickerDialogState extends State<AppDatePickerDialog> {
  late DateTime _selectedDate;
  late DateTime _displayMonth;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _displayMonth = DateTime(_selectedDate.year, _selectedDate.month);
  }

  void _changeMonth(int delta) {
    setState(() {
      _displayMonth = DateTime(_displayMonth.year, _displayMonth.month + delta);
    });
  }

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(_displayMonth.year, _displayMonth.month);
    final lastDayOfMonth = DateTime(
      _displayMonth.year,
      _displayMonth.month + 1,
      0,
    );
    final daysInMonth = lastDayOfMonth.day;
    final firstWeekday = ((firstDayOfMonth.weekday - 1) % 7);

    return Scaffold(
      backgroundColor: Color(0x80000000),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppDateUtils.formatHeaderDate(_selectedDate),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF17233C),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Tháng ${_displayMonth.month} Năm ${_displayMonth.year}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF17233C),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 8,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            _changeMonth(-1);
                          },
                          child: const Icon(Icons.arrow_back_ios_new, size: 16),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            _changeMonth(1);
                          },
                          child: const Icon(Icons.arrow_forward_ios, size: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                AppGrid(
                  itemHeightFactor: 0.9,
                  crossAxisCount: 7,
                  itemCount: 7 + firstWeekday + daysInMonth,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index < 7) {
                      return Center(
                        child: Text(
                          AppDateUtils.weekdays[index],
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF17233C),
                          ),
                        ),
                      );
                    }

                    final dayIndex = index - 7 - firstWeekday;
                    if (dayIndex < 0 || dayIndex >= daysInMonth) {
                      return const SizedBox();
                    }

                    final day = dayIndex + 1;
                    final date = DateTime(
                      _displayMonth.year,
                      _displayMonth.month,
                      day,
                    );
                    final isSelected = AppDateUtils.isSameDate(
                      date,
                      _selectedDate,
                    );

                    return InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        final date = DateTime(
                          _displayMonth.year,
                          _displayMonth.month,
                          day,
                        );
                        setState(() {
                          _selectedDate = date;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Color(0xFF2563EB)
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '$day',
                            style: isSelected
                                ? TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  )
                                : TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF17233C),
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Text('Hủy', textAlign: TextAlign.center),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(_selectedDate),
                        child: Text('Xác nhận', textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
