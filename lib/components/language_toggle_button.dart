import 'package:flutter/material.dart';
import './language_controller.dart';

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  static const Color primaryOrange = Color(0xFFFF7A1A);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: languageController,
      builder: (_, isEnglish, __) {
        return Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: primaryOrange, width: 1.2),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: languageController.toggle,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _langChip(
                  text: 'EN',
                  active: isEnglish,
                ),
                _langChip(
                  text: 'HI',
                  active: !isEnglish,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _langChip({required String text, required bool active}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: active ? primaryOrange : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: active ? Colors.white : primaryOrange,
        ),
      ),
    );
  }
}
