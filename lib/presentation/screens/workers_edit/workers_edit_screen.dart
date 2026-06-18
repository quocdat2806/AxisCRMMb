import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:axis_crm/core/di/injection_container.dart';
import 'package:axis_crm/core/network/api_client.dart';
import 'package:axis_crm/presentation/cubits/workers_edit/workers_edit_cubit.dart';
import 'package:axis_crm/presentation/widgets/app_button.dart';
import 'package:axis_crm/presentation/widgets/app_text_field.dart';
import 'package:axis_crm/presentation/widgets/money_input_formatter.dart';
import 'package:axis_crm/presentation/widgets/page_title.dart';
import 'package:axis_crm/presentation/widgets/section_card.dart';
import 'package:axis_crm/entity/user.dart';

class WorkersEditScreen extends StatelessWidget {
  const WorkersEditScreen({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    // Định dạng số tiền ban đầu để hiển thị dạng 1.000.000
    final String formattedRate = user.defaultDailyRate != null
        ? _formatMoney(user.defaultDailyRate!)
        : '';

    return BlocProvider<WorkersEditCubit>(
      create: (_) => WorkersEditCubit(
        apiClient: getIt<ApiClient>(),
        user: user,
        currentDailyRate: formattedRate,
      ),
      child: _WorkersEditView(
        initialNickname: user.nickname ?? '',
        initialDailyRate: formattedRate,
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

class _WorkersEditView extends StatefulWidget {
  const _WorkersEditView({
    required this.initialNickname,
    required this.initialDailyRate,
  });

  final String initialNickname;
  final String initialDailyRate;

  @override
  State<_WorkersEditView> createState() => _WorkersEditViewState();
}

class _WorkersEditViewState extends State<_WorkersEditView> {
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
          Navigator.of(context).pop(state.updatedUser);
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
        final WorkersEditCubit cubit = context.read<WorkersEditCubit>();

        return Scaffold(
          backgroundColor: const Color(0xFFF4F7FC),
          appBar: AppBar(
            title: const PageTitle(title: 'Chỉnh sửa thông tin'),
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
                SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppTextField(
                        label: 'Biệt danh',
                        hintText: 'Nhập biệt danh công nhân',
                        controller: _nicknameController,
                        prefixIcon: Icons.person_outline,
                        onChanged: cubit.nicknameChanged,
                      ),
                      const SizedBox(height: 14),
                      AppTextField(
                        label: 'Số tiền 1 ngày (vnđ)',
                        hintText: 'Nhập số tiền lương 1 ngày',
                        controller: _dailyRateController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [MoneyInputFormatter()],
                        prefixIcon: Icons.payments_outlined,
                        onChanged: cubit.dailyRateChanged,
                      ),
                      const SizedBox(height: 18),
                      AppButton(
                        label: 'Cập nhật',
                        isLoading: state.isSubmitting,
                        onPressed:
                            (state.nickname.trim().isEmpty ||
                                state.dailyRate.trim().isEmpty)
                            ? null
                            : () => cubit.submitUpdate(),
                      ),
                    ],
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
