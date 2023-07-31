import 'package:bbti/bottom_nav_bar.dart';
import 'package:bbti/controllers/storage.dart';
import 'package:bbti/models/lock_initial.dart';
import 'package:bbti/models/router_model.dart';
import 'package:bbti/views/router_page.dart';
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
              offset: Offset(5, 5), // changes position of shadow
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
                    Wrap(
                      children: [
                        Text(
                          widget.routerDetails.lockID,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20,
                              color: blackColour,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
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
                    Wrap(
                      children: [
                        Text(
                          widget.routerDetails.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20,
                              color: blackColour,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
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
                    Text(
                      widget.routerDetails.lockPasskey,
                      style: TextStyle(
                          fontSize: 20,
                          color: blackColour,
                          fontWeight: FontWeight.w400),
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
                    Text(
                      widget.routerDetails.password,
                      style: TextStyle(
                          fontSize: 20,
                          color: blackColour,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   width: 20,
                    // ),
                    IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: () {
                          // String toCopy =
                          //     '${routerDetails.name},${routerDetails.accessType},${routerDetails.date},${routerDetails.time}';
                          // print(toCopy);
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          _storageController
                              .deleteOneRouter(widget.routerDetails);
                          Navigator.pushAndRemoveUntil<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) => MyNavigationBar(),
                            ),
                            (route) =>
                                false, //if you want to disable back feature set to false
                          );
                        },
                        icon: Icon(Icons.delete)),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.refresh_rounded))
                  ],
                ),
                // Text("Access Permission  : FULL TIME ACCESS"),
                // Text("Start and End Date : 00-00"),
                // Text("Start and End Time : 00:00-00:00"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
