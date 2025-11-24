import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wander/core/components/responsive_container.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveContainer(
        child: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/images/wanderbooks_icon.svg',
                  width: 120,
                  height: 120,
                ),
                Text(
                  'Welcome to WanderBooks',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                FractionallySizedBox(
                  widthFactor: 0.5,
                  child: TextFormField(
                    autofocus: true,
                    // controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Enter your email',
                      // hintText: 'Enter your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    // validator: _validateEmail,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => {
                    context.go('/home')
                  },
                  child: const Text('Sign in or create account'),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('or'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: Theme.of(context).buttonTheme.height,
                  child: SignInButton(Buttons.Apple, onPressed: () => {}),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: Theme.of(context).buttonTheme.height,
                  child: SignInButton(Buttons.Google, onPressed: () => {}),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: Theme.of(context).buttonTheme.height,
                  child: SignInButton(Buttons.Facebook, onPressed: () => {}),
                ),
                // ElevatedButton(
                //   onPressed: () => {},
                //   child: const Text('Continue with Apple'),
                // ),
                // SizedBox(height: 16),
                // ElevatedButton(
                //   onPressed: () => {},
                //   child: const Text('Continue with Facebook'),
                // ),
                // SizedBox(height: 16),
                // ElevatedButton(
                //   onPressed: () => {},
                //   child: const Text('Continue with Google'),
                // ),
                SizedBox(height: 16),
                FractionallySizedBox(
                  widthFactor: 0.5,
                  child: Column(
                    children: [
                      Text(
                        "By clicking Sign in, Continue with Google, Facebook, or Apple, you agree to WanderBooks Terms of Use and Privacy Policy. ",
                      ),
                      SizedBox(height: 8),
                      Text(
                        "WanderBooks may send you communications; you may change your preferences in your account settings. We'll never post without your permission.",
                      ),
                    ],
                  ),
                  // AppleSignInButton(),
                  // SizedBox(height: 16),
                  // GoogleSignInButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
