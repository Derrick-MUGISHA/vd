import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'services/navigation_service.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/sign_up_page.dart';
import 'pages/auth/email_verification_page.dart';
import 'pages/auth/developer_panel.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize AuthService
  await AuthService().initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: 'VidarPay',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          fontFamily: 'SF Pro Display',
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        ),
        navigatorKey: NavigationService().navigatorKey,
        home: const AuthWrapper(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignUpPage(),
          '/email-verification': (context) {
            final email = ModalRoute.of(context)!.settings.arguments as String;
            return EmailVerificationPage(email: email);
          },
          '/dashboard': (context) => const HomePage(),
          '/developer': (context) => const DeveloperPanel(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        // Developer mode - skip authentication
        if (authService.isDeveloperMode) {
          return const HomePage();
        }

        // Check authentication status
        if (authService.isAuthenticated) {
          // Check if email is verified
          if (authService.isEmailVerified) {
            return const HomePage();
          } else {
            // Redirect to email verification
            return EmailVerificationPage(
              email: authService.currentUserEmail ?? '',
            );
          }
        }

        // Not authenticated - show login
        return const LoginPage();
      },
    );
  }
}

class DeveloperModeToggle extends StatelessWidget {
  const DeveloperModeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/developer');
          },
          backgroundColor: authService.isDeveloperMode 
              ? const Color(0xFF4CAF50) 
              : const Color(0xFFFF6B35),
          child: Icon(
            authService.isDeveloperMode ? Icons.developer_mode : Icons.code,
            color: Colors.white,
          ),
        );
      },
    );
  }
}