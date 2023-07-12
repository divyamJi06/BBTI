import 'package:bbti/models/lock_initial.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../controllers/storage.dart';

class LocksCard extends StatelessWidget {
  final LockDetails locksDetails;
  LocksCard({
    required this.locksDetails,
    super.key,
  });
  final StorageController _storageController = StorageController();

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
                          locksDetails.lockld!,
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
                      "Lock Name : ",
                      style: TextStyle(
                          fontSize: 20,
                          color: blackColour,
                          fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      children: [
                        Text(
                          locksDetails.lockSSID!,
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
                      locksDetails.lockPassKey!,
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
                      "Lock Password: ",
                      style: TextStyle(
                          fontSize: 20,
                          color: blackColour,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      locksDetails.lockPassword!,
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
                          //     '${locksDetails.name},${locksDetails.accessType},${locksDetails.date},${locksDetails.time}';
                          // print(toCopy);
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          // _storageController.deleteOneLock(locksDetails);
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
