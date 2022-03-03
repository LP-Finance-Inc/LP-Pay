import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lp_finance/Screens/withdraw_address.dart';

class Withdraw extends StatelessWidget {
  const Withdraw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 40,
                left: 10,
                bottom: 20,
                right: 10,
              ),
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
              ),
              // height: ,
              child: ListTile(
                leading: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                title: Text(
                  'Savings Withdraw',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'From',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 15, right: 15),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Flexiable',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              // fontSize: 14,
                              color: Theme.of(context).primaryColor),
                        ),
                        Text(
                          '\$5002',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              // fontSize: 14,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 15, right: 15),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '12 Months',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              // fontSize: 14,
                              color: Theme.of(context).primaryColor),
                        ),
                        Text(
                          '\$200',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              // fontSize: 14,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Amount',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 15, right: 15),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '\$200.0',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              // fontSize: 14,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Withdrawal fee',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        alignment: Alignment.centerRight,
                        child: Text(
                          '\$30',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(
          right: 10,
          left: 10,
          bottom: 10,
        ),
        width: MediaQuery.of(context).size.width,
        child: TextButton(
          onPressed: () {
            // Get.to(() => WithdrawalAddress());
            Get.toNamed('/withdrawaddress');
          },
          child: Text(
            'Withdraw'.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
