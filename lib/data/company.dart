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
          ChartDataItem(x: 1, y: 1),
          ChartDataItem(x: 2, y: 4),
          ChartDataItem(x: 3, y: 15),
          ChartDataItem(x: 4, y: 10)
        ],
      ),
      ChartData(
        data: [
          ChartDataItem(x: 1, y: 15),
          ChartDataItem(x: 2, y: 5),
          ChartDataItem(x: 3, y: 20),
          ChartDataItem(x: 4, y: 8)
        ],
      ),
      ChartData(
        data: [
          ChartDataItem(x: 1, y: 1),
          ChartDataItem(x: 2, y: 4),
          ChartDataItem(x: 3, y: 15),
          ChartDataItem(x: 4, y: 10)
        ],
      ),
      ChartData(
        data: [
          ChartDataItem(x: 1, y: 15),
          ChartDataItem(x: 2, y: 10),
          ChartDataItem(x: 3, y: 18),
          ChartDataItem(x: 4, y: 15)
        ],
      ),
      ChartData(
        data: [
          ChartDataItem(x: 1, y: 9),
          ChartDataItem(x: 2, y: 18),
          ChartDataItem(x: 3, y: 20),
          ChartDataItem(x: 4, y: 15)
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
          ChartDataItem(x: 1, y: 8),
          ChartDataItem(x: 2, y: 4),
          ChartDataItem(x: 3, y: 2),
          ChartDataItem(x: 4, y: 10)
        ],
      ),
      ChartData(
        data: [
          ChartDataItem(x: 1, y: 1),
          ChartDataItem(x: 2, y: 4),
          ChartDataItem(x: 3, y: 15),
          ChartDataItem(x: 4, y: 7)
        ],
      ),
      ChartData(
        data: [
          ChartDataItem(x: 1, y: 9),
          ChartDataItem(x: 2, y: 2),
          ChartDataItem(x: 3, y: 15),
          ChartDataItem(x: 4, y: 20)
        ],
      ),
      ChartData(
        data: [
          ChartDataItem(x: 1, y: 6),
          ChartDataItem(x: 2, y: 5),
          ChartDataItem(x: 3, y: 2),
          ChartDataItem(x: 4, y: 10)
        ],
      ),
      ChartData(
        data: [
          ChartDataItem(x: 1, y: 5),
          ChartDataItem(x: 2, y: 10),
          ChartDataItem(x: 3, y: 15),
          ChartDataItem(x: 4, y: 20)
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
            ChartDataItem(x: 1, y: 5),
            ChartDataItem(x: 2, y: 10),
            ChartDataItem(x: 3, y: 7),
            ChartDataItem(x: 4, y: 12)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 1),
            ChartDataItem(x: 2, y: 4),
            ChartDataItem(x: 3, y: 15),
            ChartDataItem(x: 4, y: 10)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 5),
            ChartDataItem(x: 2, y: 9),
            ChartDataItem(x: 3, y: 2),
            ChartDataItem(x: 4, y: 5)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 15),
            ChartDataItem(x: 2, y: 14),
            ChartDataItem(x: 3, y: 15),
            ChartDataItem(x: 4, y: 10)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 10),
            ChartDataItem(x: 2, y: 19),
            ChartDataItem(x: 3, y: 15),
            ChartDataItem(x: 4, y: 10)
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
            ChartDataItem(x: 1, y: 8),
            ChartDataItem(x: 2, y: 4),
            ChartDataItem(x: 3, y: 15),
            ChartDataItem(x: 4, y: 20)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 19),
            ChartDataItem(x: 2, y: 8),
            ChartDataItem(x: 3, y: 20),
            ChartDataItem(x: 4, y: 20)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 18),
            ChartDataItem(x: 2, y: 5),
            ChartDataItem(x: 3, y: 15),
            ChartDataItem(x: 4, y: 20)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 15),
            ChartDataItem(x: 2, y: 17),
            ChartDataItem(x: 3, y: 5),
            ChartDataItem(x: 4, y: 20)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 10),
            ChartDataItem(x: 2, y: 5),
            ChartDataItem(x: 3, y: 15),
            ChartDataItem(x: 4, y: 17)
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
            ChartDataItem(x: 1, y: 1),
            ChartDataItem(x: 2, y: 4),
            ChartDataItem(x: 3, y: 15),
            ChartDataItem(x: 4, y: 20)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 5),
            ChartDataItem(x: 2, y: 10),
            ChartDataItem(x: 3, y: 20),
            ChartDataItem(x: 4, y: 8)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 8),
            ChartDataItem(x: 2, y: 5),
            ChartDataItem(x: 3, y: 2),
            ChartDataItem(x: 4, y: 10)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 1),
            ChartDataItem(x: 2, y: 2),
            ChartDataItem(x: 3, y: 15),
            ChartDataItem(x: 4, y: 20)
          ],
        ),
        ChartData(
          data: [
            ChartDataItem(x: 1, y: 5),
            ChartDataItem(x: 2, y: 8),
            ChartDataItem(x: 3, y: 15),
            ChartDataItem(x: 4, y: 7)
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
