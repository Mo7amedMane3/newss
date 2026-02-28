import 'package:hive/hive.dart';
import 'package:newss/models/sources_response.dart';

class SourcesResponseAdapter extends TypeAdapter<SourcesResponse> {
  @override
  final int typeId = 0;

  @override
  SourcesResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++)
        reader.readByte(): reader.read(),
    };
    return SourcesResponse(
      status: fields[0] as String?,
      sources: (fields[1] as List?)?.cast<Sources>(),
    );
  }

  @override
  void write(BinaryWriter writer, SourcesResponse obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.sources);
  }
}