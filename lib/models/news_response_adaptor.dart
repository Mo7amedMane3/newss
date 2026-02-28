import 'package:hive/hive.dart';

import 'news_response.dart';

class NewsResponseAdapter extends TypeAdapter<NewsResponse> {
  @override
  final int typeId = 2;

  @override
  NewsResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++)
        reader.readByte(): reader.read(),
    };

    return NewsResponse(
      status: fields[0] as String?,
      code: fields[1] as String?,
      message: fields[2] as String?,
      totalResults: fields[3] as int?,
      articles: (fields[4] as List?)?.cast<Articles>(),
    );
  }

  @override
  void write(BinaryWriter writer, NewsResponse obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.totalResults)
      ..writeByte(4)
      ..write(obj.articles);
  }
}