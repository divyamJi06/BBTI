import 'package:bbti/views/passkey.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../controllers/apis.dart';

class NewMacInstallationPage extends StatelessWidget {
  NewMacInstallationPage({super.key});
  final TextEditingController _macID =
      new TextEditingController(text: "CC2B9622871E");
  final TextEditingController _macName =
      new TextEditingController(text: "REMOTE");
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _macID,
                  validator: (value) {
                    if (value!.length <= 0) return "Mac ID cannot be empty";
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Mac ID",
                    // hintText: "BBT"
                  ),
                ),
                TextFormField(
                  controller: _macName,
                  validator: (value) {
                    if (value!.length <= 0) return "Mac Name cannot be empty";
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Mac Name",
                    // hintText: "BBT"
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await ApiConnect.hitApiGet(
                          routerIP + "/",
                        );

                        var res =
                            await ApiConnect.hitApiPost("$routerIP/macid", {
                          "MacID": _macID.text.toLowerCase(),
                        });

                        print(res);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => PassKeyPage()));
                      }
                    },
                    child: Text("Submit")),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await ApiConnect.hitApiGet(
                          routerIP + "/",
                        );

                        var res =
                            await ApiConnect.hitApiPost("$routerIP/deletemac", {
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
