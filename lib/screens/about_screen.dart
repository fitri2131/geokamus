// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/abouts.dart';
import '../widgets/card_item.dart';
import '../widgets/icon_with_text_item.dart';

class AboutScreen extends StatefulWidget {
  static const name = 'Tentang';
  static const routeName = '/about';
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Abouts>(context).initialData();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://zdni.github.io/geokamus/aho.html');
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Gagal membuka browser';
    }
  }

  @override
  Widget build(BuildContext context) {
    final aboutProvider = Provider.of<Abouts>(context);
    return Scaffold(
      body: (aboutProvider.totalAbout == 0)
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(8, 129, 163, 1.0),
              ),
            )
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          margin: const EdgeInsets.only(left: 25.0),
                          width: 35,
                          height: 35,
                          child: const Icon(Icons.chevron_left),
                        ),
                      ),
                      Text(
                        'Tentang Aplikasi',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: const Icon(Icons.info_outline),
                      ),
                    ],
                  ),
                  Expanded(flex: 1, child: Container(height: 100)),
                  Row(
                    children: [
                      const SizedBox(width: 25),
                      Text(
                        'Apa itu aplikasi ${aboutProvider.allAbout[0].application}',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CardItem(
                    Colors.white,
                    Text(
                      aboutProvider.allAbout[0].description,
                      style: GoogleFonts.getFont('Poppins'),
                    ),
                    const Color.fromRGBO(8, 129, 163, 0.2),
                  ),
                  Expanded(flex: 1, child: Container(height: 100)),
                  Row(
                    children: [
                      const SizedBox(width: 25),
                      Text(
                        'Developer',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CardItem(
                    Colors.white,
                    Column(
                      children: [
                        IconWithTextItem(
                          Colors.black,
                          Icons.account_circle,
                          aboutProvider.allAbout[0].developer,
                        ),
                        const SizedBox(height: 8),
                        IconWithTextItem(
                          Colors.black,
                          Icons.school_rounded,
                          aboutProvider.allAbout[0].college,
                        ),
                        const SizedBox(height: 8),
                        IconWithTextItem(
                          Colors.black,
                          Icons.code,
                          aboutProvider.allAbout[0].stamp,
                        ),
                        const SizedBox(height: 8),
                        IconWithTextItem(
                          Colors.black,
                          Icons.email,
                          aboutProvider.allAbout[0].email,
                        ),
                      ],
                    ),
                    const Color.fromRGBO(8, 129, 163, 0.2),
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: InkWell(
                      onTap: _launchUrl,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(8, 129, 163, 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        child: Text(
                          'Pelajari Algoritma Aho-Corasick lebih lanjut.',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: Container(height: 100)),
                ],
              ),
            ),
    );
  }
}
