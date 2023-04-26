import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// class Company {
//   final String name;
//   final double benefitPercent;
//   final int price;

//   const Company({})
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late ScrollController _firstScrollController;
  late ScrollController _secondScrollController;

  late Animation<Offset> firstRightToLeftAnim;
  late AnimationController firstRightToLeftAnimController;
  late Animation<Offset> secondRightToLeftAnim;
  late Animation<Offset> rightBoxAnim;
  late Animation<Offset> leftBoxAnim;
  late Animation<Offset> rightToLeftListviewAnim;
  late AnimationController rightToLeftListviewController;
  late AnimationController boxesController;

  List<String> firstBrndList = [
    "Google",
    "Shopify",
  ];
  List<String> secondBrndList = [
    "",
    "Apple",
    "DropBox",
    "Yandex",
  ];

  List<String> thirdBrandList = ["Amazon", "Facebok", "Twitter", ""];
  bool showDialogScreen = false;

  bool showListView = false;
  int selectedItem = 0;
  double dialogWidth = 0;
  double dialogHeight = 0;

  @override
  void dispose() {
    _firstScrollController.dispose();
    _secondScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _firstScrollController = ScrollController(initialScrollOffset: 140.0);
    _secondScrollController = ScrollController(initialScrollOffset: 372.0);

    firstRightToLeftAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    boxesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    rightToLeftListviewController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    firstRightToLeftAnim = Tween(
      begin: const Offset(2, 0),
      end: const Offset(-1, 0),
    ).animate(CurvedAnimation(
        parent: firstRightToLeftAnimController, curve: Curves.easeOut));

    secondRightToLeftAnim = Tween(
      begin: const Offset(-2, 0),
      end: const Offset(1, 0),
    ).animate(CurvedAnimation(
        parent: firstRightToLeftAnimController, curve: Curves.easeOut));

    rightBoxAnim = Tween(
      begin: const Offset(8, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: boxesController, curve: Curves.easeOut));

    leftBoxAnim = Tween(
      begin: const Offset(-2, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: boxesController, curve: Curves.easeOut));

    rightToLeftListviewAnim = Tween(
      begin: const Offset(2, 0),
      end: const Offset(0, 0),
    ).animate(rightToLeftListviewController);

    Future.delayed(const Duration(microseconds: 0)).then((value) async {
      setState(() {
        _height = 300;
      });
      await Future.delayed(
        const Duration(milliseconds: 700),
      );
      boxesController.forward();
    });

    boxesController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rightToLeftListviewController.forward();
      }
    });
    rightToLeftListviewController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        firstRightToLeftAnimController.forward();
      }
    });

    firstRightToLeftAnimController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showListView = true;
        });
      }
    });

    super.initState();
  }

  double _height = 0;
  @override
  Widget build(BuildContext context) {
    double? height = MediaQuery.of(context).size.height;
    double? width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF070713),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                AnimatedContainer(
                  height: _height,
                  duration: const Duration(milliseconds: 1500),
                  margin: const EdgeInsets.only(right: 3, left: 3),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xFF1edee4),
                          Color(0xFF1edee4),
                          Color(0xFF1799d7),
                          Color(0xFF1786db),
                          Color(0xFF051ed9),
                        ],
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 23, left: 12),
                            child: Column(
                              children: const [
                                Text(
                                  "Hello, Amir!",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Let's invest together!",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 16, top: 12),
                            width: 60,
                            height: 60,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                "assets/images/user_prof.jpeg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "25 800",
                              style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.w400),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              width: 80,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white.withOpacity(0.4),
                              ),
                              child: Center(
                                child: Text(
                                  "+620",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SlideTransition(
                  position: leftBoxAnim,
                  child: Container(
                    margin: const EdgeInsets.only(right: 5, left: 5, top: 12),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width / 2 - 10,
                            height: height * .18,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: const Color(0xFF0a0720)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Top Up",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Container(
                                  width: 10,
                                ),
                                RotatedBox(
                                  quarterTurns: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1.5),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(3),
                                      child: const Icon(
                                        Icons.arrow_outward,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SlideTransition(
                            position: rightBoxAnim,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _height = height / 2 - 120;
                                });
                              },
                              child: Container(
                                width: width / 2 - 10,
                                height: height * .18,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: const Color(0xFF0a0720)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Withdraw",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 1.5),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.all(3),
                                        child: const Icon(
                                          Icons.arrow_outward,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
                SlideTransition(
                  position: rightToLeftListviewAnim,
                  child: Container(
                    height: 80,
                    margin: const EdgeInsets.only(top: 20),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: firstBrndList.length,
                      itemBuilder: (context, index) {
                        String title = firstBrndList[index];
                        return Container(
                          margin: EdgeInsets.only(
                              right: 15, left: index == 0 ? 55 : 0),
                          width: 215,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0a0720),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 12),
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color(0xFF1b193d),
                                ),
                                child: const Center(
                                  child: Text(
                                    "G",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 12, left: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF47417d),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "100,27",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 8),
                                            child: Text(
                                              "+0,53%",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                showListView
                    ? Container(
                        height: 80,
                        margin: const EdgeInsets.only(top: 20),
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: _firstScrollController,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: secondBrndList.length,
                          itemBuilder: (context, index) {
                            String title = secondBrndList[index];

                            return index == 0
                                ? Container(
                                    height: 80,
                                    margin: const EdgeInsets.only(left: 5),
                                    width: 215,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      gradient: const LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.topLeft,
                                        colors: [
                                          Color(0xFF3fdcd6),
                                          Color(0xFF48eace),
                                          Color(0xFF90e6cf)
                                        ],
                                      ),
                                    ),
                                    child: Row(
                                      children: [],
                                    ),
                                  )
                                : Container(
                                    height: 80,
                                    margin: EdgeInsets.only(
                                        right: 18, left: index == 0 ? 40 : 0),
                                    width: 215,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0a0720),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 12),
                                          width: 55,
                                          height: 55,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: const Color(0xFF1b193d),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "G",
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 12, left: 12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                title,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xFF47417d)),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "100,27",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white
                                                              .withOpacity(0.8),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 8),
                                                      child: Text(
                                                        "+0,53%",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.6),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                        ),
                      )
                    : SlideTransition(
                        position: firstRightToLeftAnim,
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          width: 215,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.topLeft,
                              colors: [
                                Color(0xFF3fdcd6),
                                Color(0xFF48eace),
                                Color(0xFF90e6cf)
                              ],
                            ),
                          ),
                        ),
                      ),
                showListView
                    ? Container(
                        height: 80,
                        margin: const EdgeInsets.only(top: 15),
                        child: ListView.builder(
                          controller: _secondScrollController,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: thirdBrandList.length,
                          itemBuilder: (context, index) {
                            String title = thirdBrandList[index];

                            return title == ""
                                ? Container(
                                    height: 80,
                                    width: 210,
                                    margin: const EdgeInsets.only(right: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFF5810df),
                                          Color(0xFF4f0cdc),
                                          Color(0xFF3d06db),
                                          Color(0xFF0e07ca)
                                        ],
                                      ),
                                    ),
                                    child: Row(children: []),
                                  )
                                : GestureDetector(
                                    onLongPress: () {
                                      setState(() {
                                        showDialogScreen = true;
                                        if (dialogWidth != 0) {
                                          dialogWidth = 0;
                                          dialogHeight = 0;
                                        } else {
                                          dialogWidth = 350;
                                          dialogHeight = 480;
                                        }
                                      });
                                      print("longPress");
                                    },
                                    child: Container(
                                      height: 80,
                                      margin: const EdgeInsets.only(
                                          right: 18, left: 2),
                                      width: 215,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF0a0720),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 12),
                                            width: 55,
                                            height: 55,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: const Color(0xFF1b193d),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "G",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 12, left: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  title,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Color(0xFF47417d)),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 10),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "100,27",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.8),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 8),
                                                        child: Text(
                                                          "+0,53%",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                          },
                        ),
                      )
                    : SlideTransition(
                        position: secondRightToLeftAnim,
                        child: Container(
                          margin: const EdgeInsets.only(top: 15),
                          width: 215,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF5810df),
                                Color(0xFF4f0cdc),
                                Color(0xFF3d06db),
                                Color(0xFF0e07ca)
                              ],
                            ),
                          ),
                        ),
                      )
              ],
            ),
            Dismissible(
              direction: DismissDirection.vertical,
              onDismissed: (direction) {},
              key: UniqueKey(),
              child: AnimatedContainer(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                    gradient: const LinearGradient(
                        begin: Alignment.bottomRight,
                        colors: [
                          Color(0xFF040240),
                          Color(0xFF030131),
                        ])),
                duration: const Duration(milliseconds: 1500),
                width: dialogWidth,
                height: dialogHeight,
                alignment: Alignment.center,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 7),
                              child: const Icon(
                                Icons.paypal,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              child: const Text(
                                "PayPal",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: const Text(
                          "155,48",
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: const Text(
                          "+0,47",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFF55746b)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 35),
                        child: SfSparkLineChart(
                          axisLineColor: Colors.transparent,
                          data: const <double>[
                            1,
                            5,
                            -6,
                            0,
                            1,
                            -2,
                            7,
                            -7,
                            -4,
                            -10,
                          ],
                          trackball: const SparkChartTrackball(
                              color: Colors.white,
                              activationMode: SparkChartActivationMode.tap),

                          // labelDisplayMode: SparkChartLabelDisplayMode.all,
                          // labelStyle: TextStyle(color: Colors.white),
                          // marker: SparkChartMarker(
                          //     displayMode: SparkChartMarkerDisplayMode.all),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 16),
                        child: Row(
                          // mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              "12:30",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            SizedBox(
                              width: 55,
                            ),
                            Text(
                              "13:30",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            SizedBox(
                              width: 55,
                            ),
                            Text(
                              "14:30",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            SizedBox(
                              width: 55,
                            ),
                            Text(
                              "15:30",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        height: 30,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              decoration: BoxDecoration(
                                color: selectedItem == index
                                    ? Colors.white
                                    : const Color(0xFF080720),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              margin: const EdgeInsets.only(right: 5, left: 20),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedItem = index;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Center(
                                    child: Text(
                                      "1M",
                                      style: TextStyle(
                                        color: selectedItem == index
                                            ? Colors.black
                                            : const Color(0xFF504d72),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
