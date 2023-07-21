import 'package:bbti/bottom_nav_bar.dart';
import 'package:bbti/controllers/storage.dart';
import 'package:bbti/models/mac_model.dart';
import 'package:bbti/views/passkey.dart';
import 'package:bbti/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../controllers/apis.dart';
import '../widgets/custom_appbar.dart';

class NewMacInstallationPage extends StatelessWidget {
  NewMacInstallationPage({super.key});
  final TextEditingController _macID = new TextEditingController();
  final TextEditingController _macName = new TextEditingController();
  StorageController _storageController = StorageController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: CustomAppBar(heading: "Add Mac")),
        body: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _macID,
                    validator: (value) {
                      if (value!.length <= 0) return "Mac ID cannot be empty";
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: "Mac ID",
                      labelStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: _macName,
                      validator: (value) {
                        if (value!.length <= 0)
                          return "Mac Name cannot be empty";
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: "Mac Name",
                        labelStyle: TextStyle(fontSize: 15),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    width: 200,
                    text: "Submit",
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await ApiConnect.hitApiGet(
                          routerIP + "/",
                        );

                        var res =
                            await ApiConnect.hitApiPost("$routerIP/macid", {
                          "MacID": _macID.text.toLowerCase(),
                        });

                        MacsDetails macsDetails = MacsDetails(
                            id: _macID.text,
                            name: _macName.text,
                            isPresentInESP: true);
                        _storageController.addmacs(macsDetails);
                        print(res);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyNavigationBar()));
                      }
                    },
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await ApiConnect.hitApiGet(
                            routerIP + "/",
                          );

                          var res = await ApiConnect.hitApiPost(
                              "$routerIP/deletemac", {
                            "MacID": _macID.text.toLowerCase(),
                          });

                          print(res);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => PassKeyPage()));
                        }
                      },
                      child: Text("Delete")),
                ],
              ),
            ),
          ),
        ));
  }
}




    //  JSONObject json = new JSONObject();
    //                 try {
    //                     json.put("MacCheck", "OFF");
    //                 } catch (JSONException e) {
    //                     Log.d(TAG, e.getMessage());
    //                 }
    //                 StringEntity entity = new StringEntity(json.toString(), "UTF-8");
    //                 System.out.println(entity);
    //                 client.post(getApplicationContext(), lockip + "/MacOnOff", entity, "application/json", new JsonHttpResponseHandler() {
