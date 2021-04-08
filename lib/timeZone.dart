class TimeZone {
  String value;
  String abbr;
  num offset;
  bool isdst;
  List<String> utc;

  TimeZone({
    this.abbr,
    this.isdst,
    this.offset,
    this.value,
    this.utc,
  });

  factory TimeZone.fromJson(json) {
    return TimeZone(
      value: json["value"],
      abbr: json["abbr"],
      offset: json["offset"],
      isdst: json["isdst"],
      utc: json["utc"] != null
          ? (json["utc"] as List).map((e) => e.toString()).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();

    data["value"] = this.value;
    data["abbr"] = this.abbr;
    data["offset"] = this.offset;
    data["isdst"] = this.isdst;
    data["uts"] = this.utc;

    return data;
  }

  TimeZone copyWith({value}) {
    return TimeZone(value: value ?? this.value);
  }
}
