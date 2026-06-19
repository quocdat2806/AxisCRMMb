import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/presentation/screens/worksheet/reconcile_worksheet_screen.dart';
import 'package:axis_crm/presentation/cubits/reconcile_worksheet/reconcile_worksheet_cubit.dart';
import 'package:axis_crm/presentation/screens/user_advance/reconcile_advance_screen.dart';
import 'package:axis_crm/presentation/cubits/reconcile_advance/reconcile_advance_cubit.dart';
import 'package:axis_crm/presentation/screens/yearly_summary/yearly_summary_screen.dart';

class ReconcileTabScreen extends StatelessWidget {
  const ReconcileTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F7FC),
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: const Color(0xFFF4F7FC),
          elevation: 0,
          bottom: const TabBar(
            labelColor: Color(0xFF2563EB),
            unselectedLabelColor: Color(0xFF667085),
            indicatorColor: Color(0xFF2563EB),
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            tabs: [
              Tab(text: 'Bảng công'),
              Tab(text: 'Ứng tiền'),
              Tab(text: 'Tổng kết năm'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocProvider<ReconcileWorksheetCubit>(
              create: (_) =>
                  ReconcileWorksheetCubit(apiClient: getIt<ApiClient>()),
              child: const ReconcileWorksheetView(isTab: true),
            ),
            BlocProvider<ReconcileAdvanceCubit>(
              create: (_) =>
                  ReconcileAdvanceCubit(apiClient: getIt<ApiClient>()),
              child: const ReconcileAdvanceView(isTab: true),
            ),
            const YearlySummaryScreen(isTab: true),
          ],
        ),
      ),
    );
  }
}
