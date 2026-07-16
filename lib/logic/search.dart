import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locapass/Screens/editData.dart';
import 'package:locapass/data/cubitPass/passwords_cubit.dart';

class CustomSearch extends SearchDelegate {
  final PasswordsCubit passwordsCubit;
  CustomSearch({required this.passwordsCubit});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF060D1A),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      scaffoldBackgroundColor: const Color(0xFF060D1A),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<PasswordsCubit, PasswordsState>(
      bloc: passwordsCubit,
      builder: (context, state) {
        final getData = passwordsCubit.values
            .where(
              (element) => element["name"].toString().toLowerCase().contains(
                query.toLowerCase(),
              ),
            )
            .toList();
        return ListView.builder(
          itemCount: getData.length,
          itemBuilder: (context, index) {
            final item = getData[index];
            final realIndex = passwordsCubit.values.indexOf(item);
            return Card(
              color: Color(0xFF060D1A),
              child: ListTile(
                onLongPress: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    title: "are you sure to delete?",
                    animType: AnimType.scale,
                    btnOkText: "Delete",
                    btnOkColor: Colors.red,
                    btnOkOnPress: () {
                      context.read<PasswordsCubit>().deletePassword(realIndex);
                    },
                    btnCancelColor: Colors.green,
                    btnCancelText: "Cancel",
                    btnCancelOnPress: () {},
                  ).show();
                },
                onTap: () {},
                title: Text(getData[index]["name"]),
                subtitle: Text(getData[index]["email"]),
                leading: Icon(Icons.person, color: Colors.greenAccent),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                EditData(oldItem: getData[index], index: index),
                          ),
                        );
                      },
                      child: Icon(Icons.edit, color: Colors.blue, size: 20),
                    ),
                    SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 10),
                            backgroundColor: const Color(0xFF151F2E),
                            content: Row(
                              children: [
                                Expanded(child: Text("Copy: ")),
                                SizedBox(width: 15),
                                TextButton.icon(
                                  onPressed: () async {
                                    ScaffoldMessenger.of(
                                      context,
                                    ).hideCurrentSnackBar();
                                    await Clipboard.setData(
                                      ClipboardData(text: item["email"]),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.green,
                                        content: Text(
                                          "Email Copied! ☑️",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.alternate_email,
                                    color: Colors.greenAccent,
                                  ),
                                  label: Text(
                                    "Email",
                                    style: TextStyle(color: Colors.greenAccent),
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () async {
                                    ScaffoldMessenger.of(
                                      context,
                                    ).hideCurrentSnackBar();
                                    await Clipboard.setData(
                                      ClipboardData(text: item["password"]),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.green,
                                        content: Text(
                                          "Password Copied! ☑️",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.password,
                                    color: Colors.greenAccent,
                                  ),
                                  label: Text(
                                    "password",
                                    style: TextStyle(color: Colors.greenAccent),
                                  ),
                                ),
                                SizedBox(width: 50),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Icon(Icons.copy, color: Colors.red, size: 20),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<PasswordsCubit, PasswordsState>(
      bloc: passwordsCubit,
      builder: (context, state) {
        final sourceList = query.isEmpty
            ? passwordsCubit.values
            : passwordsCubit.values
                  .where(
                    (element) => element["name"]
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()),
                  )
                  .toList();
        return ListView.builder(
          itemCount: sourceList.length,
          itemBuilder: (context, index) {
            final item = sourceList[index];
            final realIndex = passwordsCubit.values.indexOf(item);
            return Card(
              color: Color(0xFF151F2E),
              child: ListTile(
                onLongPress: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    title: "are you sure to delete?",
                    animType: AnimType.scale,
                    btnOkText: "Delete",
                    btnOkColor: Colors.red,
                    btnOkOnPress: () {
                      context.read<PasswordsCubit>().deletePassword(realIndex);
                    },
                    btnCancelColor: Colors.green,
                    btnCancelText: "Cancel",
                    btnCancelOnPress: () {},
                  ).show();
                },
                onTap: () {},
                title: Text(
                  sourceList[index]["name"],
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  sourceList[index]["email"],
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(Icons.person, color: Colors.greenAccent),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 10),
                            backgroundColor: const Color(0xFF151F2E),
                            content: Row(
                              children: [
                                Expanded(child: Text("Copy: ")),
                                SizedBox(width: 15),
                                TextButton.icon(
                                  onPressed: () async {
                                    ScaffoldMessenger.of(
                                      context,
                                    ).hideCurrentSnackBar();
                                    await Clipboard.setData(
                                      ClipboardData(text: item["email"]),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.green,
                                        content: Text(
                                          "Email Copied! ☑️",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.alternate_email,
                                    color: Colors.greenAccent,
                                  ),
                                  label: Text(
                                    "Email",
                                    style: TextStyle(color: Colors.greenAccent),
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () async {
                                    ScaffoldMessenger.of(
                                      context,
                                    ).hideCurrentSnackBar();
                                    await Clipboard.setData(
                                      ClipboardData(text: item["password"]),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.green,
                                        content: Text(
                                          "Password Copied! ☑️",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.password,
                                    color: Colors.greenAccent,
                                  ),
                                  label: Text(
                                    "password",
                                    style: TextStyle(color: Colors.greenAccent),
                                  ),
                                ),
                                SizedBox(width: 50),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Icon(Icons.copy, color: Colors.red, size: 20),
                    ),
                    SizedBox(height: 8),

                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditData(
                              oldItem: sourceList[index],
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: Icon(Icons.edit, color: Colors.blue, size: 20),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
