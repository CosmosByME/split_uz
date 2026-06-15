import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_uz/core/theme/app_colors.dart';
import 'package:split_uz/core/widgets/text_field_custom.dart';
import 'package:split_uz/data/model/user.dart';
import 'package:split_uz/presentation/creating_profile.dart/bloc/creating_user_bloc.dart';

class CreatingProfilePage extends StatefulWidget {
  final UserModel user;
  const CreatingProfilePage({super.key, required this.user});

  @override
  State<CreatingProfilePage> createState() => _CreatingProfilePageState();
}

class _CreatingProfilePageState extends State<CreatingProfilePage> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
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
                      "Enter your name",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 16),
                    TextFieldCustom(controller: _controller, hintText: "Name"),
                    SizedBox(height: 16),
                    BlocBuilder<CreatingUserBloc, CreatingUserState>(
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
                              ? state is CreatingUserLoading
                                    ? null
                                    : () async {
                                        context.read<CreatingUserBloc>().add(
                                          CreatingUserRequested(
                                            uid: widget.user.uid,
                                            phone: widget.user.phone,
                                            name: _controller.text.trim(),
                                          ),
                                        );
                                      }
                              : null,
                          child: state is CreatingUserLoading
                              ? SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  "Next",
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
            ],
          ),
        ),
      ),
    );
  }
}
