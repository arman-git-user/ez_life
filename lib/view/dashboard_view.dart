import 'dart:async';

import 'package:ez_life/view/ai_chat_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class Dashboard_View extends StatelessWidget {
  const Dashboard_View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff02040B),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      /// TOP BAR
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.auto_awesome,
                                color: Color(0xff8AEFFF),
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              ShaderMask(
                                shaderCallback: (bounds) {
                                  return const LinearGradient(
                                    colors: [
                                      Color(0xff8EE8FF),
                                      Color(0xff00FFC6),
                                    ],
                                  ).createShader(bounds);
                                },
                                child: const Text(
                                  "EZ Life",
                                  style: TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          /// PROFILE
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.cyanAccent.withOpacity(0.5),
                              ),
                            ),
                            child: const CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage(
                                "https://i.pravatar.cc/300",
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 34),

                      Text(
                        DateFormat('EEEE, MMM d').format(DateTime.now()).toUpperCase(),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.65),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Hi, Alex",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.greenAccent.withOpacity(0.4),
                                  blurRadius: 20,
                                )
                              ],
                            ),
                            child: const Icon(
                              Icons.psychology_alt_outlined,
                              color: Color(0xff00FFD0),
                              size: 30,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      /// AI CARD
                      Container(
                        padding: const EdgeInsets.all(26),
                        decoration: BoxDecoration(
                          color: const Color(0xff0B101A),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.08),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Text(
                                    "OPTIMIZATION ALERT",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xffA9E8FF),
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 26),

                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 20,
                                  height: 1.6,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                                children: const [
                                  TextSpan(style: TextStyle(fontSize: 18),
                                    text:
                                    "Based on your deep sleep\npatterns and upcoming 10 AM\nstrategy meeting, I recommend a\n",
                                  ),
                                  TextSpan(
                                    text:
                                    "15-minute focused meditation ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xff00FFD0),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    style: TextStyle(fontSize: 18),
                                    text:
                                    "\nnow to peak your cognitive load\nby mid-morning.",
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 34),

                            InkWell(
                              onTap: (){
                                context.push('/dashboard/AIChat');
                              },
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xffA7EAFF),
                                      Color(0xff12D7FF),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                      Colors.cyanAccent.withOpacity(0.35),
                                      blurRadius: 18,
                                    )
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    "Start Session",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// SEARCH
                      const SizedBox(height: 24),

                       Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xff070C16),
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.08),
                            ),
                          ),
                          child: Row(
                            children: [

                              /// TEXT FIELD
                              Expanded(
                                child: TextField(
                                  readOnly: true,
                                  onTap: (){
                                    context.push('/dashboard/AIChat');
                                  },
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Ask EZ AI anything...",
                                    hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ),

                              /// MIC BUTTON (UNCHANGED)

                            ],
                          ),
                        ),

                      const SizedBox(height: 32),
                      /// MEMORIES TITLE
                      sectionTitle("Recent Memories"),

                      const SizedBox(height: 22),

                      SizedBox(
                        height: 260,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            memoryCard(
                              image:
                              "https://images.unsplash.com/photo-1515879218367-8466d910aaa4",
                              title: "Coding Flow",
                              subtitle: "Yesterday",
                            ),
                            memoryCard(
                              image:
                              "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
                              title: "Morning Hike",
                              subtitle: "Oct 22",
                            ),
                            memoryCard(
                              image:
                              "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4",
                              title: "Team Dinner",
                              subtitle: "Oct 18",
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 34),

                      sectionOnly("Future Paths"),

                      const SizedBox(height: 22),

                      futurePathCard(
                        icon: Icons.flight_takeoff,
                        title: "Weekend Getaway: Tokyo",
                        subtitle: "Ideal conditions detected",
                        leftGlow: const Color(0xff00FFD0),
                      ),

                      const SizedBox(height: 18),

                      futurePathCard(
                        icon: Icons.menu_book_rounded,
                        title: "New Skill: Neural Physics",
                        subtitle: "Based on recent queries",
                        leftGlow: Colors.white,
                      ),

                      const SizedBox(height: 50),

                      Center(
                        child: Column(
                          children: [
                            Text(
                              "\"The best way to predict the\nfuture is to create it.\"",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                height: 1.6,
                                fontStyle: FontStyle.italic,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "AI MOTIVATIONAL INSIGHT #442",
                              style: TextStyle(
                                color: Color(0xffA9E8FF),
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),

              /// BOTTOM NAVIGATION
              // Container(
              //   margin: const EdgeInsets.only(bottom: 12),
              //   padding:
              //   const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              //   decoration: BoxDecoration(
              //     color: const Color(0xff070B14),
              //     borderRadius: BorderRadius.circular(40),
              //     border: Border.all(
              //       color: Colors.white.withOpacity(0.08),
              //     ),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       navIcon(Icons.home_outlined, true),
              //       navIcon(Icons.storage_rounded, false),
              //       navIcon(Icons.chat_bubble_outline, false),
              //       navIcon(Icons.psychology_alt_outlined, false),
              //       navIcon(Icons.person_outline, false),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget navIcon(IconData icon, bool active) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active
            ? Colors.cyanAccent.withOpacity(0.15)
            : Colors.transparent,
        boxShadow: active
            ? [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.25),
            blurRadius: 18,
          )
        ]
            : [],
      ),
      child: Icon(
        icon,
        color: active
            ? const Color(0xffA8E9FF)
            : Colors.white.withOpacity(0.5),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        // const Text(
        //   "View All",
        //   style: TextStyle(
        //     color: Color(0xffA9E8FF),
        //     fontSize: 20,
        //   ),
        // ),
      ],
    );
  }

  Widget sectionOnly(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget memoryCard({
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: 170,
      margin: const EdgeInsets.only(right: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.9),
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget futurePathCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color leftGlow,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff0A0F18),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 120,
            decoration: BoxDecoration(
              color: leftGlow,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.tealAccent.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      icon,
                      color: const Color(0xff00FFD0),
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}