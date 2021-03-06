
import 'package:flutter_demo2/screen/app_sign_in/validator.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidators
{
  EmailSignInModel(
      {this.email = '',
      this.password = '',
      this.formType = EmailSignInFormType.signIn,
      this.isLoading = false,
      this.submitted = false});

  final String email ;
  final String password ;
  final EmailSignInFormType formType ;
  final bool isLoading ;
  final bool submitted ;

String get primaryButtonText {
  return formType == EmailSignInFormType.signIn
      ? 'Sign In'
      : 'Create an account';
}

String get secondaryButtonText {
  return formType == EmailSignInFormType.signIn
  ? 'Need an account ? Register'
      : 'Have an account ? Sign In';
}

String get passwordError
{
   bool  showErrorText =
     submitted && !emailValidator.isValid(password);
  return   showErrorText ? invalidPasswordErrorText : null ;
}

  String get emailErrorText
  {
    bool showErrorText =
        submitted && !emailValidator.isValid(email);
    return   showErrorText ? invalidEmailErrorText : null ;
  }

bool get canSubmit {
  return emailValidator.isValid(email) &&
   emailValidator.isValid(password) &&
      !isLoading;
}
EmailSignInModel  copyWith({
  String email ,
  String password,
  EmailSignInFormType formType ,
  bool isLoading ,
  bool submitted ,
}){
  return EmailSignInModel(
    email: email ?? this.email ,
    password:  password ?? this.password ,
    formType:  formType ?? this.formType ,
    isLoading:  isLoading ?? this.isLoading ,
    submitted:  submitted ?? this.submitted
  );
}

// model.copyWith(email : email )
}
