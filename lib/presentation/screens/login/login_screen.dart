import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/router_path.dart';
import '../../cubits/login/login_cubit.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) => LoginCubit(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF4FF),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 12),
                const Center(child: _AppMark()),
                const SizedBox(height: 34),
                const _LoginCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppMark extends StatelessWidget {
  const _AppMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF2563EB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(Icons.hub_outlined, color: Colors.white, size: 31),
    );
  }
}

class _LoginCard extends StatelessWidget {
  const _LoginCard();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.user != null) {
          context.go(RouterPath.main, extra: state.user);
        }
      },
      builder: (BuildContext context, LoginState state) {
        final LoginCubit cubit = context.read<LoginCubit>();
        return Column(
          children: <Widget>[
            AppTextField(
              label: 'Số điện thoại',
              hintText: '090 123 4567',
              keyboardType: TextInputType.phone,
              onChanged: cubit.phoneChanged,
            ),
            const SizedBox(height: 14),
            AppTextField(
              label: 'Tên của bạn',
              hintText: 'Tên của bạn',
              onChanged: cubit.nameChanged,
            ),
            const SizedBox(height: 14),
            AppButton(
              label: 'Đăng nhập',
              isLoading: state.isSubmitting,
              onPressed: state.canSubmit ? cubit.submit : null,
            ),
            if (state.error != null) ...[
              const SizedBox(height: 14),
              Text(state.error!, style: const TextStyle(color: Colors.red)),
            ],
          ],
        );
      },
    );
  }
}
