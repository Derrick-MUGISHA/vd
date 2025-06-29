import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Header
                _buildHeader(),
                const SizedBox(height: 32),
                
                // Wallet Balance Card
                _buildWalletBalanceCard(),
                const SizedBox(height: 24),
                
                // Action Buttons
                _buildActionButtons(),
                const SizedBox(height: 32),
                
                // Quick Actions Section
                _buildQuickActionsSection(),
                const SizedBox(height: 32),
                
                // Family Wallet Banner
                _buildFamilyWalletBanner(),
                const SizedBox(height: 32),
                
                // Transactions Section
                _buildTransactionsSection(),
                const SizedBox(height: 100), // Bottom padding for navigation
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // Profile Avatar
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFFF6B35),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Text(
              'Kh',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        
        // Greeting Text
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi K Hypolite',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
        ),
        
        // Notification Icon
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.notifications_outlined,
            color: Color(0xFF666666),
            size: 20,
          ),
        ),
        const SizedBox(width: 8),
        
        // Settings Icon
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.settings_outlined,
            color: Color(0xFF666666),
            size: 20,
          ),
        ),
        const SizedBox(width: 8),
        
        // Filter Icon
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFFF6B35),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.tune,
            color: Colors.white,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildWalletBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Wallet Balance',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.visibility_outlined,
                size: 16,
                color: Color(0xFF666666),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F8FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4A90E2),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'RWF',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A90E2),
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 16,
                      color: Color(0xFF4A90E2),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            '30990',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.add,
            label: '',
            backgroundColor: const Color(0xFFFF6B35),
            iconColor: Colors.white,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: _buildActionButton(
            icon: Icons.south_outlined,
            label: 'Withdraw',
            backgroundColor: const Color(0xFFF0F8FF),
            iconColor: const Color(0xFF4CAF50),
            textColor: const Color(0xFF4CAF50),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: _buildActionButton(
            icon: Icons.sync_alt,
            label: 'Convert',
            backgroundColor: const Color(0xFFF0F8FF),
            iconColor: const Color(0xFF4CAF50),
            textColor: const Color(0xFF4CAF50),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color iconColor,
    Color? textColor,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
          if (label.isNotEmpty) ...[
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textColor ?? iconColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Quick actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const Spacer(),
            Text(
              'Edit',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFFF6B35),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildQuickActionItem(
              icon: Icons.payment_outlined,
              label: 'Pay',
              backgroundColor: const Color(0xFFF0F8FF),
              iconColor: const Color(0xFF4CAF50),
            ),
            _buildQuickActionItem(
              icon: Icons.phone_android_outlined,
              label: 'Airtime',
              backgroundColor: const Color(0xFFF0F8FF),
              iconColor: const Color(0xFF4CAF50),
            ),
            _buildQuickActionItem(
              icon: Icons.flash_on_outlined,
              label: 'Electricity',
              backgroundColor: const Color(0xFFF0F8FF),
              iconColor: const Color(0xFF4CAF50),
            ),
            _buildQuickActionItem(
              icon: Icons.more_horiz,
              label: 'More',
              backgroundColor: const Color(0xFFF0F8FF),
              iconColor: const Color(0xFF4CAF50),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionItem({
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color iconColor,
  }) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _buildFamilyWalletBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F8FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Family Wallet',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Added',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Set Spending Limits With Linked Family Accounts.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Transactions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const Spacer(),
            Text(
              'View All',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFFF6B35),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildTransactionItem(
          title: 'School uniforms',
          date: '24 april 2025',
          amount: '+ RWF\n90,000',
          isIncome: true,
        ),
        const SizedBox(height: 16),
        _buildTransactionItem(
          title: 'School uniforms',
          date: '24 april 2025',
          amount: '+ RWF\n90,000',
          isIncome: true,
        ),
      ],
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String date,
    required String amount,
    required bool isIncome,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F8FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.receipt_outlined,
            color: const Color(0xFF4CAF50),
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF666666),
                ),
              ),
            ],
          ),
        ),
        Text(
          amount,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isIncome ? const Color(0xFF4CAF50) : const Color(0xFFFF6B35),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
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
            icon: Icons.home,
            label: 'Home',
            isSelected: true,
          ),
          _buildNavItem(
            icon: Icons.send_outlined,
            label: 'Send',
            isSelected: false,
          ),
          _buildNavItem(
            icon: Icons.credit_card_outlined,
            label: 'Cards',
            isSelected: false,
          ),
          _buildNavItem(
            icon: Icons.more_horiz,
            label: 'More',
            isSelected: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isSelected ? const Color(0xFF4CAF50) : const Color(0xFF666666),
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected ? const Color(0xFF4CAF50) : const Color(0xFF666666),
          ),
        ),
      ],
    );
  }
}