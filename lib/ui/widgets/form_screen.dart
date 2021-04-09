import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  final List<Widget> formFields;

  const FormContainer({
    Key key,
    this.formFields,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          children: formFields,
        ),
      ),
    );
  }
}
