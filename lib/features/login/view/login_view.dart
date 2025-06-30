import '../../../core.dart';
import '../../home/view/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final biometricService = BiometricService.instance;
  final secureStorage = SecureStorageService.instance;
  final _formKey = GlobalKey<FormState>();
  bool? isBiometricSupported;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      isBiometricSupported = await biometricService.isDeviceSupported();
      // String? token = await secureStorage.read<String>('authToken');
      // if (token != null) {
      //   attemptBiometricLogin();
      // }
    });
  }

  Future<void> attemptBiometricLogin() async {
    bool success = await biometricService.authenticateWithBiometrics();

    if (success) {
      String? token = await secureStorage.read<String>('authToken');
      if (token != null) {
        if (context.mounted) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeView()));
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No token found. Please log in manually.')));
        }
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Biometric authentication failed.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.grey, Color.fromARGB(255, 29, 221, 163)])),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: IntrinsicHeight(
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(Assets.assetsLock, animate: true, width: 200, height: 200, repeat: true, fit: BoxFit.contain),
                    TextFormField(
                      controller: mobileNumberController,
                      decoration: InputDecoration(hintText: "Mobile Number", counterText: ''),
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter mobile number";
                        } else if (value.length != 10) {
                          return "Please enter valid mobile number";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(hintText: "Password"),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter password";
                        } else if (value.length < 8) {
                          return "Password must be at least 8 characters";
                        } else if (!value.contains(RegExp(r'[A-Z]'))) {
                          return "Password must contain at least one uppercase letter";
                        } else if (!value.contains(RegExp(r'[a-z]'))) {
                          return "Password must contain at least one lowercase letter";
                        } else if (!value.contains(RegExp(r'[0-9]'))) {
                          return "Password must contain at least one number";
                        }
                        return null;
                      },
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Lottie.asset(
                                        Assets.assetsSuccess,
                                        animate: true,
                                        width: 200,
                                        height: 200,
                                        repeat: false,
                                        fit: BoxFit.contain,
                                      ),
                                      Text("Login Successful", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                      Text(
                                        "You have successfully logged in.",
                                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                            await secureStorage.write('authToken', '1234567890');
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeView()));
                          }
                        },
                        child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Use Biometric?", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                        Material(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          clipBehavior: Clip.antiAlias,
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              if (isBiometricSupported == true) {
                                await attemptBiometricLogin();
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Column(
                                        children: [
                                          Lottie.asset(
                                            Assets.assetsBiometricFailed,
                                            animate: true,
                                            width: 200,
                                            height: 200,
                                            repeat: false,
                                            fit: BoxFit.contain,
                                          ),
                                          Text("Biometric not supported"),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            onLongPress: () {},
                            child: Lottie.asset(
                              Assets.assetsBiometric,
                              animate: true,
                              width: 150,
                              height: 150,
                              repeat: true,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
