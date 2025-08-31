import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageCtrl = PageController();
  int _current = 0;

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    if (!_pageCtrl.hasClients) return;
    final total = _pages.length;
    index = index.clamp(0, total - 1);
    _pageCtrl.animateToPage(
      index,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  // สไลด์พร้อมรูปทางขวา
  final List<Widget> _pages = const [
    _Slide(
      title: 'Doctor Octopus',
      body:
          'Doc Ock หรือ Doctor Octopus (ดอกเตอร์ ออคโตปุส) เป็นตัวละครวายร้ายจาก Marvel Comics ซึ่งมีชื่อจริงว่า ดร. อ็อตโต้ ออคตาเวียส (Dr. Otto Octavius) เขาเป็นนักวิทยาศาสตร์อัจฉริยะที่มีหนวดกลสี่ข้างติดอยู่กับหลังและสามารถควบคุมได้ด้วยความคิด ซึ่งทำให้เขามีความสามารถในการยกของหนัก ปีนป่าย และต่อสู้กับศัตรูอย่างสไปเดอร์แมน.' ,
      imagePath: 'lib/images/Dr._Octopus_Marvel.jpg',
    ),
    _Slide(
      title: 'Sandman',
      body:
          'แซนด์แมน (Sandman) คือฟลินท์ มาร์โค (Flint Marko) หรือ วิลเลียม เบเกอร์ (William Baker) เป็นวายร้ายในจักรวาลมาร์เวล (Marvel) ที่มีความสามารถในการเปลี่ยนร่างกายให้กลายเป็นทรายและควบคุมทรายได้ เขาเป็นศัตรูตัวฉกาจของสไปเดอร์-แมน โดยมีประวัติเริ่มแรกจากการเป็นอาชญากรรมที่บังเอิญได้รับพลังจากเครื่องเร่งอนุภาค อย่างไรก็ตาม ในเวลาต่อมา ฟลินท์ได้กลายเป็นตัวละครที่ซับซ้อนมากขึ้น โดยมีความลังเลระหว่างความเป็นวายร้ายและฮีโร่ (antihero) ',
      imagePath: 'lib/images/sandman.jpg',
    ),
    _Slide(
      title: 'Venom',
      body:
          'เอดดี้ บร็อค รวมร่างกับซิมไบโอต ทำให้มีพลังคล้ายสไปเดอร์แมนแต่รุนแรงกว่า '
          'เกลียดปีเตอร์ ปาร์คเกอร์เป็นการส่วนตัว',
      imagePath: 'lib/images/venom.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const double cardMaxWidth = 1000;
    const double panelHeight = 420; // ความสูงพื้นที่สไลด์ (ปรับได้)

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // พื้นหลังรูปเต็มจอ
          Image.asset(
            'lib/images/spider-man.jpg',
            fit: BoxFit.cover,
          ),

          // กล่องกลางที่ไม่เต็มหน้า + หัวข้อใหญ่ + สไลด์แนวนอน
          SafeArea(
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.9, // กว้าง 90% ของจอ
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: cardMaxWidth),
                  child: Container(
                    padding: const EdgeInsets.all(20),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ==== หัวข้อใหญ่ ====
                        Text(
                          'SPIDER-MAN ENEMIES',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            height: 1.2,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.black.withOpacity(0.95),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(height: 2, color: Colors.black12),
                        const SizedBox(height: 16),

                        // ==== พื้นที่สไลด์ + ปุ่มลูกศรซ้อนทับ ====
                        SizedBox(
                          height: panelHeight,
                          child: Stack(
                            children: [
                              // PageView แนวนอน
                              PageView.builder(
                                controller: _pageCtrl,
                                itemCount: _pages.length,
                                onPageChanged: (i) {
                                  setState(() => _current = i);
                                },
                                itemBuilder: (_, i) => _pages[i],
                              ),

                              // ปุ่มลูกศรซ้าย
                              Positioned(
                                left: 0,
                                top: 0,
                                bottom: 0,
                                child: Center(
                                  child: _ArrowButton(
                                    icon: Icons.chevron_left,
                                    onTap: () => _goTo(_current - 1),
                                    enabled: _current > 0,
                                  ),
                                ),
                              ),

                              // ปุ่มลูกศรขวา
                              Positioned(
                                right: 0,
                                top: 0,
                                bottom: 0,
                                child: Center(
                                  child: _ArrowButton(
                                    icon: Icons.chevron_right,
                                    onTap: () => _goTo(_current + 1),
                                    enabled: _current < _pages.length - 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14),

                        // จุดบอกตำแหน่งสไลด์
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(_pages.length, (i) {
                            final active = i == _current;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: active ? 18 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: active ? Colors.black87 : Colors.black26,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          }),
                        ),
                      ],
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

// --------------------------- Widgets ย่อย ---------------------------

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({
    required this.icon,
    required this.onTap,
    this.enabled = true,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.35,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, size: 28),
        ),
      ),
    );
  }
}

/// สไลด์ที่รองรับ “รูปอยู่ทางขวา”
/// - จอกว้าง (>= 640) จะวางข้อความซ้าย + รูปขวา
/// - จอแคบ จะวางเป็นแนวตั้ง (ข้อความก่อน รูปตาม)
class _Slide extends StatelessWidget {
  const _Slide({
    required this.title,
    required this.body,
    this.imagePath,
  });

  final String title;
  final String body;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            border: Border.all(color: Colors.black12),
          ),
          child: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: LayoutBuilder(
                builder: (context, c) {
                  final isWide = c.maxWidth >= 640;
                  final textBlock = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        body,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(height: 1.4),
                      ),
                    ],
                  );

                  final imageWidget = (imagePath == null)
                      ? const SizedBox.shrink()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AspectRatio(
                            aspectRatio: 5 / 6, // สัดส่วนภาพ
                            child: Image.asset(
                              imagePath!,
                             
                            ),
                          ),
                        );

                  if (imagePath != null && isWide) {
                    // วางข้อความซ้าย + รูปขวา
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ข้อความกินพื้นที่มากกว่า
                        Expanded(flex: 3, child: textBlock),
                        const SizedBox(width: 16),
                        // รูปจำกัดความกว้าง
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 180,
                            maxWidth: 320,
                          ),
                          child: imageWidget,
                        ),
                      ],
                    );
                  }

                  // จอแคบหรือไม่มีรูป -> แนวตั้ง
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textBlock,
                      if (imagePath != null) ...[
                        const SizedBox(height: 12),
                        imageWidget,
                      ],
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
