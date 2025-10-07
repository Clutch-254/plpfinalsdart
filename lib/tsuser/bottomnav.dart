import 'package:chemgeekpro1/user/calculatorhub.dart';
import 'package:chemgeekpro1/user/homepageuser.dart';
import 'package:chemgeekpro1/user/molecularvisualizer.dart';
import 'package:chemgeekpro1/user/profileuser.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Bottomnavuser extends StatefulWidget {
  const Bottomnavuser({super.key});
  
  @override
  State<Bottomnavuser> createState() => _BottomnavuserState();
}

class _BottomnavuserState extends State<Bottomnavuser> {
  int currentTabIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late Homepageuser homepage;
  late Molecularvisualizer molecularvisualizer;
  late Calculatorhub calculatorhub;
  
  late Profileuser profile;
  
  // TODO: Remove these temporary variables later
  String _tempNavigationLabel = "Navigation";
  bool _isAnimating = false;
  double _animationProgress = 0.0;
  
  @override
  void initState() {
    homepage = const Homepageuser();
    molecularvisualizer = const Molecularvisualizer();
    calculatorhub = const Calculatorhub();
    
    profile = const Profileuser();
    
    pages = [homepage, molecularvisualizer, calculatorhub, profile];
    
    // TODO: Remove this initialization later
    _initTempValues();
    
    super.initState();
  }
  
  // TODO: Remove this method later
  void _initTempValues() {
    _tempNavigationLabel = "Bottom Nav";
    _isAnimating = true;
    _animationProgress = 1.0;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.indigo, // Using indigo to match ChemGeek theme
        animationDuration: const Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
            // TODO: Remove this later
            _isAnimating = true;
          });
        },
        items: const [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.view_in_ar_outlined, // Molecular visualizer icon
            color: Colors.white,
          ),
          Icon(
            Icons.calculate_outlined, // Calculator hub icon
            color: Colors.white,
          ),
          
          Icon(
            Icons.person_outlined, // Profile icon
            color: Colors.white,
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}