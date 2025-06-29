import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        title: const Text(
          'Services',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 32),
              const Text(
                'Available services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    _buildServiceItem(
                      icon: Icons.account_balance_wallet,
                      iconColor: const Color(0xFFFF6B35),
                      title: 'Vidari accounts',
                    ),
                    const SizedBox(height: 16),
                    _buildServiceItem(
                      icon: Icons.phone_android,
                      iconColor: const Color(0xFFFFC107),
                      title: 'Mobile Money',
                    ),
                    const SizedBox(height: 16),
                    _buildServiceItem(
                      icon: Icons.account_balance,
                      iconColor: const Color(0xFF4CAF50),
                      title: 'Bank account',
                    ),
                    const SizedBox(height: 16),
                    _buildServiceItem(
                      icon: Icons.phone,
                      iconColor: const Color(0xFFE53935),
                      title: 'Airtel money',
                    ),
                    const SizedBox(height: 16),
                    _buildServiceItem(
                      icon: Icons.flash_on,
                      iconColor: const Color(0xFFE53935),
                      title: 'Electricity',
                    ),
                    const SizedBox(height: 16),
                    _buildServiceItem(
                      icon: Icons.refresh,
                      iconColor: const Color(0xFF2196F3),
                      title: 'Irembo',
                    ),
                    const SizedBox(height: 16),
                    _buildServiceItem(
                      icon: Icons.star,
                      iconColor: const Color(0xFF9C27B0),
                      title: 'Startimes',
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

  Widget _buildSearchBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Color(0xFFCCCCCC),
            size: 20,
          ),
          const SizedBox(width: 12),
          const Text(
            'Search services',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFFCCCCCC),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem({
    required IconData icon,
    required Color iconColor,
    required String title,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFF666666),
            size: 16,
          ),
        ],
      ),
    );
  }
}