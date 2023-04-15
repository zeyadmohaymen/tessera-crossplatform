// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/core/widgets/app_scaffold.dart';
import 'package:tessera/features/authentication/view/widgets/reusable_button.dart';
import 'package:tessera/features/authentication/view/widgets/email_button.dart';
import '../../../../core/services/authentication/facebook_authentication.dart';
import '../../../../core/services/authentication/google_authentication.dart';
import '../../cubit/auth_cubit.dart';

/// Screen that allows the user to choose between logging in / signing up with email, Google, or Facebook.
class LoginOptionsScreen extends StatelessWidget {
  const LoginOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppScaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'logo',
                        child: Image.asset(
                          'assets/images/AppIconMed.png',
                          height: 120,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Let\'s get started!',
                        style: TextStyle(
                            color: AppColors.textOnLight,
                            fontSize: 40.0,
                            fontFamily: 'NeuePlak'),
                      ),
                      const Text(
                        'Sign up or log in to see what\'s happening near you.',
                        style: TextStyle(
                            color: AppColors.secondaryTextOnLight,
                            fontSize: 20.0,
                            fontFamily: 'NeuePlak'),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      EmailButton(
                        colourBackground: AppColors.primary,
                        buttonText: 'Continue with Email Address',
                        colourText: Colors.white,
                        onTap: () =>
                            Navigator.of(context).pushNamed('/login_signup'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ContinueButton(
                          image: 'assets/images/facebook.png',
                          buttonText: 'Continue with Facebook',
                          onTap: () async {
                            await context
                                .read<AuthCubit>()
                                .signIn(FacebookAuthService());

                            if (context.read<AuthCubit>().state is SignedIn) {
                              Navigator.of(context)
                                  .pushReplacementNamed('/third');
                            }
                          }),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ContinueButton(
                        image: 'assets/images/Google.png',
                        buttonText: 'Continue with Google',
                        onTap: () async {
                          await context
                              .read<AuthCubit>()
                              .signIn(GoogleAuthService());

                          if (context.read<AuthCubit>().state is SignedIn) {
                            Navigator.of(context)
                                .pushReplacementNamed('/third');
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              if (context.watch<AuthCubit>().state is Loading)
                const CircularProgressIndicator.adaptive(),
            ],
          ),
        ),
      ),
    );
  }
}