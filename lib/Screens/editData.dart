import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locapass/Screens/homePage.dart';
import 'package:locapass/data/cubitPass/passwords_cubit.dart';
import 'package:locapass/logic/textField.dart';

class EditData extends StatefulWidget {
  final Map<String, dynamic> oldItem;
  final int index;
  const EditData({super.key, required this.oldItem, required this.index});

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;

  GlobalKey<FormState> formstate = GlobalKey();
  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.oldItem["name"]);
    email = TextEditingController(text: widget.oldItem["email"]);
    password = TextEditingController(text: widget.oldItem["password"]);
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuiry = MediaQuery.of(context);
    final ScreenWidth = mediaQuiry.size.width;
    final ScreenHieght = mediaQuiry.size.height;
    return BlocBuilder<PasswordsCubit, PasswordsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF060D1A),
          appBar: AppBar(backgroundColor: const Color(0xFF060D1A)),
          body: Container(
            width: double.infinity,
            height: double.infinity,

            child: ListView(
              children: [
                Form(
                  key: formstate,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: ScreenHieght * 0.02),
                        Text(
                          "Edit email",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        SizedBox(height: ScreenHieght * 0.03),
                        Text(
                          "Name",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Textfield(
                          hintText: "name",

                          isPassword: false,
                          myController: name,
                        ),
                        SizedBox(height: ScreenHieght * 0.05),
                        Text(
                          "email",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Textfield(
                          hintText: "email",
                          isPassword: false,
                          myController: email,
                        ),
                        SizedBox(height: ScreenHieght * 0.05),
                        Text(
                          "Password",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Textfield(
                          hintText: "password",
                          isPassword: true,
                          myController: password,
                        ),

                        SizedBox(height: ScreenHieght * 0.07),

                        Center(
                          child: state is isLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () {
                                    if (formstate.currentState!.validate()) {
                                      context
                                          .read<PasswordsCubit>()
                                          .updatePassword(
                                            widget.index,
                                            name.text,
                                            email.text,
                                            password.text,
                                          );
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => Homepage(),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Edit email",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
