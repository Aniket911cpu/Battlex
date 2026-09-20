import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import '../models/transaction_model.dart';

final walletProvider = StateNotifierProvider<WalletNotifier, WalletState>((ref) {
  return WalletNotifier();
});

class WalletState {
  final double balance;
  final List<TransactionModel> transactions;

  WalletState({required this.balance, required this.transactions});

  WalletState copyWith({double? balance, List<TransactionModel>? transactions}) {
    return WalletState(
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
    );
  }
}

class WalletNotifier extends StateNotifier<WalletState> {
  WalletNotifier() : super(WalletState(balance: 0, transactions: [])) {
    _loadWallet();
  }

  void _loadWallet() {
    final box = Hive.box('walletBox');
    final balance = box.get('balance', defaultValue: 2450.0);
    
    final txString = box.get('transactions');
    List<TransactionModel> txs = [];
    if (txString != null) {
      final List<dynamic> jsonList = jsonDecode(txString);
      txs = jsonList.map((e) => TransactionModel.fromJson(e)).toList();
    } else {
      // Mock initial transactions
      txs = [
        TransactionModel(id: 'tx1', title: 'Winnings - BGMI Match', date: 'Today, 10:30 PM', amount: 500, type: 'credit', status: 'SUCCESS'),
        TransactionModel(id: 'tx2', title: 'Entry Fee - BGMI Match', date: 'Today, 09:00 PM', amount: 50, type: 'debit', status: 'SUCCESS'),
        TransactionModel(id: 'tx3', title: 'Cash Deposit', date: 'Oct 15, 2026', amount: 2000, type: 'credit', status: 'SUCCESS'),
      ];
      _saveTransactions(txs);
    }
    
    state = WalletState(balance: balance, transactions: txs);
  }

  void _saveBalance(double balance) {
    Hive.box('walletBox').put('balance', balance);
  }

  void _saveTransactions(List<TransactionModel> txs) {
    Hive.box('walletBox').put('transactions', jsonEncode(txs.map((e) => e.toJson()).toList()));
  }

  Future<void> addCash(double amount) async {
    // Simulate delay
    await Future.delayed(const Duration(seconds: 1));
    final newBalance = state.balance + amount;
    
    final tx = TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Cash Deposit',
      date: 'Just now',
      amount: amount,
      type: 'credit',
      status: 'SUCCESS',
    );
    
    final newTxs = [tx, ...state.transactions];
    state = state.copyWith(balance: newBalance, transactions: newTxs);
    
    _saveBalance(newBalance);
    _saveTransactions(newTxs);
  }

  Future<bool> deductCash(double amount, String reason) async {
    if (state.balance >= amount) {
      final newBalance = state.balance - amount;
      final tx = TransactionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: reason,
        date: 'Just now',
        amount: amount,
        type: 'debit',
        status: 'SUCCESS',
      );
      
      final newTxs = [tx, ...state.transactions];
      state = state.copyWith(balance: newBalance, transactions: newTxs);
      
      _saveBalance(newBalance);
      _saveTransactions(newTxs);
      return true;
    }
    return false; // Insufficient funds
  }
}
