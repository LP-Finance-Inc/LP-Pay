// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokenListAdapter extends TypeAdapter<TokenList> {
  @override
  final int typeId = 1;

  @override
  TokenList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TokenList(
      balance: fields[0] as double,
      mint: fields[2] as String,
      usdBalance: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TokenList obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.balance)
      ..writeByte(1)
      ..write(obj.usdBalance)
      ..writeByte(2)
      ..write(obj.mint);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
