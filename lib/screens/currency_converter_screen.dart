import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/currency_data.dart';
import '../widgets/bottom_nav_bar.dart';

/// Halaman: Currency Converter, bentuknya seperti kalkulator konversi
/// mata uang di iPhone (angka besar + pilihan mata uang + numpad).
///
/// CATATAN "STATELESS": semua halaman lain di app ini StatelessWidget.
/// Halaman ini satu-satunya StatefulWidget, karena angka yang diketik
/// dan hasil konversi harus berubah live tiap kali user menekan tombol
/// numpad -- itu perlu `setState`. Ini pengecualian wajar dan lumrah
/// dijelaskan begitu saja di laporan tugas kalian.
class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  String _display = '100';
  double? _operand;
  String? _pendingOperator;
  bool _waitingForOperand = false;

  String _fromCode = 'IDR';
  String _toCode = 'USD';

  double get _displayValue => double.tryParse(_display) ?? 0;
  CurrencyInfo get _fromInfo => currencyByCode(_fromCode);
  CurrencyInfo get _toInfo => currencyByCode(_toCode);
  double get _convertedValue => convertCurrency(_displayValue, _fromCode, _toCode);

  // ---------- Numpad logic ----------

  void _inputDigit(String digit) {
    setState(() {
      if (_waitingForOperand || _display == '0') {
        _display = digit;
        _waitingForOperand = false;
      } else if (_display.length < 12) {
        _display += digit;
      }
    });
  }

  void _inputDecimal() {
    setState(() {
      if (_waitingForOperand) {
        _display = '0.';
        _waitingForOperand = false;
      } else if (!_display.contains('.')) {
        _display += '.';
      }
    });
  }

  void _backspace() {
    setState(() {
      if (_display.length <= 1 || (_display.startsWith('-') && _display.length == 2)) {
        _display = '0';
      } else {
        _display = _display.substring(0, _display.length - 1);
      }
    });
  }

  void _toggleSign() {
    setState(() {
      if (_display.startsWith('-')) {
        _display = _display.substring(1);
      } else if (_display != '0') {
        _display = '-$_display';
      }
    });
  }

  void _percent() {
    setState(() {
      _display = _trimResult(_displayValue / 100);
    });
  }

  double _calculate(double a, double b, String op) {
    switch (op) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '×':
        return a * b;
      case '÷':
        return b == 0 ? 0 : a / b;
      default:
        return b;
    }
  }

  String _trimResult(double v) {
    if (v == v.roundToDouble() && v.abs() < 1e12) return v.toStringAsFixed(0);
    return v.toStringAsFixed(4).replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
  }

  void _chooseOperator(String op) {
    setState(() {
      if (_pendingOperator != null && !_waitingForOperand) {
        _operand = _calculate(_operand ?? 0, _displayValue, _pendingOperator!);
        _display = _trimResult(_operand!);
      } else {
        _operand = _displayValue;
      }
      _pendingOperator = op;
      _waitingForOperand = true;
    });
  }

  void _equals() {
    if (_pendingOperator == null || _operand == null) return;
    setState(() {
      _display = _trimResult(_calculate(_operand!, _displayValue, _pendingOperator!));
      _pendingOperator = null;
      _operand = null;
      _waitingForOperand = true;
    });
  }

  void _clearAll() {
    setState(() {
      _display = '0';
      _operand = null;
      _pendingOperator = null;
      _waitingForOperand = false;
    });
  }

  // ---------- Currency swap & picker ----------

  void _swapCurrencies() {
    final convertedNow = _convertedValue;
    setState(() {
      final tmp = _fromCode;
      _fromCode = _toCode;
      _toCode = tmp;
      _display = _trimResult(convertedNow);
      _operand = null;
      _pendingOperator = null;
      _waitingForOperand = false;
    });
  }

  Future<void> _pickCurrency({required bool isFrom}) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isFrom ? 'Pilih mata uang asal' : 'Pilih mata uang tujuan',
                style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
              const SizedBox(height: 8),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: currencies.length,
                  itemBuilder: (context, index) {
                    final c = currencies[index];
                    final isSelected = c.code == (isFrom ? _fromCode : _toCode);
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.surfaceLight,
                        child: Text(c.symbol,
                            style: const TextStyle(color: AppColors.white, fontSize: 13)),
                      ),
                      title: Text(c.code,
                          style: const TextStyle(
                              color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                      subtitle: Text(c.name,
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      trailing: isSelected
                          ? const Icon(Icons.check, color: AppColors.white)
                          : null,
                      onTap: () => Navigator.of(context).pop(c.code),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    if (selected == null) return;
    setState(() {
      if (isFrom) {
        _fromCode = selected;
      } else {
        _toCode = selected;
      }
    });
  }

  // ---------- UI ----------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('Currency Converter', style: TextStyle(color: AppColors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Clear',
            icon: const Text('C', style: TextStyle(color: AppColors.textSecondary, fontSize: 16)),
            onPressed: _clearAll,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            groupRawInput(_display, _fromInfo),
                            style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _CurrencyPill(
                        code: _fromCode,
                        onTap: () => _pickCurrency(isFrom: true),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _swapCurrencies,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          child: const Icon(Icons.swap_vert,
                              color: Colors.orangeAccent, size: 22),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Divider(color: AppColors.border, thickness: 0.8),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            formatNumber(_convertedValue, _toInfo),
                            style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 34,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _CurrencyPill(
                        code: _toCode,
                        muted: true,
                        onTap: () => _pickCurrency(isFrom: false),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${formatCurrency(1, _toInfo.code)} = ${formatNumber(convertCurrency(1, _toCode, _fromCode), _fromInfo)} ${_fromInfo.code}',
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(child: _NumPad(
              onDigit: _inputDigit,
              onDecimal: _inputDecimal,
              onBackspace: _backspace,
              onToggleSign: _toggleSign,
              onPercent: _percent,
              onOperator: _chooseOperator,
              onEquals: _equals,
              activeOperator: _waitingForOperand ? _pendingOperator : null,
            )),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }
}

class _CurrencyPill extends StatelessWidget {
  final String code;
  final VoidCallback onTap;
  final bool muted;

  const _CurrencyPill({required this.code, required this.onTap, this.muted = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              code,
              style: TextStyle(
                color: muted ? AppColors.textSecondary : AppColors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(Icons.unfold_more,
                size: 16, color: muted ? AppColors.textSecondary : AppColors.white),
          ],
        ),
      ),
    );
  }
}

class _NumPad extends StatelessWidget {
  final void Function(String) onDigit;
  final VoidCallback onDecimal;
  final VoidCallback onBackspace;
  final VoidCallback onToggleSign;
  final VoidCallback onPercent;
  final void Function(String) onOperator;
  final VoidCallback onEquals;
  final String? activeOperator;

  const _NumPad({
    required this.onDigit,
    required this.onDecimal,
    required this.onBackspace,
    required this.onToggleSign,
    required this.onPercent,
    required this.onOperator,
    required this.onEquals,
    required this.activeOperator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Expanded(child: Row(children: [
            _key('⌫', style: _KeyStyle.grey, onTap: onBackspace),
            _key('+/-', style: _KeyStyle.grey, onTap: onToggleSign),
            _key('%', style: _KeyStyle.grey, onTap: onPercent),
            _key('÷', style: _KeyStyle.orange, onTap: () => onOperator('÷'),
                isActive: activeOperator == '÷'),
          ])),
          Expanded(child: Row(children: [
            _key('7', onTap: () => onDigit('7')),
            _key('8', onTap: () => onDigit('8')),
            _key('9', onTap: () => onDigit('9')),
            _key('×', style: _KeyStyle.orange, onTap: () => onOperator('×'),
                isActive: activeOperator == '×'),
          ])),
          Expanded(child: Row(children: [
            _key('4', onTap: () => onDigit('4')),
            _key('5', onTap: () => onDigit('5')),
            _key('6', onTap: () => onDigit('6')),
            _key('−', style: _KeyStyle.orange, onTap: () => onOperator('-'),
                isActive: activeOperator == '-'),
          ])),
          Expanded(child: Row(children: [
            _key('1', onTap: () => onDigit('1')),
            _key('2', onTap: () => onDigit('2')),
            _key('3', onTap: () => onDigit('3')),
            _key('+', style: _KeyStyle.orange, onTap: () => onOperator('+'),
                isActive: activeOperator == '+'),
          ])),
          Expanded(child: Row(children: [
            _key('0', onTap: () => onDigit('0'), flex: 2),
            _key('.', onTap: onDecimal),
            _key('=', style: _KeyStyle.orange, onTap: onEquals),
          ])),
        ],
      ),
    );
  }

  Widget _key(
    String label, {
    required VoidCallback onTap,
    _KeyStyle style = _KeyStyle.dark,
    int flex = 1,
    bool isActive = false,
  }) {
    Color bg;
    Color fg;
    switch (style) {
      case _KeyStyle.orange:
        bg = isActive ? AppColors.white : Colors.orangeAccent;
        fg = isActive ? Colors.orangeAccent : Colors.black;
        break;
      case _KeyStyle.grey:
        bg = AppColors.surfaceLight;
        fg = AppColors.white;
        break;
      case _KeyStyle.dark:
        bg = AppColors.surface;
        fg = AppColors.white;
        break;
    }

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Material(
          color: bg,
          shape: const StadiumBorder(),
          child: InkWell(
            customBorder: const StadiumBorder(),
            onTap: onTap,
            child: Center(
              child: Text(
                label,
                style: TextStyle(color: fg, fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum _KeyStyle { dark, grey, orange }
