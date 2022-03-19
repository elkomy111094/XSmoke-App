import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 6,
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white,
                      child: Column())),
              Expanded(
                  flex: 4,
                  child: Container(
                      color: Color(0xFFF05057).withOpacity(.4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [],
                      ))),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width * 1.19,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                child: Icon(
                  Icons.close,
                  size: 30,
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 10),
                    color: Colors.white,
                    shape: BoxShape.circle),
                height: 70,
                width: 70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
