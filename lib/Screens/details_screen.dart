import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_add_to_cart_button/flutter_add_to_cart_button.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:handling_network_data/components/colors.dart';
import 'package:handling_network_data/components/others.dart';
import 'package:handling_network_data/mapper/data_model.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
      {super.key, required this.currentProduct, required this.products});

  final Product currentProduct;
  final List<Product> products;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Product> similarProducts = [];
    final List<Product> otherProducts = [];
    for (var product in widget.products) {
      if (widget.currentProduct.category == product.category) {
        similarProducts.add(product);
      } else {
        otherProducts.add(product);
      }
    }
    final Product currentProduct = widget.currentProduct;
    AddToCartButtonStateId stateId = AddToCartButtonStateId.idle;
    return SafeArea(
      child: Scaffold(
        extendBody: false,
        appBar: AppBar(
          backgroundColor: midColor,
          title: const Text('Details'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: ListView(
                  children: [
                    CarouselSlider(
                      disableGesture: false,
                      options: CarouselOptions(
                        height: size(context).height * 0.42,
                      ),
                      // carouselController: CarouselController(),
                      items: currentProduct.images.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: midColor,
                              ),
                              padding: const EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(
                                  horizontal: size(context).width * 0.03,
                                  vertical: size(context).height * 0.01),
                              child: Image.network(
                                currentProduct
                                    .images[currentProduct.images.indexOf(i)],
                                fit: BoxFit.fitHeight,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Text(
                      currentProduct.title,
                      style: const TextStyle(
                        color: black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Brand: ${currentProduct.brand} | ',
                      style: const TextStyle(
                        color: black,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Price: ${currentProduct.price.toStringAsFixed(2)}  ',
                          style: const TextStyle(
                            color: black,
                            fontSize: 17,
                          ),
                        ),
                        const Spacer(),
                        // ignore: prefer_const_constructors
                        Text(
                          'Discount:  ',
                          style: const TextStyle(
                            color: callToAction,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          color: minorColor.withOpacity(0.8),
                          child: Text(
                            '-${currentProduct.discountPercentage.toStringAsFixed(1)}%',
                            style: const TextStyle(
                              color: mainColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size(context).width * 0.02,
                        )
                      ],
                    ),
                    Text(
                      'Stock: \$${currentProduct.stock.toString()} left!',
                      style: const TextStyle(
                        color: black,
                        fontSize: 17,
                      ),
                    ),
                    const Text(
                      'Ratings :',
                      style: TextStyle(
                        color: black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RatingStars(
                      value: currentProduct.rating,
                      starBuilder: (index, color) => Icon(
                        Icons.star,
                        color: color,
                      ),
                      starCount: 5,
                      starSize: 22,
                      valueLabelColor: black,
                      valueLabelTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 15.0),
                      valueLabelRadius: 3,
                      maxValue: 5,
                      starSpacing: 3,
                      maxValueVisibility: true,
                      valueLabelVisibility: true,
                      animationDuration: const Duration(milliseconds: 2000),
                      valueLabelPadding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 12),
                      valueLabelMargin: const EdgeInsets.only(right: 8),
                      starOffColor: midColor,
                      starColor: minorColor,
                    ),
                    Card(
                      margin: EdgeInsets.only(
                        top: size(context).height * 0.02,
                        bottom: size(context).height * 0.02,
                      ),
                      color: minorColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size(context).width * 0.03,
                            vertical: size(context).height * 0.01),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'No time to wait?',
                              style: TextStyle(
                                color: mainColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'View all the hottest deal right now!       ',
                              style: TextStyle(
                                color: midColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      tileColor: midColor,
                      title: const Text(
                        "Description",
                        style: TextStyle(
                            color: minorColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text(
                        currentProduct.description,
                        style: const TextStyle(
                          color: black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: black,
                      margin: EdgeInsets.symmetric(
                          vertical: size(context).height * 0.01),
                      child: const Text(
                        'Related Products',
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: midColor,
                      margin: EdgeInsets.symmetric(
                          vertical: size(context).height * 0.01),
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        currentProduct.category,
                        style: const TextStyle(
                          color: minorColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size(context).height * 0.45,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.6,
                          crossAxisCount: 2,
                        ),
                        itemCount: similarProducts.length,
                        itemBuilder: (context, index) {
                          final Product currentProduct = similarProducts[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                            currentProduct: currentProduct,
                                            products: widget.products,
                                          )));
                            },
                            child: Container(
                              key: Key('${currentProduct.id}'),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: midColor,
                              ),
                              padding: const EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(
                                  horizontal: size(context).width * 0.03,
                                  vertical: size(context).height * 0.01),
                              height: size(context).height * 0.25,
                              width: size(context).width,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        color: minorColor.withOpacity(0.8),
                                        child: Text(
                                          '-${currentProduct.discountPercentage.toStringAsFixed(1)}%',
                                          style: const TextStyle(
                                            color: mainColor,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical:
                                                size(context).height * 0.005),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Container(
                                          color: callToAction,
                                          child: Image(
                                            width: size(context).width * 0.28,
                                            height:
                                                size(context).height * 0.133,
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                currentProduct.thumbnail),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: size(context).width * 0.02,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    color: mainColor,
                                    height: size(context).height,
                                    width: size(context).width * 0.33,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          currentProduct.title,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: minorColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'Price: \$${currentProduct.price.toStringAsFixed(2)}',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          currentProduct.stock >= 17
                                              ? ('Stock : ${currentProduct.stock}')
                                              : 'Few items left!',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Rate:${currentProduct.discountPercentage.toStringAsFixed(1)}',
                                              style: const TextStyle(
                                                color: black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Icon(
                                              (Icons.favorite),
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Container(
                                          color: midColor,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Description',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Icon(Icons.arrow_forward_ios,
                                                  size: 15),
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
                    ),
                    SizedBox(
                      height: size(context).height * 0.03,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: black,
                      margin: EdgeInsets.symmetric(
                          vertical: size(context).height * 0.01),
                      child: const Text(
                        'Other Products',
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size(context).height * 0.45,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.6,
                          crossAxisCount: 2,
                        ),
                        itemCount: similarProducts.length,
                        itemBuilder: (context, index) {
                          final Product currentProduct = otherProducts[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                            currentProduct: currentProduct,
                                            products: widget.products,
                                          )));
                            },
                            child: Container(
                              key: Key('${currentProduct.id}'),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: midColor,
                              ),
                              padding: const EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(
                                  horizontal: size(context).width * 0.03,
                                  vertical: size(context).height * 0.01),
                              height: size(context).height * 0.25,
                              width: size(context).width,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        color: minorColor.withOpacity(0.8),
                                        child: Text(
                                          '-${currentProduct.discountPercentage.toStringAsFixed(1)}%',
                                          style: const TextStyle(
                                            color: mainColor,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical:
                                                size(context).height * 0.005),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Image(
                                          width: size(context).width * 0.28,
                                          height: size(context).height * 0.133,
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              currentProduct.thumbnail),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: size(context).width * 0.02,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    color: mainColor,
                                    height: size(context).height,
                                    width: size(context).width * 0.33,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          currentProduct.title,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: minorColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          'Price: \$${currentProduct.price.toStringAsFixed(2)}',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          currentProduct.stock >= 17
                                              ? ('Stock : ${currentProduct.stock}')
                                              : 'Few items left!',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Rate:${currentProduct.discountPercentage.toStringAsFixed(1)}',
                                              style: const TextStyle(
                                                color: black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Icon(
                                              (Icons.favorite),
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Container(
                                          color: midColor,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Description',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Icon(Icons.arrow_forward_ios,
                                                  size: 15),
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
                    ),
                    SizedBox(
                      height: size(context).height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 5),
                      child: AddToCartButton(
                        trolley: Image.asset(
                          'assets/images/shopping-cart.png',
                          width: 24,
                          height: 24,
                          color: Colors.white,
                        ),
                        text: const Text(
                          'Add to cart',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17, color: mainColor),
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                        check: const SizedBox(
                          width: 48,
                          height: 48,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(25),
                        backgroundColor: black,
                        onPressed: (id) {
                          if (id == AddToCartButtonStateId.idle) {
                            //handle logic when pressed on idle state button.
                            setState(() {
                              stateId = AddToCartButtonStateId.loading;
                              Future.delayed(const Duration(seconds: 3), () {
                                setState(() {
                                  stateId = AddToCartButtonStateId.done;
                                });
                              });
                            });
                          } else if (id == AddToCartButtonStateId.done) {
                            //handle logic when pressed on done state button.
                            setState(() {
                              stateId = AddToCartButtonStateId.idle;
                            });
                          }
                        },
                        stateId: stateId,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
