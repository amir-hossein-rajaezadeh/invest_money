import 'package:flutter/material.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late ScrollController _controller; // <--

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

  List<String> thirdBrandList = ["Amazon", "Facebok", "Twitter"];
  // late ScrollController _controller;
  bool isFirstTry = true;

  bool showListView = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = ScrollController(initialScrollOffset: 155.0);

    firstRightToLeftAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    boxesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    rightToLeftListviewController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
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
    boxesController.forward();

    rightToLeftListviewAnim = Tween(
      begin: const Offset(2, 0),
      end: const Offset(0, 0),
    ).animate(rightToLeftListviewController);

    rightToLeftListviewController.forward();
    firstRightToLeftAnimController.forward();

    // rightBoxAnim.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     rightToLeftListviewController.forward();
    //   }
    // });
    // rightToLeftListviewAnim.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //   }
    // });

    firstRightToLeftAnimController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showListView = true;
        });
      }
    });
    // _controller.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? height = MediaQuery.of(context).size.height;
    double? width = MediaQuery.of(context).size.width;

    if (isFirstTry) {
      isFirstTry = false;
      // _controller.jumpTo(200);
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF070713),
        body: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
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
              height: height / 2 - 120,
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
                      )),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
                          onTap: () {},
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
                      margin:
                          EdgeInsets.only(right: 15, left: index == 0 ? 55 : 0),
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
                            margin: const EdgeInsets.only(top: 12, left: 12),
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
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 8),
                                        child: Text(
                                          "+0,53%",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Colors.white.withOpacity(0.6),
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
                      controller: _controller,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: secondBrndList.length,
                      itemBuilder: (context, index) {
                        String title = secondBrndList[index];

                        return index == 0
                            ? Container(
                                height: 80,
                                margin: EdgeInsets.only(
                                    right: 0, left: index == 0 ? 40 : 0),
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
                                    right: 0, left: index == 0 ? 40 : 0),
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
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFF47417d)),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
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
                                                  margin: const EdgeInsets.only(
                                                      left: 8),
                                                  child: Text(
                                                    "+0,53%",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white
                                                            .withOpacity(0.6),
                                                        fontWeight:
                                                            FontWeight.w500),
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
                    height: 85,
                    margin: const EdgeInsets.only(top: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: thirdBrandList.length,
                      itemBuilder: (context, index) {
                        String title = thirdBrandList[index];

                        return index == 0
                            ? Container(
                                height: 85,
                                margin: const EdgeInsets.only(top: 20),
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
                              )
                            : Container(
                                height: 80,
                                margin: EdgeInsets.only(
                                    right: 0, left: index == 0 ? 40 : 0),
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
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFF47417d)),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
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
                                                  margin: const EdgeInsets.only(
                                                      left: 8),
                                                  child: Text(
                                                    "+0,53%",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white
                                                            .withOpacity(0.6),
                                                        fontWeight:
                                                            FontWeight.w500),
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
                    position: secondRightToLeftAnim,
                    child: Container(
                      margin: const EdgeInsets.only(top: 12),
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
      ),
    );
  }
}
