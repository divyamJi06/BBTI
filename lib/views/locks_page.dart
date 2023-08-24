import '../constants.dart';
import '../models/lock_initial.dart';
import 'connecttolock.dart';
import 'qr_view.dart';
import '../widgets/lock_card.dart';
import 'package:flutter/material.dart';

import '../controllers/storage.dart';

class LockPage extends StatelessWidget {
  LockPage({super.key});
  final StorageController _storageController = new StorageController();

  Future<List<LockDetails>> fetchLocks() async {
    return _storageController.readLocks();
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
                    "Add Lock",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QRViewExample(),
                ));
              }),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            iconTheme: IconThemeData(color: appBarColour),
            backgroundColor: backGroundColour,
            automaticallyImplyLeading: false,
            title: Text(
              "Locks",
              style: TextStyle(
                  color: appBarColour,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            actions: const [],
            centerTitle: true,
            elevation: 0,
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: fetchLocks(),
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
                                            lockName:
                                                snapshot.data![index].lockSSID,
                                            IP: snapshot.data![index].iPAddress,
                                            lockID:
                                                snapshot.data![index].lockld,
                                            lockPassKey: snapshot
                                                .data![index].lockPassKey!,
                                          )));
                            },
                            child:
                                LocksCard(locksDetails: snapshot.data![index]),
                          );
                        });
                  }),
            ],
          ),
        ));
  }
}
