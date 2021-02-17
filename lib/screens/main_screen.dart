import 'package:flutter/material.dart';
import 'package:test_reka/core/api.dart';
import 'package:test_reka/core/models/cuaca.dart';
import 'package:test_reka/core/models/wilayah.dart';
import 'package:test_reka/core/service.dart';
import 'package:test_reka/screens/theme.dart';
import 'package:test_reka/utils/converter.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  //create controller untuk tabBar
  TabController controller;
  int _currentIndex = 0;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 2);
    setState(() {
      isLoading = true;
    });
    getWilayah().then((value) {
      setState(() {
        isLoading = false;
        listWilayah = value;
      });
    });
    controller.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (controller.indexIsChanging) {
      if (controller.index == 1) {
        shortListCuaca = listCuaca
            .where((e) => e.jamCuaca.day != DateTime.now().day)
            .toList();
      }
      if (controller.index == 0) {
        shortListCuaca = listCuaca
            .where((e) => e.jamCuaca.day == DateTime.now().day)
            .toList();
      }
      setState(() {
        _currentIndex = controller.index;
      });
    }
  }

  List<Wilayah> listWilayah;
  Wilayah selectedWilayah;
  bool isLoading = false;

  List<Cuaca> listCuaca;
  List<Cuaca> shortListCuaca;
  Cuaca selectedCuaca;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Container(
              width: deviceWidth(context),
              height: deviceHeight(context),
              decoration: BoxDecoration(
                color: purpleColor,
              ),
              child: Center(child: CircularProgressIndicator()))
          : Stack(
              children: [
                Container(
                    width: deviceWidth(context), height: deviceHeight(context)),
                Container(
                    width: deviceWidth(context),
                    height: deviceHeight(context) - (deviceHeight(context) / 3),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [purpleColor, blueColor]))),
                Container(
                  width: deviceWidth(context),
                  height: deviceHeight(context),
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(
                          //   'DKI Jakarta',
                          //   style: fontWhite.copyWith(
                          //       fontSize: 18, fontWeight: FontWeight.bold),
                          // ),
                          SizedBox(width: 5),
                          Container(
                            width: 250,
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              iconEnabledColor: Colors.white,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                              ),
                              hint: Text(
                                "Select Your City",
                                style: fontWhite.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              style: fontWhite.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              value: selectedWilayah,
                              items: listWilayah.map((value) {
                                return DropdownMenuItem(
                                  child: Text(
                                    value.kota,
                                  ),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedWilayah = value;
                                });
                                getCuaca(value.id).then((value) {
                                  setState(() {
                                    listCuaca = value;
                                    shortListCuaca = value
                                        .where((e) =>
                                            e.jamCuaca.day ==
                                            DateTime.now().day)
                                        .toList();
                                    selectedCuaca = value.firstWhere((e) =>
                                        e.jamCuaca.hour >= DateTime.now().hour);
                                  });
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      listCuaca == null
                          ? SizedBox(height: 90)
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 90,
                                  child: Text('${selectedCuaca.tempC}',
                                      style: fontWhite.copyWith(
                                          fontSize: 80,
                                          fontWeight: FontWeight.w300)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(180),
                                      border: Border.all(
                                          color: Colors.white, width: 2)),
                                )
                              ],
                            ),
                      SizedBox(
                        height: 30,
                      ),
                      Text("${tanggalWithTime(DateTime.now())}",
                          style: fontWhite.copyWith(fontSize: 14)),
                      listCuaca == null
                          ? SizedBox()
                          : Text(selectedCuaca.cuaca,
                              style: fontWhite.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                      listCuaca == null
                          ? SizedBox()
                          : Image.network(
                              API.iconCuaca + '${selectedCuaca.kodeCuaca}.png'),
                      Expanded(child: SizedBox()),
                      Container(
                        width: deviceWidth(context),
                        height: deviceHeight(context) / 3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TabBar(
                                labelStyle: fontBlack,
                                controller: controller,
                                indicatorColor: Colors.black,
                                indicator: UnderlineTabIndicator(
                                    insets:
                                        EdgeInsets.symmetric(horizontal: 40),
                                    borderSide: BorderSide(width: 3)),
                                tabs: <Widget>[
                                  new Tab(
                                    child: Text('Hari Ini',
                                        style: fontBlack.copyWith(
                                          color: _currentIndex == 0
                                              ? Colors.black
                                              : Colors.grey,
                                          fontWeight: _currentIndex == 0
                                              ? FontWeight.bold
                                              : FontWeight.w500,
                                        )),
                                  ),
                                  new Tab(
                                      child: Text('Besok',
                                          style: fontBlack.copyWith(
                                            color: _currentIndex == 1
                                                ? Colors.black
                                                : Colors.grey,
                                            fontWeight: _currentIndex == 1
                                                ? FontWeight.bold
                                                : FontWeight.w500,
                                          )))
                                ],
                              ),
                            ),
                            Builder(
                              builder: (context) {
                                if (listCuaca == null) {
                                  return Container(
                                      margin: EdgeInsets.only(top: 40),
                                      child: Text('Please select your city'));
                                }
                                return Expanded(
                                  child: Container(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: shortListCuaca.length,
                                      itemBuilder: (context, index) {
                                        var d = shortListCuaca[index];
                                        return Container(
                                          width: deviceWidth(context) / 4,
                                          height: 200,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text('${convertJam(d.jamCuaca)}',
                                                  style: fontBlack),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: Image.network(
                                                  API.iconCuaca +
                                                      '${d.kodeCuaca}.png',
                                                  width: 50,
                                                  height: 50,
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Text('${d.tempC}',
                                                        style:
                                                            fontBlack.copyWith(
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300)),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    width: 8,
                                                    height: 8,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(180),
                                                        border: Border.all(
                                                            color: Colors.black,
                                                            width: 2)),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
