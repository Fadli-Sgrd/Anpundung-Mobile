import 'package:flutter/material.dart';

/// Header Section dengan gradient (dari home_screen)
class HeaderSection extends StatelessWidget {
  final String greeting;
  final String userName;
  final String userImageUrl;
  final Widget? bottomWidget;

  const HeaderSection({
    super.key,
    required this.greeting,
    required this.userName,
    required this.userImageUrl,
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 60, 25, 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF163172), Color(0xFF1E56A0)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x40163172),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greeting,
                    style: const TextStyle(
                      color: Color(0xFFD6E4F0),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              // Avatar dengan border putih tipis
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(userImageUrl),
                ),
              ),
            ],
          ),
          if (bottomWidget != null) ...[
            const SizedBox(height: 30),
            bottomWidget!,
          ],
        ],
      ),
    );
  }
}
