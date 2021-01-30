class AleartSetupsObject {
  String alertCondition;
  String alertID;
  String bySMS;
  String condition;
  String conditionName;
  String conditionValue;
  String customMsg;
  String exchange;
  String executed;
  String notificationAction;
  String symbol;
  String validity;

  AleartSetupsObject(
      {this.alertCondition,
      this.alertID,
      this.bySMS,
      this.condition,
      this.conditionName,
      this.conditionValue,
      this.customMsg,
      this.exchange,
      this.executed,
      this.notificationAction,
      this.symbol,
      this.validity});

  factory AleartSetupsObject.fromJson(Map<String, dynamic> json) =>
      AleartSetupsObject(
          alertCondition: json['AlertCondition'],
          alertID: json['AlertID'],
          bySMS: json['BySMS'],
          condition: json['Condition'],
          conditionName: json['ConditionName'],
          conditionValue: json['ConditionValue'],
          customMsg: json['CustomMsg'],
          exchange: json['Exchange'],
          executed: json['Executed'],
          notificationAction: json['NotificationAction'],
          symbol: json['Symbol'],
          validity: json['Validity']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AlertCondition'] = this.alertCondition;
    data['AlertID'] = this.alertID;
    data['BySMS'] = this.bySMS;
    data['Condition'] = this.condition;
    data['ConditionName'] = this.conditionName;
    data['ConditionValue'] = this.conditionValue;
    data['CustomMsg'] = this.customMsg;
    data['Exchange'] = this.exchange;
    data['Executed'] = this.executed;
    data['NotificationAction'] = this.notificationAction;
    data['Symbol'] = this.symbol;
    data['Validity'] = this.validity;
    return data;
  }
}
