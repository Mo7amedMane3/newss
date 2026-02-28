import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newss/models/sources_response.dart';

class SourceTab extends StatelessWidget {
  final Sources source;
  final bool isSelected;
  const SourceTab({super.key, required this.source, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.blue),
      ),
      child: Text(
        source.name ?? '',
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isSelected ? Colors.white : Colors.blue,
        ),
      ),
    );
  }
}
