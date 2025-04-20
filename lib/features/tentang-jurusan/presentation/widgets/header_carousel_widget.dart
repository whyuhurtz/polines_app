import 'dart:async';
import 'package:flutter/material.dart';

class HeaderCarouselWidget extends StatefulWidget {
  final List<String> imagePaths;
  final double height;

  const HeaderCarouselWidget({
    Key? key,
    required this.imagePaths,
    this.height = 200.0,
  }) : super(key: key);

  @override
  State<HeaderCarouselWidget> createState() => _HeaderCarouselWidgetState();
}

class _HeaderCarouselWidgetState extends State<HeaderCarouselWidget> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;
  
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _startAutoScroll();
  }
  
  @override
  void dispose() {
    _stopAutoScroll();
    _pageController.dispose();
    super.dispose();
  }
  
  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < widget.imagePaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      }
    });
  }
  
  void _stopAutoScroll() {
    _timer?.cancel();
    _timer = null;
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imagePaths.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return _buildCarouselItem(widget.imagePaths[index]);
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.imagePaths.length,
                (index) => _buildIndicator(index == _currentPage),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCarouselItem(String imagePath) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.1),
              Colors.black.withOpacity(0.5),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? const Color(0xFFF6C31A) : Colors.white.withOpacity(0.5),
      ),
    );
  }
}