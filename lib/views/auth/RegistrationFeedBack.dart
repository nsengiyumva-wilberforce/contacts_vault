import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gic_call_center/views/auth/VerifyEmail.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationFeedback extends StatefulWidget {
    final String email;
  const RegistrationFeedback({super.key, required String this.email});

  @override
  State<RegistrationFeedback> createState() => _RegistrationFeedbackState();
}

class _RegistrationFeedbackState extends State<RegistrationFeedback> with TickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    timeDilation = 2.0; // Slowing down the animation for demonstration purposes

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.015,
              ),
              SizedBox(
                height: size.height * 0.088,
              ),
              Container(
                height: size.height * 0.35,
                width: double.maxFinite,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.0 + 0.1 * _animation.value,
                      child: child,
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/successRegistration.png"),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.048,
              ),
              Text(
                "Thank you !",
                style: GoogleFonts.lato(
                    letterSpacing: 1,
                    fontSize: size.height * 0.044,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 42, 129, 201)),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: size.width * 0.05, left: size.width * 0.06),
                child: Text(
                  "Your account has been created successfully",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: size.height * 0.016),
                ),
              ),
              SizedBox(
                height: size.height * 0.055,
              ),
        
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                    print('email: ${widget.email}');
                      return VerificationCodeScreen(email: widget.email);
                    }));
                  },
                  child: Center(
                    child: Container(
                      height: size.height*0.08,
                      width: size.width*0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 42, 129, 201)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width*0.12),
                        child: Center(child: Text('Verify Your Email', style: GoogleFonts.lato(
                          color: Colors.white
                        ),)),
                      ),
                    ),
                  ),
                ),
               ],
          ),
        ),
      )
    );
  }
}