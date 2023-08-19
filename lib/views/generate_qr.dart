import 'package:flutter/material.dart';

import '../controllers/storage.dart';
import '../models/contacts.dart';
import '../models/lock_initial.dart';
import '../models/router_model.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/qr.dart';

class GenerateQRPage extends StatefulWidget {
  const GenerateQRPage({super.key});

  @override
  State<GenerateQRPage> createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
  StorageController _storageController = StorageController();
  @override
  void initState() {
    super.initState();
    // getData();
  }

  List<ContactsModel> contacts = [];
  List<LockDetails> locks = [];
  List<RouterDetails> routers = [];
  getData() async {
    // setState(() async {
    contacts = await _storageController.readContacts();
    locks = await _storageController.readLocks();
    routers = await _storageController.readRouters();
    // });
    return (contacts, locks, routers);
  }

  bool isSelected = true;
  String selected = "Locks";

  LockDetails lock = LockDetails(
      lockld: "default",
      lockSSID: "def",
      isAutoLock: false,
      privatePin: "1234",
      lockPassword: "default",
      iPAddress: "0.0.0.0");
  RouterDetails router = RouterDetails(
      lockID: "default",
      name: "default",
      password: "default",
      lockPasskey: "default");
  ContactsModel contact = ContactsModel(
      accessType: "default", date: "default", time: "default", name: "default");

  @override
  Widget build(BuildContext context) {
    // if (routers == null) return CircularProgressIndicator();
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(heading: "Generate QR"),
        preferredSize: const Size.fromHeight(60),
      ),
      body: Center(
          child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();
                print((snapshot.data.runtimeType));
                var x = snapshot.data as (
                  List<ContactsModel>,
                  List<LockDetails>,
                  List<RouterDetails>
                );
                contacts = x.$1;
                locks = x.$2;
                routers = x.$3;
                return Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    DropdownMenu(
                        initialSelection: selected,
                        onSelected: (value) async {
                          setState(() {
                            print(value);
                            selected = value!;
                            if (value == "Locks") {
                              isSelected = true;
                            } else {
                              isSelected = false;
                            }
                          });
                        },
                        dropdownMenuEntries: [
                          const DropdownMenuEntry(
                              value: "Locks", label: "Locks"),
                          const DropdownMenuEntry(
                              value: "Routers", label: "Routers"),
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    isSelected
                        ? const Text("Select Lock")
                        : const Text("Select Router"),
                    isSelected
                        ? DropdownMenu(
                            onSelected: (value) async {
                              lock =
                                  await _storageController.getLockBySSID(value);
                            },
                            dropdownMenuEntries: locks
                                .map((e) => DropdownMenuEntry(
                                    value: e.lockSSID, label: e.lockSSID))
                                .toList())
                        : DropdownMenu(
                            onSelected: (value) async {
                              router = await _storageController
                                  .getRouterByName(value);
                            },
                            dropdownMenuEntries: routers
                                .map((e) => DropdownMenuEntry(
                                    value: e.name +"_"+ e.lockID,
                                    label: e.name +"_"+ e.lockID))
                                .toList()),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Select Contact"),
                    DropdownMenu(
                        onSelected: (value) async {
                          contact =
                              await _storageController.getContactByPhone(value);
                        },
                        dropdownMenuEntries: contacts
                            .map((e) =>
                                DropdownMenuEntry(value: e.name, label: e.name))
                            .toList()),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QRPage(
                                        data: isSelected
                                            ? "${lock.toLockQR()},${contact.toContactsQR()}"
                                            : "${router.toRouterQR()},${contact.toContactsQR()}")));
                          },
                          child: new Text("Generate"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: new Text("Cancel"),
                        ),
                      ],
                    )
                  ],
                );
              })),
    );
  }
}
