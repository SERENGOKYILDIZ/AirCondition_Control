import 'package:flutter/material.dart';

class ACSelector extends StatelessWidget {
  final String selectedAC;
  final List<String> acList;
  final Function(String) onACSelected;

  const ACSelector({
    super.key,
    required this.selectedAC,
    required this.acList,
    required this.onACSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
             decoration: BoxDecoration(
         color: const Color(0xFF1E1E1E),
         borderRadius: BorderRadius.circular(16),
         boxShadow: [
           BoxShadow(
             color: Colors.black.withOpacity(0.3),
             spreadRadius: 1,
             blurRadius: 15,
             offset: const Offset(0, 4),
           ),
         ],
       ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.ac_unit,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
                             Text(
                 'AC Selection',
                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
                   fontWeight: FontWeight.bold,
                 ),
               ),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: selectedAC,
                         decoration: InputDecoration(
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(12),
                 borderSide: BorderSide(
                   color: Theme.of(context).colorScheme.primary,
                 ),
               ),
               enabledBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(12),
                 borderSide: BorderSide(
                   color: Colors.grey.shade600,
                 ),
               ),
               focusedBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(12),
                 borderSide: BorderSide(
                   color: Theme.of(context).colorScheme.primary,
                   width: 2,
                 ),
               ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            items: acList.map((String ac) {
              return DropdownMenuItem<String>(
                value: ac,
                child: Text(ac),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                onACSelected(newValue);
              }
            },
          ),
        ],
      ),
    );
  }
}
