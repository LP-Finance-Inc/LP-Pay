// class Token {
//   late double balance = 0;
//   late double usdBalance = 0;
//   final String mint;
//   Token(this.balance, this.mint);
// }

class TokenInfo {
  late String name;
  late String logoUrl = "";
  late String symbol;
  late String mintAddress;

  TokenInfo({required this.name, required this.symbol});
  TokenInfo.withInfo(this.mintAddress, this.name, this.logoUrl, this.symbol);
}

class TransactionDetail {
  // Who sent the transaction
  final String origin;
  // Recipient of the transaction
  final String destination;
  // How much
  final double ammount;
  // Was the account of this transaction the same as the destination
  final bool receivedOrNot;
  // The Program ID of this transaction, e.g, System Program, Token Program...
  final String programId;
  // The UNIX timestamp of the block where the transaction was included
  final int blockTime;

  TransactionDetail(
    this.origin,
    this.destination,
    this.ammount,
    this.receivedOrNot,
    this.programId,
    this.blockTime,
  );

  Map<String, dynamic> toJson() {
    return {
      "origin": origin,
      "destination": destination,
      "ammount": ammount,
      "receivedOrNot": receivedOrNot,
      "tokenMint": programId,
      "blockNumber": blockTime
    };
  }
}
