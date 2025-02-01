import 'package:charge_me/ui/widgets/profile_item.dart';
import 'package:flutter/material.dart';

import '../../core/const/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: const Text('Профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.network(
                        'https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        height: 60,
                        width: 60,
                        errorBuilder: (x, y, z) {
                          return CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/images/user.png'),
                          );
                        },
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Имя Фамилия',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '+998 99 123 45 57',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Image.asset('assets/icons/pen.png', height: 20, width: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(12)),
              child: profileItem(
                  'assets/icons/wallet.png',
                  'Кошелек',
                  Text('247 700 000 сум',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: grey))),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  profileItem(
                    'assets/icons/settings.png',
                    'Настройки',
                    Icon(Icons.chevron_right, color: grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 58.0),
                    child: Divider(
                      color: divider.withOpacity(0.5),
                    ),
                  ),
                  profileItem(
                    'assets/icons/feedback.png',
                    'Служба поддержки',
                    Icon(Icons.chevron_right, color: grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 58.0),
                    child: Divider(
                      color: divider.withOpacity(0.5),
                    ),
                  ),
                  profileItem(
                    'assets/icons/file.png',
                    'Условия использования',
                    Icon(Icons.chevron_right, color: grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 58.0),
                    child: Divider(
                      color: divider.withOpacity(0.5),
                    ),
                  ),
                  profileItem(
                    'assets/icons/info.png',
                    'О нас',
                    Icon(Icons.chevron_right, color: grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(12)),
              child: profileItem('assets/icons/logout.png', 'Выйти из аккаунта',
                  Icon(Icons.chevron_right, color: grey),
                  textColor: red),
            ),
          ],
        ),
      ),
    );
  }
}
