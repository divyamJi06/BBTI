import 'package:bbti/constants.dart';
import 'package:bbti/models/lock_initial.dart';
import 'package:bbti/views/connecttolock.dart';
import 'package:bbti/views/lock_on_off.dart';
import 'package:bbti/views/qr_view.dart';
import 'package:bbti/widgets/custom_appbar.dart';
import 'package:bbti/widgets/custom_button.dart';
import 'package:bbti/widgets/lock_card.dart';
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
              child: Column(
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
            preferredSize: Size.fromHeight(60),
            child: CustomAppBar(heading: "Lock")),
        body: FutureBuilder(
            future: fetchLocks(),
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
                                      IP: snapshot.data![index].iPAddress,
                                      lockID: snapshot.data![index].lockld,
                                      lockPassKey:
                                          snapshot.data![index].lockPassKey!,
                                    )));
                      },
                      child: LocksCard(locksDetails: snapshot.data![index]),
                    );
                  });
            }));
  }
}
