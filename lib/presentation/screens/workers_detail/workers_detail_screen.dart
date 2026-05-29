import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';

import '../../blocs/workers_detail/workers_detail_cubit.dart';

class WorkersDetailScreen extends StatelessWidget {
  const WorkersDetailScreen({
    required this.userId,
    required this.userName,
    super.key,
  });

  final String userId;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkersDetailCubit>(
      create: (_) => WorkersDetailCubit(
        userId: userId,
        apiClient: getIt<ApiClient>(),
      ),
      child: _WorkersDetailView(userName: userName),
    );
  }
}

class _WorkersDetailView extends StatelessWidget {
  const _WorkersDetailView({required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkersDetailCubit, WorkersDetailState>(
      builder: (BuildContext context, WorkersDetailState state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF4F7FC),
          appBar: AppBar(
            title: Text(userName),
            backgroundColor: const Color(0xFFF4F7FC),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
            children: <Widget>[
              const _PageTitle(title: 'Chi tiết thợ'),
              const SizedBox(height: 16),
              if (state.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (state.error != null)
                _ErrorState(message: state.error!)
              else if (state.summary != null) ...[
                _SummaryCard(summary: state.summary!),
                const SizedBox(height: 16),
                _AttendanceSection(
                  month: state.month,
                  onPrevious: context.read<WorkersDetailCubit>().previousMonth,
                  onNext: context.read<WorkersDetailCubit>().nextMonth,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.summary});

  final dynamic summary;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.calendar_month, color: Color(0xFF2457D6)),
              const SizedBox(width: 8),
              Text(
                'Tháng ${summary.month}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF17233C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              _SummaryItem(
                label: 'Ngày đi làm',
                value: '${summary.attendance.fullDays}',
                color: const Color(0xFF16A34A),
              ),
              _SummaryItem(
                label: 'Nửa ngày',
                value: '${summary.attendance.halfDays}',
                color: const Color(0xFF8B9AAF),
              ),
              _SummaryItem(
                label: 'Nghỉ',
                value: '${summary.attendance.absentDays}',
                color: const Color(0xFFE5484D),
              ),
            ],
          ),
          const Divider(height: 24),
          _InfoRow(label: 'Lương theo ngày', value: '${summary.defaultDailyRate} VND'),
          _InfoRow(label: 'Tổng lương', value: '${summary.totalEarned} VND'),
          _InfoRow(label: 'Đã ứng', value: '${summary.totalAdvanced} VND'),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF667085),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF667085),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF17233C),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendanceSection extends StatelessWidget {
  const _AttendanceSection({
    required this.month,
    required this.onPrevious,
    required this.onNext,
  });

  final DateTime month;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF17233C),
                  ),
                ),
              ),
              IconButton(
                onPressed: onNext,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ],
      ),
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
      ),
      child: child,
    );
  }
}

class _PageTitle extends StatelessWidget {
  const _PageTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF17233C),
        fontSize: 24,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFE5484D),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}