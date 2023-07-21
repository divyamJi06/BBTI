import 'package:bbti/constants.dart';
import 'package:bbti/controllers/storage.dart';
import 'package:bbti/models/mac_model.dart';
import 'package:bbti/views/add_mac.dart';
import 'package:bbti/widgets/mac_card.dart';
import 'package:flutter/material.dart';

class MacsPage extends StatefulWidget {
  const MacsPage({Key? key}) : super(key: key);

  @override
  _MacsPageState createState() => _MacsPageState();
}

class _MacsPageState extends State<MacsPage> {
  final StorageController _storageController = new StorageController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // fetchContacts();
  }

  Future<List<MacsDetails>> fetchContacts() async {
    return _storageController.readMacs();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 120,
        width: 120,
        child: FloatingActionButton.large(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 30,
                ),
                Text(
                  "Add Mac",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
            onPressed: () async {
              // if (contact != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewMacInstallationPage()));
              // } else {
              // TODO: Add a toast tp show its not possible to open contacts
              // }
            }),
      ),
      key: scaffoldKey,
      backgroundColor: whiteColour,
      appBar: AppBar(
        backgroundColor: backGroundColour,
        // automaticallyImplyLeading: false,
        title: Text(
          "Mac",
          style: TextStyle(
              color: appBarColour, fontSize: 40, fontWeight: FontWeight.bold),
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
                        return MacCard(macsDetails: snapshot.data![index]);
                      });
                })
          ],
        ),
      ),
    );
  }
}
