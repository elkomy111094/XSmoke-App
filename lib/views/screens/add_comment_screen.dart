import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xsmoke/conatants.dart';

import '../../core/view_models/comment_view_model.dart';

class AddCommentScreen extends StatelessWidget {
  void _showToast(BuildContext context, String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 1),
        elevation: 20,
        backgroundColor: kSecondaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text(
          "Add Your Advice",
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        //Normal textInputField will be displayed
                        style:
                            TextStyle(color: Colors.white, fontFamily: "Eczar"),
                        maxLines: 6,
                        maxLength: 250,
                        onSaved: (val) {},
                        onChanged: (val) {
                          Provider.of<AddCommentController>(context,
                                  listen: false)
                              .setCommentValue(val);
                        },
                        // when user presses enter it will adapt to it

                        decoration: InputDecoration(
                          fillColor: kSecondaryColor,
                          filled: true,
                          hintText: "Enetr Your Advice Here ...",
                          hintStyle:
                              TextStyle(color: Colors.white70, fontSize: 18),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(color: Colors.white),
                          ),
                          //fillColor: Colors.green
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    RaisedButton(
                      color: Colors.black,
                      onPressed: () {
                        if (Provider.of<AddCommentController>(context,
                                        listen: false)
                                    .comment ==
                                null ||
                            Provider.of<AddCommentController>(context,
                                    listen: false)
                                .comment
                                .isEmpty ||
                            Provider.of<AddCommentController>(context,
                                        listen: false)
                                    .comment ==
                                "" ||
                            Provider.of<AddCommentController>(context,
                                        listen: false)
                                    .comment ==
                                " ") {
                          _showToast(context, "Please Enter Your Comment !!!");
                        } else {
                          Provider.of<AddCommentController>(context,
                                  listen: false)
                              .addComment()
                              .then((value) {
                            Provider.of<AddCommentController>(context,
                                    listen: false)
                                .resetComment();
                            Navigator.of(context).pop();
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 5, left: 25, right: 25),
                        child: Text(
                          "Submit Comment",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Eczar",
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Provider.of<AddCommentController>(context).processState
              ? Center(
                  child: CircularProgressIndicator(
                  color: kSecondaryColor,
                  backgroundColor: Colors.white,
                ))
              : SizedBox(),
        ],
      ),
    );
  }
}
