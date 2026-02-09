class SourcesResponse {
  String? status;
  List<Sources>? sources;

  SourcesResponse({this.status, this.sources});

  SourcesResponse.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    sources = json["sources"] == null ? null : (json["sources"] as List).map((e) => Sources.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    if(sources != null) {
      _data["sources"] = sources?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Sources {
  String? id;
  String? name;
  String? description;
  String? url;
  String? category;
  String? language;
  String? country;

  Sources({this.id, this.name, this.description, this.url, this.category, this.language, this.country});

  Sources.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    url = json["url"];
    category = json["category"];
    language = json["language"];
    country = json["country"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["description"] = description;
    _data["url"] = url;
    _data["category"] = category;
    _data["language"] = language;
    _data["country"] = country;
    return _data;
  }
}