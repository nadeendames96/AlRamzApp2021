class AccountsStatementObject {
  int avgPrice;
  int balance;
  int cRAMT;
  String clientNameA;
  String clientNameE;
  String curNameA;
  String curNameE;
  int dBAMT;
  String docName;
  String docNo;
  String postDate;
  int qTY;
  String remarkA;
  String remarkE;
  String settDate;
  int sharePrice;
  String status;
  int totalComm;

  AccountsStatementObject(
      {this.avgPrice,
        this.balance,
        this.cRAMT,
        this.clientNameA,
        this.clientNameE,
        this.curNameA,
        this.curNameE,
        this.dBAMT,
        this.docName,
        this.docNo,
        this.postDate,
        this.qTY,
        this.remarkA,
        this.remarkE,
        this.settDate,
        this.sharePrice,
        this.status,
        this.totalComm});

 factory AccountsStatementObject.fromJson(Map<String, dynamic> json) =>AccountsStatementObject(
    avgPrice : json['AvgPrice'],
    balance : json['Balance'],
    cRAMT : json['CR_AMT'],
    clientNameA : json['ClientNameA'],
    clientNameE : json['ClientNameE'],
    curNameA : json['CurNameA'],
    curNameE : json['CurNameE'],
    dBAMT : json['DB_AMT'],
    docName : json['DocName'],
    docNo : json['DocNo'],
    postDate : json['PostDate'],
    qTY : json['QTY'],
    remarkA : json['RemarkA'],
    remarkE : json['RemarkE'],
    settDate : json['SettDate'],
    sharePrice : json['SharePrice'],
    status : json['Status'],
    totalComm : json['TotalComm'],
 );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AvgPrice'] = this.avgPrice;
    data['Balance'] = this.balance;
    data['CR_AMT'] = this.cRAMT;
    data['ClientNameA'] = this.clientNameA;
    data['ClientNameE'] = this.clientNameE;
    data['CurNameA'] = this.curNameA;
    data['CurNameE'] = this.curNameE;
    data['DB_AMT'] = this.dBAMT;
    data['DocName'] = this.docName;
    data['DocNo'] = this.docNo;
    data['PostDate'] = this.postDate;
    data['QTY'] = this.qTY;
    data['RemarkA'] = this.remarkA;
    data['RemarkE'] = this.remarkE;
    data['SettDate'] = this.settDate;
    data['SharePrice'] = this.sharePrice;
    data['Status'] = this.status;
    data['TotalComm'] = this.totalComm;
    return data;
  }
}