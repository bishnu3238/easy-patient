class Doctor {
  final String id;
  final String doc_id;
  final DateTime join_date;
  final String title;
  final String doctor_name;
  final String image;
  final String department;
  final String mobile;
  final String password;
  final String gender;
  final DateTime dob;
  final String address;
  final String email;
  final String specialist;
  final String qulifica;
  final String experi;
  final String regn_no;
  final String state;
  final String city;
  final String pincode;
  final String about_doctor;
  final String bank_name;
  final String account_no;
  final String ifsc_code;
  final String branch_code;
  final String status;
  final DateTime date;

  const Doctor({
    required this.id,
    required this.doc_id,
    required this.join_date,
    required this.title,
    required this.doctor_name,
    required this.image,
    required this.department,
    required this.mobile,
    required this.password,
    required this.gender,
    required this.dob,
    required this.address,
    required this.email,
    required this.specialist,
    required this.qulifica,
    required this.experi,
    required this.regn_no,
    required this.state,
    required this.city,
    required this.pincode,
    required this.about_doctor,
    required this.bank_name,
    required this.account_no,
    required this.ifsc_code,
    required this.branch_code,
    required this.status,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'doc_id': doc_id,
      'join_date': join_date,
      'title': title,
      'doctor_name': doctor_name,
      'image': image,
      'department': department,
      'mobile': mobile,
      'password': password,
      'gender': gender,
      'dob': dob,
      'address': address,
      'email': email,
      'specialist': specialist,
      'qulifica': qulifica,
      'experi': experi,
      'regn_no': regn_no,
      'state': state,
      'city': city,
      'pincode': pincode,
      'about_doctor': about_doctor,
      'bank_name': bank_name,
      'account_no': account_no,
      'ifsc_code': ifsc_code,
      'branch_code': branch_code,
      'status': status,
      'date': date,
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      join_date: map['join_date'] as DateTime,
      title: map['title'] as String,
      doctor_name: map['doctor_name'] as String,
      image: map['image'] as String,
      department: map['department'] as String,
      mobile: map['mobile'] as String,
      password: map['password'] as String,
      gender: map['gender'] as String,
      dob: map['dob'] as DateTime,
      address: map['address'] as String,
      email: map['email'] as String,
      specialist: map['specialist'] as String,
      qulifica: map['qulifica'] as String,
      experi: map['experi'] as String,
      regn_no: map['regn_no'] as String,
      state: map['state'] as String,
      city: map['city'] as String,
      pincode: map['pincode'] as String,
      about_doctor: map['about_doctor'] as String,
      bank_name: map['bank_name'] as String,
      account_no: map['account_no'] as String,
      ifsc_code: map['ifsc_code'] as String,
      branch_code: map['branch_code'] as String,
      status: map['status'] as String,
      date: map['date'] as DateTime,
    );
  }
}
