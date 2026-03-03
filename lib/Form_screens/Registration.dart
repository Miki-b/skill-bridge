import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillbridge_excercise_app/Form_screens/translations.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final countryController = TextEditingController();
  bool hide = false;
  final _formKey = GlobalKey<FormState>();
  final countries = ['Ethiopia',"Kenya", "Sudan", "Somalia","Eritrea", "Djbouti", "Other"];
  final Languages = ["Eng", "Amh", "Oromo" ];
  String selectedLanguage = "Eng";
  String? selectedValue;
  String? selectedGender;
  bool isMusicChecked= false;
  bool isArtChecked= false;
  bool isWritingChecked= false;

  Future<void> saveLanguage(String lang) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('language', lang);
  }

  Future<void> loadLanguage() async {
    final pref = await SharedPreferences.getInstance();
    final language = pref.getString('language');

    if (language != null) {
      setState(() {
        selectedLanguage = language;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadLanguage();
  }


  String tran(String key){

    return translations[selectedLanguage]?[key] ?? key;
  }

  @override
  void dispose(){
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    countryController.dispose();
    super.dispose();
  }

  void submitForm(){
    if(_formKey.currentState!.validate()){
      final Country = selectedValue=="Other"? countryController.text: selectedValue;
      Navigator.pushNamed(
          context,
          '/displayData',
          arguments: {
            'name': nameController.text,
            'email': emailController.text,
            'password': passwordController.text,
            'country': Country,
            'gender': selectedGender,
            'art':isArtChecked,
            'music':isMusicChecked,
            'writing': isWritingChecked
          }
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tran("registration")),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
                value: selectedLanguage,
                items: Languages.map((L)=>
                    DropdownMenuItem(
                      value: L,
                    child: Text(L))).toList(),
                onChanged: (value){
                  setState(() {
                    selectedLanguage = value!;
                  });
                  saveLanguage(value!);
                }),
          )
        ],
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(

            children: [
              SizedBox(height: 20,),
              //name
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: tran("name"),
                  hintText: tran("nameHint"),
                  border: OutlineInputBorder()
                ),
                validator: (value){
                  if (value == null || value.isEmpty){
                    return "Please enter your name";
                  }
                },
              ),
              SizedBox(height: 20,),
              //email
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: tran("email"),
                    hintText: tran("emailHint"),
                    border: OutlineInputBorder()
                ),
                validator: (value){
                  if (value == null || value.isEmpty){
                    return "Please enter your email";
                  }
                },
              ),
          
              //password
              SizedBox(height: 20,),
              //email
              TextFormField(
                controller: passwordController,
                obscureText: hide,
                decoration: InputDecoration(
                    labelText:tran("password"),
                    hintText: tran("passwordHint"),
                    border: OutlineInputBorder(),
                  suffixIcon: GestureDetector(
                    onTap: (){
                      setState(() {
                        hide = !hide;
                      });
                    },
                      child: Icon(hide?Icons.visibility_off:Icons.visibility)
          
                ),
              ),
                  validator: (value){
                  final _value =value;
                    if (_value == null || _value.isEmpty ){
                      return "Please enter your password";
                    }
                  },
              ),
              SizedBox(height: 20,),

              //Dropdown of citizen
              DropdownButtonFormField(


                  decoration: InputDecoration(
                      labelText: tran("country"),
                      hintText: tran("countryHint"),
                      border: OutlineInputBorder()
                  ),
                  value: selectedValue,
                  items: countries.map((country) {
                    return DropdownMenuItem<String>(
                        value: country,
                        child: Text(country)
                    );
                  }).toList(),
                  onChanged: (value){
                    setState(() {
                      selectedValue = value!;
                    });

                  }
              ),

              SizedBox(height: 20,),
              if(selectedValue== "Other")...[
                TextFormField(
                  controller: countryController,
                  decoration: InputDecoration(
                      labelText: tran("country"),
                      hintText: tran("countryHint"),
                      border: OutlineInputBorder()
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return "Please enter your Country";
                    }
                  },
                ),

              ],
              SizedBox(height: 20,),
              Text("Select Your gender"),
              SizedBox(height: 20,),
              RadioListTile<String>(
                title: Text("Male"),
                  value: "Male",
                groupValue: selectedGender,
                onChanged: (value){
                  setState(() {
                    selectedGender = value!;
                  });
                },
              ),RadioListTile<String>(
                title: Text("Female"),
                  value: "Female",
                groupValue: selectedGender,
                onChanged: (value){
                  setState(() {
                    selectedGender = value!;
                  });
                },
              ),
              SizedBox(height: 20,),
              Text("What its your hobby?"),
              Row(
                children: [
                  Checkbox(
                      value: isMusicChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isMusicChecked =value!;
                        });
                      }
                  ),
                  Text("Music"),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      value: isArtChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isArtChecked =value!;
                        });
                      }
                  ),
                  Text("Art"),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      value: isWritingChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isWritingChecked =value!;
                        });
                      }
                  ),
                  Text("Writing"),
                ],
              ),

              SizedBox(height: 20,),
              //button
              ElevatedButton(
                  onPressed: submitForm,
                  style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 143,
                      vertical: 20,
                    ),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                  ),
                  child: Text("Submit Form"))
          
            ],
          ),
        ),
      ),
    );
  }
}
