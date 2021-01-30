class MenuPopUpMobile {
  static const bool isEN = true;
  static const String aleart = isEN ? "Alert setup" : "التنبيهات";
  static const String transfer_account =
      isEN ? 'Transfer amount' : 'مبلغ التحويل';
  static const String settings = isEN ? "Settings" : "اعدادات";
  static const String change_password =
      isEN ? "Change Password" : 'كلمة المرور';
  static const String sign_out = isEN ? "Sign Out" : 'خروج';
  static const List<String> choice = <String>[
    aleart,
    transfer_account,
    change_password,
    settings,
    sign_out
  ];
}
