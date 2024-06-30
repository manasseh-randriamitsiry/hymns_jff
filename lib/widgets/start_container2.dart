import 'package:flutter/material.dart';

class ExploreUpcomingAndNearbyEvents extends StatelessWidget {
  const ExploreUpcomingAndNearbyEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 327,
          height: 288,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 327,
                  height: 288,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFF7E69),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 210,
                child: SizedBox(
                  width: 287,
                  height: 58,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 287,
                          height: 58,
                          decoration: ShapeDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(0.71, -0.71),
                              end: Alignment(-0.71, 0.71),
                              colors: [Color(0xFF20222C), Color(0xDB070708)],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 90,
                        top: 20.68,
                        child: SizedBox(
                          width: 107,
                          child: Text(
                            'COMMENCER',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFFDFDFD),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0.09,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(
                left: 24,
                top: 37.75,
                child: SizedBox(
                  width: 279,
                  height: 128.75,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 80.75,
                        child: SizedBox(
                          width: 279,
                          child: Opacity(
                            opacity: 0.60,
                            child: Text(
                              'Find and booking concert tickets near you! Invite your friends to watch together',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFFDFDFD),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0.12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        top: 0,
                        child: SizedBox(
                          width: 219,
                          child: Text(
                            'Regarder des concerts gratuits avec des amis',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFFDFDFD),
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0.07,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}