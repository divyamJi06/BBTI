import '../bottom_nav_bar.dart';
import '../controllers/storage.dart';
import '../models/router_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RouterCard extends StatefulWidget {
  final RouterDetails routerDetails;
  RouterCard({
    required this.routerDetails,
    super.key,
  });

  @override
  State<RouterCard> createState() => _RouterCardState();
}

class _RouterCardState extends State<RouterCard> {
  bool hide = true;
  StorageController _storageController = StorageController();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          // height: 150,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(5, 5), // changes position of shadow
            ),
          ], color: whiteColour, borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Lock ID : ",
                      style: TextStyle(
                          fontSize: 20,
                          color: blackColour,
                          fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                      child: Text(
                        widget.routerDetails.lockID,
                        style: TextStyle(
                            fontSize: 20,
                            color: blackColour,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Router Name : ",
                      style: TextStyle(
                          fontSize: 20,
                          color: blackColour,
                          fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                      child: Text(
                        widget.routerDetails.name,
                        style: TextStyle(
                            fontSize: 20,
                            color: blackColour,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Lock PassKey : ",
                      style: TextStyle(
                          fontSize: 20,
                          color: blackColour,
                          fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                      child: Text(
                        hide
                            ? List.generate(
                                widget.routerDetails.lockPasskey.length,
                                (index) => "*").join()
                            : widget.routerDetails.lockPasskey,
                        style: TextStyle(
                            fontSize: 20,
                            color: blackColour,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Router Password: ",
                      style: TextStyle(
                          fontSize: 20,
                          color: blackColour,
                          fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                      child: Text(
                        hide
                            ? List.generate(
                                widget.routerDetails.password.length,
                                (index) => "*").join()
                            : widget.routerDetails.password,
                        style: TextStyle(
                            fontSize: 20,
                            color: blackColour,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: backGroundColour,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   width: 10,
                      // ),
                      IconButton(
                          tooltip: "Delete Router",
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (cont) {
                                  return AlertDialog(
                                    title: const Text('BBT Lock'),
                                    content:
                                        const Text('This will delete the Lock'),
                                    actions: [
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('CANCEL'),
                                      ),
                                      OutlinedButton(
                                        onPressed: () async {
                                          _storageController.deleteOneRouter(
                                              widget.routerDetails);
                                          Navigator.pushAndRemoveUntil<dynamic>(
                                            context,
                                            MaterialPageRoute<dynamic>(
                                              builder: (BuildContext context) =>
                                                  MyNavigationBar(),
                                            ),
                                            (route) =>
                                                false, //if you want to disable back feature set to false
                                          );
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(Icons.delete)),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          tooltip: "Show Details",
                          onPressed: () {
                            setState(() {
                              hide = !hide;
                            });
                          },
                          icon: hide
                              ? const Icon(Icons.remove_red_eye)
                              : const Icon(CupertinoIcons.eye_slash_fill)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
