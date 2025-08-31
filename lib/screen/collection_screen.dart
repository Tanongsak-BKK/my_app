import 'package:flutter/material.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ใส่พาธรูปของคุณที่นี่
    final List<String> imagePaths = [
      'lib/images/spiderman1.jpg',
      'lib/images/spiderman2.jpg',
      'lib/images/spiderman3.jpg',
      // เพิ่มได้ตามต้องการ
    ];

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // พื้นหลังเดิม
          Positioned.fill(
            child: Image.asset(
              'lib/images/spider-man.jpg', // พาธภาพพื้นหลัง
              fit: BoxFit.cover,
            ),
          ),

          // กล่องกลางไม่เต็มหน้า + Grid 3 คอลัมน์
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: FractionallySizedBox(
                  widthFactor: 0.92, // กว้าง ~92% ของจอ
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.88),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Collection',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Grid 3 คอลัมน์ (ใส่ภาพ)
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, // 3 คอลัมน์
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1, // สี่เหลี่ยมจัตุรัส
                            ),
                            itemCount: imagePaths.length,
                            itemBuilder: (context, index) {
                              final path = imagePaths[index];
                              return _ImageTile(path: path);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageTile extends StatelessWidget {
  const _ImageTile({required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ✨ บังคับให้รูป “เต็มช่อง” จริง ๆ
          Positioned.fill(
            child: Image.asset(
              path,
             // ปรับเป็น BoxFit.contain ถ้าอยากไม่ให้รูปถูกครอป
            ),
          ),

          // เงาบาง ๆ ที่ขอบล่าง เผื่อวางตัวหนังสือภายหลัง
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 26,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black26],
                ),
              ),
            ),
          ),

          // แตะได้ (อนาคตจะเปิดดูภาพเต็ม/รายละเอียด)
          
        ],
      ),
    );
  }
}
