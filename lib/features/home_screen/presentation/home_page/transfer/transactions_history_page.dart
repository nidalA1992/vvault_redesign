import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:intl/intl.dart';
import 'package:vvault_redesign/features/home_screen/presentation/home_page/provider/transaction_history_provider.dart';
import 'package:vvault_redesign/features/home_screen/presentation/settings_page/settings_page.dart';
import 'package:vvault_redesign/features/shared/ui_kit/appbar_without_avatar.dart';
import 'package:vvault_redesign/features/shared/ui_kit/home_page/operation_instance.dart';

class TransactionsHistoryPage extends StatefulWidget {
  const TransactionsHistoryPage({super.key});

  @override
  State<TransactionsHistoryPage> createState() => _TransactionsHistoryPageState();
}

enum SortCriteria { date, type, currency }

class _TransactionsHistoryPageState extends State<TransactionsHistoryPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool _isAscending = true;
  Map<String, List<dynamic>> groupedTransactions = {};
  String? selectedType;
  bool ascendingSelected = false;

  Future<void> _loadData({bool ascending = false, String? filter}) async {
    await Provider.of<TransactionHistoryProvider>(context, listen: false)
        .loadTransactions(ascending: ascending, filter: filter);
    List<dynamic> transactions =
        Provider.of<TransactionHistoryProvider>(context, listen: false).transactions;
    _groupTransactionsByDate(transactions);
  }

  void _groupTransactionsByDate(List<dynamic> transactions) {
    setState(() {
      groupedTransactions = {};
      for (var transaction in transactions) {
        String date = DateFormat('yyyy-MM-dd').format(DateTime.parse(transaction['CreatedAt']));
        if (!groupedTransactions.containsKey(date)) {
          groupedTransactions[date] = [];
        }
        groupedTransactions[date]!.add(transaction);
      }
    });
  }

  void _onRefresh() async {
    await _loadData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          decoration: BoxDecoration(color: Color(0xFF141619)),
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBarWithoutAva(
                  txt: "Transaction History",
                ),
                SizedBox(height: 20.h,),
                Container(
                  width: 350.w,
                  height: 1.50.h,
                  color: Color(0xFF1D2126),
                ),
                SizedBox(height: 20.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _customButton("Дата"),
                    _customButton("Тип"),
                    SizedBox(width: 104.w,)
                  ],
                ),
                SizedBox(height: 20.h,),
                Expanded(
                  child: SmartRefresher(
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    enablePullDown: true,
                    child: ListView(
                      children: _buildDateSections(),
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

  List<Widget> _buildDateSections() {
    List<Widget> sections = [];
    groupedTransactions.forEach((date, transactions) {
      sections.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    color: Color(0xFFEDF7FF),
                    fontSize: 16.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h,)
              ],
            ),
          )
      );
      sections.addAll(
          transactions.map((transaction) => OperationInstance(
            type: transaction['Type'],
            username: transaction['From'],
            quantity: transaction['GiveAmount'],
            currency: transaction['Currency'],
            walletAdress: transaction['data']['wallet_address'] ?? '',
            tx_hash: transaction['data']['tx_hash'] ?? '',
            dateTime: transaction['UpdatedAt'],
          )).toList()
      );
    });
    return sections;
  }

  Widget _customButton(String text) {
    return InkWell(
      onTap: () async {
        if (text == "Дата") {
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Color(0xFF141619),
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    decoration: ShapeDecoration(
                      color: Color(0xFF1D2126),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Container(
                              width: 350.w,
                              height: 50.h,
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              decoration: ShapeDecoration(
                                color: ascendingSelected ? Color(0xFF1A283C) : Color(0xFF21262D),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ascending",
                                    style: TextStyle(
                                      color: Color(0xFFEDF7FF),
                                      fontSize: 14.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )),
                          onTap: () {
                            setState(() {
                              _isAscending = true;
                              ascendingSelected = true;
                            });
                            Navigator.pop(context);
                            _loadData(ascending: true);
                          },
                        ),
                        ListTile(
                          title: Container(
                              width: 350.w,
                              height: 50.h,
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              decoration: ShapeDecoration(
                                color: !ascendingSelected ? Color(0xFF1A283C) : Color(0xFF21262D),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Descending",
                                    style: TextStyle(
                                      color: Color(0xFFEDF7FF),
                                      fontSize: 14.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )),
                          onTap: () {
                            setState(() {
                              _isAscending = false;
                              ascendingSelected = false;
                            });
                            Navigator.pop(context);
                            _loadData(ascending: false);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        } else if (text == "Тип") {
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Color(0xFF141619),
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  double bottomSheetHeight = MediaQuery.of(context).size.height * 0.6;
                  final types = ['all', 'deal', 'payment', 'exchange', 'withdraw', 'deposit', 'transfer', 'freezing', 'payment_deal'];
                  return Container(
                    height: bottomSheetHeight,
                    decoration: ShapeDecoration(
                      color: Color(0xFF1D2126),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: ListView.builder(
                      itemCount: types.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Container(
                            width: 350.w,
                            height: 50.h,
                            padding: EdgeInsets.symmetric(horizontal: 20.h),
                            decoration: ShapeDecoration(
                              color: selectedType == types[index] ? Color(0xFF1A283C) : Color(0xFF21262D),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  types[index],
                                  style: TextStyle(
                                    color: Color(0xFFEDF7FF),
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setModalState(() => selectedType = types[index]);
                            Navigator.pop(context);
                            String? filter = selectedType == 'all' ? null : selectedType;
                            _loadData(filter: filter);
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        } else if (text == "Валюта") {
          // Implement currency filter logic here, if necessary
        }
      },
      child: Container(
        width: 104.w,
        height: 40.h,
        decoration: ShapeDecoration(
          color: Color(0xFF262C35),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Color(0x7FEDF7FF),
                fontSize: 14.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 5.w,),
            Icon(Icons.keyboard_arrow_down_outlined, color: Color(0x7FEDF7FF)),
          ],
        ),
      ),
    );
  }

}