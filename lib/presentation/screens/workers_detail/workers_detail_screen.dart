import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/entity/user.dart';
import 'package:axis_crm/presentation/cubits/workers_detail/workers_detail_cubit.dart';
import 'package:axis_crm/presentation/screens/admin_advance_screen/admin_advance_screen.dart';
import 'package:axis_crm/presentation/screens/admin_worksheet_screen/admin_worksheet_screen.dart';
import 'package:axis_crm/presentation/widgets/app_button.dart';
import 'package:axis_crm/presentation/widgets/page_title.dart';
import 'package:axis_crm/presentation/widgets/section_card.dart';
import 'package:axis_crm/presentation/screens/yearly_summary/yearly_summary_screen.dart';
import 'package:axis_crm/presentation/cubits/workers_edit/workers_edit_cubit.dart';
import 'package:axis_crm/presentation/widgets/app_text_field.dart';
import 'package:axis_crm/presentation/widgets/money_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:axis_crm/core/utils/date_until.dart';
import 'package:lunar/lunar.dart';

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
        final String displayName = state.user.nickname ?? state.user.name;

        return DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: const Color(0xFFF4F7FC),
            appBar: AppBar(
              title: PageTitle(title: 'Chi tiết thợ - $displayName'),
              backgroundColor: const Color(0xFFF4F7FC),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF17233C)),
                onPressed: () => Navigator.of(context).pop(),
              ),
              bottom: const TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.center,
                labelColor: Color(0xFF2563EB),
                unselectedLabelColor: Color(0xFF667085),
                indicatorColor: Color(0xFF2563EB),
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                tabs: [
                  Tab(text: 'Chấm công'),
                  Tab(text: 'Ứng tiền'),
                  Tab(text: 'Thông tin'),
                  Tab(text: 'Tổng kết năm'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _TimekeepingTab(state: state, cubit: cubit),
                _AdvanceTab(state: state, cubit: cubit),
                _InfoTab(
                  user: state.user,
                  onUpdated: (updatedUser) {
                    cubit.updateUser(updatedUser);
                    cubit.refresh();
                  },
                ),
                YearlySummaryScreen(
                  targetUser: state.user,
                  isTab: true,
                  key: ValueKey(state.user),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TimekeepingTab extends StatelessWidget {
  const _TimekeepingTab({required this.state, required this.cubit});

  final WorkersDetailState state;
  final WorkersDetailCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: <Widget>[
              _AttendanceCalendar(
                month: state.month,
                attendanceDays: state.attendanceDays,
                fullDays: state.fullDays,
                halfDays: state.halfDays,
                absentDays: state.absentDays,
                onPrevious: cubit.previousMonth,
                onNext: cubit.nextMonth,
              ),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
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
        ),
      ],
    );
  }
}

class _AdvanceTab extends StatelessWidget {
  const _AdvanceTab({required this.state, required this.cubit});

  final WorkersDetailState state;
  final WorkersDetailCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: <Widget>[
              SectionCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: cubit.previousMonth,
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Color(0xFF17233C),
                      ),
                    ),
                    Text(
                      AppDateUtils.formatLunarMonthHeader(state.month),
                      style: const TextStyle(
                        color: Color(0xFF17233C),
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    IconButton(
                      onPressed: cubit.nextMonth,
                      icon: const Icon(
                        Icons.chevron_right,
                        color: Color(0xFF17233C),
                      ),
                    ),
                  ],
                ),
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
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
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
        ),
      ],
    );
  }
}

class _InfoTab extends StatelessWidget {
  const _InfoTab({required this.user, required this.onUpdated});

  final User user;
  final ValueChanged<User> onUpdated;

  @override
  Widget build(BuildContext context) {
    final String formattedRate = user.defaultDailyRate != null
        ? _formatMoney(user.defaultDailyRate!)
        : '';

    return BlocProvider<WorkersEditCubit>(
      create: (_) => WorkersEditCubit(
        apiClient: getIt<ApiClient>(),
        user: user,
        currentDailyRate: formattedRate,
      ),
      child: _InfoTabView(
        initialNickname: user.nickname ?? '',
        initialDailyRate: formattedRate,
        user: user,
        onUpdated: onUpdated,
      ),
    );
  }

  static String _formatMoney(int value) {
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

class _InfoTabView extends StatefulWidget {
  const _InfoTabView({
    required this.initialNickname,
    required this.initialDailyRate,
    required this.user,
    required this.onUpdated,
  });

  final String initialNickname;
  final String initialDailyRate;
  final User user;
  final ValueChanged<User> onUpdated;

  @override
  State<_InfoTabView> createState() => _InfoTabViewState();
}

class _InfoTabViewState extends State<_InfoTabView> {
  late final TextEditingController _nicknameController;
  late final TextEditingController _dailyRateController;

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController(text: widget.initialNickname);
    _dailyRateController = TextEditingController(text: widget.initialDailyRate);
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _dailyRateController.dispose();
    super.dispose();
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        await launchUrl(launchUri);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Không thể gọi số: $phoneNumber. Lỗi: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkersEditCubit, WorkersEditState>(
      listener: (context, state) {
        if (state.submitSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cập nhật thông tin thành công'),
              backgroundColor: Colors.green,
            ),
          );
          widget.onUpdated(state.updatedUser!);
        }
        if (state.submitError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Lỗi: ${state.submitError}'),
              backgroundColor: Colors.red,
            ),
          );
          context.read<WorkersEditCubit>().clearError();
        }
      },
      builder: (BuildContext context, WorkersEditState state) {
        final WorkersEditCubit editCubit = context.read<WorkersEditCubit>();

        return ListView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 38),
          children: <Widget>[
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Tên thợ: ${widget.user.name}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF17233C),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Số điện thoại: ${widget.user.phone}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF667085),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.phone, color: Color(0xFF2457D6)),
                        onPressed: () => _makePhoneCall(widget.user.phone),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 24,
                    thickness: 1,
                    color: Color(0xFFE4E7EC),
                  ),
                  AppTextField(
                    label: 'Biệt danh',
                    hintText: 'Nhập biệt danh công nhân',
                    controller: _nicknameController,
                    prefixIcon: Icons.person_outline,
                    onChanged: editCubit.nicknameChanged,
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    label: 'Lương mặc định / ngày (vnđ)',
                    hintText: 'Nhập số tiền lương 1 ngày',
                    controller: _dailyRateController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [MoneyInputFormatter()],
                    prefixIcon: Icons.payments_outlined,
                    onChanged: editCubit.dailyRateChanged,
                  ),
                  const SizedBox(height: 18),
                  AppButton(
                    label: 'Cập nhật thông tin',
                    isLoading: state.isSubmitting,
                    onPressed:
                        (state.nickname.trim().isEmpty ||
                            state.dailyRate.trim().isEmpty)
                        ? null
                        : () => editCubit.submitUpdate(),
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
      final Lunar lunar = Lunar.fromDate(date);
      final monthVal = lunar.getMonth();
      final String monthName = monthVal < 0 ? '${monthVal.abs()} (Nhuận)' : '$monthVal';
      return 'Ngày ${lunar.getDay()}/$monthName (Âm lịch)';
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
              return _AttendanceTile(day: days[index], month: month);
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
    final List<DateTime?> lunarGridDays = AppDateUtils.generateLunarCalendarDays(month);

    final Map<String, WorkerAttendanceDay> attendanceByDate =
        <String, WorkerAttendanceDay>{
          for (final WorkerAttendanceDay item in attendanceDays)
            if (item.date != null) '${item.date!.year}-${item.date!.month}-${item.date!.day}': item,
        };

    final List<WorkerAttendanceDay> result = <WorkerAttendanceDay>[];

    for (final DateTime? date in lunarGridDays) {
      if (date == null) {
        result.add(WorkerAttendanceDay(day: 0, shift: '', status: ''));
      } else {
        final String key = '${date.year}-${date.month}-${date.day}';
        final WorkerAttendanceDay? dayData = attendanceByDate[key];
        result.add(
          dayData ?? WorkerAttendanceDay(day: date.day, shift: '', status: '', date: date),
        );
      }
    }

    return result;
  }
}

class _AttendanceTile extends StatelessWidget {
  const _AttendanceTile({required this.day, required this.month});

  final WorkerAttendanceDay day;
  final DateTime month;

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

    final DateTime cellDate = day.date ?? DateTime(month.year, month.month, day.day);
    final Lunar lunar = Lunar.fromDate(cellDate);
    final String displayLabel = '${lunar.getDay()}';

    return Container(
      alignment: Alignment.center,
      decoration: decoration,
      child: Text(
        displayLabel,
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
