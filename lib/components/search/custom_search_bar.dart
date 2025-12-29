import 'package:flutter/material.dart';

/// Custom Search Bar reusable dengan styling konsisten
class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;
  final String value;
  final TextEditingController? controller;

  const CustomSearchBar({
    super.key,
    this.hintText = "Cari...",
    required this.onChanged,
    this.onClear,
    this.value = "",
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.search, color: Color(0xFF1E56A0)),
          suffixIcon: value.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: onClear,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD6E4F0)),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}
