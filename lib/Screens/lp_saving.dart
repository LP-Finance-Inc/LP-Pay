import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lp_finance/Controller/lp_saving_controller.dart';
import 'package:lp_finance/Screens/current_plan.dart';
import 'package:lp_finance/Widgets/lp_terms.dart';
import 'package:sizer/sizer.dart';
import 'package:lp_finance/Widgets/signup_form.dart';
import 'package:flutter_html/flutter_html.dart';

class LpSavingView extends StatelessWidget {
  LpSavingView({Key? key}) : super(key: key);

  final LpSavingController lpSavingController = Get.put(LpSavingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).backgroundColor,
        body: Obx(
          () => (Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 7.h,
                  left: 5.w,
                  bottom: 1.h,
                  right: 5.w,
                ),
                width: MediaQuery.of(context).size.width,
                height: 100,
                // height: ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Get.back();
                      },
                    ),
                    Text(
                      lpSavingController.screenTitle.value,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox()
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 87.5.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: 10.w, top: 5.h, right: 10.w, bottom: 5.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Options',
                            style: TextStyle(
                              color: Color(0xff7A869A),
                              fontSize: 13.sp,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          LpTerms(
                            title: "3 Months",
                            interest: "2.3%",
                            checked: true,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          LpTerms(
                            title: "6 Months",
                            interest: "3.3%",
                            checked: false,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          LpTerms(
                            title: "12 Months",
                            interest: "5.3%",
                            checked: false,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 2.h,
                                width: 2.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xff0a84ff), width: 3),
                                ),
                              ),
                              Expanded(
                                child: ExpandableText(
                                  html:
                                      """                              <ul style="list-style-type: undefined;">
                                              <li><strong><em>Terms</em></strong> refer to the locked period of deposited amount in the <strong><em>LP Savings Wallet</em></strong></li>
                                              <li><strong><em>Deposit/Withdrawal Fee&nbsp;</em></strong>is a two-separate fee</li>
                                          </ul>
                                          <p style='margin-top:0in;margin-right:0in;margin-bottom:0in;margin-left:.5in;line-height:150%;font-size:15px;font-family:"Calibri",sans-serif;'><strong><em>-&gt;<span style='background:yellow;'>Deposit Fee</span></em></strong> refers to a fee that occurs when the user deposits fund from <strong>LP Transaction Wallet</strong> to <strong>LP Savings Wallet</strong>. Deposit Fee is going to be charged to the <strong>LP Transaction Wallet</strong>.</p>
                                          <p style='margin-top:0in;margin-right:0in;margin-bottom:0in;margin-left:.5in;line-height:150%;font-size:15px;font-family:"Calibri",sans-serif;'><strong><em>ex)</em></strong> Eric deposits \$10,000 from LP Transaction Wallet (\$10,500) to LP Savings Wallet (\$0). \$10,00 is deposited to the LP Savings Wallet and a fee is charged to the LP Transaction Wallet, resulting in a balance of 10,500-10,000-Deposit Fee. If there is no sufficient balance to charge the fees, the transaction is declined.&nbsp;</p>
                                          <p style='margin-top:0in;margin-right:0in;margin-bottom:0in;margin-left:.5in;line-height:150%;font-size:15px;font-family:"Calibri",sans-serif;'><strong><em>-&gt;<span style="background:yellow;">Withdrawal fee</span>&nbsp;</em></strong>refers to a fee that occurs when the user withdraws fund from <strong>LP Savings Wallet&nbsp;</strong>to <strong>LP Transaction Wallet.</strong> Withdrawal fee is going to be charged to the <strong>LP Savings Wallet</strong>.</p>
                                          <p style='margin-top:0in;margin-right:0in;margin-bottom:0in;margin-left:.5in;line-height:150%;font-size:15px;font-family:"Calibri",sans-serif;'><strong>ex)&nbsp;</strong>Eric withdraws \$10,000 from LP Savings Wallet to LP Transaction Wallet. His total withdrawal amount would be 10,000-Withdrawal Fee.</p>
                                          <ul class="decimal_type" style="list-style-type: undefined;">
                                              <li><strong><em>Minimum Deposit</em></strong> refers to a minimum amount that should be deposited to create a term in <strong>LP Savings Wallet.&nbsp;</strong>If the deposit amount is lower than the minimum deposit, the transaction is declined.</li>
                                              <li><strong><em>Interest is compounded daily</em></strong></li>
                                          </ul>
                                          <ul style="list-style-type: undefined;margin-left:0.25in;">
                                              <li>5.3% Interest Rate -&gt; 0.01452% return daily on previous amount -&gt; 5.442% APY</li>
                                          </ul>""",
                                ),
                              )
                            ],
                          ),
                          Text(
                            'Amount',
                            style: TextStyle(
                              color: Color(0xff7A869A),
                              fontSize: 13.sp,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(234, 237, 247, 0.45),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: FocusScope(
                              child: Focus(
                                onFocusChange: (focus) {
                                  print("focus: $focus");
                                  lpSavingController.isFocus.value = focus;
                                },
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    hintText: 'amount',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color:
                                          Color(0xff2C3D57).withOpacity(0.46),
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                    suffixIcon: Icon(
                                      Icons.attach_money_outlined,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width,
                            child: TextButton(
                              onPressed: () {
                                // Get.toNamed('/currentplan');
                                Get.to(LpSavingView());
                              },
                              child: Text(
                                'Deposit'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          SizedBox(
                              height: lpSavingController.isFocus.isTrue
                                  ? 40.h
                                  : 0.h),
                        ],
                      )),
                ),
              )
            ],
          )),
        ));
  }
}

class ExpandableText extends StatefulWidget {
  ExpandableText({this.html});
  final html;

  bool isExpanded = false;

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      new AnimatedSize(
          duration: const Duration(milliseconds: 500),
          child: new ConstrainedBox(
              constraints: widget.isExpanded
                  ? new BoxConstraints()
                  : new BoxConstraints(maxHeight: 15.h),
              child: Stack(
                children: [
                  new Html(data: widget.html, style: {
                    "span": Style(
                      backgroundColor: Colors.yellow,
                    ),
                    "body": Style(
                      margin: EdgeInsets.zero,
                    )
                  }),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AnimatedOpacity(
                      opacity: widget.isExpanded ? 0 : 1,
                      duration: Duration(seconds: 1),
                      child: Container(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ),
                ],
              ))),
      widget.isExpanded
          ? Column(
              children: [
                new ConstrainedBox(constraints: new BoxConstraints()),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        child: const Text('Hide me'),
                        onPressed: () =>
                            setState(() => widget.isExpanded = false)),
                  ],
                )
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                new TextButton(
                    child: const Text('Ream more'),
                    onPressed: () => setState(() => widget.isExpanded = true)),
              ],
            )
    ]);
  }
}
