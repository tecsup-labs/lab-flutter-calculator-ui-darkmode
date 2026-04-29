import 'package:flutter/material.dart';

void main() {
  runApp(const PremiumCalculatorApp());
}

class PremiumCalculatorApp extends StatelessWidget {
  const PremiumCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Inter'),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  bool isDarkMode = true;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bgColorTop = isDarkMode ? const Color(0xFF232629) : const Color(0xFFF0F2F5);
    final bgColorBottom = isDarkMode ? const Color(0xFF18191C) : const Color(0xFFE6E9EF);
    final displayTextColor = isDarkMode ? Colors.white : const Color(0xFF2D2E33);
    final secondaryTextColor = isDarkMode ? Colors.white24 : Colors.black26;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [bgColorTop, bgColorBottom],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              children: [
                // Top Bar
                Row(
                  children: [
                    _buildNeumorphicIcon(
                      onTap: toggleTheme,
                      icon: isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight_round,
                    ),
                  ],
                ),
                // Display Area
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          isDarkMode ? '4,900 + 15,910' : '30,820 + 9,205',
                          style: TextStyle(
                            fontSize: 20,
                            color: secondaryTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            isDarkMode ? '20,810' : '40,025',
                            style: TextStyle(
                              fontSize: 72,
                              color: displayTextColor,
                              fontWeight: FontWeight.w200,
                              letterSpacing: -2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Buttons Area
                Expanded(
                  flex: 6,
                  child: _buildButtonsGrid(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNeumorphicIcon({required VoidCallback onTap, required IconData icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF2E3136) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(4, 4),
            ),
            BoxShadow(
              color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white,
              blurRadius: 10,
              offset: const Offset(-4, -4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: isDarkMode ? Colors.white70 : Colors.black54,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildButtonsGrid() {
    return Column(
      children: [
        Expanded(child: _buildRow(['C', '+/-', '%', '÷'])),
        const SizedBox(height: 12),
        Expanded(child: _buildRow(['7', '8', '9', '×'])),
        const SizedBox(height: 12),
        Expanded(child: _buildRow(['4', '5', '6', '-'])),
        const SizedBox(height: 12),
        Expanded(child: _buildRow(['1', '2', '3', '+'])),
        const SizedBox(height: 12),
        Expanded(
          child: Row(
            children: [
              Expanded(flex: 2, child: _buildButton('0')),
              const SizedBox(width: 12),
              Expanded(child: _buildButton('.')),
              const SizedBox(width: 12),
              Expanded(child: _buildButton('=', isOperator: true)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(List<String> labels) {
    return Row(
      children: labels.map((label) {
        bool isOperator = ['÷', '×', '-', '+', '='].contains(label);
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: labels.last == label ? 0 : 12),
            child: _buildButton(label, isOperator: isOperator),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildButton(String label, {bool isOperator = false}) {
    bool isSpecial = ['C', '+/-', '%'].contains(label);
    
    final baseColor = isOperator 
        ? const Color(0xFFF2851C)
        : (isDarkMode 
            ? (isSpecial ? const Color(0xFF353A45) : const Color(0xFF242830))
            : (isSpecial ? const Color(0xFFDDE2EC) : const Color(0xFFFFFFFF)));

    final textColor = isOperator 
        ? Colors.white 
        : (isDarkMode ? Colors.white : const Color(0xFF2D2E33));

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black.withOpacity(0.7) : Colors.black.withOpacity(0.15),
            offset: const Offset(8, 8),
            blurRadius: 16,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: isDarkMode ? Colors.white.withOpacity(0.04) : Colors.white,
            offset: const Offset(-6, -6),
            blurRadius: 16,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            // Surface Gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isOperator 
                    ? [const Color(0xFFFEAC45), const Color(0xFFF2851C)]
                    : isDarkMode
                      ? [baseColor.withOpacity(0.8), baseColor]
                      : [Colors.white, baseColor],
                ),
                border: Border.all(
                  color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.6),
                  width: 1.2,
                ),
              ),
            ),
            // Sunken effect (Inner Shadow simulation)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.08),
                    width: 2.2,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(isDarkMode ? 0.2 : 0.06),
                      Colors.transparent,
                      Colors.white.withOpacity(isDarkMode ? 0.06 : 0.2),
                    ],
                    stops: const [0.0, 0.45, 1.0],
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
