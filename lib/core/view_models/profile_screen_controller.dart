import 'package:flutter/cupertino.dart';

import '../../models/user_model.dart';
import '../services/firestore_user.dart';

class ProfileScreenController extends ChangeNotifier {
  bool processState = false;

  Future saveUser(UserModel user) async {
    processState = true;
    notifyListeners();

    await FireStoreUser().addUserToFireStore(user).then((value) {
      processState = false;
      notifyListeners();
    });
  }
}
