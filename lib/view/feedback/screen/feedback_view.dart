import 'package:flutter/material.dart';
import 'package:our_space/view_model/feedback_provider.dart';
import 'package:provider/provider.dart';

class FeedbackView extends StatefulWidget {
  const FeedbackView({super.key});

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<FeedbackProvider>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          splashRadius: 25,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.asset(
              width: 45,
              "assets/images/icon.png",
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        blurRadius: 30,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: Text(
                    "Feedback Form",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
                child: Text(
                  textAlign: TextAlign.center,
                  "Your feedback is incredibly valuable to us. Please share your thoughts on how we can make our app even better.",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 41, 78, 152)
                          .withOpacity(0.6),
                      blurRadius: 150,
                      spreadRadius: 10,
                    )
                  ],
                ),
                child:
                    Consumer<FeedbackProvider>(builder: (context, values, _) {
                  return Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),

                          //TextFormfield user
                          TextFormField(
                            cursorColor: Colors.white,
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.name,
                            controller: _userController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person,
                                  color: Color.fromARGB(255, 96, 126, 187)),
                              labelText: "Name",
                              labelStyle: const TextStyle(color: Colors.white),
                              hintText: "Your Name",
                              hintStyle: const TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 41, 78, 152)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 41, 78, 152)),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 41, 78, 152)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 41, 78, 152)),
                              ),
                            ),
                            validator: (value) =>
                                values.validateUser(_userController.text),
                          ),
                          const SizedBox(height: 30),

                          //TextFormField email
                          TextFormField(
                            cursorColor: Colors.white,
                            style: const TextStyle(color: Colors.white),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.mail,
                                  color: Color.fromARGB(255, 96, 126, 187)),
                              labelText: "Email",
                              labelStyle: const TextStyle(color: Colors.white),
                              hintText: "user@gmail.com",
                              hintStyle: const TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 41, 78, 152)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 41, 78, 152)),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 41, 78, 152)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 41, 78, 152)),
                              ),
                            ),
                            validator: (value) =>
                                values.validateEmail(_emailController.text),
                          ),
                          const SizedBox(height: 30),

                          //TextFormField message
                          TextFormField(
                            cursorColor: Colors.white,
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.multiline,
                            controller: _messageController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              labelText: "What is your feedback?",
                              hintText: "write a message here",
                              labelStyle: const TextStyle(color: Colors.white),
                              hintStyle: const TextStyle(color: Colors.white),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 41, 78, 152)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 41, 78, 152)),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 41, 78, 152)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 41, 78, 152)),
                              ),
                            ),
                            validator: (value) =>
                                values.validateMessage(_messageController.text),
                          ),
                          const SizedBox(height: 30),

                          //Button Send
                          Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              width: 130,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    showDialog(
                                      context: context,
                                      builder: (
                                        context,
                                      ) {
                                        return AlertDialog(
                                          contentTextStyle: const TextStyle(
                                              color: Colors.white),
                                          backgroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          content: Stack(
                                            children: [
                                              Image.asset(
                                                'assets/images/done.gif',
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [
                                                  Text(
                                                    textAlign: TextAlign.center,
                                                    'Thank you for submitting your feedback.',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  SizedBox(height: 130),
                                                  Text(
                                                    textAlign: TextAlign.center,
                                                    'We will review it shortly and get back to you if necessary.',
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              child: const Text('OK'),
                                              onPressed: () {
                                                Navigator.pop(context);

                                                _userController.clear();
                                                _emailController.clear();
                                                _messageController.clear();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  shape: const StadiumBorder(),
                                  backgroundColor:
                                      const Color.fromARGB(255, 41, 78, 152)
                                          .withOpacity(0.6),
                                ),
                                child: const Text("SEND", style: TextStyle(color: Color.fromARGB(255, 220, 87, 213))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
