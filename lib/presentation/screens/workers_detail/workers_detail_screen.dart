import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/entity/user.dart';
import 'package:axis_crm/presentation/cubits/workers_detail/workers_detail_cubit.dart';
import 'package:axis_crm/presentation/screens/admin_advance_screen/admin_advance_screen.dart';
import 'package:axis_crm/presentation/screens/admin_worksheet_screen/admin_worksheet_screen.dart';
import 'package:axis_crm/presentation/screens/workers_edit/workers_edit_screen.dart';
import 'package:axis_crm/presentation/widgets/app_button.dart';
import 'package:axis_crm/presentation/widgets/page_title.dart';
import 'package:axis_crm/presentation/widgets/section_card.dart';
import 'package:axis_crm/presentation/screens/yearly_summary/yearly_summary_screen.dart';

class WorkersDetailScreen extends StatelessWidget {
  const WorkersDetailScreen({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkersDetailCubit>(
      create: (_) {
        return WorkersDetailCubit(user: user, apiClient: getIt<ApiClient>());
      },
      child: const _WorkersDetailView(),
    );
  }
}

class _WorkersDetailView extends StatelessWidget {
  const _WorkersDetailView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkersDetailCubit, WorkersDetailState>(
      builder: (BuildContext context, WorkersDetailState state) {
        final WorkersDetailCubit cubit = context.read<WorkersDetailCubit>();
        return Scaffold(
          backgroundColor: const Color(0xFFF4F7FC),
          appBar: AppBar(
            title: const PageTitle(title: 'Chi tiết thợ'),
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
                Text(
                  'Tên thợ: ${state.user.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF17233C),
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  'Biệt danh: ${state.user.nickname ?? 'Chưa thiết lập'}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF17233C),
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  'SĐT: ${state.user.phone}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF17233C),
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  'Lương mặc định: ${state.user.defaultDailyRate != null ? "${_formatMoney(state.user.defaultDailyRate!)} vnđ/ngày" : "Chưa cài đặt"}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF17233C),
                  ),
                ),
                const SizedBox(height: 16),

                AppButton(
                  label: 'Tổng kết năm',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => YearlySummaryScreen(targetUser: state.user),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                AppButton(
                  label: 'Chỉnh sửa',
                  onPressed: () async {
                    final updatedUser = await Navigator.of(context).push<User>(
                      MaterialPageRoute<User>(
                        builder: (_) => WorkersEditScreen(user: state.user),
                      ),
                    );
                    if (updatedUser != null) {
                      cubit.updateUser(updatedUser);
                      cubit.refresh();
                    }
                  },
                ),
                const SizedBox(height: 16),

                Row(
                  children: <Widget>[
                    Expanded(
                      child: AppButton(
                        label: 'Chấm công',
                        onPressed: () async {
                          final result = await Navigator.of(context).push<bool>(
                            MaterialPageRoute<bool>(
                              builder: (_) => AdminWorksheetScreen(
                                userId: cubit.state.userId,
                                userName: state.user.name,
                              ),
                            ),
                          );
                          if (result == true) {
                            cubit.refresh();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppButton(
                        label: 'Ứng tiền',
                        onPressed: () async {
                          final result = await Navigator.of(context).push<bool>(
                            MaterialPageRoute<bool>(
                              builder: (_) => AdminAdvanceScreen(
                                userId: cubit.state.userId,
                                userName: state.user.name,
                              ),
                            ),
                          );
                          if (result == true) {
                            cubit.refresh();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _AttendanceCalendar(
                  month: state.month,
                  attendanceDays: state.attendanceDays,
                  fullDays: state.fullDays,
                  halfDays: state.halfDays,
                  absentDays: state.absentDays,
                  onPrevious: cubit.previousMonth,
                  onNext: cubit.nextMonth,
                ),
                const SizedBox(height: 16),
                _WorkerAdvanceRecordsSection(
                  records: state.workerAdvanceRecords,
                  isLoading: state.isLoading,
                  hasMore: state.hasMoreWorkerAdvanceRecords,
                  onLoadMore: cubit.loadMoreWorkerAdvanceRecords,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatMoney(int value) {
    final String str = value.toString();
    final StringBuffer result = StringBuffer();
    final int length = str.length;
    for (int i = 0; i < length; i++) {
      if (i > 0 && (length - i) % 3 == 0) {
        result.write('.');
      }
      result.write(str[i]);
    }
    return result.toString();
  }
}

class _WorkerAdvanceRecordsSection extends StatelessWidget {
  const _WorkerAdvanceRecordsSection({
    required this.records,
    required this.isLoading,
    required this.hasMore,
    required this.onLoadMore,
  });

  final List<WorkerAdvanceItem> records;
  final bool isLoading;
  final bool hasMore;
  final VoidCallback onLoadMore;

  int get _totalAmount => records.fold(
    0,
    (sum, r) => sum + (r.amount ?? r.contractorAmount ?? r.workerAmount ?? 0),
  );

  String get _formattedTotal {
    final String str = _totalAmount.toString();
    final StringBuffer result = StringBuffer();
    final int length = str.length;
    for (int i = 0; i < length; i++) {
      if (i > 0 && (length - i) % 3 == 0) {
        result.write('.');
      }
      result.write(str[i]);
    }
    return '$result vnđ';
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading && records.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (records.isEmpty) {
      return SectionCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Text(
            'Chưa có đơn ứng tiền nào',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    return Column(
      children: <Widget>[
        SectionCard(
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Color(0xFF2563EB),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Tổng tiền ứng tháng này',
                      style: TextStyle(fontSize: 12, color: Color(0xFF667085)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _formattedTotal,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF17233C),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ...records.map(_WorkerAdvanceItem.new),
        if (hasMore)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: AppButton(label: 'Tải thêm', onPressed: onLoadMore),
          ),
      ],
    );
  }
}

class _WorkerAdvanceItem extends StatelessWidget {
  const _WorkerAdvanceItem(this.record);

  final WorkerAdvanceItem record;

  @override
  Widget build(BuildContext context) {
    final int displayAmount =
        record.amount ?? record.contractorAmount ?? record.workerAmount ?? 0;
    final String formattedAmount = _formatCurrency(displayAmount);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5EAF3)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF2563EB).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.payments_outlined,
              color: Color(0xFF2563EB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _formatDate(record.date),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF17233C),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Số tiền: $formattedAmount',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF667085),
                  ),
                ),
                if (record.contractorNote != null &&
                    record.contractorNote!.isNotEmpty) ...<Widget>[
                  const SizedBox(height: 2),
                  Text(
                    'Ghi chú: ${record.contractorNote}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF667085),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(int amount) {
    final String str = amount.toString();
    final StringBuffer result = StringBuffer();
    final int length = str.length;
    for (int i = 0; i < length; i++) {
      if (i > 0 && (length - i) % 3 == 0) {
        result.write('.');
      }
      result.write(str[i]);
    }
    return '$result vnđ';
  }

  String _formatDate(String dateStr) {
    try {
      final DateTime date = DateTime.parse(dateStr);
      final String day = date.day.toString().padLeft(2, '0');
      final String month = date.month.toString().padLeft(2, '0');
      return '$day/$month/${date.year}';
    } catch (_) {
      return dateStr;
    }
  }
}

class _AttendanceCalendar extends StatelessWidget {
  const _AttendanceCalendar({
    required this.month,
    required this.attendanceDays,
    required this.fullDays,
    required this.halfDays,
    required this.absentDays,
    required this.onPrevious,
    required this.onNext,
  });

  final DateTime month;
  final List<WorkerAttendanceDay> attendanceDays;
  final int fullDays;
  final int halfDays;
  final int absentDays;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final List<WorkerAttendanceDay> days = _buildAttendanceDays(
      month,
      attendanceDays,
    );

    return SectionCard(
      child: Column(
        children: <Widget>[
          Row(
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
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              IconButton(
                onPressed: onNext,
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
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              _StatItem(
                label: 'Cả ngày',
                value: fullDays,
                color: const Color(0xFF2563EB),
              ),
              const SizedBox(width: 16),
              _StatItem(
                label: 'Nửa ngày',
                value: halfDays,
                color: const Color(0xFF8B9AAF),
              ),
              const SizedBox(width: 16),
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

  List<WorkerAttendanceDay> _buildAttendanceDays(
    DateTime month,
    List<WorkerAttendanceDay> attendanceDays,
  ) {
    final int totalDays = DateTime(month.year, month.month + 1, 0).day;
    final int firstWeekday = DateTime(month.year, month.month).weekday;

    final Map<int, WorkerAttendanceDay> attendanceByDay =
        <int, WorkerAttendanceDay>{
          for (final WorkerAttendanceDay item in attendanceDays) item.day: item,
        };

    final List<WorkerAttendanceDay> result = <WorkerAttendanceDay>[
      for (int i = 1; i < firstWeekday; i++)
        WorkerAttendanceDay(day: 0, shift: '', status: ''),
    ];

    for (int day = 1; day <= totalDays; day++) {
      final WorkerAttendanceDay? dayData = attendanceByDay[day];
      result.add(
        dayData ?? WorkerAttendanceDay(day: day, shift: '', status: ''),
      );
    }

    return result;
  }
}

class _AttendanceTile extends StatelessWidget {
  const _AttendanceTile({required this.day});

  final WorkerAttendanceDay day;

  @override
  Widget build(BuildContext context) {
    if (day.day == 0) {
      return const SizedBox.shrink();
    }

    final bool isWorked =
        day.shift == 'full' || day.shift == 'half' || day.shift == 'absent';

    final BoxDecoration decoration = switch (day.shift) {
      'full' => BoxDecoration(
        color: const Color(0xFF2563EB),
        borderRadius: BorderRadius.circular(8),
      ),
      'absent' => BoxDecoration(
        color: const Color(0xFFE5484D),
        borderRadius: BorderRadius.circular(8),
      ),
      'half' => BoxDecoration(
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
      _ => BoxDecoration(
        border: Border.all(color: const Color(0xFF2563EB), width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
    };

    return Container(
      alignment: Alignment.center,
      decoration: decoration,
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: isWorked ? Colors.white : const Color(0xFF2563EB),
          fontWeight: FontWeight.w800,
        ),
      ),
    );
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
