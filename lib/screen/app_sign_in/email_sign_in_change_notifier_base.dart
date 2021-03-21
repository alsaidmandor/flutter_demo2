import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo2/common_widget/form_submit_button.dart';
import 'package:flutter_demo2/common_widget/show_exception_alert_dialog.dart';
import 'package:flutter_demo2/models/email_sign_in_change_Model.dart';
import 'package:flutter_demo2/services/auth.dart';
import 'package:provider/provider.dart';

class EmailSignInFormChangeNotifierBase extends StatefulWidget {
  EmailSignInFormChangeNotifierBase({Key key, @required this.model}) : super(key: key);

  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (_) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (_, model, __) => EmailSignInFormChangeNotifierBase(model: model),
      ),
    );
  }

  @override
  _EmailSignInFormChangeNotifierBaseState createState() =>
      _EmailSignInFormChangeNotifierBaseState();
}
// TextEditingController uses StatefulWidget not StatelessWidget .

class _EmailSignInFormChangeNotifierBaseState extends State<EmailSignInFormChangeNotifierBase> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  EmailSignInChangeModel get model => widget.model ;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await widget.model.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: e,
      );
    }
  }

  void _emailEditingComplete() {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    widget.model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
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
        onPressed: model.canSubmit ? _submit : null,
        txt: model.primaryButtonText,
      ),
      SizedBox(
        height: 8.0,
      ),
      TextButton(
        onPressed: !model.isLoading ? _toggleFormType : null,
        child: Text(
         model.secondaryButtonText,
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
          labelText: 'Password',
          errorText: model.passwordError ,
          enabled: model.isLoading == false),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: widget.model.updatePassword,
      // enable to done or submit
      onEditingComplete: _submit,

    );
  }

  TextField _buildEmailTextField() {

    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      // use this for focus or show Keyboard when click email page
      decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@test.com',
          errorText: model.emailErrorText ,
          enabled: model.isLoading == false),

      autocorrect: false,
      // hide th top bar for keyboard
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,// enable to next textField
      onChanged:  model.updateEmail,
      onEditingComplete: () => _emailEditingComplete(  ), // use this onEditingComplete when editableText.onEditingComplete
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
}
