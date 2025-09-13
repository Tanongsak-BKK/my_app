import 'package:flutter/material.dart';
import 'package:my_app/screen/home_screen.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _obscure1 = true;
  bool _obscure2 = true;
  bool _agree = false;
  bool _loading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _onRegister() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณายอมรับเงื่อนไขการใช้งาน')),
      );
      return;
    }

    setState(() => _loading = true);
    // เดโม่: หน่วงเวลาแทนการเรียก API
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() => _loading = false);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('สร้างบัญชีสำเร็จ!')),
    );

    // ไปหน้า Home หรือจะ pop กลับไป Login ก็ได้
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  String? _validateEmailOrPhone(String? v) {
    final value = v?.trim() ?? '';
    if (value.isEmpty) return 'กรอกอีเมลหรือเบอร์โทร';
    if (value.contains('@')) {
      final ok = RegExp(r'^\S+@\S+\.\S+$').hasMatch(value);
      if (!ok) return 'รูปแบบอีเมลไม่ถูกต้อง';
    } else {
      final digits = value.replaceAll(RegExp(r'\D'), '');
      if (digits.length < 8) return 'เบอร์โทรสั้นเกินไป';
    }
    return null;
  }

  String? _validatePassword(String? v) {
    final value = v ?? '';
    if (value.length < 6) return 'รหัสผ่านอย่างน้อย 6 ตัวอักษร';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final gradient = const LinearGradient(
      colors: [Color.fromARGB(255, 153, 8, 8), Color.fromARGB(255, 6, 29, 131)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _BrandLogo(),
                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Create account",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 141, 4, 4),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameCtrl,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'Full name',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator: (v) =>
                            (v == null || v.trim().length < 2) ? 'กรอกชื่อให้ถูกต้อง' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'Email / Phone Number',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: _validateEmailOrPhone,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passCtrl,
                        obscureText: _obscure1,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            tooltip: _obscure1 ? 'Show password' : 'Hide password',
                            onPressed: () => setState(() => _obscure1 = !_obscure1),
                            // แสดง "สถานะปัจจุบัน"
                            icon: Icon(_obscure1 ? Icons.visibility_off : Icons.visibility),
                          ),
                        ),
                        validator: _validatePassword,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _confirmCtrl,
                        obscureText: _obscure2,
                        decoration: InputDecoration(
                          hintText: 'Confirm password',
                          prefixIcon: const Icon(Icons.lock_reset_outlined),
                          suffixIcon: IconButton(
                            tooltip: _obscure2 ? 'Show password' : 'Hide password',
                            onPressed: () => setState(() => _obscure2 = !_obscure2),
                            icon: Icon(_obscure2 ? Icons.visibility_off : Icons.visibility),
                          ),
                        ),
                        validator: (v) {
                          if (v != _passCtrl.text) return 'รหัสผ่านไม่ตรงกัน';
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: _agree,
                      onChanged: (v) => setState(() => _agree = v ?? false),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    const Expanded(
                      child: Text(
                        'ฉันยอมรับเงื่อนไขการใช้งานและนโยบายความเป็นส่วนตัว',
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _onRegister,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      disabledBackgroundColor: Colors.transparent,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: gradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: _loading
                            ? const SizedBox(
                                width: 22, height: 22,
                                child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white),
                              )
                            : const Text(
                                'Create Account',
                                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
                              ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),
                const Row(
                  children: [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Or Sign up with'),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialIcon(icon: Icons.facebook, onTap: () {}),
                    const SizedBox(width: 12),
                    _SocialIcon(icon: Icons.camera_alt_outlined, onTap: () {}),
                    const SizedBox(width: 12),
                    _SocialIcon(icon: Icons.linked_camera_outlined, onTap: () {}),
                  ],
                ),

                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? '),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(), // กลับไป Login
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Color.fromARGB(255, 148, 0, 0), fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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