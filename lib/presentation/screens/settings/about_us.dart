import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "About Auragram",
              style: TextStyle(fontSize: 30),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("""
Welcome to Auragram, your premier social media platform designed for seamless user interaction and socializing. Created by Sreeraj CR in 2024, Auragram offers a feature-rich experience while prioritizing the security and privacy of your data.

Key Features:

•User Interaction: Connect with friends, family, and colleagues through Auragram's intuitive interface, fostering meaningful interactions and relationships.

•Socializing: Explore a vibrant community of users sharing their experiences, interests, and passions. From photos and videos to status updates and stories, Auragram lets you express yourself freely.

•Privacy and Security: Rest assured that your data is safe with us. Auragram is committed to protecting your privacy and ensures that any sensitive information collected is securely stored and never shared with third parties.

•Customizable Profiles: Personalize your profile with photos, bios, and other details to showcase your personality and interests. Tailor your experience to reflect who you are and what you love.

•Regular Updates: We're constantly improving Auragram to provide you with the best possible experience. Look forward to regular updates and enhancements that keep our platform fresh and exciting.


•Why Choose Auragram?

•Community-Centric: Join a diverse community of users from around the world who share your interests and values. Discover new connections and forge lasting friendships on Auragram.


•Seamless Experience: Whether you're browsing from your computer or on the go with your mobile device, Auragram offers a seamless experience across all platforms. Stay connected wherever you are.

•Creator Commitment: Sreeraj CR, the creator of Auragram, is dedicated to delivering a top-notch social media experience. With a passion for innovation and user satisfaction, Auragram continues to evolve to meet your needs.

•Get Started Today!

•Download Auragram now and immerse yourself in a world of connection, creativity, and community. Join millions of users who have made Auragram their go-to social media platform and experience the difference for yourself."""),
            )
          ],
        ),
      ),
    );
  }
}
