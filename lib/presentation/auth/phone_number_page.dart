import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_uz/core/theme/app_colors.dart';
import 'package:split_uz/core/widgets/phone_number_field.dart';
import 'package:split_uz/presentation/auth/bloc/auth_bloc.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.text.length == 12) {
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
              Text(
                "Split UZ",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 32),
              Container(
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
                      "Enter your phone number",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 16),
                    PhoneNumberField(controller: _controller),
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
                              ? state is AuthLoadInProgress
                                    ? null
                                    : () async {
                                        context.read<AuthBloc>().add(
                                          SendCodeRequested(
                                            phoneNumber:
                                                '+998${_controller.text.replaceAll(' ', '')}',
                                          ),
                                        );
                                      }
                              : null,
                          child: state is AuthLoadInProgress
                              ? SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  "Send Code",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
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
            ],
          ),
        ),
      ),
    );
  }
}
