import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_uz/core/theme/app_colors.dart';
import 'package:split_uz/core/widgets/otp_field.dart';
import 'package:split_uz/presentation/auth/bloc/auth_bloc.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _controller = TextEditingController();
  final Key _timerKey = UniqueKey();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.text.length == 6) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Split UZ", style: Theme.of(context).textTheme.displayLarge),
              SizedBox(height: 32),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                constraints: BoxConstraints(maxWidth: 400),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SMS kodni kiriting",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 16),
                    OtpField(controller: _controller),
                    SizedBox(height: 16),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.background,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            fixedSize: Size(300, 50),
                          ),
                          onPressed: _controller.text.isNotEmpty
                              ? state is AuthCodeSent
                                    ? () {
                                        context.read<AuthBloc>().add(
                                          CodeVerified(
                                            smsCode: _controller.text.trim(),
                                            verificationId:
                                                state.verificationId,
                                            phoneNumber: state.phoneNumber,
                                          ),
                                        );
                                      }
                                    : null
                              : null,
                          child: state is AuthLoadInProgress
                              ? SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  "Verify Code",
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(
                                        color: _controller.text.isNotEmpty
                                            ? Colors.white
                                            : Colors.white.withValues(
                                                alpha: 0.3,
                                              ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Kod kelmadimi? "),
                  TweenAnimationBuilder<Duration>(
                    key: _timerKey,
                    duration: Duration(seconds: 30),
                    tween: Tween(
                      begin: Duration(seconds: 30),
                      end: Duration(seconds: 0),
                    ),
                    builder: (context, value, child) {
                      return value.inSeconds == 0
                          ? child!
                          : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "(${value.inSeconds}s)",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            );
                    },
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return TextButton(
                          onPressed: state is AuthCodeSent
                              ? () {
                                  context.read<AuthBloc>().add(
                                    CodeResent(
                                      phoneNumber: state.phoneNumber,
                                      resendToken: state.resendToken,
                                    ),
                                  );
                                }
                              : null,
                          child: state is AuthLoadInProgress
                              ? SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    color: AppColors.background,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text("Kodni qayta yuborish"),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
