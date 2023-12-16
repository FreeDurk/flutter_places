import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/constants/theme_data.dart';

class AppInputField extends StatefulWidget {
  final Widget title;
  final String placeholder;
  final bool obscureText;
  final Function(String)? onChanged;
  final Function()? iconTap;

  const AppInputField({
    required this.title,
    required this.placeholder,
    required this.obscureText,
    required this.onChanged,
    this.iconTap,
    super.key,
  });

  @override
  State<AppInputField> createState() => _InputFieldsState();
}

class _InputFieldsState extends State<AppInputField> {
  bool showPass = true;

  @override
  void initState() {
    setState(() {
      showPass = widget.obscureText;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title,
        const SizedBox(
          height: 10,
        ),
        TextField(
          onChanged: widget.onChanged,
          obscureText: widget.obscureText ? showPass : false,
          style: const TextStyle(
            fontSize: 14,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: greyOpacity,
            focusedBorder: outlineBorder,
            enabledBorder: outlineBorder,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            hintText: widget.placeholder,
            hintStyle: const TextStyle(fontSize: 12),
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPass = !showPass;
                      });
                    },
                    icon: Icon(
                      showPass ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
