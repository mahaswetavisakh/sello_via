import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/navbar.dart';

class AddProduct extends StatefulWidget {
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<XFile>? _img=[];
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();
  final TextEditingController _productDescription = TextEditingController();

  Future<void> createProduct(BuildContext context) async {
    if (_productName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter your Product name")));
    } else if (_productPrice.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter your product price")));
    } else if (_productDescription.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please enter your product description")));
    } else {}
  }

  String dropdownvalue = "category1";
  List<String> items = ["category1", "category2", "category3"];
  String dropdownvalue1 = "subcategory1";
  List<String> items1 = ["subcategory1", "subcategory2", "subcategory3"];


  List categories=[
    {
      "name":"Electronics",
      "id":1,
      "image":"/sdcs.png",
      "subCategories":[
        {
          "name":"Laptops",
          "id":11,
          "image":"/sdcs.png",
        }
      ],
    },

    {
      "name":"Vehicles",
      "id":2,
      "image":"/sdcs.png",
      "subCategories":[
        {
          "name":"car",
          "id":12,
          "image":"/sdcs.png",
        }
      ],
    }
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Topbar("Add Products"),
                const SizedBox(
                  height: 25,
                ),
                const Text("Product Name:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                TextField(
                  controller: _productName,
                  decoration: const InputDecoration(
                      hintText: "Please Enter Your Product Name"),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Product Price:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                TextField(
                  controller: _productPrice,
                  decoration: const InputDecoration(
                      hintText: "Please Enter Your Product Price"),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Product Description:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                TextField(
                  controller: _productDescription,
                  decoration: const InputDecoration(
                      hintText: "Please Enter Your Product Description"),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Product Category:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                DropdownButton(
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
                const Text("Product SubCategory:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                DropdownButton(
                  value: dropdownvalue1,
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  items: items1.map((String items1) {
                    return DropdownMenuItem(
                      value: items1,
                      child: Text(items1),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue1 = newValue!;
                    });
                  },
                ),
                const Text("Product Image:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _img!.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == _img!.length) {
                        return IconButton(
                          icon: const Icon(Icons.camera_alt_outlined),
                          onPressed: () async {
                            ImagePicker picker = ImagePicker();
                            List<XFile> data = await picker.pickMultiImage();
                            data.forEach((element) {
                              _img!.add(element);
                            });
                            setState(() {});
                          },
                        );
                      }
                      return Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(
                                  File(_img![index].path),
                                ))),
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            _img!.remove(_img![index]);
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white70),
                            child: const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                      // _img!.length = 4
                      //index=3
                      // print("index:-$index");
                      // print("Length:-${_img!.length}");
                      // print("IF:-${index==_img!.length}");
                      // print("===================================");
                      // if(index==_img!.length){
                      //   return IconButton(
                      //     icon: const Icon(Icons.camera_alt_outlined),
                      //     onPressed: () async {
                      //       ImagePicker picker = ImagePicker();
                      //       _img = await picker.pickMultiImage();
                      //       setState(() {});
                      //     },
                      //   );
                      // }else{
                      //   return Image.file(
                      //     File(_img![index].path),
                      //     height: 100,
                      //     width: 100,
                      //   );
                      // }
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    createProduct(context);
                  },
                  child: const Text("Add Product"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
