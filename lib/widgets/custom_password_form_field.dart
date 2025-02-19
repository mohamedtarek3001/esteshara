import 'package:flutter/material.dart';

class CustomPasswordFormField extends StatelessWidget {
  const CustomPasswordFormField({
    super.key,
    required this.title,
    required this.hint,
    required this.isVisible,
    required this.onTap,
    this.controller,
    this.validator
  });
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String title;
  final String hint;
  final bool isVisible;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          validator: validator,
          controller: controller,
          obscureText: isVisible,
          decoration: InputDecoration(
              label: title.isEmpty ? const Text('Password') : Text(title,),
              labelStyle: const TextStyle(fontSize: 18,color: Colors.grey),
              suffixIcon: IconButton(onPressed: onTap, icon: const Icon(Icons.visibility)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0x73000000), fontSize: 12)),
        ),
      ],
    );
  }
}