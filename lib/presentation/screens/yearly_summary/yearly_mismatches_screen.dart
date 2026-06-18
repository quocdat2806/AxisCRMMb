import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/entity/user.dart';
import 'package:axis_crm/presentation/cubits/yearly_mismatches/yearly_mismatches_cubit.dart';
import 'package:axis_crm/presentation/cubits/yearly_mismatches/yearly_mismatches_state.dart';
import 'package:axis_crm/presentation/widgets/page_title.dart';

class YearlyMismatchesScreen extends StatelessWidget {
  const YearlyMismatchesScreen({
    required this.year,
    this.targetUser,
    super.key,
  });

  final String year;
  final User? targetUser;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<YearlyMismatchesCubit>(
      create: (_) => YearlyMismatchesCubit(
        apiClient: getIt<ApiClient>(),
        year: year,
        targetUser: targetUser,
      ),
      child: _YearlyMismatchesView(year: year),
    );
  }
}

class _YearlyMismatchesView extends StatelessWidget {
  const _YearlyMismatchesView({required this.year});

  final String year;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F7FC),
        appBar: AppBar(
          title: PageTitle(title: 'Chi tiết ngày lệch năm $year'),
          backgroundColor: const Color(0xFFF4F7FC),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF17233C)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: const TabBar(
            labelColor: Color(0xFF2563EB),
            unselectedLabelColor: Color(0xFF667085),
            indicatorColor: Color(0xFF2563EB),
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            tabs: [
              Tab(text: 'Lệch chấm công'),
              Tab(text: 'Lệch tạm ứng'),
            ],
          ),
        ),
        body: BlocBuilder<YearlyMismatchesCubit, YearlyMismatchesState>(
          builder: (BuildContext context, YearlyMismatchesState state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return _buildErrorState(state.error!, context);
            }

            if (state.data == null) {
              return const Center(child: Text('Không có dữ liệu chênh lệch'));
            }

            final targetUser = context.read<YearlyMismatchesCubit>().targetUser;
            final response = state.data!;
            return TabBarView(
              children: [
                _buildAttendanceMismatchesList(response.attendanceMismatches, targetUser),
                _buildAdvanceMismatchesList(response.advanceMismatches, targetUser),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildErrorState(String error, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.error_outline_rounded, color: Colors.red, size: 48),
          const SizedBox(height: 12),
          Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<YearlyMismatchesCubit>().loadYearlyMismatches(),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB)),
            child: const Text('Thử lại', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceMismatchesList(List<AttendanceMismatchItem> list, User? targetUser) {
    if (list.isEmpty) {
      return const Center(
        child: Text(
          'Không có chênh lệch chấm công',
          style: TextStyle(color: Color(0xFF667085), fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );
    }

    // Sort newest first
    final sortedList = List<AttendanceMismatchItem>.from(list)
      ..sort((a, b) => b.date.compareTo(a.date));

    return ListView.builder(
      padding: const EdgeInsets.all(18),
      itemCount: sortedList.length,
      itemBuilder: (_, int index) {
        final item = sortedList[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFFFB74D).withOpacity(0.5), width: 1.2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _formatDateStr(item.date),
                      style: const TextStyle(
                        color: Color(0xFF17233C),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildMismatchBadge(),
                  ],
                ),
                const Divider(height: 20, thickness: 1, color: Color(0xFFE4E7EC)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: _buildComparisonColumn(
                        title: targetUser != null ? 'Thợ tự chấm' : 'Bạn tự chấm',
                        value: _getShiftLabel(item.workerShift),
                        valueColor: _getShiftColor(item.workerShift),
                        note: item.workerNote,
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 1,
                      color: const Color(0xFFE4E7EC),
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    Expanded(
                      child: _buildComparisonColumn(
                        title: targetUser != null ? 'Bạn chấm' : 'Chủ thầu chấm',
                        value: _getShiftLabel(item.contractorShift),
                        valueColor: _getShiftColor(item.contractorShift),
                        note: item.contractorNote,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAdvanceMismatchesList(List<AdvanceMismatchItem> list, User? targetUser) {
    if (list.isEmpty) {
      return const Center(
        child: Text(
          'Không có chênh lệch tiền tạm ứng',
          style: TextStyle(color: Color(0xFF667085), fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );
    }

    // Sort newest first
    final sortedList = List<AdvanceMismatchItem>.from(list)
      ..sort((a, b) => b.date.compareTo(a.date));

    return ListView.builder(
      padding: const EdgeInsets.all(18),
      itemCount: sortedList.length,
      itemBuilder: (_, int index) {
        final item = sortedList[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFFFB74D).withOpacity(0.5), width: 1.2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _formatDateStr(item.date),
                      style: const TextStyle(
                        color: Color(0xFF17233C),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildMismatchBadge(),
                  ],
                ),
                const Divider(height: 20, thickness: 1, color: Color(0xFFE4E7EC)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: _buildComparisonColumn(
                        title: targetUser != null ? 'Thợ tự khai báo' : 'Bạn tự khai báo',
                        value: item.workerAmount != null
                            ? '${_formatMoney(item.workerAmount!)} vnđ'
                            : 'Chưa khai báo',
                        valueColor: item.workerAmount != null
                            ? const Color(0xFF17233C)
                            : const Color(0xFF98A2B3),
                        note: item.workerNote,
                        isMoney: true,
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 1,
                      color: const Color(0xFFE4E7EC),
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    Expanded(
                      child: _buildComparisonColumn(
                        title: targetUser != null ? 'Bạn ghi nhận' : 'Chủ thầu ghi nhận',
                        value: item.contractorAmount != null
                            ? '${_formatMoney(item.contractorAmount!)} vnđ'
                            : 'Chưa xác nhận',
                        valueColor: item.contractorAmount != null
                            ? const Color(0xFF17233C)
                            : const Color(0xFFC62828),
                        note: item.contractorNote,
                        isMoney: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMismatchBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.warning_amber_rounded, color: Color(0xFFC62828), size: 14),
          SizedBox(width: 4),
          Text(
            'Lệch',
            style: TextStyle(color: Color(0xFFC62828), fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonColumn({
    required String title,
    required String value,
    required Color valueColor,
    required String? note,
    bool isMoney = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF667085),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 14,
            fontWeight: isMoney ? FontWeight.w800 : FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        if (note != null && note.isNotEmpty)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.notes_rounded, size: 12, color: Color(0xFF667085)),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  note,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF667085),
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          )
        else
          const Text(
            'Không có ghi chú',
            style: TextStyle(
              color: Color(0xFF98A2B3),
              fontSize: 11,
              fontStyle: FontStyle.italic,
            ),
          ),
      ],
    );
  }

  String _getShiftLabel(String? shift) {
    if (shift == 'full') return 'Cả ngày';
    if (shift == 'half') return 'Nửa ngày';
    if (shift == 'absent') return 'Vắng';
    return 'Chưa chấm';
  }

  Color _getShiftColor(String? shift) {
    if (shift == 'full') return const Color(0xFF2E7D32);
    if (shift == 'half') return const Color(0xFF1565C0);
    if (shift == 'absent') return const Color(0xFFC62828);
    return const Color(0xFF757575);
  }

  String _formatDateStr(String dateStr) {
    try {
      final parsed = DateTime.parse(dateStr);
      final weekdayStr = _getWeekdayStr(parsed.weekday);
      final dayStr = parsed.day.toString().padLeft(2, '0');
      final monthStr = parsed.month.toString().padLeft(2, '0');
      return '$weekdayStr, $dayStr/$monthStr';
    } catch (_) {
      return dateStr;
    }
  }

  String _getWeekdayStr(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Thứ 2';
      case DateTime.tuesday:
        return 'Thứ 3';
      case DateTime.wednesday:
        return 'Thứ 4';
      case DateTime.thursday:
        return 'Thứ 5';
      case DateTime.friday:
        return 'Thứ 6';
      case DateTime.saturday:
        return 'Thứ 7';
      case DateTime.sunday:
        return 'Chủ Nhật';
      default:
        return '';
    }
  }

  String _formatMoney(double value) {
    final int valInt = value.abs().toInt();
    final String str = valInt.toString();
    final StringBuffer result = StringBuffer();
    final int length = str.length;
    for (int i = 0; i < length; i++) {
      if (i > 0 && (length - i) % 3 == 0) {
        result.write('.');
      }
      result.write(str[i]);
    }
    final String sign = value < 0 ? '-' : '';
    return '$sign$result';
  }
}
