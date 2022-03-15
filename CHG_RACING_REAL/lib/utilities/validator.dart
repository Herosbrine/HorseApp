class Validator {
  String? validatePassword(String password) => password.isEmpty
      ? 'Entrez un mot de passe valide'
      : password.toString().length < 6
          ? 'Le mot de passe doit comporter 6 caractères'
          : null;

  String? validateEmail(String value) {
    Pattern pattern = r"^[\w-\.]+@([\w-]+\.)+[a-zA-Z]{2,4}$";
    RegExp regex = new RegExp(pattern as String);
    if (value.isEmpty) {
      return "entrer l'adresse email";
    }
    if (!regex.hasMatch(value.trim()))
      return 'Entrez une adresse mail valide';
    else
      return null;
  }

  String? validateConfirmPassword(String password, String confirmPassWord) {
    if (password != confirmPassWord) {
      return 'Le mot de passe ne correspond pas';
    } else
      return null;
  }
}
