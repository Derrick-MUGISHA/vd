import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        title: const Text(
          'Cards',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: Color(0xFF666666),
              size: 24,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.help_outline,
              color: Color(0xFF666666),
              size: 24,
            ),
            onPressed: () {},
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const Icon(
              Icons.filter_alt,
              color: Color(0xFFFF6B35),
              size: 24,
            ),
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildCardSection(),
              const SizedBox(height: 24),
              _buildActionButtons(),
              const SizedBox(height: 24),
              _buildRequestPhysicalCard(),
              const SizedBox(height: 32),
              _buildSpendingsSection(),
              const SizedBox(height: 24),
              _buildTransactionsSection(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardSection() {
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B35),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'VIDARPAY',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(
                    Icons.visibility_outlined,
                    size: 16,
                    color: Color(0xFF666666),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Hide info',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'K Hypolite',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '•••••••• 4895',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A1A1A),
              letterSpacing: 2,
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
            icon: Icons.north_outlined,
            label: 'Top up',
            color: const Color(0xFF4CAF50),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionButton(
            icon: Icons.south_outlined,
            label: 'Withdraw',
            color: const Color(0xFF4CAF50),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionButton(
            icon: Icons.receipt_outlined,
            label: 'Details',
            color: const Color(0xFF4CAF50),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionButton(
            icon: Icons.settings_outlined,
            label: 'Setting',
            color: const Color(0xFF4CAF50),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: color,
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

  Widget _buildRequestPhysicalCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F8FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        'Request Physical card',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF4CAF50),
        ),
      ),
    );
  }

  Widget _buildSpendingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Spendings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const Spacer(),
            const Text(
              'View All',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFFFF6B35),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          '30990',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'This week ( April 14 - April 31 2024',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transactions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 16),
        _buildTransactionItem(
          title: 'School uniforms',
          date: '24 april 2025',
          amount: '+ RWF\n90,000',
        ),
        const SizedBox(height: 16),
        _buildTransactionItem(
          title: 'School uniforms',
          date: '24 april 2025',
          amount: '+ RWF\n90,000',
        ),
      ],
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String date,
    required String amount,
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
          child: const Icon(
            Icons.receipt_outlined,
            color: Color(0xFF4CAF50),
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
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4CAF50),
          ),
        ),
      ],
    );
  }
}