import 'package:e_health_project/pages/home_screen/adim_sayar.dart';
import 'package:e_health_project/pages/home_screen/code_page.dart';
import 'package:e_health_project/pages/home_screen/medicine_screen.dart';
import 'package:e_health_project/pages/login.dart';
import 'package:flutter/material.dart';
import 'home_screen/BMI_calculator.dart';
import 'home_screen/cart_page.dart';
import '../widget/drawer_widget.dart';
import 'navigation_screen/news.dart';
import 'navigation_screen/nobetci_eczane.dart';
import 'navigation_screen/profile.dart';
import 'home_screen/weather.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    NewsPage(),
    NobetciEczanePage(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Spacer(),
            GestureDetector(
              onLongPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
              onDoubleTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Çıkış Yap'),
                    content: Text('Çıkış yapmak istediğinize emin misiniz?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('İptal'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Perform logout logic here
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                          // Redirect to login page or perform any other action
                        },
                        child: Text('Çıkış Yap'),
                      ),
                    ],
                  ),
                );
              },
              child: CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black12,
        elevation: 0,
      ),

      drawer: DrawerWidget(),
       body: SingleChildScrollView(
        child:Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height:50), // Araya boşluk ekleyelim
                  Container(
                    height: 190,
                    width: 190,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.teal,
                        width: 4,
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
                              pageBuilder: (_, __, ___) => MedicineScreen(),
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
                              'assets/images/medicine.png',
                              height: 120,
                              width: 120,
                              fit: BoxFit.fitWidth,
                            ),
                            Positioned(
                              bottom: 10,
                              child: Text(
                                'Günlük İlaçlar',
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
         Container(
           height: 190,
           width: 190,
           decoration: BoxDecoration(
             color: Colors.white, // Taban rengini beyaz olarak güncelledik
             borderRadius: BorderRadius.circular(10),
             border: Border.all(
               color: Colors.teal, // Çerçeve rengini kırmızı olarak güncelledik
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
                              pageBuilder: (_, __, ___) => IlacSorguPage(),
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
                              'assets/images/recete.png',
                              height: 120,
                              width: 120,
                              fit: BoxFit.fitWidth,
                            ),
                            Positioned(
                              bottom: 10, // Sepet yazısının alt kenara olan uzaklığını ayarlayabilirsiniz
                              child: Text(
                                'Reçete',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height:200), // Araya boşluk ekleyelim
                  Container(
                    height: 190,
                    width: 190,
                    decoration: BoxDecoration(
                      color: Colors.white, // Taban rengini beyaz olarak güncelledik
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.teal, // Çerçeve rengini kırmızı olarak güncelledik
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
                              pageBuilder: (_, __, ___) => CartPage(),
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
                              'assets/images/shopping-cart.png',
                              height: 120,
                              width: 120,
                              fit: BoxFit.fitWidth,
                            ),
                            Positioned(
                              bottom: 10, // Sepet yazısının alt kenara olan uzaklığını ayarlayabilirsiniz
                              child: Text(
                                'Sepet',
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
         Container(
           height: 190,
           width: 190,
           decoration: BoxDecoration(
             color: Colors.white, // Taban rengini beyaz olarak güncelledik
             borderRadius: BorderRadius.circular(10),
             border: Border.all(
               color: Colors.teal, // Çerçeve rengini kırmızı olarak güncelledik
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
                     pageBuilder: (_, __, ___) => HavaDurumu(),
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
                              'assets/images/weather-forecast.png',
                              height: 120,
                              width: 120,
                              fit: BoxFit.fitWidth,
                            ),
                            Positioned(
                              bottom: 10, // Sepet yazısının alt kenara olan uzaklığını ayarlayabilirsiniz
                              child: Text(
                                'Hava Durumu',
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
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height:100), // Araya boşluk ekleyelim
         Container(
           height: 190,
           width: 190,
           decoration: BoxDecoration(
             color: Colors.white, // Taban rengini beyaz olarak güncelledik
             borderRadius: BorderRadius.circular(10),
             border: Border.all(
               color: Colors.teal, // Çerçeve rengini kırmızı olarak güncelledik
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
                     pageBuilder: (_, __, ___) => StepCounterPage(),
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
                        'assets/images/footsteps-silhouette-variant.png',
                        height: 120,
                        width: 120,
                        fit: BoxFit.fitWidth,
                      ),
                      Positioned(
                        bottom: 10, // Sepet yazısının alt kenara olan uzaklığını ayarlayabilirsiniz
                        child: Text(
                          'Adım Sayar',
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
         Container(
           height: 190,
           width: 190,
           decoration: BoxDecoration(
             color: Colors.white, // Taban rengini beyaz olarak güncelledik
             borderRadius: BorderRadius.circular(10),
             border: Border.all(
               color: Colors.teal, // Çerçeve rengini kırmızı olarak güncelledik
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
                     pageBuilder: (_, __, ___) => BMICalculator(),
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
                        'assets/images/weight-scale.png',
                        height: 120,
                        width: 120,
                        fit: BoxFit.fitWidth,
                      ),
                      Positioned(
                        bottom: 10, // Sepet yazısının alt kenara olan uzaklığını ayarlayabilirsiniz
                        child: Text(
                          'Vücut Kitle İndeksi',
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
          ],)]
        ),


      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.black12,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black12,
            icon: Icon(Icons.article),
            label: 'News',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black12,
            icon: Icon(Icons.local_pharmacy),
            label: 'Pharmacy',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black12,
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NobetciEczanePage()),
            );
          } else if (index == 3) {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile(),
                ));
          }
        },
      ),
    );
  }
}