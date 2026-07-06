import 'package:flutter/material.dart';

class Textfield extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController myController;
  final TextInputType? type;
  final String? isIcon;
  final String? Function(String?)? validator;
  const Textfield({
    super.key,
    required this.hintText,
    required this.isPassword,
    required this.myController,
    this.type,
    this.isIcon,
    this.validator,
  });

  @override
  State<Textfield> createState() => _TextfieldState();
}

class _TextfieldState extends State<Textfield> {
  bool _obSecure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword ? _obSecure : false,
      controller: widget.myController,
      keyboardType: widget.type,
      style: TextStyle(color: Colors.white),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Value";
        }
      },
      decoration: InputDecoration(
        hint: Text("${widget.hintText}", style: TextStyle(color: Colors.white)),

        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obSecure = !_obSecure;
                  });
                },
                icon: Icon(_obSecure ? Icons.visibility : Icons.visibility_off),
              )
            : null,
      ),
    );
  }
}
