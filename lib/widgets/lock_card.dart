import 'package:bbti/controllers/storage.dart';
import 'package:bbti/models/lock_initial.dart';
import 'package:bbti/views/update_lock_name.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../controllers/apis.dart';

class LocksCard extends StatefulWidget {
  final LockDetails locksDetails;
  LocksCard({
    required this.locksDetails,
    super.key,
  });

  @override
  State<LocksCard> createState() => _LocksCardState();
}

class _LocksCardState extends State<LocksCard> {
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
                          widget.locksDetails.lockld!,
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
                          widget.locksDetails.lockSSID!,
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
                      widget.locksDetails.lockPassKey!,
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
                      widget.locksDetails.lockPassword!,
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
                    Transform.scale(
                        scale: 1,
                        child: Switch(
                          onChanged: (value) async {
                            print("===============");
                            print(value);
                            if (value) {
                              await ApiConnect.hitApiPost(
                                  "${widget.locksDetails.iPAddress}/Autolock",
                                  {"AutoLockTime": "ON"});
                            } else {
                              await ApiConnect.hitApiPost(
                                  "${widget.locksDetails.iPAddress}/Autolock",
                                  {"AutoLockTime": "OFF"});
                            }
                            setState(() {
                              _storageController.updateLockAutoStatus(
                                  widget.locksDetails.lockSSID, value);
                            });
                          },
                          value: widget.locksDetails.isAutoLock,
                          activeColor: appBarColour,
                          activeTrackColor: backGroundColour,
                          inactiveThumbColor: blackColour,
                          inactiveTrackColor: whiteColour,
                        )),
                    SizedBox(
                      width: 20,
                    ),
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
                          _storageController.deleteOneLock(widget.locksDetails);
                          setState(() {});
                        },
                        icon: Icon(Icons.delete)),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateLockInstallationPage(
                                          lockDetails: widget.locksDetails)));
                        },
                        icon: Icon(Icons.refresh_rounded))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
