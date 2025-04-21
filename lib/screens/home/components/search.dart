import 'package:flutter/material.dart';
import 'package:logo_n_spinner/logo_n_spinner.dart';
import 'package:real_estate_app/utils/constants.dart';

class SearchForm extends StatefulWidget {
  @override
  State<SearchForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SearchForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          if (isLoading == false) ...[
            Form(
              key: _formKey,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .5,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: SemiBlack,
                          ),
                          hintText: "Saint Petersburg",
                          prefixIcon: Icon(
                            Icons.location_pin,
                            color: SemiBlack,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(
                            color: SemiBlack,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width:
                                  2, // Optional: makes the border more visible
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2, // Optional
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Email cannot be blank' : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            Center(
              child: LogoandSpinner(
                imageAssets: 'assets/images/logo.png',
                reverse: true,
                arcColor: kPrimaryColor,
                spinSpeed: Duration(milliseconds: 500),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
