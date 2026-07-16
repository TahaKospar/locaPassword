import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locapass/Screens/homePage.dart';
import 'package:locapass/data/cubitPass/passwords_cubit.dart';
import 'package:locapass/logic/textField.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey();

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
                          "Adding Email",
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
                                          .AddPassword(
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
                                    "Add Account",
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
