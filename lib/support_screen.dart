import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  // Function to open bKash
  void openBkashApp(BuildContext context) async {
    const url = 'https://bkash.com';
    const fallbackUrl = 'https://play.google.com/store/apps/details?id=com.bKash.customerapp'; // bKash app on Play Store

    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else if (await canLaunch(fallbackUrl)) {
        await launch(fallbackUrl);
      } else {
        throw 'Could not launch $url or $fallbackUrl';
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open bKash. Please install the bKash app.'),
        ),
      );
    }
  }

  // Function to open Buy Me a Coffee
  void openDonationLink(BuildContext context) async {
    const url = 'https://buymeacoffee.com/yourusername';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open the donation page. Please install a browser.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Support Us"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade800, Colors.purple.shade800],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header Text
                Text(
                  "Support Our App",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Your support helps us improve and grow!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),

                // bKash Card
                _buildPaymentCard(
                  icon: Icons.account_balance_wallet,
                  title: "Support via bKash",
                  subtitle: "Send support via bKash: 01XXX-XXXXXX",
                  onTap: () => openBkashApp(context),
                  color: Colors.green.shade600,
                ),
                SizedBox(height: 20),

                // Buy Me a Coffee Card
                _buildPaymentCard(
                  icon: Icons.coffee,
                  title: "Support Internationally",
                  subtitle: "Credit Card, PayPal, and more",
                  onTap: () => openDonationLink(context),
                  color: Colors.orange.shade600,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable Payment Card Widget
  Widget _buildPaymentCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.5), width: 1),
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white70),
          ],
        ),
      ),
    );
  }
}