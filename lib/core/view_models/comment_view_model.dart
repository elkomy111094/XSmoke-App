import 'package:flutter/cupertino.dart';
import 'package:xsmoke/core/services/firestore_user.dart';

class AddCommentController extends ChangeNotifier {
  String _comment = " ";
  bool processState = false;

  String get comment => _comment;
  resetComment() {
    _comment = " ";
    notifyListeners();
  }

  setCommentValue(String value) {
    _comment = value;
    notifyListeners();
  }

  Future addComment() async {
    processState = true;
    notifyListeners();
    await FireStoreUser().setComment(comment: this.comment).then((value) {
      processState = false;
      notifyListeners();
    });
  }
}
