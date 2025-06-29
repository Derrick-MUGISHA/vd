import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildDateSection(),
              const SizedBox(height: 32),
              _buildTypeSection(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(
          Icons.tune,
          color: Color(0xFF1A1A1A),
          size: 20,
        ),
        const SizedBox(width: 8),
        const Text(
          'Filter by',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ],
    );
  }

  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Date',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildDateOption(
                icon: Icons.calendar_today_outlined,
                title: 'Today',
                subtitle: '18 nov 2024',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDateOption(
                icon: Icons.calendar_today_outlined,
                title: 'Yesterday',
                subtitle: '18 nov 2024',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildDateOption(
                icon: Icons.calendar_today_outlined,
                title: 'Last week',
                subtitle: '18 nov 2024',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDateOption(
                icon: Icons.calendar_today_outlined,
                title: 'Last month',
                subtitle: '18 nov 2024',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildDateOption(
          icon: Icons.calendar_today_outlined,
          title: 'Custom range',
          subtitle: '',
          isFullWidth: true,
        ),
      ],
    );
  }

  Widget _buildDateOption({
    required IconData icon,
    required String title,
    required String subtitle,
    bool isFullWidth = false,
  }) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF666666),
            size: 20,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Type',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTypeOption('Airtime'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTypeOption('Bills'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTypeOption('Bills'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTypeOption('Electricity'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTypeOption('Bills'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTypeOption('Bills'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeOption(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1A1A1A),
        ),
      ),
    );
  }
}