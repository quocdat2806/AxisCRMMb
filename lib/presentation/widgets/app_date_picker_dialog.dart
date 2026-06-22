import 'package:axis_crm/core/utils/date_until.dart';
import 'package:axis_crm/presentation/widgets/app_grid.dart';
import 'package:flutter/material.dart';
import 'package:lunar/lunar.dart';

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
    _displayMonth = AppDateUtils.getFirstDayOfLunarMonth(_selectedDate);
  }

  void _changeMonth(int delta) {
    setState(() {
      if (delta == -1) {
        _displayMonth = AppDateUtils.previousLunarMonth(_displayMonth);
      } else {
        _displayMonth = AppDateUtils.nextLunarMonth(_displayMonth);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<DateTime?> lunarGridDays = AppDateUtils.generateLunarCalendarDays(_displayMonth);

    return Scaffold(
      backgroundColor: const Color(0x80000000),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppDateUtils.formatLunarHeaderDate(_selectedDate),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF17233C),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppDateUtils.formatLunarMonthHeader(_displayMonth),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF17233C),
                      ),
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
                  itemCount: 7 + lunarGridDays.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index < 7) {
                      return Center(
                        child: Text(
                          AppDateUtils.weekdays[index],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF17233C),
                          ),
                        ),
                      );
                    }

                    final dateIndex = index - 7;
                    final date = lunarGridDays[dateIndex];
                    if (date == null) {
                      return const SizedBox();
                    }

                    final isSelected = AppDateUtils.isSameDate(
                      date,
                      _selectedDate,
                    );

                    final lunar = Lunar.fromDate(date);
                    final int lunarDay = lunar.getDay();

                    return InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          _selectedDate = date;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF2563EB)
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '$lunarDay',
                            style: isSelected
                                ? const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  )
                                : const TextStyle(
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
                        child: const Text('Hủy', textAlign: TextAlign.center),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(_selectedDate),
                        child: const Text('Xác nhận', textAlign: TextAlign.center),
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
