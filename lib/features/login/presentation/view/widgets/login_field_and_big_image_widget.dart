import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class LoginFieldAndBigImageWidget extends StatelessWidget {
  const LoginFieldAndBigImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          showSnackBar(context, state.errorMessage, AppColors.red);
        }
        if (state is LoginSuccess) {
          showSnackBar(context, "loginSuccess".tr(), AppColors.green);
          context.pushReplacementNamed(AppRoutes.homeScreen);
        }
      },
      builder: (context, state) {
        final loginCubit = LoginCubit.get(context);
        return Row(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(start: 46.w),
              child: Column(
                children: [
                  FieldsWidget(loginCubit: loginCubit),
                  const SizedBox(height: 10),
                  KeepLoginWidget(loginCubit: loginCubit),
                  const SizedBox(height: 20),
                  LoginButtonWidget(loginCubit: loginCubit),
                ],
              ),
            ),
            const Spacer(),
            Image.asset(
              AppImages.bigImageLogin,
              width: 518.w,
              fit: BoxFit.cover,
            ),
          ],
        );
      },
    );
  }
}
