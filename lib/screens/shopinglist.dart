import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shopinglist/models/shop.dart';
import 'package:shopinglist/routes/page_routes.dart';
import 'package:shopinglist/services/auth_helper.dart';
import 'package:shopinglist/services/shop_dao.dart';
import 'package:shopinglist/widgets/beveled_button..dart';

class ShopinglistPage extends StatefulWidget {
  const ShopinglistPage({super.key});
  static const String routeName = "/ShopinglistPage";

  @override
  State<ShopinglistPage> createState() => _ShopinglistPageState();
}

class _ShopinglistPageState extends State<ShopinglistPage> {
  final _itemController = TextEditingController();
  final _priceController = TextEditingController();
  final Future<FirebaseApp> _future = Firebase.initializeApp();
  final ScrollController _scrollController = ScrollController();
  String? uid;
  String key = '';
  String status = 'add';
  final ShopDao shopDao = ShopDao();
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Navigator.pushReplacementNamed(context, PageRoutes.loginPage);
    } else {
      setState(() {
        uid = user.uid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPersistentFrameCallback((_) => _scrollToBottom);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Wish List"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                await AuthenticationHelper().signOut();
                Navigator.pushReplacementNamed(context, PageRoutes.loginPage);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Card(
                elevation: 10,
                color: Colors.orange.withOpacity(0.7),
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _itemController,
                        decoration: const InputDecoration(
                            hintText: "Enter ItemName", labelText: "ItemName"),
                      ),
                      TextField(
                        controller: _priceController,
                        decoration: const InputDecoration(
                            hintText: "Enter Price", labelText: "Price"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: BeveledButton(
                              title: "Save Wish", 
                              onTap: _saveData)),
                      const SizedBox(
                        height: 10,
                      ),
                      _getWishList(),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  Widget _getWishList() {
    return Expanded(
        child: FirebaseAnimatedList(
            controller: _scrollController,
            query: shopDao.getshop(uid.toString()),
            itemBuilder: (context, snapshot, animation, index) {
              final json = snapshot.value as Map<dynamic, dynamic>;
              final shop = Shop.fromJson(json);
              return Card(
                elevation: 10,
                color: Colors.black45,
                child: ListTile(
                  leading: Theme(
                    data: ThemeData(
                      primarySwatch: Colors.red,
                      unselectedWidgetColor: Colors.blue,
                    ),
                    child: Checkbox(
                        value: shop.isDone,
                        onChanged: (value) {
                          setState(() {
                            shop.isDone = value!;
                            String key = snapshot.key.toString();
                            shopDao.updateshop(key, shop, uid.toString());
                          });
                        }),
                  ),
                  title: Text(
                    "shop- ${shop.itemName} - ${shop.price}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _itemController.text = shop.itemName;
                              _priceController.text = shop.price;
                              key = snapshot.key.toString();
                              status = "edit";
                            });
                          },
                          icon: const Icon(Icons.edit, color: Colors.red)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              shopDao.deleteshop(
                                  snapshot.key.toString(), uid.toString());
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ],
                  ),
                ),
              );
            }));
  }

  void _saveData() {
    String itemName = _itemController.text.toString();
    String price = _priceController.text.toString();
    Shop wish = Shop(itemName: itemName, price: price, isDone: false);

    switch (status) {
      case "add":
        shopDao.saveshop(wish, uid.toString());
        _itemController.clear();
        _priceController.clear();
        break;
      case "edit":
        setState(() {
          shopDao.updateshop(key, wish, uid.toString());
          _itemController.clear();
          _priceController.clear();
          status = "add";
          key = "";
        });
        break;
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
}
