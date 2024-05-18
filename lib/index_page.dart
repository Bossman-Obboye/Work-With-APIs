import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:handling_network_data/Screens/details_screen.dart';
import 'package:handling_network_data/components/colors.dart';
import 'package:handling_network_data/components/others.dart';
import 'package:handling_network_data/mapper/data_model.dart';
import 'package:http/http.dart' as http;

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int currentIndex = 0;

  onTap(index) {
    currentIndex = index;
  }

  List<Product> listOfProducts = [];

  Future<List<Product>> httpResponse() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    final products = productsFromJson(response.body).products;
    for (var product in products) {
      listOfProducts.add(product);
    }
    return listOfProducts;
  }

  @override
  void initState() {
    super.initState();
    httpResponse();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: midColor,
        title: const Text('Seller'),
        actions: [
          IconButton(
            onPressed: () {},
            color: Colors.black,
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      drawer: Drawer(
        width: size(context).width * 0.7,
        elevation: 2,
        backgroundColor: midColor,
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: mainColor),
              child: SizedBox(
                  width: size(context).width,
                  child: const Center(child: Text('jhgfd'))),
            )
          ],
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: httpResponse(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
                itemCount: listOfProducts.length,
                itemBuilder: (context, index) {
                  Product currentProduct = listOfProducts[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                  currentProduct: currentProduct, products: listOfProducts,)));
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
                          Stack(children: [
                            Container(
                              height: size(context).height,
                              width: size(context).width * 0.44,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(currentProduct.thumbnail),
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
                          ]),
                          SizedBox(
                            width: size(context).width * 0.028,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: mainColor,
                            height: size(context).height,
                            width: size(context).width * 0.42,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  currentProduct.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: minorColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Price: \$${currentProduct.price.toStringAsFixed(2)}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 17,
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
                                    fontSize: 17,
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
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.favorite),
                                      iconSize: 30,
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
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(Icons.arrow_forward_ios, size: 20),
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
                });
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SnakeNavigationBar.color(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          snakeShape: SnakeShape.rectangle,
          snakeViewColor: minorColor,
          backgroundColor: midColor,
          unselectedItemColor: black,
          showSelectedLabels: true,
          onTap: (index) {
            setState(() {
              onTap(index);
            });
          },
          elevation: 3,
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorites'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    ));
  }
}
