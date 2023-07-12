import 'package:bbti/constants.dart';
import 'package:bbti/controllers/storage.dart';
import 'package:bbti/views/select_access.dart';
import 'package:flutter/material.dart';

import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';

import '../models/contacts.dart';
import '../widgets/contact_card.dart';
import '../widgets/custom_button.dart';

// class ContactPage extends StatelessWidget {
//   const ContactPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       // bottomNavigationBar: MyNavigationBar(),
//       body: Center(
//         child: Column(
//           children: [Text("Contact")],
//         ),
//       ),
//     );
//   }
// }

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final FlutterContactPicker _contactPicker = new FlutterContactPicker();
  final StorageController _storageController = new StorageController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // fetchContacts();
  }

  Future<List<ContactsModel>> fetchContacts() async {
    return _storageController.readContacts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: whiteColour,
      appBar: AppBar(
        backgroundColor: backGroundColour,
        // automaticallyImplyLeading: false,
        title: Text(
          "Contacts",
          style: TextStyle(
              color: appBarColour,
              fontSize: 40,
              fontWeight: FontWeight.bold),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            CustomButton(
              onPressed: () async {
                Contact? contact = await _contactPicker.selectContact();
                if (contact != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AccessRequestPage(
                                name: contact.fullName!,
                              )));
                } else {
                  // TODO: Add a toast tp show its not possible to open contacts
                }
              },
              text: "Add Contacts",
            ),
            // const Divider(
            //   height: 12,
            //   thickness: 1,
            //   color: Color(0xFFE0E3E7),
            // ),
            FutureBuilder(
                future: fetchContacts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) return Text("ERROR");

                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ContactsCard(
                          // contactsDetails: ContactsModel(
                          //     accessType: "Full_timed_acess",
                          //     date: "00:00",
                          //     time: "00dwd",
                          //     name: "Nandan")
                          contactsDetails: snapshot.data![index],
                        );
                      });
                })
          ],
        ),
      ),
    );
  }
}
