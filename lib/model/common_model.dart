class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String stateBarColor;
  final bool hideAppBar;

  CommonModel(
      {this.icon, this.title, this.url, this.stateBarColor, this.hideAppBar});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
        icon: json["icon"],
        title: json["title"],
        url: json["url"],
        stateBarColor: json["stateBarColor"],
        hideAppBar: json["hideAppBar"]);
  }
}
