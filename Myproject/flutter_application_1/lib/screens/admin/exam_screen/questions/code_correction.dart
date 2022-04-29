import 'package:flutter/material.dart';

class CodeCorrection extends StatefulWidget {
  const CodeCorrection({Key? key}) : super(key: key);

  @override
  State<CodeCorrection> createState() => _CodeCorrectionState();
}

class _CodeCorrectionState extends State<CodeCorrection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Code Correctie"),
      ),
    );
  }
}
