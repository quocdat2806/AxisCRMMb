import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/presentation/cubits/reconcile_worksheet/reconcile_worksheet_cubit.dart';
import 'package:axis_crm/presentation/cubits/reconcile_worksheet/reconcile_worksheet_state.dart';
import 'package:axis_crm/presentation/widgets/page_title.dart';
import 'package:axis_crm/presentation/widgets/section_card.dart';

class ReconcileWorksheetScreen extends StatelessWidget {
  const ReconcileWorksheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReconcileWorksheetCubit>(
      create: (_) => ReconcileWorksheetCubit(apiClient: getIt<ApiClient>()),
      child: const _ReconcileWorksheetView(),
    );
  }
}

class _ReconcileWorksheetView extends StatefulWidget {
  const _ReconcileWorksheetView();

  @override
  State<_ReconcileWorksheetView> createState() =>
      _ReconcileWorksheetViewState();
}

class _ReconcileWorksheetViewState extends State<_ReconcileWorksheetView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        title: const PageTitle(title: 'Đối chiếu bảng công'),
        backgroundColor: const Color(0xFFF4F7FC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF17233C)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<ReconcileWorksheetCubit, ReconcileWorksheetState>(
        builder: (BuildContext context, ReconcileWorksheetState state) {
          final cubit = context.read<ReconcileWorksheetCubit>();

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
                  ..._buildReconcileContent(state.data!, state.currentMonth)
                else
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.0),
                    child: Center(child: Text('Không có dữ liệu đối chiếu')),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMonthSelector(
    BuildContext context,
    ReconcileWorksheetState state,
    ReconcileWorksheetCubit cubit,
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

  Widget _buildErrorState(String error, ReconcileWorksheetCubit cubit) {
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

  List<Widget> _buildReconcileContent(
    ReconcileResponse data,
    DateTime currentMonth,
  ) {
    final Map<String, ReconcileAttendanceItem> workerMap = {
      for (var item in data.workerAttendance) item.date: item,
    };
    final Map<String, ReconcileAttendanceItem> contractorMap = {
      for (var item in data.contractorAttendance) item.date: item,
    };

    final List<MapEntry<String, ReconcileAttendanceItem?>> workerGridDays =
        _buildGridDays(currentMonth, workerMap);
    final List<MapEntry<String, ReconcileAttendanceItem?>> contractorGridDays =
        _buildGridDays(currentMonth, contractorMap);

    // Extract only the day numbers of mismatch dates
    final List<int> mismatchDayNumbers =
        data.mismatchDates
            .map((dateStr) {
              try {
                return DateTime.parse(dateStr).day;
              } catch (_) {
                return 0;
              }
            })
            .where((d) => d > 0)
            .toList()
          ..sort();

    final String mismatchDaysText = mismatchDayNumbers.isEmpty
        ? 'Không có ngày nào bị lệch số liệu.'
        : 'Những ngày bị lệch công: ${mismatchDayNumbers.join(', ')}';

    return <Widget>[
      SectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Bảng công của bạn',
              style: TextStyle(
                color: Color(0xFF17233C),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildCalendarGrid(workerGridDays),
          ],
        ),
      ),
      const SizedBox(height: 20),

      SectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Bảng công chủ thầu chấm',
              style: TextStyle(
                color: Color(0xFF17233C),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildCalendarGrid(contractorGridDays),
          ],
        ),
      ),
      const SizedBox(height: 20),

      // List of mismatched dates notification card
      SectionCard(
        child: Row(
          children: <Widget>[
            Icon(
              mismatchDayNumbers.isEmpty
                  ? Icons.check_circle_outline_rounded
                  : Icons.warning_amber_rounded,
              color: mismatchDayNumbers.isEmpty
                  ? const Color(0xFF2E7D32)
                  : const Color(0xFFE65100),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                mismatchDaysText,
                style: TextStyle(
                  color: mismatchDayNumbers.isEmpty
                      ? const Color(0xFF2E7D32)
                      : const Color(0xFFE65100),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),

      SectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Ký hiệu màu sắc',
              style: TextStyle(
                color: Color(0xFF17233C),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: <Widget>[
                _buildLegendItem('Cả ngày', const Color(0xFF2563EB)),
                _buildLegendItem(
                  'Nửa ngày',
                  const Color(0xFF2563EB),
                ), // matching gradient logic
                _buildLegendItem('Vắng', const Color(0xFFE5484D)),
                _buildLegendItem(
                  'Chưa chấm',
                  const Color(0xFFE4E7EC),
                  hasBorder: true,
                ),
              ],
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildLegendItem(String label, Color color, {bool hasBorder = false}) {
    Widget colorBox;
    if (label == 'Nửa ngày') {
      colorBox = Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: <Color>[
              Color(0xFF2563EB),
              Color(0xFF2563EB),
              Color(0xFFE5484D),
              Color(0xFFE5484D),
            ],
            stops: <double>[0, 0.5, 0.5, 1],
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      );
    } else {
      colorBox = Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: hasBorder ? color.withValues(alpha: 0.15) : color,
          borderRadius: BorderRadius.circular(4),
          border: hasBorder ? Border.all(color: color, width: 1.5) : null,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        colorBox,
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF667085),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  List<MapEntry<String, ReconcileAttendanceItem?>> _buildGridDays(
    DateTime month,
    Map<String, ReconcileAttendanceItem> attendanceMap,
  ) {
    final int totalDays = DateTime(month.year, month.month + 1, 0).day;
    final int firstWeekday = DateTime(month.year, month.month).weekday;

    final List<MapEntry<String, ReconcileAttendanceItem?>> days = [
      for (int i = 1; i < firstWeekday; i++) const MapEntry('', null),
    ];

    for (int d = 1; d <= totalDays; d++) {
      final String dayStr = d.toString().padLeft(2, '0');
      final String monthStr = month.month.toString().padLeft(2, '0');
      final String dateKey = '${month.year}-$monthStr-$dayStr';

      final item = attendanceMap[dateKey];
      days.add(MapEntry(d.toString(), item));
    }

    return days;
  }

  Widget _buildCalendarGrid(
    List<MapEntry<String, ReconcileAttendanceItem?>> gridDays,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: gridDays.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (_, int index) {
        final entry = gridDays[index];
        final String dayLabel = entry.key;
        final item = entry.value;

        if (dayLabel.isEmpty) {
          return const SizedBox.shrink();
        }

        BoxDecoration decoration;
        TextStyle textStyle = const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 13,
        );

        if (item == null || item.shift == null) {
          decoration = BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE4E7EC), width: 1.5),
          );
          textStyle = textStyle.copyWith(color: const Color(0xFF98A2B3));
        } else {
          final shift = item.shift;
          if (shift == 'full') {
            decoration = BoxDecoration(
              color: const Color(0xFF2563EB),
              borderRadius: BorderRadius.circular(8),
            );
            textStyle = textStyle.copyWith(color: Colors.white);
          } else if (shift == 'half') {
            decoration = BoxDecoration(
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
            );
            textStyle = textStyle.copyWith(color: Colors.white);
          } else if (shift == 'absent') {
            decoration = BoxDecoration(
              color: const Color(0xFFE5484D),
              borderRadius: BorderRadius.circular(8),
            );
            textStyle = textStyle.copyWith(color: Colors.white);
          } else {
            decoration = BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE4E7EC), width: 1.5),
            );
            textStyle = textStyle.copyWith(color: const Color(0xFF98A2B3));
          }
        }

        return Container(
          alignment: Alignment.center,
          decoration: decoration,
          child: Text(dayLabel, style: textStyle),
        );
      },
    );
  }
}
