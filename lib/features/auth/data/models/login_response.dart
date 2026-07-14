class LoginResponse {
  String? token;
  Meta? mMeta;

  LoginResponse({this.token, this.mMeta});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    mMeta = json['_meta'] != null ? new Meta.fromJson(json['_meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = this.token;
    if (this.mMeta != null) {
      data['_meta'] = this.mMeta!.toJson();
    }
    return data;
  }
}

class Meta {
  String? poweredBy;
  String? docsUrl;
  String? upgradeUrl;
  String? exampleUrl;
  String? variant;
  String? message;
  Cta? cta;
  String? context;

  Meta(
      {this.poweredBy,
        this.docsUrl,
        this.upgradeUrl,
        this.exampleUrl,
        this.variant,
        this.message,
        this.cta,
        this.context});

  Meta.fromJson(Map<String, dynamic> json) {
    poweredBy = json['powered_by'];
    docsUrl = json['docs_url'];
    upgradeUrl = json['upgrade_url'];
    exampleUrl = json['example_url'];
    variant = json['variant'];
    message = json['message'];
    cta = json['cta'] != null ? new Cta.fromJson(json['cta']) : null;
    context = json['context'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['powered_by'] = this.poweredBy;
    data['docs_url'] = this.docsUrl;
    data['upgrade_url'] = this.upgradeUrl;
    data['example_url'] = this.exampleUrl;
    data['variant'] = this.variant;
    data['message'] = this.message;
    if (this.cta != null) {
      data['cta'] = this.cta!.toJson();
    }
    data['context'] = this.context;
    return data;
  }
}

class Cta {
  String? label;
  String? url;

  Cta({this.label, this.url});

  Cta.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['url'] = this.url;
    return data;
  }
}
