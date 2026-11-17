
import 'package:flutter/material.dart';

class SkinProfileScreen extends StatefulWidget {
  const SkinProfileScreen({super.key});

  @override
  State<SkinProfileScreen> createState() =>
      _SkinProfileScreenState();
}

class _SkinProfileScreenState extends State<SkinProfileScreen> {
  String? selectedSkinType;

  final Set<String> selectedConcerns = {};

  final List<String> skinTypes = [
    'Dry',
    'Oily',
    'Combination',
    'Normal',
  ];

  final List<String> skinConcerns = [
    'Acne',
    'Dryness',
    'Redness',
    'Sensitivity',
    'Dark Spots',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F0),

      appBar: AppBar(
        title: const Text('Skin Profile'),
        backgroundColor: const Color(0xFFF8F7F0),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/skincare.jpg',
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                'Your Skin Profile',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF334F38),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Tell us about your skin to personalize your routine.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              // SKIN TYPE
              const Text(
                'What is your skin type?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Wrap(
                spacing: 10,
                runSpacing: 10,

                children: skinTypes.map((type) {
                  return ChoiceChip(
                    label: Text(type),
                    selected: selectedSkinType == type,

                    selectedColor: const Color(0xFFD4E5CE),

                    onSelected: (selected) {
                      setState(() {
                        selectedSkinType =
                        selected ? type : null;
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 35),

              // SKIN CONCERNS
              const Text(
                'What are your skin concerns?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Wrap(
                spacing: 10,
                runSpacing: 10,

                children: skinConcerns.map((concern) {
                  return FilterChip(
                    label: Text(concern),

                    selected:
                    selectedConcerns.contains(concern),

                    selectedColor: const Color(0xFFD4E5CE),

                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedConcerns.add(concern);
                        } else {
                          selectedConcerns.remove(concern);
                        }
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 40),

              // SAVE PROFILE BUTTON
              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: selectedSkinType == null
                      ? null
                      : () {
                    showDialog(
                      context: context,

                      builder: (dialogContext) {
                        return AlertDialog(
                          title: const Text(
                            'Profile Saved!',
                          ),

                          content: Text(
                            'Skin Type: $selectedSkinType\n'
                                'Concerns: ${selectedConcerns.isEmpty ? "None" : selectedConcerns.join(", ")}',
                          ),

                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                  dialogContext,
                                );
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color(0xFF638568),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                  ),

                  child: const Text(
                    'Save Profile',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
