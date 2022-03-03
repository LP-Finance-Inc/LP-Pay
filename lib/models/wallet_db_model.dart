import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:lp_finance/models/token_list.dart';
import 'package:solana/solana.dart';
part 'wallet_db_model.g.dart';

// List<WalletDbModel> walletDbModelFromJson(String str) =>
//     List<WalletDbModel>.from(
//         json.decode(str).map((x) => WalletDbModel.fromJson(x)));
//
// String walletDbModelToJson(List<WalletDbModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 0)
class WalletDbModel {
  WalletDbModel({
    this.name,
    this.password,
    this.address,
    this.balance,
    this.usdBalance,
    this.token,
    this.wallet,
  });

  @HiveField(0)
  String? name;
  @HiveField(1)
  String? password;
  @HiveField(2)
  String? address;
  @HiveField(3)
  String? balance;
  @HiveField(4)
  String? usdBalance;
  @HiveField(5)
  List<TokenList>? token;
  @HiveField(6)
  String? wallet;

  factory WalletDbModel.fromJson(Map<String, dynamic> json) => WalletDbModel(
        name: json["name"],
        password: json["password"],
        address: json["address"],
        balance: json["balance"],
        usdBalance: json["usdBalance"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
        "address": address,
        "balance": balance,
        "usdBalance": usdBalance,
      };
}
