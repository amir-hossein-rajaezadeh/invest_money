import 'package:flutter/material.dart';

@immutable
class Company {
  final String name;
  final double price;
  final double changePercent;
  final bool hasBenefit;
  final String companyLogo;
  final List<ChartData> chardData;
  const Company(
      {required this.name,
      required this.changePercent,
      required this.price,
      required this.hasBenefit,
      required this.companyLogo,
      required this.chardData});
}

@immutable
class ChartData {
  final List<ChartDataItem> data;
  const ChartData({
    required this.data,
  });
}

@immutable
class ChartDataItem {
  final double x;
  final double y;

  const ChartDataItem({required this.x, required this.y});
}

const companyList = [
  Company(
      name: "",
      price: 0,
      changePercent: 0,
      hasBenefit: true,
      companyLogo: "",
      chardData: []),
  Company(
    name: "Google",
    price: 100.27,
    changePercent: 0.55,
    hasBenefit: true,
    companyLogo: "assets/images/google.png",
    chardData: [
      ChartData(
        data: [
          ChartDataItem(x: 1, y: 20),
          ChartDataItem(x: 2, y: 40),
          ChartDataItem(x: 3, y: 150),
          ChartDataItem(x: 4, y: 100)
        ],
      ),
      ChartData(
        data: [
          ChartDataItem(x: 1, y: 100),
          ChartDataItem(x: 2, y: 80),
          ChartDataItem(x: 3, y: 120),
          ChartDataItem(x: 4, y: 100)
        ],
      ),
      ChartData(
        data: [
          ChartDataItem(x: 1, y: 100),
          ChartDataItem(x: 2, y: 120),
          ChartDataItem(x: 3, y: 130),
          ChartDataItem(x: 4, y: 100)
        ],
      ),
      ChartData(
        data: [
          ChartDataItem(x: 1, y: 50),
          ChartDataItem(x: 2, y: 100),
          ChartDataItem(x: 3, y: 150),
          ChartDataItem(x: 4, y: 100)
        ],
      ),
      ChartData(
        data: [
          ChartDataItem(x: 1, y: 20),
          ChartDataItem(x: 2, y: 60),
          ChartDataItem(x: 3, y: 90),
          ChartDataItem(x: 4, y: 100)
        ],
      ),
    ],
  ),
  Company(
    name: "Shopify",
    price: 44.67,
    changePercent: 0.47,
    hasBenefit: false,
    companyLogo: "assets/images/shopify.png",
    chardData: [
      ChartData(
        data: [
          ChartDataItem(x: 1, y: 45),
          ChartDataItem(x: 2, y: 49),
          ChartDataItem(x: 3, y: 47),
          ChartDataItem(x: 4, y: 44)
        ],
      ),
      ChartData(
        data: [
          ChartDataItem(x: 1, y: 40),
          ChartDataItem(x: 2, y: 42),
          ChartDataItem(x: 3, y: 43),
          ChartDataItem(x: 4, y: 44)
        ],
      ),
      ChartData(
        data: [
          ChartDataItem(x: 1, y: 50),
          ChartDataItem(x: 2, y: 48),
          ChartDataItem(x: 3, y: 40),
          ChartDataItem(x: 4, y: 44)
        ],
      ),
      ChartData(
        data: [
          ChartDataItem(x: 1, y: 5),
          ChartDataItem(x: 2, y: 17),
          ChartDataItem(x: 3, y: 22),
          ChartDataItem(x: 4, y: 44)
        ],
      ),
      ChartData(
        data: [
          ChartDataItem(x: 1, y: 5),
          ChartDataItem(x: 2, y: 20),
          ChartDataItem(x: 3, y: 50),
          ChartDataItem(x: 4, y: 44)
        ],
      ),
    ],
  ),
  Company(
      name: "Dropbox",
      price: 19.9,
      changePercent: 1.07,
      hasBenefit: true,
      companyLogo: "assets/images/dropbox.png",
      chardData: [
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 17),
            ChartDataItem(x: 2, y: 19),
            ChartDataItem(x: 3, y: 20),
            ChartDataItem(x: 4, y: 19)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 25),
            ChartDataItem(x: 2, y: 20),
            ChartDataItem(x: 3, y: 22),
            ChartDataItem(x: 4, y: 19)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 15),
            ChartDataItem(x: 2, y: 30),
            ChartDataItem(x: 3, y: 25),
            ChartDataItem(x: 4, y: 19)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 15),
            ChartDataItem(x: 2, y: 14),
            ChartDataItem(x: 3, y: 15),
            ChartDataItem(x: 4, y: 19)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 2),
            ChartDataItem(x: 2, y: 10),
            ChartDataItem(x: 3, y: 15),
            ChartDataItem(x: 4, y: 19)
          ],
        ),
      ]),
  Company(
      name: "Apple",
      price: 155.48,
      changePercent: 0.47,
      hasBenefit: true,
      companyLogo: "assets/images/apple.png",
      chardData: [
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 150),
            ChartDataItem(x: 2, y: 152),
            ChartDataItem(x: 3, y: 154),
            ChartDataItem(x: 4, y: 155)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 170),
            ChartDataItem(x: 2, y: 180),
            ChartDataItem(x: 3, y: 160),
            ChartDataItem(x: 4, y: 150)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 151),
            ChartDataItem(x: 2, y: 150),
            ChartDataItem(x: 3, y: 152),
            ChartDataItem(x: 4, y: 155)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 140),
            ChartDataItem(x: 2, y: 145),
            ChartDataItem(x: 3, y: 150),
            ChartDataItem(x: 4, y: 155)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 20),
            ChartDataItem(x: 2, y: 60),
            ChartDataItem(x: 3, y: 90),
            ChartDataItem(x: 4, y: 150)
          ],
        ),
      ]),
  Company(
      name: "PayPal",
      price: 72.05,
      changePercent: 1.14,
      hasBenefit: false,
      companyLogo: "assets/images/paypal.png",
      chardData: [
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 71),
            ChartDataItem(x: 2, y: 72),
            ChartDataItem(x: 3, y: 70),
            ChartDataItem(x: 4, y: 72)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 65),
            ChartDataItem(x: 2, y: 68),
            ChartDataItem(x: 3, y: 70),
            ChartDataItem(x: 4, y: 72)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 70),
            ChartDataItem(x: 2, y: 62),
            ChartDataItem(x: 3, y: 65),
            ChartDataItem(x: 4, y: 72)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 40),
            ChartDataItem(x: 2, y: 60),
            ChartDataItem(x: 3, y: 80),
            ChartDataItem(x: 4, y: 72)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 5),
            ChartDataItem(x: 2, y: 15),
            ChartDataItem(x: 3, y: 60),
            ChartDataItem(x: 4, y: 72)
          ],
        ),
      ]),
  Company(
      name: "",
      price: 0,
      changePercent: 0,
      hasBenefit: false,
      companyLogo: "",
      chardData: []),
];
