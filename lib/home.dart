import 'package:flutter/material.dart';
import 'models/card_model.dart';
import 'models/transaction_model.dart';
import 'widgets/custom_card.dart';
import 'widgets/transaction_item.dart';
import 'widgets/quick_action_button.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      CardModel(
        cardNumber: '1234567812345678',
        cardHolder: 'JOHN SMITH',
        expiryDate: '12/25',
        cvv: '123',
        cardType: 'Debit Card',
        balance: 5420.50,
        isActive: true,
      ),
      CardModel(
        cardNumber: '8765432187654321',
        cardHolder: 'JOHN SMITH',
        expiryDate: '08/26',
        cvv: '456',
        cardType: 'Credit Card',
        balance: 2150.00,
        isActive: false,
      ),
    ];

    final transactions = [
      TransactionModel(
        id: '1',
        title: 'Grocery Shopping',
        subtitle: 'Walmart Supercenter',
        amount: 85.50,
        date: DateTime.now().subtract(const Duration(hours: 2)),
        type: 'expense',
        icon: 'shopping',
        isIncome: false,
      ),
      TransactionModel(
        id: '2',
        title: 'Salary Deposit',
        subtitle: 'Monthly Salary',
        amount: 3500.00,
        date: DateTime.now().subtract(const Duration(days: 1)),
        type: 'income',
        icon: 'salary',
        isIncome: true,
      ),
      TransactionModel(
        id: '3',
        title: 'Restaurant',
        subtitle: 'Pizza Palace',
        amount: 32.75,
        date: DateTime.now().subtract(const Duration(days: 2)),
        type: 'expense',
        icon: 'food',
        isIncome: false,
      ),
      TransactionModel(
        id: '4',
        title: 'Investment Return',
        subtitle: 'Stock Dividend',
        amount: 125.00,
        date: DateTime.now().subtract(const Duration(days: 3)),
        type: 'income',
        icon: 'investment',
        isIncome: true,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'John Smith',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3436),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: Color(0xFF2D3436),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Balance Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6C5CE7).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Balance',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '\$7,570.50',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Income',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  '\$3,625.00',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expenses',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  '\$1,245.25',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Quick Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    QuickActionButton(
                      icon: Icons.send_outlined,
                      label: 'Send',
                      onTap: () {},
                      backgroundColor: const Color(0xFF6C5CE7),
                    ),
                    QuickActionButton(
                      icon: Icons.download_outlined,
                      label: 'Request',
                      onTap: () {},
                      backgroundColor: const Color(0xFF00B894),
                    ),
                    QuickActionButton(
                      icon: Icons.credit_card_outlined,
                      label: 'Cards',
                      onTap: () {},
                      backgroundColor: const Color(0xFFE17055),
                    ),
                    QuickActionButton(
                      icon: Icons.more_horiz,
                      label: 'More',
                      onTap: () {},
                      backgroundColor: const Color(0xFF636E72),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // My Cards Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'My Cards',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3436),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: Color(0xFF6C5CE7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Cards Horizontal List
                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      return CustomCard(
                        card: cards[index],
                        isSmall: true,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),

                // Recent Transactions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Transactions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3436),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: Color(0xFF6C5CE7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Transactions List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    return TransactionItem(transaction: transactions[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}