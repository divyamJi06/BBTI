import 'package:bbti/models/router_model.dart';
import 'package:bbti/views/add_router.dart';
import 'package:bbti/views/lock_on_off.dart';
import 'package:bbti/widgets/router_card.dart';
import 'package:flutter/material.dart';

import '../bottom_nav_bar.dart';
import '../constants.dart';
import '../controllers/storage.dart';
import '../widgets/custom_appbar.dart';
import 'connecttolock.dart';

class RouterPage extends StatelessWidget {
  RouterPage({super.key});
  final StorageController _storageController = new StorageController();

  Future<List<RouterDetails>> fetchRouters() async {
    return _storageController.readRouters();
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
                  "Add Router",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewRouterInstallationPage()));
            }),
      ),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(heading: "Routers")),
      // bottomNavigationBar: MyNavigationBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: fetchRouters(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) return Text("ERROR");

                  return ListView.builder(
                      padding: EdgeInsets.only(top: 10),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ConnectToLockWidget(
                                          IP: snapshot.data![index].iPAddress!,
                                          lockID: snapshot.data![index].lockID,
                                          lockPassKey:
                                              snapshot.data![index].lockPasskey,
                                        )));
                          },
                          child:
                              RouterCard(routerDetails: snapshot.data![index]),
                        );
                      });
                })
          ],
        ),
      ),
    );
  }
}
