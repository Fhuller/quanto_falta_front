import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quanto_falta_front/core/ui/todo_list_icon.dart';

class QuantoField extends StatelessWidget {
  final String label;
  final IconButton? suffixIconButton;
  final bool obscureText;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  QuantoField({
    super.key,
    required this.label,
    this.suffixIconButton,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
  })  : assert(obscureText == true ? suffixIconButton == null : true,
            'Obscure text não pode ser enviado com suffixbutton'),
        obscureTextVN = ValueNotifier(obscureText);

  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: obscureTextVN,
      builder: (_, obscureTextVNValue, child) {
        return TextFormField(
          focusNode: focusNode,
          controller: controller,
          validator: validator,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.red),
            ),
            isDense: true,
            suffixIcon: suffixIconButton ??
                (obscureText == true
                    ? IconButton(
                        onPressed: () {
                          obscureTextVN.value = !obscureTextVNValue;
                        },
                        icon: Icon(
                          !obscureTextVNValue
                              ? TodoListIcon.eye_slash
                              : TodoListIcon.eye,
                          size: 15,
                        ),
                      )
                    : null),
          ),
          obscureText: obscureTextVNValue,
        );
      },
    );
  }
}
