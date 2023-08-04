import 'package:bbti/models/router_model.dart';
import 'package:bbti/views/add_router.dart';
import 'package:bbti/widgets/router_card.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../controllers/storage.dart';
import 'connecttolock.dart';

class RouterPage extends StatelessWidget {
  RouterPage({super.key});
  final StorageController _storageController = StorageController();

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
            child: const Column(
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
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          iconTheme: IconThemeData(color: appBarColour),
          backgroundColor: backGroundColour,
          automaticallyImplyLeading: false,
          title: Text(
            "Routers",
            style: TextStyle(
                color: appBarColour, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
      ),
      // bottomNavigationBar: MyNavigationBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: fetchRouters(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) return const Text("ERROR");

                  return ListView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      physics: const NeverScrollableScrollPhysics(),
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
                                          lockName: snapshot.data![index].name,
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
