import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/entity/user.dart';
import 'package:axis_crm/presentation/cubits/worksheet/worksheet_cubit.dart';
import 'package:axis_crm/presentation/widgets/app_button.dart';
import 'package:axis_crm/presentation/widgets/page_title.dart';
import 'package:axis_crm/presentation/widgets/section_card.dart';
import 'package:axis_crm/core/utils/date_until.dart';
import 'package:lunar/lunar.dart';
import '../timekeeping/timekeeping_screen.dart';

class WorksheetScreen extends StatelessWidget {
  const WorksheetScreen({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorksheetCubit>(
      create: (_) => WorksheetCubit(user: user, apiClient: getIt<ApiClient>()),
      child: const _WorksheetView(),
    );
  }
}

class _WorksheetView extends StatelessWidget {
  const _WorksheetView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorksheetCubit, WorksheetState>(
      builder: (BuildContext context, WorksheetState state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF4F7FC),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(18),
                    children: <Widget>[
                      PageTitle(title: 'Bảng công'),
                      const SizedBox(height: 20),
                      _AttendanceCalendar(
                        month: state.currentMonth,
                        attendanceDays: state.attendanceDays,
                        fullDays: state.fullDays,
                        halfDays: state.halfDays,
                        absentDays: state.absentDays,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: AppButton(
                    label: 'Chấm công',
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const TimekeepingScreen(),
                        ),
                      );
                      if (context.mounted) {
                        context.read<WorksheetCubit>().loadWorksheet();
                      }
                    },
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

class _AttendanceCalendar extends StatelessWidget {
  const _AttendanceCalendar({
    required this.month,
    required this.attendanceDays,
    required this.fullDays,
    required this.halfDays,
    required this.absentDays,
  });

  final DateTime month;
  final List<AttendanceDay> attendanceDays;
  final int fullDays;
  final int halfDays;
  final int absentDays;

  @override
  Widget build(BuildContext context) {
    final List<AttendanceDay> days = _buildAttendanceDays(
      month,
      attendanceDays,
    );

    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                onPressed: context.read<WorksheetCubit>().previousMonth,
                icon: const Icon(Icons.chevron_left),
              ),
              Expanded(
                child: Text(
                  AppDateUtils.formatLunarMonthHeader(month),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF17233C),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              IconButton(
                onPressed: context.read<WorksheetCubit>().nextMonth,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: days.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (_, int index) {
              return _AttendanceTile(day: days[index], month: month);
            },
          ),

          const SizedBox(height: 16),
          Row(
            spacing: 16,
            children: <Widget>[
              _StatItem(
                label: 'Cả ngày',
                value: fullDays,
                color: const Color(0xFF2563EB),
              ),
              _StatItem(
                label: 'Nửa ngày',
                value: halfDays,
                color: const Color(0xFF8B9AAF),
              ),
              _StatItem(
                label: 'Nghỉ',
                value: absentDays,
                color: const Color(0xFFE5484D),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AttendanceTile extends StatelessWidget {
  const _AttendanceTile({required this.day, required this.month});

  final AttendanceDay day;
  final DateTime month;

  @override
  Widget build(BuildContext context) {
    if (day.day == 0) {
      return const SizedBox.shrink();
    }

    final BoxDecoration decoration = switch (day.type) {
      AttendanceType.worked => BoxDecoration(
        color: const Color(0xFF2563EB),
        borderRadius: BorderRadius.circular(8),
      ),
      AttendanceType.absent => BoxDecoration(
        color: const Color(0xFFE5484D),
        borderRadius: BorderRadius.circular(8),
      ),
      AttendanceType.half => BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[
            Color(0xFF2563EB),
            Color(0xFF2563EB),
            Color(0xFFE5484D),
            Color(0xFFE5484D),
          ],
          stops: <double>[0, 0.5, 0.5, 1],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      AttendanceType.empty => BoxDecoration(
        border: Border.all(color: const Color(0xFF2563EB), width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
    };

    final DateTime cellDate = day.date ?? DateTime(month.year, month.month, day.day);
    final Lunar lunar = Lunar.fromDate(cellDate);
    final String displayLabel = '${lunar.getDay()}';

    return GestureDetector(
      onTap: () => _showDayDetailDialog(context),
      child: Container(
        alignment: Alignment.center,
        decoration: decoration,
        child: Text(
          displayLabel,
          style: TextStyle(
            color: day.type == AttendanceType.empty
                ? const Color(0xFF2563EB)
                : Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  void _showDayDetailDialog(BuildContext context) {
    final DateTime cellDate = day.date ?? DateTime(month.year, month.month, day.day);
    final Lunar lunar = Lunar.fromDate(cellDate);
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text('Ngày ${lunar.getDay()}/${lunar.getMonth()}/${lunar.getYear()} (Âm lịch)'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Loại: ${_getShiftLabel(day.type)}'),
              if (day.note != null && day.note!.isNotEmpty) ...<Widget>[
                const SizedBox(height: 8),
                Text('Ghi chú: ${day.note}'),
              ] else ...<Widget>[
                const SizedBox(height: 8),
                const Text('Không có ghi chú'),
              ],
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  String _getShiftLabel(AttendanceType type) {
    switch (type) {
      case AttendanceType.worked:
        return 'Cả ngày';
      case AttendanceType.half:
        return 'Nửa ngày';
      case AttendanceType.absent:
        return 'Nghỉ';
      default:
        return 'Chua có dữ liệu';
    }
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
            Text(
              '$value',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF667085),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<AttendanceDay> _buildAttendanceDays(
  DateTime month,
  List<AttendanceDay> attendanceDays,
) {
  final List<DateTime?> lunarGridDays = AppDateUtils.generateLunarCalendarDays(month);

  final Map<String, AttendanceDay> attendanceByDate = <String, AttendanceDay>{
    for (final AttendanceDay item in attendanceDays)
      if (item.date != null) '${item.date!.year}-${item.date!.month}-${item.date!.day}': item,
  };

  final List<AttendanceDay> days = <AttendanceDay>[];

  for (final DateTime? date in lunarGridDays) {
    if (date == null) {
      days.add(const AttendanceDay(day: 0, type: AttendanceType.empty));
    } else {
      final String key = '${date.year}-${date.month}-${date.day}';
      final AttendanceDay? dayData = attendanceByDate[key];
      if (dayData != null) {
        days.add(dayData);
      } else {
        days.add(AttendanceDay(day: date.day, type: AttendanceType.empty, date: date));
      }
    }
  }

  return days;
}
