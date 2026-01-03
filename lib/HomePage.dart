import 'package:flutter/material.dart';
import 'package:mobile/AddTransactionPage.dart';
import 'TransactionList.dart';
import 'Transaction.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  HomePage({Key? key, required this.onThemeToggle, required this.isDarkMode})
      : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  bool _isLoggedIn = false;
  String _userName = '';
  bool _isLoading = false;

  void _showAuthDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return const AuthDialog(
          parentContext: null,
        );
      },
    ).then((result) {
      if (result != null && result is Map<String, dynamic>) {
        if (result['success'] == true) {
          setState(() {
            _isLoggedIn = true;
            _userName = result['userName'];
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Welcome, $_userName!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(result['message'] ?? 'Authentication failed')),
          );
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Summary"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        leading: _isLoggedIn
            ? Tooltip(
          message: 'Logout',
          child: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              setState(() {
                _isLoggedIn = false;
                _userName = '';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully')),
              );
            },
          ),
        )
            : Tooltip(
          message: 'Login',
          child: IconButton(
            icon: const Icon(Icons.login),
            onPressed: _showAuthDialog,
          ),
        ),
        actions: [
          Tooltip(
            message: widget.isDarkMode ? 'Light Mode' : 'Dark Mode',
            child: IconButton(
              icon: Icon(
                  widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: widget.onThemeToggle,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isLoggedIn)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.indigo[50],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Welcome, $_userName! 👋',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 8),
            const Text(
              'Balances',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),

            // USD Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('USD', style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                        Icon(Icons.attach_money, color: Colors.indigo)
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.arrow_downward, color: Colors.green),
                        const SizedBox(width: 8),
                        const Expanded(child: Text('Income')),
                        Text('\$${Transaction
                            .totalIncome('USD')
                            .toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.green,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.arrow_upward, color: Colors.red),
                        const SizedBox(width: 8),
                        const Expanded(child: Text('Expenses')),
                        Text('\$${Transaction
                            .totalExpenses('USD')
                            .toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.red,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      children: [
                        const Expanded(child: Text('Balance', style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))),
                        Text('\$${Transaction.balance('USD').toStringAsFixed(
                            2)}', style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // LBP Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('LBP', style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                        Icon(Icons.money, color: Colors.indigo)
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.arrow_downward, color: Colors.green),
                        const SizedBox(width: 8),
                        const Expanded(child: Text('Income')),
                        Text('${Transaction.totalIncome('LBP').toStringAsFixed(
                            2)} LBP', style: const TextStyle(color: Colors
                            .green, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.arrow_upward, color: Colors.red),
                        const SizedBox(width: 8),
                        const Expanded(child: Text('Expenses')),
                        Text('${Transaction
                            .totalExpenses('LBP')
                            .toStringAsFixed(2)} LBP',
                            style: const TextStyle(color: Colors.red,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      children: [
                        const Expanded(child: Text('Balance', style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))),
                        Text('${Transaction.balance('LBP').toStringAsFixed(
                            2)} LBP', style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (b) => AddTransaction()),
                      ).then((_) => setState(() {}));
                    },
                    icon: const Icon(Icons.add_circle_outline),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      child: Text('Add Transaction'),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (c) => TransactionList()));
                    },
                    icon: const Icon(Icons.account_balance_wallet_rounded,
                        color: Colors.indigo),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      child: Text('View Transactions',
                          style: TextStyle(color: Colors.indigo)),
                    ),
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.indigo),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class AuthDialog extends StatefulWidget {
  final BuildContext? parentContext;

  const AuthDialog({Key? key, this.parentContext}) : super(key: key);

  @override
  State<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  bool _isLoginMode = true;
  bool _isLoading = false;

  // Login fields
  String _loginEmail = '';
  String _loginPassword = '';

  // Register fields
  String _registerFullName = '';
  String _registerEmail = '';
  String _registerPhone = '';
  String _registerPassword = '';
  String _registerPasswordConfirm = '';

  Future<void> _handleLogin() async {
    if (_loginEmail.isEmpty || _loginPassword.isEmpty) {
      _showError('Please fill all fields');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // TODO: Call API login method
      // final result = await AuthService.login(_loginEmail, _loginPassword);

      // For now, simulating success
      Navigator.of(context).pop({
        'success': true,
        'userName': _loginEmail.split('@')[0],
      });
    } catch (e) {
      _showError('Login failed: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleRegister() async {
    if (_registerFullName.isEmpty ||
        _registerEmail.isEmpty ||
        _registerPhone.isEmpty ||
        _registerPassword.isEmpty ||
        _registerPasswordConfirm.isEmpty) {
      _showError('Please fill all fields');
      return;
    }

    if (_registerPassword != _registerPasswordConfirm) {
      _showError('Passwords do not match');
      return;
    }

    if (_registerPassword.length < 6) {
      _showError('Password must be at least 6 characters');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // TODO: Call API register method
      // final result = await AuthService.register(
      //   fullName: _registerFullName,
      //   email: _registerEmail,
      //   phone: _registerPhone,
      //   password: _registerPassword,
      // );

      // For now, simulating success
      Navigator.of(context).pop({
        'success': true,
        'userName': _registerFullName.split(' ')[0],
      });
    } catch (e) {
      _showError('Registration failed: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isLoginMode ? 'Login' : 'Register'),
      contentPadding: const EdgeInsets.all(16),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isLoginMode) ...[
              // Login Mode
              TextField(
                enabled: !_isLoading,
                decoration: const InputDecoration(
                  labelText: 'Email or Phone',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _loginEmail = value,
              ),
              const SizedBox(height: 12),
              TextField(
                enabled: !_isLoading,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _loginPassword = value,
              ),
            ] else
              ...[
                // Register Mode
                TextField(
                  enabled: !_isLoading,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _registerFullName = value,
                ),
                const SizedBox(height: 12),
                TextField(
                  enabled: !_isLoading,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _registerEmail = value,
                ),
                const SizedBox(height: 12),
                TextField(
                  enabled: !_isLoading,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _registerPhone = value,
                ),
                const SizedBox(height: 12),
                TextField(
                  enabled: !_isLoading,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _registerPassword = value,
                ),
                const SizedBox(height: 12),
                TextField(
                  enabled: !_isLoading,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _registerPasswordConfirm = value,
                ),
              ],
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : (_isLoginMode ? _handleLogin : _handleRegister),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: _isLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                )
                    : Text(_isLoginMode ? 'Login' : 'Register'),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _isLoading
                  ? null
                  : () {
                setState(() => _isLoginMode = !_isLoginMode);
              },
              child: Text(
                _isLoginMode
                    ? "Don't have an account? Register"
                    : 'Already have an account? Login',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
