import 'package:axis_crm/presentation/widgets/page_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/core/network/api_client_dto.dart';
import 'package:axis_crm/entity/user.dart';
import 'package:axis_crm/presentation/cubits/yearly_summary/yearly_summary_cubit.dart';
import 'package:axis_crm/presentation/cubits/yearly_summary/yearly_summary_state.dart';
import 'package:axis_crm/presentation/widgets/section_card.dart';
import 'package:axis_crm/presentation/screens/yearly_summary/yearly_mismatches_screen.dart';

class YearlySummaryScreen extends StatelessWidget {
  const YearlySummaryScreen({this.targetUser, this.isTab = false, super.key});

  final User? targetUser;
  final bool isTab;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<YearlySummaryCubit>(
      create: (_) => YearlySummaryCubit(
        apiClient: getIt<ApiClient>(),
        targetUser: targetUser,
      ),
      child: _YearlySummaryView(targetUser: targetUser, isTab: isTab),
    );
  }
}

class _YearlySummaryView extends StatelessWidget {
  const _YearlySummaryView({this.targetUser, this.isTab = false});

  final User? targetUser;
  final bool isTab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      body: BlocBuilder<YearlySummaryCubit, YearlySummaryState>(
        builder: (BuildContext context, YearlySummaryState state) {
          final cubit = context.read<YearlySummaryCubit>();

          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(18),
              children: <Widget>[
                // Year Selector
                if (!isTab)
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back_rounded),
                      ),
                      PageTitle(
                        title: 'Tổng kết năm ${targetUser?.name ?? ''}',
                      ),
                    ],
                  ),
                if (!isTab) const SizedBox(height: 16),
                _buildYearSelector(context, state, cubit),
                const SizedBox(height: 16),

                if (state.isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state.error != null)
                  _buildErrorState(state.error!, cubit)
                else if (state.data != null)
                  ..._buildSummaryContent(
                    context,
                    state.data!,
                    state.currentYear,
                  )
                else
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.0),
                    child: Center(child: Text('Không có dữ liệu tổng kết năm')),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildYearSelector(
    BuildContext context,
    YearlySummaryState state,
    YearlySummaryCubit cubit,
  ) {
    return SectionCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: cubit.previousYear,
            icon: const Icon(Icons.chevron_left, color: Color(0xFF17233C)),
          ),
          Text(
            'Năm ${state.currentYear}',
            style: const TextStyle(
              color: Color(0xFF17233C),
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          IconButton(
            onPressed: cubit.nextYear,
            icon: const Icon(Icons.chevron_right, color: Color(0xFF17233C)),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error, YearlySummaryCubit cubit) {
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
            onPressed: cubit.loadYearlySummary,
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

  List<Widget> _buildSummaryContent(
    BuildContext context,
    YearlySummaryData data,
    String currentYear,
  ) {
    final worker = data.workerSide;
    final contractor = data.contractorSide;

    final double workDaysDiff = worker.totalWorkDays - contractor.totalWorkDays;
    final double advanceDiff =
        worker.totalAdvanceAmount - contractor.totalAdvanceAmount;
    final bool hasMismatch = workDaysDiff != 0 || advanceDiff != 0;

    return <Widget>[
      // Status Header Box
      _buildSummaryCard(hasMismatch, workDaysDiff, advanceDiff),
      const SizedBox(height: 20),

      // Card 1: Total Work Days Comparison
      _buildComparisonCard(
        title: 'Tổng công quy đổi',
        workerValue: '${worker.totalWorkDays} công',
        contractorValue: '${contractor.totalWorkDays} công',
        diffLabel: _formatDiffText(workDaysDiff, 'công'),
        diffColor: _getDiffColor(workDaysDiff),
        icon: Icons.calendar_today_rounded,
        onViewMismatches: workDaysDiff != 0
            ? () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => YearlyMismatchesScreen(
                    year: currentYear,
                    targetUser: targetUser,
                  ),
                ),
              )
            : null,
      ),
      const SizedBox(height: 16),

      // Card 2: Total Advance Amount Comparison
      _buildComparisonCard(
        title: 'Tổng số tiền tạm ứng',
        workerValue: '${_formatMoney(worker.totalAdvanceAmount)} vnđ',
        contractorValue: '${_formatMoney(contractor.totalAdvanceAmount)} vnđ',
        diffLabel: _formatDiffText(advanceDiff, 'vnđ'),
        diffColor: _getDiffColor(advanceDiff),
        icon: Icons.payments_outlined,
        onViewMismatches: advanceDiff != 0
            ? () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => YearlyMismatchesScreen(
                    year: currentYear,
                    targetUser: targetUser,
                  ),
                ),
              )
            : null,
      ),
      const SizedBox(height: 16),
    ];
  }

  Widget _buildSummaryCard(
    bool hasMismatch,
    double workDaysDiff,
    double advanceDiff,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: hasMismatch ? const Color(0xFFFFF3E0) : const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasMismatch
              ? const Color(0xFFFFB74D)
              : const Color(0xFF81C784),
          width: 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            hasMismatch
                ? Icons.warning_amber_rounded
                : Icons.check_circle_outline_rounded,
            color: hasMismatch
                ? const Color(0xFFE65100)
                : const Color(0xFF2E7D32),
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  hasMismatch
                      ? 'Phát hiện lệch đối chiếu'
                      : 'Số liệu trùng khớp',
                  style: TextStyle(
                    color: hasMismatch
                        ? const Color(0xFFE65100)
                        : const Color(0xFF2E7D32),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hasMismatch
                      ? 'Có sự chênh lệch trong tổng số công hoặc tiền tạm ứng giữa hai bên.'
                      : 'Số liệu chấm công và tạm ứng hoàn toàn trùng khớp.',
                  style: TextStyle(
                    color: hasMismatch
                        ? const Color(0xFFF57C00)
                        : const Color(0xFF388E3C),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonCard({
    required String title,
    required String workerValue,
    required String contractorValue,
    required String diffLabel,
    required Color diffColor,
    required IconData icon,
    VoidCallback? onViewMismatches,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4E7EC), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header
            Row(
              children: <Widget>[
                Icon(icon, color: const Color(0xFF2563EB), size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF17233C),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (diffLabel.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: diffColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      diffLabel,
                      style: TextStyle(
                        color: diffColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const Divider(height: 24, thickness: 1, color: Color(0xFFE4E7EC)),

            Row(
              children: <Widget>[
                Expanded(
                  child: _buildValueColumn(
                    label: targetUser != null ? 'Thợ khai báo' : 'Bạn khai báo',
                    value: workerValue,
                  ),
                ),
                Container(
                  height: 44,
                  width: 1,
                  color: const Color(0xFFE4E7EC),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                ),
                Expanded(
                  child: _buildValueColumn(
                    label: targetUser != null ? 'Bạn chấm' : 'Chủ thầu chấm',
                    value: contractorValue,
                  ),
                ),
              ],
            ),
            if (onViewMismatches != null) ...[
              const Divider(height: 24, thickness: 1, color: Color(0xFFE4E7EC)),
              Center(
                child: TextButton.icon(
                  onPressed: onViewMismatches,
                  icon: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: Color(0xFF2563EB),
                  ),
                  label: const Text(
                    'Xem ngày lệch',
                    style: TextStyle(
                      color: Color(0xFF2563EB),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildValueColumn({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF667085),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF17233C),
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  String _formatDiffText(double diff, String unit) {
    if (diff == 0) return 'Trùng khớp';
    if (unit == 'vnđ') {
      return 'Lệch: ${_formatMoney(diff)} vnđ';
    }
    return 'Lệch: ${diff.toStringAsFixed(diff.truncateToDouble() == diff ? 0 : 1)} $unit';
  }

  Color _getDiffColor(double diff) {
    return diff == 0 ? const Color(0xFF2E7D32) : const Color(0xFFFF9800);
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
