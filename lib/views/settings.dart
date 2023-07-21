import 'package:bbti/controllers/storage.dart';
import 'package:bbti/views/mac_details.dart';
import 'package:bbti/views/pinpage.dart';
import 'package:bbti/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../bottom_nav_bar.dart';
import '../constants.dart';
import '../controllers/apis.dart';
import '../widgets/custom_appbar.dart';
import 'add_mac.dart';

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       // bottomNavigationBar: MyNavigationBar(),
//       body: Center(
//         child: Column(
//           children: [Text("Settings")],
//         ),
//       ),
//     );
//   }
// }

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: CustomAppBar(heading: "Settings")),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: "Factory Reset",
                  bgmColor: redButtonColour,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PinCodeWidget()));
                  },
                ),
                CustomButton(text: "Set AutoLock", onPressed: () {}),
                CustomButton(
                  text: "Mac",
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MacsPage()));
                  },
                ),
                CustomButton(
                  text: "Mac Enable",
                  onPressed: () async {
                    StorageController _sto = new StorageController();
                    _sto.deleteRouters();
                    // _sto.readContacts();
                    // var res = await ApiConnect.hitApiPost(
                    //     "$routerIP/deletemac", {
                    //   "MacID": _macID.text,
                    // });

                    // print(res);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             NewMacInstallationPage()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
