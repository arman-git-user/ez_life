import 'package:ez_life/data/local/db_connection.dart';
import 'package:ez_life/view_model/ai_chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:provider/provider.dart';

class AIChatView extends StatefulWidget {
  const AIChatView({super.key});

  @override
  State<AIChatView> createState() => _AIChatViewState();
}

class _AIChatViewState extends State<AIChatView> {
  DbConnection? _dbConnection;
  List<Map<String, dynamic>> allNotes = [];
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  /// SMOOTH CHATGPT-LIKE AUTO SCROLL
  void scrollToBottom() {
    if (!_scrollController.hasClients) return;

    Future.delayed(const Duration(milliseconds: 120), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,

        duration: const Duration(milliseconds: 900),

        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _dbConnection = DbConnection.getInstance;
    _dbConnection!.getExp();
    getNotes();
  }

  @override
  void dispose() {
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff02040B),

      body: SafeArea(
        child: Column(
          children: [
            /// MAIN CONTENT
            Expanded(
              child: Consumer<AiChatViewModel>(
                builder: (context, value, child) {
                  return SingleChildScrollView(
                    controller: _scrollController,

                    padding: const EdgeInsets.symmetric(horizontal: 22),

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
                                  color: Color(0xff8BE9FF),
                                  size: 20,
                                ),

                                const SizedBox(width: 10),

                                ShaderMask(
                                  shaderCallback: (bounds) {
                                    return const LinearGradient(
                                      colors: [
                                        Color(0xff9CEEFF),
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
                                  color: Colors.cyanAccent.withOpacity(0.4),
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

                        const SizedBox(height: 36),

                        /// AI ORB
                        Center(
                          child: Column(
                            children: [
                              Container(
                                height: 170,
                                width: 170,

                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,

                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.grey.shade800,
                                      Colors.grey.shade900,
                                    ],
                                  ),

                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                  ),

                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.cyanAccent.withOpacity(
                                        0.25,
                                      ),
                                      blurRadius: 35,
                                      spreadRadius: 5,
                                    ),

                                    BoxShadow(
                                      color: Colors.purpleAccent.withOpacity(
                                        0.18,
                                      ),
                                      blurRadius: 40,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),

                                child: const Center(
                                  child: Icon(
                                    Icons.psychology_alt_outlined,
                                    size: 58,
                                    color: Color(0xff00FFD1),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 26),

                              const Text(
                                "Oracle AI",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                "DIGITAL LIFE OPTIMIZER",
                                style: TextStyle(
                                  letterSpacing: 2.2,
                                  fontSize: 18,
                                  color: Colors.white.withOpacity(0.7),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 42),

                        /// DEFAULT AI MESSAGE
                        aiBubble(text: "How can I help you today?"),

                        const SizedBox(height: 30),

                        /// CHAT HISTORY
                        ...value.messages.map((message) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 22),

                            child: message.isUser
                                ? userBubble(text: message.text)
                                : aiBubble(text: message.text),
                          );
                        }).toList(),

                        /// LOADING INDICATOR
                        if (value.loading)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 14,
                            ),

                            decoration: BoxDecoration(
                              color: const Color(0xff0B1019),
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.06),
                              ),
                            ),

                            child: Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                dot(),
                                const SizedBox(width: 8),

                                dot(),
                                const SizedBox(width: 8),

                                dot(),
                              ],
                            ),
                          ),

                        const SizedBox(height: 140),
                      ],
                    ),
                  );
                },
              ),
            ),

            /// CHAT INPUT SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),

              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xff060B13),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyanAccent.withOpacity(0.08),
                      blurRadius: 25,
                    ),
                  ],
                ),

                child: Row(
                  children: [
                    /// PLUS BUTTON
                    Container(
                      height: 54,
                      width: 54,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.04),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.08),
                        ),
                      ),

                      child: const Icon(
                        Icons.add,
                        color: Colors.white70,
                        size: 30,
                      ),
                    ),

                    const SizedBox(width: 16),

                    /// TEXT FIELD
                    Expanded(
                      child: TextField(
                        controller: _chatController,

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),

                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Ask your Oracle...",
                          hintStyle: TextStyle(
                            color: Colors.white24,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    /// SEND BUTTON
                    InkWell(
                      onTap: () async {
                        if (_chatController.text.trim().isNotEmpty) {
                          String userQuestion = _chatController.text.trim();
                          
                          // Construction of hidden system prompt
                          String traits =
                              'You are a personal Life assistant\n User Personality: \n'
                              ' -${allNotes[0][DbConnection.COLUMN_FIRST_TRAIT]}\n'
                              ' -${allNotes[0][DbConnection.COLUMN_SECOND_TRAIT]}\n'
                              ' -${allNotes[0][DbConnection.COLUMN_THIRD_TRAIT]}\n'
                              ' -${allNotes[0][DbConnection.COLUMN_FOURTH_TRAIT]}\n'
                              ' -${allNotes[0][DbConnection.COLUMN_FIFTH_TRAIT]}\n'
                              ' Past experiences: \n ${allNotes[0][DbConnection.USER_EXP]}\n'
                              'Current user question:\n';
                          
                          final String lastLine =
                              'Give guidance according to the user personality and experiences.';
                              
                          final fullPrompt = "$traits\n$userQuestion\n$lastLine";

                          _chatController.clear();

                          await context.read<AiChatViewModel>().promptAI(
                            displayText: userQuestion,
                            fullPrompt: fullPrompt,
                          );

                          scrollToBottom();
                        }
                      },

                      child: Container(
                        height: 66,
                        width: 66,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          gradient: const LinearGradient(
                            colors: [Color(0xff7AF7FF), Color(0xff00E0C6)],
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.cyanAccent.withOpacity(0.35),
                              blurRadius: 20,
                              spreadRadius: 1,
                            ),
                          ],
                        ),

                        child: const Icon(
                          Icons.arrow_upward_rounded,
                          color: Colors.black,
                          size: 34,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// BOTTOM NAVIGATION
            // Padding(
            //
            //   padding: const EdgeInsets.only(
            //     left: 22,
            //     right: 22,
            //     bottom: 14,
            //   ),
            //
            //   child: Container(
            //
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 22,
            //       vertical: 14,
            //     ),
            //
            //     decoration: BoxDecoration(
            //       color: const Color(0xff070B14),
            //       borderRadius: BorderRadius.circular(40),
            //       border: Border.all(
            //         color: Colors.white.withOpacity(0.08),
            //       ),
            //     ),
            //
            //     child: Row(
            //
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //
            //       children: [
            //
            //         navIcon(Icons.home_outlined, false),
            //         navIcon(Icons.storage_rounded, false),
            //         navIcon(Icons.chat_bubble_outline, true),
            //         navIcon(Icons.psychology_alt_outlined, false),
            //         navIcon(Icons.person_outline, false),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  /// AI MESSAGE BUBBLE
  Widget aiBubble({required String text}) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(28),

      decoration: BoxDecoration(
        color: const Color(0xff06080F),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),

      child: GptMarkdown(
        text,

        style: TextStyle(
          fontSize: 14,
          height: 1.6,
          color: Colors.white.withOpacity(0.9),
        ),
      ),
    );
  }

  /// USER MESSAGE BUBBLE
  Widget userBubble({required String text}) {
    return Align(
      alignment: Alignment.centerRight,

      child: Container(
        width: MediaQuery.of(context).size.width * 0.78,

        padding: const EdgeInsets.all(24),

        decoration: BoxDecoration(
          color: const Color(0xff101924),

          borderRadius: BorderRadius.circular(30),

          border: Border.all(color: Colors.cyanAccent.withOpacity(0.15)),

          boxShadow: [
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(0.12),
              blurRadius: 18,
              spreadRadius: 1,
            ),
          ],
        ),

        child: Text(
          text,

          style: TextStyle(
            height: 1.5,
            fontSize: 16,
            color: Colors.cyan.shade50,
          ),
        ),
      ),
    );
  }

  /// TYPING DOT
  Widget dot() {
    return Container(
      height: 10,
      width: 10,
      decoration: const BoxDecoration(
        color: Color(0xff00FFD1),
        shape: BoxShape.circle,
      ),
    );
  }

  /// NAVIGATION ICON
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
                  color: Colors.cyanAccent.withOpacity(0.2),
                  blurRadius: 18,
                ),
              ]
            : [],
      ),

      child: Icon(
        icon,
        size: 30,
        color: active ? const Color(0xffA7EAFF) : Colors.white.withOpacity(0.5),
      ),
    );
  }

  void getNotes() async {
    allNotes = await _dbConnection!.getExp();
    setState(() {});
  }
}
