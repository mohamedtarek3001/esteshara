import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.validator,
    this.onChanged,
    this.isEnabled,
    this.inputFormatters,
    this.keyboardType,
    this.radius
  });
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String title;
  final String hint;
  final double? radius;
  final bool? isEnabled;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          validator: validator,
          controller: controller,
          enabled: isEnabled,
          readOnly: !(isEnabled??true),
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            label: title.isEmpty ? const Text('Email') : Text(title),
              labelStyle: const TextStyle(fontSize: 18,color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius??50),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius??50),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0x73000000), fontSize: 16)),
        ),
      ],
    );
  }
}
class CustomTextFormField3 extends StatelessWidget {
  const CustomTextFormField3({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.validator,
    this.onChanged,
    this.isEnabled,
    this.inputFormatters,
    this.keyboardType,
    this.radius
  });
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String title;
  final String hint;
  final double? radius;
  final bool? isEnabled;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;




  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          validator: validator,
          controller: controller,
          enabled: isEnabled,
          readOnly: !(isEnabled??true),
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            label: title.isEmpty ? const Text('Email') : Text(title),
              labelStyle: const TextStyle(fontSize: 18,color: Color(0xff2DACC9)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius??50),
                borderSide: const BorderSide(color: Color(0xff2DACC9)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius??50),
                borderSide: const BorderSide(color: Color(0xff2DACC9)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius??50),
                borderSide: const BorderSide(color: Color(0xff2DACC9)),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0x73000000), fontSize: 16)),
        ),
      ],
    );
  }
}



class CustomTextFormField2 extends StatelessWidget {
  const CustomTextFormField2({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.validator,
    this.onChanged,
    this.isEnabled,
    this.inputFormatters,
    this.keyboardType,
  });
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String title;
  final String hint;
  final bool? isEnabled;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;




  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20,),
        TextFormField(
          validator: validator,
          controller: controller,
          enabled: isEnabled,
          readOnly: !(isEnabled??true),
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            // label: title.isEmpty ? const Text('Email') : Text(title),
            //   labelStyle: TextStyle(fontSize: 18,color: Colors.grey),
            label: title.isEmpty ? const Text('Email') : Text(title),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0x73000000), fontSize: 16)),
        ),
      ],
    );
  }
}