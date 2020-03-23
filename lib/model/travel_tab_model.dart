class TravelTabModel {
    //http://www.devio.org/io/flutter_app/json/travel_page.json
    List<TravelTab> tabs;
    String url;

    TravelTabModel({this.tabs, this.url});

    factory TravelTabModel.fromJson(Map<String, dynamic> json) {
        return TravelTabModel(
            tabs: json['tabs'] != null ? (json['tabs'] as List).map((i) => TravelTab.fromJson(i)).toList() : null,
            url: json['url'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['url'] = this.url;
        if (this.tabs != null) {
            data['tabs'] = this.tabs.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class TravelTab {
    String groupChannelCode;
    String labelName;

    TravelTab({this.groupChannelCode, this.labelName});

    factory TravelTab.fromJson(Map<String, dynamic> json) {
        return TravelTab(
            groupChannelCode: json['groupChannelCode'], 
            labelName: json['labelName'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['groupChannelCode'] = this.groupChannelCode;
        data['labelName'] = this.labelName;
        return data;
    }
}