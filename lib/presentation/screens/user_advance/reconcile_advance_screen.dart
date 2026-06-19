import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/presentation/cubits/reconcile_advance/reconcile_advance_cubit.dart';
import 'package:axis_crm/presentation/cubits/reconcile_advance/reconcile_advance_state.dart';
import 'package:axis_crm/presentation/widgets/page_title.dart';
import 'package:axis_crm/presentation/widgets/section_card.dart';

class ReconcileAdvanceScreen extends StatelessWidget {
  const ReconcileAdvanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReconcileAdvanceCubit>(
      create: (_) => ReconcileAdvanceCubit(apiClient: getIt<ApiClient>()),
      child: const ReconcileAdvanceView(),
    );
  }
}

class ReconcileAdvanceView extends StatelessWidget {
  const ReconcileAdvanceView({this.isTab = false, super.key});
  final bool isTab;

  @override
  Widget build(BuildContext context) {
    final body = BlocBuilder<ReconcileAdvanceCubit, ReconcileAdvanceState>(
      builder: (BuildContext context, ReconcileAdvanceState state) {
        final cubit = context.read<ReconcileAdvanceCubit>();

        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: <Widget>[
              // Month Selector
              _buildMonthSelector(context, state, cubit),
              const SizedBox(height: 16),

              if (state.isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.error != null)
                _buildErrorState(state.error!, cubit)
              else if (state.data != null)
                ..._buildReconcileContent(state.data!)
              else
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Center(child: Text('Không có dữ liệu đối chiếu')),
                ),
            ],
          ),
        );
      },
    );

    if (isTab) {
      return Scaffold(backgroundColor: const Color(0xFFF4F7FC), body: body);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        title: const PageTitle(title: 'Đối chiếu ứng tiền'),
        backgroundColor: const Color(0xFFF4F7FC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF17233C)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: body,
    );
  }

  Widget _buildMonthSelector(
    BuildContext context,
    ReconcileAdvanceState state,
    ReconcileAdvanceCubit cubit,
  ) {
    return SectionCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: cubit.previousMonth,
            icon: const Icon(Icons.chevron_left, color: Color(0xFF17233C)),
          ),
          Text(
            'Tháng ${state.currentMonth.month}/${state.currentMonth.year}',
            style: const TextStyle(
              color: Color(0xFF17233C),
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          IconButton(
            onPressed: cubit.nextMonth,
            icon: const Icon(Icons.chevron_right, color: Color(0xFF17233C)),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error, ReconcileAdvanceCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        children: <Widget>[
          const Icon(Icons.error_outline_rounded, color: Colors.red, size: 48),
          const SizedBox(height: 12),
          Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: cubit.loadReconcileData,
            icon: const Icon(Icons.refresh),
            label: const Text('Thử lại'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1565C0),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildReconcileContent(ReconcileAdvanceResponse data) {
    final Set<String> mismatchSet = (data.mismatchDates ?? <String>[]).toSet();

    final List<String> sortedDates = mismatchSet.toList()
      ..sort((a, b) => b.compareTo(a)); // Newest first

    if (sortedDates.isEmpty) {
      return <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 40.0),
          child: Center(
            child: Text(
              'Số liệu của bạn và chủ thầu hoàn toàn khớp nhau trong tháng này. Không có ngày nào bị lệch.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF667085), fontSize: 15),
            ),
          ),
        ),
      ];
    }

    final Map<String, ReconcileAdvanceItem> workerMap = {
      for (var item in data.workerAdvances ?? <ReconcileAdvanceItem>[])
        item.date: item,
    };
    final Map<String, ReconcileAdvanceItem> contractorMap = {
      for (var item in data.contractorAdvances ?? <ReconcileAdvanceItem>[])
        item.date: item,
    };

    return <Widget>[
      const Text(
        'Danh sách ngày chênh lệch',
        style: TextStyle(
          color: Color(0xFF17233C),
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 12),
      ...sortedDates.map((dateStr) {
        final workerItem = workerMap[dateStr];
        final contractorItem = contractorMap[dateStr];
        final isMismatched = mismatchSet.contains(dateStr);

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isMismatched
                  ? const Color(0xFFFFB74D).withOpacity(0.5)
                  : const Color(0xFFE4E7EC),
              width: 1.2,
            ),
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
                      _formatDateStr(dateStr),
                      style: const TextStyle(
                        color: Color(0xFF17233C),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isMismatched) _buildMismatchBadge(),
                  ],
                ),
                const Divider(
                  height: 20,
                  thickness: 1,
                  color: Color(0xFFE4E7EC),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: _buildComparisonColumn(
                        title: 'Bạn khai báo',
                        value: workerItem?.amount != null
                            ? '${_formatMoney(workerItem!.amount!)} vnđ'
                            : 'Chưa khai báo',
                        valueColor: workerItem?.amount != null
                            ? const Color(0xFF17233C)
                            : const Color(0xFF98A2B3),
                        note: workerItem?.note,
                        isMoney: workerItem?.amount != null,
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
                        title: 'Chủ thầu ghi nhận',
                        value: contractorItem?.amount != null
                            ? '${_formatMoney(contractorItem!.amount!)} vnđ'
                            : 'Chưa xác nhận',
                        valueColor: contractorItem?.amount != null
                            ? const Color(0xFF17233C)
                            : const Color(0xFFC62828),
                        note: contractorItem?.note,
                        isMoney: contractorItem?.amount != null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    ];
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
            style: TextStyle(
              color: Color(0xFFC62828),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
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
              const Icon(
                Icons.notes_rounded,
                size: 12,
                color: Color(0xFF667085),
              ),
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
