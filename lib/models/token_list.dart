import 'package:hive/hive.dart';
part 'token_list.g.dart';

@HiveType(typeId: 1)
class TokenList {
  @HiveField(0)
  late double balance = 0;
  @HiveField(1)
  late double usdBalance = 0;
  @HiveField(2)
  final String mint;

  TokenList(
      {required this.balance, required this.mint, required this.usdBalance});
}
