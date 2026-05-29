import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/entity/daily_summary.dart';
import 'package:axis_crm/entity/user.dart';

import '../../blocs/home/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => HomeCubit(user: user, apiClient: getIt<ApiClient>()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, HomeState state) {
        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Xin chào',
                          style: TextStyle(
                            color: Color(0xFF7A879B),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          state.user.name,
                          style: const TextStyle(
                            color: Color(0xFF17233C),
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton.filledTonal(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _AccumulatedCard(amount: state.accumulatedAmount),
              const SizedBox(height: 20),
              _AttendanceCalendar(
                month: state.homeMonth,
                attendanceDays: state.attendanceDays,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AccumulatedCard extends StatelessWidget {
  const _AccumulatedCard({required this.amount});

  final int amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF2457D6),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x262457D6),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.savings_outlined, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Số tiền đã tích luỹ trong năm nay',
                  style: TextStyle(
                    color: Color(0xFFDDE7FF),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${_formatMoney(amount)} VND',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendanceCalendar extends StatelessWidget {
  const _AttendanceCalendar({
    required this.month,
    required this.attendanceDays,
  });

  final DateTime month;
  final List<DailySummary> attendanceDays;

  @override
  Widget build(BuildContext context) {
    final List<AttendanceDay> days = _buildAttendanceDays(
      month,
      attendanceDays,
    );

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                onPressed: context.read<HomeCubit>().previousHomeMonth,
                icon: const Icon(Icons.chevron_left),
              ),
              Expanded(
                child: Text(
                  'Tháng ${month.month}/${month.year}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF17233C),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              IconButton(
                onPressed: context.read<HomeCubit>().nextHomeMonth,
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
              return _AttendanceTile(day: days[index]);
            },
          ),
          const SizedBox(height: 14),
          const Wrap(
            spacing: 14,
            runSpacing: 8,
            children: <Widget>[
              _Legend(color: Color(0xFF2563EB), label: 'Đi làm'),
              _Legend(color: Color(0xFFE5484D), label: 'Nghỉ'),
              _Legend(color: Color(0xFF8B9AAF), label: 'Nửa ngày'),
            ],
          ),
        ],
      ),
    );
  }
}

class _AttendanceTile extends StatelessWidget {
  const _AttendanceTile({required this.day});

  final AttendanceDay day;

  @override
  Widget build(BuildContext context) {
    if (day.type == AttendanceType.empty) {
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
      AttendanceType.empty => const BoxDecoration(),
    };

    return Container(
      alignment: Alignment.center,
      decoration: decoration,
      child: Text(
        '${day.day}',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF667085),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
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

List<AttendanceDay> _buildAttendanceDays(
  DateTime month,
  List<DailySummary> attendanceDays,
) {
  final int totalDays = DateTime(month.year, month.month + 1, 0).day;
  final int firstWeekday = DateTime(month.year, month.month).weekday;
  final Map<int, AttendanceType> attendanceByDay = <int, AttendanceType>{
    for (final DailySummary item in attendanceDays)
      if (item.date.year == month.year && item.date.month == month.month)
        item.date.day: _typeFromShiftValue(item.shiftValue),
  };
  final List<AttendanceDay> days = <AttendanceDay>[
    for (int i = 1; i < firstWeekday; i++)
      const AttendanceDay(day: 0, type: AttendanceType.empty),
  ];

  for (int day = 1; day <= totalDays; day++) {
    final AttendanceType type = attendanceByDay[day] ?? AttendanceType.empty;
    days.add(AttendanceDay(day: day, type: type));
  }

  return days;
}

AttendanceType _typeFromShiftValue(int value) {
  if (value >= 1) return AttendanceType.worked;
  if (value > 0) return AttendanceType.half;
  return AttendanceType.absent;
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
