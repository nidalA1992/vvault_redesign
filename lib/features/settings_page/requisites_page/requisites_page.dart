import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vvault_redesign/features/settings_page/requisites_page/edit_requisites.dart';
import 'package:vvault_redesign/features/settings_page/requisites_page/new_requisite_page.dart';
import 'package:vvault_redesign/features/settings_page/requisites_page/provider/requisites_list_provider.dart';
import 'package:vvault_redesign/features/shared/ui_kit/custom_button.dart';
import 'package:vvault_redesign/features/shared/ui_kit/requisite_instance.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../../main.dart';

class RequisitesPage extends StatefulWidget {
  const RequisitesPage({super.key});

  @override
  State<RequisitesPage> createState() => _RequisitesPageState();
}

class _RequisitesPageState extends State<RequisitesPage> with RouteAware {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ModalRoute? modalRoute = ModalRoute.of(context);
    if (modalRoute is PageRoute) {
      routeObserver.subscribe(this, modalRoute);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    _loadData();
  }

  void _loadData() async {
    await Provider.of<RequisitesListProvider>(context, listen: false).loadRequisites();
    _refreshController.refreshCompleted();
  }

  List<RequisiteInstance> _createRequisiteInstances(List<Map<String, dynamic>> requisites) {
    Map<String, List<Map<String, String>>> groupedRequisites = {};
    for (var requisite in requisites) {
      groupedRequisites.putIfAbsent(requisite['bank'], () => []).add({'requisite': requisite['requisite'], 'comment': requisite['comment']});
    }

    List<RequisiteInstance> requisiteInstances = [];
    for (var entry in groupedRequisites.entries) {
      RequisiteInstance instance = RequisiteInstance(
        bankName: entry.key,
        requisites: entry.value,
        onRequisitePressed: (context, requisite) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => EditRequisitePage(requisite: requisite['requisite'], comment: requisite['comment'])));
        },
      );
      requisiteInstances.add(instance);
    }

    return requisiteInstances;
  }

  @override
  Widget build(BuildContext context) {
    final requisites = Provider.of<RequisitesListProvider>(context).requisites;
    List<RequisiteInstance> requisiteInstances = _createRequisiteInstances(requisites.cast<Map<String, dynamic>>());

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(color: Color(0xFF141619)),
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    SizedBox(height: 20.h,),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_outlined, color: Color(0x7FEDF7FF))
                        ),
                        SizedBox(width: 10.w,),
                        Text(
                          'Реквизиты',
                          style: TextStyle(
                            color: Color(0xFFEDF7FF),
                            fontSize: 20.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    Container(
                      width: 350.w,
                      height: 1.50.h,
                      color: Color(0xFF1D2126),
                    ),
                    SizedBox(height: 20.h,),
                    Expanded(
                      child: SmartRefresher(
                        controller: _refreshController,
                        onRefresh: _loadData,
                        child: ListView(
                          children: [
                            for (var instance in requisiteInstances) instance,
                          ],
                        ),
                      ),
                    ),
                    CustomButton(
                      text: "Добавить реквизиты",
                      clr: Color(0xFF0066FF),
                      onPressed: (context) async {
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NewRequisitePage())
                        );
                        if (result == true) {
                          _loadData();
                        }
                      },
                    ),
                    SizedBox(height: 20.h,)
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}