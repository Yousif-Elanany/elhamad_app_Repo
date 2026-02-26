import 'package:hive/hive.dart';

part 'organization_model.g.dart';

@HiveType(typeId: 0)
class Organization extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  Organization({
    required this.name,
    required this.description,
  });
}
