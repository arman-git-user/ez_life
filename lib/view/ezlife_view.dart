import 'package:ez_life/data/local/db_connection.dart';
import 'package:ez_life/utils/utils.dart';
import 'package:ez_life/view/dashboard_view.dart';
import 'package:ez_life/view_model/ezlife_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EzLifeScreen extends StatefulWidget {
  const EzLifeScreen({super.key});

  @override
  State<EzLifeScreen> createState() => _EzLifeScreenState();
}

class _EzLifeScreenState extends State<EzLifeScreen> {
  DbConnection? dbConnection;
  TextEditingController memoryController = TextEditingController();
  List<String> selectedTraits = [];
  @override
  void initState() {
    // TODO: implement initState
    print(selectedTraits);
    dbConnection = DbConnection.getInstance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff050816),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TOP LOGO
              Row(
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    color: Color(0xff66F5F0),
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  ShaderMask(
                    shaderCallback: (bounds) {
                      return const LinearGradient(
                        colors: [Color(0xff8BE9FD), Color(0xff00F5C3)],
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

              const SizedBox(height: 30),

              /// HEADING
              const Text(
                "Data Integration",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 14),

              Text(
                "Enhance your digital twin by\nsynchronizing past experiences and\nfuture goals.",
                style: TextStyle(
                  height: 1.5,
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.75),
                ),
              ),

              const SizedBox(height: 40),

              /// TRAITS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.psychology_alt_outlined,
                        color: Color(0xff00FFD1),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Traits",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Select 3+",
                    style: TextStyle(color: Colors.cyan.shade100, fontSize: 18),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<EzlifeViewModel>().toggleTrait1();
                    },
                    child: traitChip(
                      "Analytical",
                      context.watch<EzlifeViewModel>().isClicked1Trait,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<EzlifeViewModel>().toggleTrait2();
                    },
                    child: traitChip(
                      "Creative",
                      context.watch<EzlifeViewModel>().isClicked2Trait,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<EzlifeViewModel>().toggleTrait3();
                    },
                    child: traitChip(
                      "Risk-Taker",
                      context.watch<EzlifeViewModel>().isClicked3Trait,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<EzlifeViewModel>().toggleTrait4();
                    },
                    child: traitChip(
                      "Disciplined",
                      context.watch<EzlifeViewModel>().isClicked4Trait,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<EzlifeViewModel>().toggleTrait5();
                    },
                    child: traitChip(
                      "Empathic",
                      context.watch<EzlifeViewModel>().isClicked5Trait,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              /// CORE MEMORIES
              sectionTitle(
                icon: Icons.stacked_line_chart_rounded,
                title: "Core Memories",
                color: Colors.purpleAccent,
              ),

              const SizedBox(height: 20),

              memoryCard(controller: memoryController),

              const SizedBox(height: 20),

              // ongoingCard(),
              const SizedBox(height: 40),

              /// SMART HABITS
              // sectionTitle(
              //   icon: Icons.auto_fix_high,
              //   title: "Smart Habits",
              //   color: Color(0xff00FFD1),
              // ),
              //
              // const SizedBox(height: 20),
              //
              // GridView.count(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   crossAxisCount: 2,
              //   crossAxisSpacing: 14,
              //   mainAxisSpacing: 14,
              //   childAspectRatio: 0.8,
              //   children: [
              //     habitCard(
              //       icon: Icons.wb_sunny_outlined,
              //       title: "Early Riser",
              //       subtitle: "05:00 AM",
              //       iconBg: Colors.greenAccent.withOpacity(0.2),
              //     ),
              //     habitCard(
              //       icon: Icons.fitness_center,
              //       title: "Athlete",
              //       subtitle: "Daily 60m",
              //       iconBg: Colors.blueGrey.withOpacity(0.3),
              //     ),
              //     habitCard(
              //       icon: Icons.menu_book_rounded,
              //       title: "Deep Work",
              //       subtitle: "Focused",
              //       iconBg: Colors.lightBlueAccent.withOpacity(0.2),
              //     ),
              //     addHabitCard(),
              //   ],
              // ),
              const SizedBox(height: 50),

              /// BUTTON
              InkWell(
                borderRadius: BorderRadius.circular(22),
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  selectedTraits.clear();
                  final ctx = context.read<EzlifeViewModel>();

                  // Collect selected trait texts
                  if (ctx.isClicked1Trait) selectedTraits.add("Analytical");
                  if (ctx.isClicked2Trait) selectedTraits.add("Creative");
                  if (ctx.isClicked3Trait) selectedTraits.add("Risk-Taker");
                  if (ctx.isClicked4Trait) selectedTraits.add("Disciplined");
                  if (ctx.isClicked5Trait) selectedTraits.add("Empathic");

                  // Check if at least 3 traits are selected
                  if (selectedTraits.length >= 3) {
                    bool check = await dbConnection!.addNote(
                      mTrait1: selectedTraits.isNotEmpty ? selectedTraits[0] : "",
                      mTrait2: selectedTraits.length > 1 ? selectedTraits[1] : "",
                      mTrait3: selectedTraits.length > 2 ? selectedTraits[2] : "",
                      mTrait4: selectedTraits.length > 3 ? selectedTraits[3] : "",
                      mTrait5: selectedTraits.length > 4 ? selectedTraits[4] : "",
                      mPastExp: memoryController.text,
                    );

                    if (check) {
                      debugPrint("Profile saved successfully");
                      if (mounted){
                        await prefs.setBool('profile_completed', true);
                        context.go('/dashboard');
                      }

                    }
                  } else {
                    Utils.flutterToast("Please select at least 3 traits");
                  }
                },
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: const LinearGradient(
                      colors: [Color(0xff8EE8FF), Color(0xff11D4FF)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyanAccent.withOpacity(0.4),
                        blurRadius: 18,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Finalize Profile",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget traitChip(String text, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: selected
              ? const Color(0xff7FE7FF)
              : Colors.white.withOpacity(0.08),
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: Colors.cyanAccent.withOpacity(0.25),
                  blurRadius: 14,
                ),
              ]
            : [],
        color: const Color(0xff0B1020),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: selected ? Colors.cyan.shade100 : Colors.white70,
        ),
      ),
    );
  }

  Widget sectionTitle({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget memoryCard({required TextEditingController controller}) {
    return Container(
      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: const Color(0xff101320),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                "PAST MEMORIES",
                style: TextStyle(
                  letterSpacing: 2,
                  color: Colors.purple.shade200,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Icon(Icons.more_horiz, color: Colors.white54),
            ],
          ),

          const SizedBox(height: 24),

          TextField(
            controller: controller,

            maxLines: null,

            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              height: 1.5,
            ),

            decoration: InputDecoration(
              isCollapsed: true,

              border: InputBorder.none,

              hintText: "e.g., Founding the tech collective..",

              hintStyle: TextStyle(
                fontSize: 22,
                color: Colors.white.withOpacity(0.25),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // OPTIONAL TAGS
          // Row(
          //   children: [
          //     tag("2018", Colors.white10),
          //     const SizedBox(width: 2),
          //     tag("Career Milestone", Colors.purple.withOpacity(0.25)),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget ongoingCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xff101320),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ONGOING PURSUIT",
                style: TextStyle(
                  letterSpacing: 2,
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Icons.add_circle_outline, color: Colors.white54),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            "What defines your current trajectory?",
            style: TextStyle(
              fontSize: 22,
              fontStyle: FontStyle.italic,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget habitCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconBg,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xff101320),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.cyan.shade100, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget addHabitCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff101320),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.white54),
            SizedBox(width: 8),
            Text(
              "Add New",
              style: TextStyle(color: Colors.white54, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
