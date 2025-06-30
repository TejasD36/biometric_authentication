import '../../../core.dart';
import '../../login/view/login_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.grey, Color.fromARGB(255, 29, 221, 163)])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBar(
              title: Text("Home View", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              backgroundColor: Colors.transparent,
              centerTitle: true,
            ),
            SizedBox(height: 30),
            Lottie.asset(Assets.assetsHome, animate: true, width: 300, repeat: true, fit: BoxFit.contain),

            Spacer(),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () async {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginView()));
                },
                child: Text("Logout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
