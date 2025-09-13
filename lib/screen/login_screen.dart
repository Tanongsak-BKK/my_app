import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:my_app/screen/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;
  bool _remember = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _restoreRemembered();
  }

  Future<void> _restoreRemembered() async {
    final prefs = await SharedPreferences.getInstance();
    final remembered = prefs.getBool('remember_me') ?? false;
    if (remembered) {
      _userCtrl.text = prefs.getString('remember_user') ?? '';
      _remember = true;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  // --- ฟังก์ชันเดโม่ล็อกอิน: จำลอง API 1.2 วินาที ---
  Future<bool> _fakeAuth(String user, String pass) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    // เงื่อนไขเดโม่: user = test, pass = 123456 หรืออีเมลที่ดูสมเหตุผล
    final emailLike = RegExp(r'^\S+@\S+\.\S+$').hasMatch(user);
    if ((user == 'test' && pass == '123456') || (emailLike && pass.length >= 6)) {
      return true;
    }
    return false;
  }

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    final ok = await _fakeAuth(_userCtrl.text.trim(), _passCtrl.text);

    // บันทึก remember me
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('remember_me', _remember);
    if (_remember) {
      await prefs.setString('remember_user', _userCtrl.text.trim());
    } else {
      await prefs.remove('remember_user');
    }

    setState(() => _loading = false);

    if (ok) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login สำเร็จ!')),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('บัญชีผู้ใช้หรือรหัสผ่านไม่ถูกต้อง')),
      );
    }
  }

  void _onForgot() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('ลิงก์ลืมรหัสผ่าน (เดโม่)')),
    );
  }

  void _onSocial(String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('เข้าสู่ระบบด้วย $provider (เดโม่)')),
    );
  }

@override
Widget build(BuildContext context) {
  final gradient = const LinearGradient(
    colors: [Color.fromARGB(255, 153, 8, 8), Color.fromARGB(255, 6, 29, 131)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  return Scaffold(
    body: Stack(
      fit: StackFit.expand,
      children: [
        // พื้นหลังรูป
        Image.asset('lib/images/backonboarding.jpg', fit: BoxFit.cover),

        // Overlay ให้คอนเทนต์ชัดขึ้น
        Container(color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.15)),

        // เนื้อหา
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 36),
          child: Column(
            children: [

              // ---- โลโก้ ----
              const SizedBox(height: 50),
              // ---- กล่องครอบฟอร์ม ----
              FormBox(
                // ปรับได้: maxWidth, padding, borderRadius
                maxWidth: 480,
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    // โลโก้
                    const _BrandLogo(),
                    const SizedBox(height: 20),

                    // Title (ถ้าอยาก)
                    const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 146, 5, 5),
                    ),
                  ),
                ),
                    const SizedBox(height: 20),

                    // ฟอร์ม
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _userCtrl,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: 'Email / Phone Number',
                              prefixIcon: Icon(Icons.email_outlined),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (v) {
                              final value = v?.trim() ?? '';
                              if (value.isEmpty) return 'กรุณากรอกอีเมลหรือเบอร์โทร';
                              if (value.contains('@')) {
                                final ok = RegExp(r'^\S+@\S+\.\S+$').hasMatch(value);
                                if (!ok) return 'รูปแบบอีเมลไม่ถูกต้อง';
                              } else {
                                final digits = value.replaceAll(RegExp(r'\D'), '');
                                if (digits.length < 8) return 'เบอร์โทรสั้นเกินไป';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _passCtrl,
                            obscureText: _obscure,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                tooltip: _obscure ? 'Show password' : 'Hide password',
                                onPressed: () => setState(() => _obscure = !_obscure),
                                icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (v) =>
                                (v ?? '').length < 6 ? 'รหัสผ่านอย่างน้อย 6 ตัวอักษร' : null,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(
                          value: _remember,
                          onChanged: (v) => setState(() => _remember = v ?? false),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        const Text('Remember me'),
                        const Spacer(),
                        TextButton(
                          onPressed: _onForgot,
                          child: const Text('Forget Password?'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _onLogin,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          disabledBackgroundColor: Colors.transparent,
                        ).merge(
                          ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                          ),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: gradient,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: _loading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.4,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Expanded(child: Divider(thickness: 1)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('Or Login with'),
                        ),
                        Expanded(child: Divider(thickness: 1)),
                      ],
                    ),
                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SocialIcon(icon: Icons.facebook, onTap: () => _onSocial('Facebook')),
                        const SizedBox(width: 12),
                        _SocialIcon(icon: Icons.camera_alt_outlined, onTap: () => _onSocial('Instagram')),
                        const SizedBox(width: 12),
                        _SocialIcon(icon: Icons.linked_camera_outlined, onTap: () => _onSocial('LinkedIn')),
                      ],
                    ),

                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const RegisterScreen()),
                            );
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: Color.fromARGB(255, 151, 7, 7),
                              fontWeight: FontWeight.w700,
                            ),
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
      ],
    ),
  );
}

}

class _BrandLogo extends StatelessWidget {
  const _BrandLogo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // วงกลมโลโก้แบบมินิมอลให้คล้ายภาพ
        Container(
          width: 120,
          height: 120,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            image: DecorationImage(image:   AssetImage('lib/images/logo.jpg'), fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _SocialIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE6E6E6)),
          boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Icon(icon, size: 26, color: const Color(0xFF3B3B3B)),
      ),
    );
  }
}

class FormBox extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double maxWidth;
  final double borderRadius;
  final double elevationOpacity;

  const FormBox({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.maxWidth = 480,
    this.borderRadius = 20,
    this.elevationOpacity = 0.12, // ความจางของเงา
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.92),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: const Color(0x1F000000)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(elevationOpacity),
                blurRadius: 22,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}


// หน้า Home หลังล็อกอิน (เดโม่)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color(0xFFFF5B7E),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('ยินดีต้อนรับเข้าสู่แอป Coffee ☕'),
      ),
    );
  }
}
