import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../Providers/CartProviders.dart';
import '../../models/Customers.dart';
import '../../models/Order.dart';
import '../../networks/ApiServices.dart';
import '../../utils/sharedServices.dart';
import '../BasePage.dart';


class CashOnDelivery extends StatefulWidget {
  int? id;
  var shippingFee;
  String? delivery_type;
  String? delivery_time;
  String? gift_from;
  String? gift_message;
  List? cartProducts;

  CashOnDelivery({
    Key? key,
    this.id,
    this.shippingFee,
    this.delivery_type,
    this.delivery_time,
    this.gift_from,
    this.gift_message,
    this.cartProducts,
  }) : super(key: key);

  @override
  State<CashOnDelivery> createState() => _CashOnDeliveryState();
}

class _CashOnDeliveryState extends State<CashOnDelivery> {
  Customers? loginDetails;
  SharedServices sharedServices = SharedServices();

  Future<Customers?> getValidation() async {
    final login1 = await sharedServices.loginDetails();
    return login1;
  }

  List<Orders> orderList = [];
  String totalValue = '';
  Api_Services api_services = Api_Services();

  Future<List<Orders>>? orderId;
  Future<List<Orders>> getList() async {
    orderList = await api_services.getOrderByUserId(widget.id);
    // orderId = '${orderList[0].id}';
    print('OrderData: ${orderList}');
    return orderList;
  }

  @override
  void initState() {
    getValidation().then((value) => setState(() {
          loginDetails = value;
        }));
    orderId = getList();
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // orderList.forEach((element) {
    //   print('elements: ${element.id}');
    // });

    if (orderList == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff00ab55),
          title: Image.asset(
            'assets/images/farmerica-logo.png',
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 25),
                    child: const Text(
                      'Thank You!!',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, fontFamily: 'Outfit'),
                    )),
                const Text(
                  'Your order is Placed!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Outfit'),
                ),
                Container(
                  width: double.infinity,
                  // height: 180,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: const BoxDecoration(
                    color: Color(0XFFF0F0F1),
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<List<Orders>>(
                              future: getList(),
                              builder: (context, snapshot) {
                                var orderIds;
                                String? deliveryDate = '';
                                String? deliveryTime = '';

                                if (snapshot.hasData) {
                                  orderIds = snapshot.data![0].id;
                                  for (int i = 0; i < snapshot.data![0].metaData!.length; i++) {
                                    if (snapshot.data![0].metaData![i].key == 'delivery_date') {
                                        deliveryDate = snapshot.data![0].metaData![i].value;
                                    } else if (snapshot.data![0].metaData![i].key == 'delivery_time') {
                                        deliveryTime = snapshot.data![0].metaData![i].value;
                                    }
                                  }
                                  print('Meta: ${snapshot.data![0].metaData!.length}');
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Text('Order number: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                                              Text(orderIds.toString(), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text('Date: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                                              Text(DateFormat.yMd().format(DateTime.parse(snapshot.data![0].dateCreated!)), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          const Text('Total: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                                          Text(snapshot.data![0].total!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Text('Shipping Date: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                                          Text(deliveryDate!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Text('Shipping Time: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                                          Text(deliveryTime!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                    ],
                                  );
                                }
                                return CircularProgressIndicator();
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff00ab55),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Provider.of<CartModel>(context, listen: false).clearCart();

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => BasePage(
                                    customer: loginDetails,
                                    title: "Farmerica App",
                                  )),
                          (route) => false);
                    },
                    child: const Text('Continue Shopping')),
              ],
            ),
          ),
        ),
      );
    }
  }
}
