import 'package:flutter/material.dart';

import 'package:translator/translator.dart';

final _formkey = GlobalKey<FormState>();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController languageController = TextEditingController();

  List<String> languages = [
    'English',
    'Arabic',
    'German',
    'French',
    'Hindi',
    'Italian',
    'Spanish',
    'Russian'
  ];

  String originalLanguage = "From";
  String destinationLanguage = "To";
  String output = " ";

  void translate(String src, String des, String input) async {
    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: des);

    setState(() {
      output = translation.text.toString();
    });

    if (src == ' ' || des == ' ') {
      setState(() {
        output = "Fail to translate";
      });
    }
  }

  String getLanguageCode(String language) {
    if (language == 'English') {
      return 'en';
    } else if (language == 'Hindi') {
      return 'hi';
    } else if (language == 'Arabic') {
      return 'ar';
    } else if (language == 'German') {
      return 'de';
    } else if (language == 'French') {
      return 'fr';
    } else if (language == 'Italian') {
      return 'it';
    } else if (language == 'Spanish') {
      return 'es';
    } else if (language == 'Russian') {
      return 'ru';
    }
    return '--';
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = false;
    return Scaffold(
      backgroundColor: const Color(0xff10223d),
      appBar: AppBar(
        title: const Text(
          'Translator App',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff10223d),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 23,
                ),
                DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      originalLanguage,
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(
                          dropDownStringItem,
                          style: const TextStyle(fontSize: 25),
                        ),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originalLanguage = value!;
                      });
                    }),
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.arrow_right_alt_outlined,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(
                  width: 40,
                ),
                DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destinationLanguage,
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(
                          dropDownStringItem,
                          style: TextStyle(fontSize: 25),
                        ),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationLanguage = value!;
                      });
                    }),
                const SizedBox(
                  width: 40,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),

            // TextFormField
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  maxLines: 5,
                  cursorColor: Colors.white,
                  textDirection:
                      // ignore: dead_code
                      isArabic ? TextDirection.rtl : TextDirection.ltr,
                  onChanged: (text) {
                    isArabic = text.contains(RegExp(r'[\u0600-\u06FF]+'));
                  },
                  autofocus: false,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      labelText: 'Enter your text...',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.white)),
                      errorStyle: TextStyle(color: Colors.red, fontSize: 20)),
                  controller: languageController,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter text to translate'
                      : null,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  _formkey.currentState!.validate();
                  translate(
                    getLanguageCode(originalLanguage),
                    getLanguageCode(destinationLanguage),
                    languageController.text.toString(),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 120,
                  child: const Text(
                    'Translate',
                    style: TextStyle(fontSize: 28),
                  ),
                )),
            // SizedBox(
            //   height: 20,
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Center(
                child: SelectableText(
                  // SelectableText can be used to select the text
                  '\n$output',
                  style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
