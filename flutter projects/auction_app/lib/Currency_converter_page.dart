// ignore: file_names

// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';
// ignore: camel_case_types
class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
   double result=0;
    final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context){
   
    return  Scaffold(
      backgroundColor: Colors.blueGrey,
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(   
              
              result.toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255)
            ),
            ),
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: textEditingController,
                style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 1)
                ),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'enter in USD',
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                  prefixIconColor: Colors.black,
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30),
                    ),
            
                  ),
                ),
              ),
            ),
            ElevatedButton(onPressed: () {
              setState((){
             result= double.parse(textEditingController.text)*81;
            });
            },
            style: const ButtonStyle(
              elevation: MaterialStatePropertyAll(10),
              backgroundColor: MaterialStatePropertyAll(Color.fromARGB(206, 0, 0, 0),
              ),
              maximumSize: MaterialStatePropertyAll(Size(200, 50),
              ),
            ),
             child: const Text('click')
            ),
       ],
      ),
      ),
    );
  }
}