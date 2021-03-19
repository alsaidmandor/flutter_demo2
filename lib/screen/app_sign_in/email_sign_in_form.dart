import 'package:flutter/material.dart';
import 'package:flutter_demo2/common_widget/form_submit_button.dart';
import 'package:flutter_demo2/screen/app_sign_in/validator.dart';
import 'package:flutter_demo2/services/auth.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  EmailSignInForm({@required this.auth});

  final AuthBase auth;

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}
// TextEditingController uses StatefulWidget not StatelessWidget .

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  String get _email => _emailController.text;

  String get _password => _passwordController.text;

  void _submit() async {
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign In'
        : 'Create an account';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an account ? Register'
        : 'Have an account ? Sign In';

    bool submitEnable = widget.emailValidator.isValid(_email) &&
        widget.emailValidator.isValid(_password);

    return [
      _buildEmailTextField(),
      SizedBox(
        height: 8.0,
      ),
      _buildPasswordTextField(),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitButton(
        onPressed: submitEnable ? _submit : null,
        txt: primaryText,
      ),
      SizedBox(
        height: 8.0,
      ),
      TextButton(
        onPressed: _toggleFormType,
        child: Text(
          secondaryText,
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    bool passwordValid = widget.emailValidator.isValid(_password);

    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: passwordValid ? null : widget.invalidPasswordErrorText ,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      // enable to done or submit
      onEditingComplete: _submit,
      onChanged: (email) => updateState(),
    );
  }

  TextField _buildEmailTextField() {
    bool emailValid = widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      // use this for focus or show Keyboard when click email page
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: emailValid ? null :widget.invalidEmailErrorText ,
      ),
      onChanged: (email) => updateState(),
      autocorrect: false,
      // hide th top bar for keyboard
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      // enable to next textField
      onEditingComplete:
          _emailEditingComplete, // use this onEditingComplete when editableText.onEditingComplete
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }

  void updateState() {
    setState(() {});
  } // use this method to enable button when write at least one letter in password after complete email
}
