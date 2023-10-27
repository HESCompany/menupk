import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    var words = <String>[];
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  List<Food> foodie = [
    Food(
        name: "Tahu Gimbal",
        price: 15000,
        desc:
            "Tahu gimbal merupakan masakan khas Semarang yang terbuat dari tahu goreng, sayuran, dan bakwan udang",
        images: 'images/A.jpg'),
    Food(
        name: "Lumpia Semarang",
        price: 5000,
        desc:
            "Sebagai kota lumpia, rasanya kalau berkunjung ke Semarang tanpa mencicipi lumpia serasa seperti belum pernah ke sana",
        images: 'images/B.jpg'),
    Food(
        name: "Bandeng Presto",
        price: 10000,
        desc:
            "Wilayah Kota Semarang dikenal memiliki pesisir pantai sehingga banyak makanan dari Semarang yang memanfaatkan ikan sebagai makanan utama",
        images: 'images/C.jpg'),
    Food(
        name: "Wingko Babat",
        price: 15000,
        desc:
            "Wingko babat merupakan panganan khas ibukota Jawa Tengah yang punya rasa manis dan gurih dari parutan kelapa",
        images: 'images/D.jpg'),
    Food(
        name: "Lontong Spekoek",
        price: 5000,
        desc:
            "Bagi yang belum tahu tentang spekoek, maka spekoek adalah nama beken dari kue tradisional bernama lapis legit",
        images: 'images/E.jpg'),
    Food(
        name: "Roti Ganjel Rel",
        price: 5000,
        desc:
            "Salah satu roti khas Semarang yang kini mulai sulit ditemukan adalah roti ganjel rel karena mulai sedikit peminatnya",
        images: 'images/F.jpg'),
    Food(
        name: "Pisang Plenet",
        price: 5000,
        desc:
            "Mungkin pisang plenet tak seterkenal lumpia, Wingko, atau bandeng presto yang notabene sama-sama makanan khas Semarang",
        images: 'images/G.jpg'),
    Food(
        name: "Sego Koyor",
        price: 15000,
        desc:
            "Sego koyor merupakan hidangan nasi putih yang disajikan dalam piring dan diberi potongan koyor. Tak lupa, disiram juga dengan kuah koyor",
        images: 'images/H.jpg'),
  ];

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Pilih menu'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            itemCount: widget.foodie.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(1.0),
                child: ListTile(
                    tileColor: Colors.blueAccent,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (contain) =>
                                OrderPage(widget.foodie[index]),
                          ));
                    },
                    title: Row(
                      children: [
                        Image(
                          fit: BoxFit.fitHeight,
                          image: AssetImage(widget.foodie[index].images),
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                tileColor: Colors.white30,
                                title: Text(widget.foodie[index].name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                trailing: Text(
                                    "Rp.${widget.foodie[index].price}",
                                    style: TextStyle(fontSize: 14)),
                              ),
                              ListTile(
                                tileColor: Colors.cyan,
                                title: Text(widget.foodie[index].desc),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              );
            }),
      );
    });
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}

class Food {
  int price;
  String name, desc, images;
  Food(
      {required this.name,
      required this.price,
      required this.desc,
      required this.images});
}

class OrderPage extends StatefulWidget {
  Food lister;
  OrderPage(this.lister);
  @override
  State<StatefulWidget> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int jumlah = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lister.name),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 1.0),
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(1.0),
                child: Image(
                    image: AssetImage(widget.lister.images), fit: BoxFit.fill)),
            Padding(
              padding: EdgeInsets.all(1.0),
              child: ListTile(
                title: Text(widget.lister.desc),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(1.0),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Harga :"),
                    Text("Rp.${widget.lister.price}"),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(1.0),
              child: ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.remove),
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                if (jumlah - 1 > -1) {
                                  jumlah -= 1;
                                }
                              });
                            },
                          ),
                          Text(
                            "${jumlah}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                jumlah += 1;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        tileColor: Colors.white,
                        leading: Icon(Icons.paid),
                        title: Center(
                          child: Text(
                            "Rp.${widget.lister.price * jumlah}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                tileColor: Colors.blue,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(1.0),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (contain) => FinalPage(widget.lister, jumlah),
                      ));
                },
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Pesan",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                tileColor: Colors.blue,
              ),
            ),
          ]),
    );
  }
}

class FinalPage extends StatefulWidget {
  Food lister;
  int ammount;
  FinalPage(this.lister, this.ammount);
  @override
  State<StatefulWidget> createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  int jumlah = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pemesanan"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 1.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(1.0),
              child: ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.lister.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(1.0),
              child: ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${widget.lister.price} x ${widget.ammount}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(1.0),
              child: ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Berhasil disimpan",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(1.0),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Total bayar:",style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("Rp.${widget.lister.price}",style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(1.0),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (contain) => MyHomePage(),
                      ));
                },
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Kembali ke menu",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                tileColor: Colors.blue,
              ),
            ),
          ]),
    );
  }
}
