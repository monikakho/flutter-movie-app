import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback onClear;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_refresh);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7B61FF).withOpacity(0.14),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF2E2942),
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: 'Cari judul film...',
          hintStyle: const TextStyle(
            color: Color(0xFFAAA2C3),
            fontWeight: FontWeight.w600,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFF7B61FF),
            size: 24,
          ),
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
                  onPressed: widget.onClear,
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Color(0xFF9D95B4),
                  ),
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(
              color: Color(0xFFC9BCFF),
              width: 1.6,
            ),
          ),
        ),
      ),
    );
  }
}