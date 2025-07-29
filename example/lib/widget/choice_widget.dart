import 'package:flutter/material.dart';

class ChoiceWidget extends StatelessWidget {
  final String title;
  final String firstButtonTitle;
  final String secondButtonTitle;
  final Function() firstButtonClicked;
  final Function() secondButtonClicked;

  const ChoiceWidget(
      {super.key,
      required this.title,
      required this.firstButtonTitle,
      required this.secondButtonTitle,
      required this.firstButtonClicked,
      required this.secondButtonClicked});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          automaticallyImplyLeading: false,
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed:  firstButtonClicked,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            shape: const CircleBorder(),
                            minimumSize: const Size(
                                double.infinity, double.infinity), // 최대 크기로 설정
                          ),
                          child: Text(firstButtonTitle),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: secondButtonClicked,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            shape: const CircleBorder(),
                            minimumSize: const Size(
                                double.infinity, double.infinity), // 최대 크기로 설정
                          ),
                          child: Text(secondButtonTitle),
                        ),
                      ),
                    ),
                  ]),
            )));
  }
}
