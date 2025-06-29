import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'notifications_page.dart';
import 'cards_page.dart';
import 'electricity_page.dart';
import 'filter_page.dart';
import 'transactions_page.dart';
import 'services_page.dart';
import 'send_money_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VidarPay',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'SF Pro Display',
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      home: const MainNavigator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const NotificationsPage(),
    const CardsPage(),
    const ElectricityPage(),
    const FilterPage(),
    const TransactionsPage(),
    const ServicesPage(),
    const SendMoneyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: Icons.notifications_outlined,
              label: 'Notifications',
              index: 0,
            ),
            _buildNavItem(
              icon: Icons.credit_card_outlined,
              label: 'Cards',
              index: 1,
            ),
            _buildNavItem(
              icon: Icons.flash_on_outlined,
              label: 'Electricity',
              index: 2,
            ),
            _buildNavItem(
              icon: Icons.tune,
              label: 'Filter',
              index: 3,
            ),
            _buildNavItem(
              icon: Icons.receipt_outlined,
              label: 'Transactions',
              index: 4,
            ),
            _buildNavItem(
              icon: Icons.apps,
              label: 'Services',
              index: 5,
            ),
            _buildNavItem(
              icon: Icons.send,
              label: 'Send Money',
              index: 6,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF4CAF50) : const Color(0xFF666666),
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isSelected ? const Color(0xFF4CAF50) : const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }
}