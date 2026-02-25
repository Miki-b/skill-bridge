import 'package:flutter/material.dart';

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
  String? selectedValue;
  String? selectedGender;
  bool isMusicChecked= false;
  bool isArtChecked= false;
  bool isWritingChecked= false;

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
        title: Text("Registration"),
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
                  labelText: "Name",
                  hintText: "Enter Your Name",
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
                    labelText: "Email",
                    hintText: "Enter Your email address",
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
                    labelText: "Password",
                    hintText: "Enter Your password",
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

                hint: Text("Country"),
                  decoration: InputDecoration(
                      labelText: "Select your Citizenship",
                      hintText: "Country",
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
                      labelText: "Country",
                      hintText: "Enter Your Country",
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
