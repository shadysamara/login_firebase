import 'package:flutter/material.dart';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:login_firebase/backend/server.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String newName;

  String newEmail;

  String newPhone;

  String newCity;
  @override
  initState() {
    super.initState();
    this.newName = appGet.userMap['userName'];
    this.newEmail = appGet.userMap['email'];
    this.newPhone = appGet.userMap['phoneNumber'];
    this.newCity = appGet.userMap['city'];
  }

  editProfile() {
    updateUserProfile(city: newCity, phoneNumber: newPhone, userName: newName);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                signOut();
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() {
            return appGet.userMap.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        appGet.editingMode.value
                            ? GestureDetector(
                                onTap: () {
                                  pickImage();
                                },
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[200],
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              appGet.userMap['imageUrl']))),
                                ),
                              )
                            : Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[200],
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            appGet.userMap['imageUrl']))),
                              ),
                        appGet.editingMode.value
                            ? TextFormField(
                                initialValue: appGet.userMap['userName'],
                                onChanged: (value) {
                                  newName = value;
                                },
                              )
                            : Text(
                                appGet.userMap['userName'],
                                style: TextStyle(fontSize: 20),
                              ),
                        appGet.editingMode.value
                            ? TextFormField(
                                initialValue: appGet.userMap['email'],
                                onChanged: (value) {
                                  newEmail = value;
                                },
                              )
                            : Text(
                                appGet.userMap['email'],
                                style: TextStyle(fontSize: 20),
                              ),
                        appGet.editingMode.value
                            ? TextFormField(
                                initialValue: appGet.userMap['phoneNumber'],
                                onChanged: (value) {
                                  newPhone = value;
                                },
                              )
                            : Text(
                                appGet.userMap['phoneNumber'],
                                style: TextStyle(fontSize: 20),
                              ),
                        appGet.editingMode.value
                            ? TextFormField(
                                initialValue: appGet.userMap['city'],
                                onChanged: (value) {
                                  newCity = value;
                                },
                              )
                            : Text(
                                appGet.userMap['city'],
                                style: TextStyle(fontSize: 20),
                              ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: RaisedButton(
                              child: Text(
                                  appGet.editingMode.value ? 'save' : 'Edit'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              onPressed: () {
                                if (appGet.editingMode.value) {
                                  editProfile();
                                }
                                appGet.editingMode.value =
                                    !appGet.editingMode.value;
                              }),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
        ),
      ),
    );
  }
}
