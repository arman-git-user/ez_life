import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    getData();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    /// RESPONSIVE VALUES
    final screenWidth = size.width;
    final screenHeight = size.height;

    final logoBoxSize = screenWidth * 0.65;
    final brainIconSize = screenWidth * 0.18;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// BACKGROUND GLOW
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [
                    Colors.tealAccent.withOpacity(0.12),
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),

          /// MAIN CONTENT
          SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenHeight,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.07,
                ),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.08),

                    /// LOGO BOX
                    Container(
                      height: logoBoxSize,
                      width: logoBoxSize,
                      decoration: BoxDecoration(
                        color: const Color(0xff03060D),
                        boxShadow: [
                          BoxShadow(
                            color:
                            Colors.cyanAccent.withOpacity(0.15),
                            blurRadius: 60,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          /// BRAIN ICON
                          Container(
                            height: brainIconSize,
                            width: brainIconSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.cyanAccent
                                      .withOpacity(0.25),
                                  blurRadius: 25,
                                ),
                              ],
                            ),
                            child: ShaderMask(
                              shaderCallback: (bounds) {
                                return const LinearGradient(
                                  colors: [
                                    Color(0xff00E5FF),
                                    Color(0xffFF4DFF),
                                  ],
                                ).createShader(bounds);
                              },
                              child: Icon(
                                Icons.psychology_alt_outlined,
                                size: brainIconSize * 0.8,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          SizedBox(
                              height: screenHeight * 0.03),

                          /// EZ LIFE TEXT
                          ShaderMask(
                            shaderCallback: (bounds) {
                              return const LinearGradient(
                                colors: [
                                  Color(0xff8EE8FF),
                                  Color(0xff00FFD0),
                                ],
                              ).createShader(bounds);
                            },
                            child: Text(
                              "EZ LIFE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.06,
                                letterSpacing: 8,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.05),

                    /// APP TITLE
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          colors: [
                            Color(0xffDDD2FF),
                            Color(0xff00FFD0),
                          ],
                        ).createShader(bounds);
                      },
                      child: Text(
                        "EZ Life",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.015),

                    /// SUBTITLE
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 4,
                          backgroundColor:
                          Color(0xff00FFD0),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Text(
                          "INTELLIGENCE ENGINE",
                          style: TextStyle(
                            color:
                            Colors.white.withOpacity(0.45),
                            fontSize: screenWidth * 0.04,
                            letterSpacing: 3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        const CircleAvatar(
                          radius: 4,
                          backgroundColor:
                          Color(0xff00FFD0),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.04),

                    /// PROGRESS BAR
                    Container(
                      width: double.infinity,
                      height: 8,
                      decoration: BoxDecoration(
                        color:
                        Colors.white.withOpacity(0.08),
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: screenWidth * 0.55,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xffB7EEFF),
                                Color(0xff00FFD0),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.cyanAccent
                                    .withOpacity(0.3),
                                blurRadius: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.04),

                    /// STATUS CHIP
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.06,
                        vertical: screenHeight * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff050A12),
                        borderRadius:
                        BorderRadius.circular(40),
                        border: Border.all(
                          color:
                          Colors.white.withOpacity(0.08),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 14,
                            width: 14,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff00FFD0),
                            ),
                          ),
                          SizedBox(
                              width: screenWidth * 0.04),
                          Text(
                            "Syncing Knowledge Graph...",
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color:
                              const Color(0xffC5F2FF),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    /// FOOTER
                    Text(
                      "Your Past Guides Your Future",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                        Colors.white.withOpacity(0.45),
                        fontSize: screenWidth * 0.065,
                        fontWeight: FontWeight.w300,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.05),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    bool completed = prefs.getBool('profile_completed') ?? false;

    Timer(const Duration(seconds: 3 ), () {
      if (mounted) {
        if (completed) {
          context.go('/dashboard');
        } else {
          context.go('/ezLife');
        }
      }
    });
  }
}



















