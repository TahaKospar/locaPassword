import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locapass/Screens/addData.dart';
import 'package:locapass/Screens/editData.dart';
import 'package:locapass/data/cubitPass/passwords_cubit.dart';
import 'package:locapass/logic/search.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    context.read<PasswordsCubit>().getPass();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 124, 188, 188),
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => AddData()));
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: const Color(0xFF060D1A),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.0, -1.3),
            radius: 1,
            colors: [
              Color.fromARGB(255, 92, 206, 160),
              Color.fromARGB(0, 0, 0, 0),
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.09),
            ListTile(
              title: Text(
                "   My Vault",
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
              trailing: IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: const Color(0xFF151F2E),
                      duration: const Duration(seconds: 6),
                      content: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Contact:",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () async {
                              final Uri whatsapp = Uri.parse(
                                "https://wa.me/+201274669824",
                              );
                              await launchUrl(
                                whatsapp,
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            icon: const Icon(
                              Icons.chat,
                              color: Colors.greenAccent,
                              size: 18,
                            ),
                            label: const Text(
                              "WhatsApp",
                              style: TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          TextButton.icon(
                            onPressed: () async {
                              final Uri telegram = Uri.parse(
                                "https://t.me/My_KING_T",
                              ); // اليوزر بتاعك هنا بدون @
                              await launchUrl(
                                telegram,
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            icon: const Icon(
                              Icons.telegram,
                              color: Colors.blueAccent,
                              size: 18,
                            ),
                            label: const Text(
                              "Telegram",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                iconSize: 32,
                color: Colors.white,
                icon: const Icon(Icons.info),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                  // filled: true,
                  fillColor: Colors.grey[300],
                  prefixIcon: Icon(Icons.search),

                  hintText: "Search",
                  hoverColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearch(
                      passwordsCubit: context.read<PasswordsCubit>(),
                    ),
                  );
                },
              ),
            ),

            Expanded(
              child: BlocBuilder<PasswordsCubit, PasswordsState>(
                builder: (context, state) {
                  if (state is isLoading)
                    return Center(child: CircularProgressIndicator());
                  if (state is isLoaded) {
                    final password = context.read<PasswordsCubit>().values;
                    return ListView.builder(
                      itemCount: password.length,
                      itemBuilder: (context, index) {
                        final item = password.elementAt(index);
                        return Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFF151F2E),
                            borderRadius: BorderRadius.circular(20),
                          ),
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
                                  context.read<PasswordsCubit>().deletePassword(
                                    index,
                                  );
                                },
                                btnCancelColor: Colors.green,
                                btnCancelText: "Cancel",
                                btnCancelOnPress: () {},
                              ).show();
                            },
                            title: Text(
                              "${item["name"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Text(
                              "${item["email"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            leading: Icon(
                              Icons.person,
                              color: Colors.greenAccent,
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 10),
                                        backgroundColor: const Color(
                                          0xFF151F2E,
                                        ),
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
                                                  ClipboardData(
                                                    text: item["email"],
                                                  ),
                                                );
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    duration: Duration(
                                                      seconds: 2,
                                                    ),
                                                    backgroundColor:
                                                        Colors.green,
                                                    content: Text(
                                                      "Email Copied! ☑️",
                                                      textAlign:
                                                          TextAlign.center,
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
                                                style: TextStyle(
                                                  color: Colors.greenAccent,
                                                ),
                                              ),
                                            ),
                                            TextButton.icon(
                                              onPressed: () async {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).hideCurrentSnackBar();
                                                await Clipboard.setData(
                                                  ClipboardData(
                                                    text: item["password"],
                                                  ),
                                                );
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    duration: Duration(
                                                      seconds: 2,
                                                    ),
                                                    backgroundColor:
                                                        Colors.green,
                                                    content: Text(
                                                      "Password Copied! ☑️",
                                                      textAlign:
                                                          TextAlign.center,
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
                                                style: TextStyle(
                                                  color: Colors.greenAccent,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 50),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.copy,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(height: 8),

                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EditData(
                                          oldItem: item,
                                          index: index,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
