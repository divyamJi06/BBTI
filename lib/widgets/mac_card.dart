import 'package:bbti/controllers/storage.dart';
import 'package:bbti/models/mac_model.dart';
import 'package:flutter/material.dart';

import '../bottom_nav_bar.dart';
import '../constants.dart';
import '../controllers/apis.dart';

class MacCard extends StatefulWidget {
  final MacsDetails macsDetails;

  MacCard({
    required this.macsDetails,
    super.key,
  });

  @override
  State<MacCard> createState() => _MacCardState();
}

class _MacCardState extends State<MacCard> {
  StorageController _storageController = StorageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSwitched = widget.macsDetails.isPresentInESP;
  }

  bool isSwitched = false;

  var textValue = 'Switch is OFF';

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
                    Wrap(
                      children: [
                        Text(
                          widget.macsDetails.lockDetails.lockSSID,
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
                      "Mac ID : ",
                      style: TextStyle(
                          fontSize: 20,
                          color: blackColour,
                          fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      children: [
                        Text(
                          widget.macsDetails.id,
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
                      "Mac Name : ",
                      style: TextStyle(
                          fontSize: 20,
                          color: blackColour,
                          fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      children: [
                        Text(
                          widget.macsDetails.name,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () async {
                          _storageController.deleteOneMacs(widget.macsDetails);
                          await ApiConnect.hitApiGet(
                            "$routerIP/",
                          );
                          Navigator.pop(context);

                          var res = await ApiConnect.hitApiPost(
                              "$routerIP/deletemac", {
                            "MacID": widget.macsDetails.id.toLowerCase(),
                          });
                        },
                        icon: const Icon(Icons.delete)),
                    const SizedBox(
                      width: 10,
                    ),
                    Transform.scale(
                        scale: 1,
                        child: Switch(
                          onChanged: (value) async {
                            setState(() {
                              isSwitched = value;
                            });
                            // return;
                            print(value);
                            if (value) {
                              // await ApiConnect.hitApiGet(
                              //   "$routerIP/",
                              // );

                              // Navigator.pop(context);

                              var res = await ApiConnect.hitApiPost(
                                  "$routerIP/MacOnOff", {
                                "MacCheck": "ON",
                              });
                              print(res);
                            } else {
                              var res = await ApiConnect.hitApiPost(
                                 
                                  "$routerIP/MacOnOff", {
                                "MacCheck": "OFF",
                              });
                              print(res);
                            }
                            MacsDetails macD = MacsDetails(
                                id: widget.macsDetails.id,
                                lockDetails: widget.macsDetails.lockDetails,
                                name: widget.macsDetails.name,
                                isPresentInESP: isSwitched);
                            _storageController.updateMacStatus(macD);

                            // Navigator.pop(context);
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
                          value: isSwitched,
                          activeColor: appBarColour,
                          activeTrackColor: backGroundColour,
                          inactiveThumbColor: blackColour,
                          inactiveTrackColor: whiteColour,
                        )),
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
