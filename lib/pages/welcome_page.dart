import 'package:e_health_project/pages/pharmacy/add_medicine.dart';
import 'package:e_health_project/pages/hospital/ilac_ekleme.dart';
import 'package:e_health_project/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:e_health_project/pages/pharmacy/p_home_page.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hoş Geldiniz',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 190,
                  width: 190,
                  decoration: BoxDecoration(
                    color: Colors.white, // Taban rengini beyaz olarak güncelledik
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.red, // Çerçeve rengini kırmızı olarak güncelledik
                      width: 4, // Çerçeve kalınlığını 2 olarak belirledik
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder: (_, __, ___) => HomePage(),
                            transitionsBuilder: (_, animation, __, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: ScaleTransition(
                                  scale: animation,
                                  child: child,
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/team.png',
                            height: 120,
                            width: 120,
                            fit: BoxFit.fitWidth,
                          ),
                          Positioned(
                            bottom: 10, // Sepet yazısının alt kenara olan uzaklığını ayarlayabilirsiniz
                            child: Text(
                              'Kullanıcı Girişi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height:20),
                Container(
                  height: 190,
                  width: 190,
                  decoration: BoxDecoration(
                    color: Colors.white, // Taban rengini beyaz olarak güncelledik
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.red, // Çerçeve rengini kırmızı olarak güncelledik
                      width: 4, // Çerçeve kalınlığını 2 olarak belirledik
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder: (_, __, ___) => EczaneAnaSayfa(),
                            transitionsBuilder: (_, animation, __, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: ScaleTransition(
                                  scale: animation,
                                  child: child,
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/pharmacist.png',
                            height: 120,
                            width: 120,
                            fit: BoxFit.fitWidth,
                          ),
                          Positioned(
                            bottom: 10, // Sepet yazısının alt kenara olan uzaklığını ayarlayabilirsiniz
                            child: Text(
                              'Eczane Girişi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height:20),
                Container(
                  height: 190,
                  width: 190,
                  decoration: BoxDecoration(
                    color: Colors.white, // Taban rengini beyaz olarak güncelledik
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.red, // Çerçeve rengini kırmızı olarak güncelledik
                      width: 4, // Çerçeve kalınlığını 2 olarak belirledik
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder: (_, __, ___) => RandomCodePage(),
                            transitionsBuilder: (_, animation, __, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: ScaleTransition(
                                  scale: animation,
                                  child: child,
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/medical-team.png',
                            height: 120,
                            width: 120,
                            fit: BoxFit.fitWidth,
                          ),
                          Positioned(
                            bottom: 10, // Sepet yazısının alt kenara olan uzaklığını ayarlayabilirsiniz
                            child: Text(
                              'Doktor Girişi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],),
          ],
        ),
      ),
    ));
  }
}
