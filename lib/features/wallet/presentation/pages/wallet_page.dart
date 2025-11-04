import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/professional_theme.dart';

class WalletPage extends ConsumerStatefulWidget {
  const WalletPage({super.key});

  @override
  ConsumerState<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends ConsumerState<WalletPage> {
  final double _walletBalance = 2500.00;
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      type: TransactionType.credit,
      amount: 500.00,
      description: 'Consultation with Dr. Elena Petrova',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      status: TransactionStatus.completed,
    ),
    Transaction(
      id: '2',
      type: TransactionType.debit,
      amount: 800.00,
      description: 'Video Call with Prof. Rahul Sharma',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      status: TransactionStatus.completed,
    ),
    Transaction(
      id: '3',
      type: TransactionType.credit,
      amount: 100.00,
      description: 'Referral Bonus',
      timestamp: DateTime.now().subtract(const Duration(days: 5)),
      status: TransactionStatus.completed,
    ),
    Transaction(
      id: '4',
      type: TransactionType.credit,
      amount: 2000.00,
      description: 'Wallet Top-up',
      timestamp: DateTime.now().subtract(const Duration(days: 7)),
      status: TransactionStatus.completed,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: ProfessionalColors.background,
      appBar: AppBar(
        title: const Text('My Wallet'),
      ),
      body: Column(
        children: [
          // Wallet Balance Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ProfessionalColors.primary,
                  ProfessionalColors.primaryLight,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wallet Balance',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '₹',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      _walletBalance.toStringAsFixed(2),
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Add money
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add Money'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: ProfessionalColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Withdraw
                        },
                        icon: const Icon(Icons.arrow_upward),
                        label: const Text('Withdraw'),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Transaction History
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transaction History',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // View all transactions
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
          ),

          // Transactions List
          Expanded(
            child: _transactions.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 64,
                          color: ProfessionalColors.textSecondary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No transactions yet',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: ProfessionalColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _transactions.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final transaction = _transactions[index];
                      return _buildTransactionItem(context, transaction);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, Transaction transaction) {
    final theme = Theme.of(context);
    final isCredit = transaction.type == TransactionType.credit;

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (isCredit ? ProfessionalColors.success : ProfessionalColors.error)
              .withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          isCredit ? Icons.arrow_downward : Icons.arrow_upward,
          color: isCredit ? ProfessionalColors.success : ProfessionalColors.error,
          size: 20,
        ),
      ),
      title: Text(
        transaction.description,
        style: theme.textTheme.titleSmall,
      ),
      subtitle: Text(
        _formatDate(transaction.timestamp),
        style: theme.textTheme.bodySmall,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${isCredit ? '+' : '-'}₹${transaction.amount.toStringAsFixed(2)}',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isCredit ? ProfessionalColors.success : ProfessionalColors.error,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: transaction.status == TransactionStatus.completed
                  ? ProfessionalColors.success.withOpacity(0.1)
                  : ProfessionalColors.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              transaction.status == TransactionStatus.completed
                  ? 'Completed'
                  : 'Pending',
              style: theme.textTheme.bodySmall?.copyWith(
                color: transaction.status == TransactionStatus.completed
                    ? ProfessionalColors.success
                    : ProfessionalColors.warning,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

enum TransactionType { credit, debit }

enum TransactionStatus { completed, pending, failed }

class Transaction {
  final String id;
  final TransactionType type;
  final double amount;
  final String description;
  final DateTime timestamp;
  final TransactionStatus status;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.timestamp,
    required this.status,
  });
}

