import 'package:flutter/material.dart';
import 'FoodMenu.dart';
import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Order App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Food Order - Total Price:'),
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
  final Random random = Random();

  // รายการเมนูที่สามารถสุ่มได้ (name, price, ingredients)
  final List<FoodMenu> menuOptions = [
    FoodMenu(name: 'Salad', price: '80', ingredients: 'Lettuce, Tomato, Cheese'),
    FoodMenu(name: 'Steak', price: '300', ingredients: 'Beef, Cheese, Potato'),
    FoodMenu(name: 'spaghetti', price: '500', ingredients: 'spaghetti, Cheese, Beef'),
  ];

  // รายการเมนูที่จะแสดงในแอป (เริ่มต้นเป็นค่าว่าง)
  List<FoodMenu> foodMenuList = [];

  // ฟังก์ชันคำนวณราคาอาหารรวมทั้งหมด
  int calculateTotalPrice() {
    int total = 0;
    for (var menu in foodMenuList) {
      total += int.parse(menu.price);
    }
    return total;
  }

  // ฟังก์ชันเพิ่มเมนูแบบสุ่ม
  void addRandomFoodMenu() {
    setState(() {
      // สุ่มเมนูจากรายการ menuOptions
      final randomMenu = menuOptions[random.nextInt(menuOptions.length)];
      // เพิ่มเมนูใหม่ใน foodMenuList
      foodMenuList.add(randomMenu);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title} ${calculateTotalPrice()}'),
        backgroundColor: Colors.purple.shade200,
      ),
      body: foodMenuList.isEmpty
          ? const Center(
              child: Text(
                'No food items. Please add some!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: foodMenuList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.purple.shade100,
                    child: Text(
                      '${foodMenuList[index].price}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  title: Text(
                    'Dish $index is ${foodMenuList[index].name}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      'This menu ingredients are ${foodMenuList[index].ingredients}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: addRandomFoodMenu,
        tooltip: 'Add Food Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
