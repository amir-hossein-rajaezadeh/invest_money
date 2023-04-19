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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double? height = MediaQuery.of(context).size.height;
    double? width = MediaQuery.of(context).size.width;

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
              height: height / 2 - 90,
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
                                  fontWeight: FontWeight.w300),
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
                      margin: const EdgeInsets.only(left: 20, bottom: 60),
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
            Container(
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
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Container(
                            width: 10,
                          ),
                          RotatedBox(
                            quarterTurns: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 1.5),
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
                            "Withdraw",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Container(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 1.5),
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
                  ]),
            ),
            Container(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Container(
                    width: 150,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(100)),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
