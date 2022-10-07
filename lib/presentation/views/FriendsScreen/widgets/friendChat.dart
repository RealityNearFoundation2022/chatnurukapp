import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/views/chatRoomScreen/chatRoomScreen.dart';

class ChatCard extends StatelessWidget {
  final String uid;
  final String photo;
  final String name;
  final String message;
  final String time;
  final bool connect;
  const ChatCard(
      {Key key,
      this.uid,
      this.photo,
      this.name,
      this.message,
      this.time,
      this.connect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '/ChatSoonScreen');
        Navigator.pushNamed(context, ChatRoomScreen.routeName, arguments: {
          'contactId': uid,
          'name': name,
          'photo': photo,
          'empty': false
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Image.asset(
                    photo,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        color: connect ?? false ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: ScreenWH(context).width * 0.45,
                        child: Text(
                          message,
                          style: GoogleFonts.sourceSansPro(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        time,
                        style: GoogleFonts.sourceSansPro(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
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
