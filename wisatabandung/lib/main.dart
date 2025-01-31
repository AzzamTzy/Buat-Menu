import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FoodMenu(),
    );
  }
}

class FoodMenu extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {
      'name': 'Margherita Pizza',
      'image': 'https://example.com/margherita_pizza.jpg',
      'price': '\$12.99',
    },
    {
      'name': 'Caesar Salad',
      'image': 'https://example.com/caesar_salad.jpg',
      'price': '\$9.99',
    },
    {
      'name': 'Spaghetti Carbonara',
      'image': 'https://example.com/spaghetti_carbonara.jpg',
      'price': '\$14.99',
    },
    {
      'name': 'Grilled Salmon',
      'image': 'https://example.com/grilled_salmon.jpg',
      'price': '\$19.99',
    },
    {
      'name': 'Chocolate Lava Cake',
      'image': 'https://example.com/chocolate_lava_cake.jpg',
      'price': '\$6.99',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Menu'),
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          return FoodMenuItem(menuItem: menuItems[index]);
        },
      ),
    );
  }
}

class FoodMenuItem extends StatefulWidget {
  final Map<String, dynamic> menuItem;

  FoodMenuItem({required this.menuItem});

  @override
  _FoodMenuItemState createState() => _FoodMenuItemState();
}

class _FoodMenuItemState extends State<FoodMenuItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(_controller);
  }

  void _onThumbsUp() {
    _controller.forward().then((_) => _controller.reverse());
    print('${widget.menuItem['name']} liked!');
  }

  void _onThumbsDown() {
    _controller.forward().then((_) => _controller.reverse());
    print('${widget.menuItem['name']} disliked!');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            ScaleTransition(
              scale: _animation,
              child: CachedNetworkImage(
                imageUrl: widget.menuItem['image'],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.menuItem['name'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.menuItem['price'],
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.thumb_up, color: Colors.blue),
                        onPressed: _onThumbsUp,
                      ),
                      IconButton(
                        icon: Icon(Icons.thumb_down, color: Colors.red),
                        onPressed: _onThumbsDown,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
