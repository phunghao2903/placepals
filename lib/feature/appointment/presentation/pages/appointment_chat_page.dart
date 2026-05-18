import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/appointment_chat_message.dart';
import '../../domain/entities/appointment_feed.dart';

class AppointmentChatPage extends StatelessWidget {
  final List<AppointmentInvitee> invitees;
  final String placeName;

  const AppointmentChatPage({
    super.key,
    required this.invitees,
    this.placeName = 'Salmon Sushi Bar',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Row(
                children: <Widget>[
                  InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => Navigator.of(context).pop(),
                    child: const SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          placeName,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF2D2D2D),
                          ),
                        ),
                        Text(
                          'Group Hangout',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFD0C2BB),
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          height: 28,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                invitees.where((e) => e.isSelected).length + 1,
                            separatorBuilder: (_, _) =>
                                const SizedBox(width: 4),
                            itemBuilder: (context, index) {
                              final selected = invitees
                                  .where((e) => e.isSelected)
                                  .toList();
                              if (index < selected.length) {
                                final invitee = selected[index];
                                return CircleAvatar(
                                  radius: 14,
                                  backgroundImage: invitee.hasAvatar
                                      ? (invitee.usesNetworkAvatar
                                                ? NetworkImage(
                                                    invitee.avatarAssetPath,
                                                  )
                                                : AssetImage(
                                                    invitee.avatarAssetPath,
                                                  ))
                                            as ImageProvider
                                      : null,
                                  child: !invitee.hasAvatar
                                      ? Text(invitee.name.characters.first)
                                      : null,
                                );
                              }
                              return Text(
                                '+ You',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFD0C2BB),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFFFF6B5A),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFF1E7E2)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F4F7),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Today',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4D556B),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ..._messages.map(_ChatMessageBubble.new),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: <Widget>[
                  _RoundControl(icon: Icons.add_rounded, onTap: () {}),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: const Color(0xFFEDE3DE)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Type a message...',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFB8AAA3),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.sentiment_satisfied_alt_outlined,
                            color: Color(0xFFB8AAA3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _RoundControl(
                    icon: Icons.send_rounded,
                    color: const Color(0xFFFF6B5A),
                    iconColor: Colors.white,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessageBubble extends StatelessWidget {
  final AppointmentChatMessage message;

  const _ChatMessageBubble(this.message);

  @override
  Widget build(BuildContext context) {
    final align = message.isMine
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    final bubbleColor = message.isMine
        ? const Color(0xFFFF7D71)
        : const Color(0xFFF1F4F7);

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: align,
        children: <Widget>[
          if (!message.isMine)
            Padding(
              padding: const EdgeInsets.only(left: 40, bottom: 6),
              child: Text(
                message.senderName,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF8F817B),
                ),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: message.isMine
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: <Widget>[
              if (!message.isMine) ...<Widget>[
                CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage(message.senderAvatarAssetPath),
                ),
                const SizedBox(width: 10),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: bubbleColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    message.message,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: message.isMine
                          ? Colors.white
                          : const Color(0xFF2D2D2D),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (message.metaLabel != null)
            Padding(
              padding: EdgeInsets.only(
                top: 4,
                left: message.isMine ? 0 : 40,
                right: message.isMine ? 8 : 0,
              ),
              child: Text(
                message.metaLabel!,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFB8AAA3),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RoundControl extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  final Color iconColor;

  const _RoundControl({
    required this.icon,
    required this.onTap,
    this.color = const Color(0xFFF7F1EF),
    this.iconColor = const Color(0xFFAA9B95),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, color: iconColor),
        ),
      ),
    );
  }
}

const List<AppointmentChatMessage> _messages = <AppointmentChatMessage>[
  AppointmentChatMessage(
    id: '1',
    senderName: 'Sarah',
    senderAvatarAssetPath: 'assets/images/profile.jpg',
    message: 'Hey everyone! super excited for sushi tonight! 🍣',
    isMine: false,
  ),
  AppointmentChatMessage(
    id: '2',
    senderName: 'You',
    senderAvatarAssetPath: '',
    message: 'Me too! I\'ve been craving their spicy salmon rolls all week. 😋',
    isMine: true,
    metaLabel: 'Read 4:21 PM',
  ),
  AppointmentChatMessage(
    id: '3',
    senderName: 'Mike',
    senderAvatarAssetPath: 'assets/images/bean_bloom.png',
    message: 'I\'m running about 5 mins late, traffic is crazy on 4th Ave.',
    isMine: false,
  ),
  AppointmentChatMessage(
    id: '4',
    senderName: 'Jenny',
    senderAvatarAssetPath: 'assets/images/cafe_tan.png',
    message: 'No worries Mike! We can grab a table first.',
    isMine: false,
  ),
  AppointmentChatMessage(
    id: '5',
    senderName: 'Jenny',
    senderAvatarAssetPath: 'assets/images/cafe_tan.png',
    message: 'Shall we order appetizers?',
    isMine: false,
  ),
  AppointmentChatMessage(
    id: '6',
    senderName: 'You',
    senderAvatarAssetPath: '',
    message: 'Yes! Edamame and Gyoza please! 🥟',
    isMine: true,
    metaLabel: 'Delivered',
  ),
];
