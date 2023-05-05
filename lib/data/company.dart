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
  final List<int> data;
  const ChartData({
    required this.data,
  });
}

const companyList = [
  Company(
      name: "",
      price: 0,
      changePercent: 0,
      hasBenefit: true,
      companyLogo: "",
      chardData: [
        ChartData(
          data: [8, 2, 15, 12],
        ),
      ]),
  Company(
    name: "Google",
    price: 100.27,
    changePercent: 0.55,
    hasBenefit: true,
    companyLogo: "assets/images/google.png",
    chardData: [
      ChartData(
        data: [3, 14, 10, 18],
      ),
      ChartData(
        data: [8, 2, 15, 12],
      ),
      ChartData(
        data: [10, 15, 20, 25],
      ),
      ChartData(
        data: [15, 10, 5, 7],
      ),
      ChartData(
        data: [8, 18, 15, 17],
      )
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
        data: [15, 10, 5, 7],
      ),
      ChartData(
        data: [8, 2, 15, 12],
      ),
      ChartData(
        data: [10, 15, 20, 25],
      ),
      ChartData(
        data: [3, 14, 10, 18],
      ),
      ChartData(
        data: [8, 18, 15, 17],
      ),
      ChartData(
        data: [15, 10, 5, 7],
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
          data: [8, 18, 15, 17],
        ),
        ChartData(
          data: [15, 10, 5, 7],
        ),
        ChartData(
          data: [3, 14, 10, 18],
        ),
        ChartData(
          data: [8, 2, 15, 12],
        ),
        ChartData(
          data: [8, 18, 15, 17],
        ),
        ChartData(
          data: [10, 15, 20, 25],
        ),
        ChartData(
          data: [15, 10, 5, 7],
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
            7,
            14,
            18,
            20,
          ],
        ),
        ChartData(
          data: [8, 18, 15, 17],
        ),
        ChartData(
          data: [10, 15, 20, 25],
        ),
        ChartData(
          data: [15, 10, 5, 7],
        ),
        ChartData(
          data: [8, 2, 15, 12],
        ),
        ChartData(
          data: [15, 10, 5, 7],
        ),
        ChartData(
          data: [8, 18, 15, 17],
        ),
        ChartData(
          data: [3, 14, 10, 18],
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
          data: [10, 15, 20, 25],
        ),
        ChartData(
          data: [8, 2, 15, 12],
        ),
        ChartData(
          data: [10, 15, 20, 25],
        ),
        ChartData(
          data: [3, 14, 10, 18],
        ),
        ChartData(
          data: [8, 18, 15, 17],
        ),
        ChartData(
          data: [15, 10, 5, 7],
        ),
      ]),
  Company(
      name: "",
      price: 0,
      changePercent: 0,
      hasBenefit: false,
      companyLogo: "",
      chardData: [
        ChartData(
          data: [
            1,
            2,
            3,
          ],
        ),
      ]),
];
