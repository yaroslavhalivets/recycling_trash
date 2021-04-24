class Uid {
  String? uid;

  Uid(this.uid);

  factory Uid.fromJson(Map<String, dynamic> json) => Uid(json['uid']);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
    };
  }
}
