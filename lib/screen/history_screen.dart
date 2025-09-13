import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  // เนื้อหายาว ใช้ triple quotes ป้องกัน error สตริงหลายบรรทัด
  static const String _longThai = '''
Peter Parker” เป็นเด็กกำพร้าพ่อเเม่ตั้งเเต่อายุได้ 6 ปี เพราะเหตุการณ์เครื่องบินตกที่พรากชีวิตพ่อเเม่ของเค้าไป ทำให้เค้าได้ใช้ชีวิตอยู่กับลุงเบนเเละป้าเมย์ในนิวยอร์ค ปีเตอร์เป็นเด็กหัวดีเเละมีความสามารถในการเรียนสูงจนจบการศึกษาในโรงเรียนมิดทาวน์
เเต่ชีวิตวัยรุ่นธรรมดาของเค้าต้องเปลี่ยนไปเมื่อได้เข้าร่วมงานนิทรรศการวิทยาศาสตร์ด้านนิวเคลียร์ที่จัดขึ้น เเละถูกเเมงมุมกัมมันตรังสีที่หลุดออกมากัด ทำให้เค้าค้นพบว่าเเมงมุมตัวนั้นได้มอบพลังเหนือมนุษย์ให้กับเค้า
หลังจากนั้นเขาได้พบหนทางทดสอบพลังที่เค้ามีด้วยการเป็นนักเเสดงมวยปล้ำ โดยปกปิดตัวตนเเละเรียกตัวเองว่า “Spider-Man” แต่แล้ววันหนึ่งก็ได้เกิดเหตุการณ์ไม่คาดฝันขึ้น เมื่อเขาได้พลาดการหยุดยั้งอาชญากรคนหนึ่งเนื่องจากเห็นว่าไม่ใช่ความรับผิดชอบของเค้า เป็นเหตุให้อาชญากรคนเดียวกันนั้นได้ทำร้ายลุงเบนจนเสียชีวิต เหตุการณ์ในครั้งนั้นทำให้เค้าเรียนรู้ว่า “พลังอันยิ่งใหญ่ที่เขาได้รับมานั้น มันจะต้องมาพร้อมกับความรับผิดชอบที่ยิ่งใหญ่” โดยการใช้พลังพิเศษที่เค้ามีปกป้องความสงบสุขของผู้คน
การจากไปของลุงเบนทำให้ปีเตอร์ต้องไปทำงานเป็นช่างถ่ายภาพให้กับสำนักหนังสือพิมพ์ “Daily Bugle” ของนาย เจ. โจนาห์ เจมสัน (J. Jonah Jameson) ที่ชื่นชอบในผลงานของปีเตอร์ เเต่เกลียดสไปเดอร์เเมนเข้าไส้
ต่อมาเค้าได้เข้าศึกษาต่อด้านวิทยาศาสตร์ที่มหาวิทยาลัย Empire State ได้พบกับเพื่อนใหม่อย่าง “Harry Osborn” รวมทั้ง “Flash Thompson” เพื่อนเก่าที่ชอบรังเเกเค้าในสมัยมัธยม เค้ามีความสัมพันธ์กับ “Gwen Stacy” เพื่อนในมหาวิทยาลัย ที่ภายหลังถูก “Green Goblin” โยนลงจากสะพานบรู๊คลิน เเล้วเสียชีวิตด้วยเเรงกระเเทกจากการที่สไปดี้ยิงใยไปรับทำให้คอหัก การสูญเสียดังกล่าวทำให้ “Mary Jane” เพื่อนของปีเตอร์ได้มีโอกาสใกล้ชิดกันจนก่อเกิดเป็นความรักครั้งใหม่
ในฐานะของสไปเดอร์เเมน เค้าได้เข้าร่วมเป็นสมาชิกของทีมอเวนเจอร์ รวมทั้งต่อสู้ร่วมกับเหล่าฮีโร่อีกมากมาย ในฐานะของปีเตอร์ ปาร์คเกอร์ หลังจากได้เป็นอาจารย์เมื่อเรียนจบระดับมหาวิทยาลัย เค้าได้เข้าทำงานเป็นนักวิทยาศาสตร์ใน “Horizon Laps” จากการฝากฝังของนาย เจ. โจนาห์ เจมสัน ที่ได้รับเลือกให้เป็นนายกเทศมนตรีของนิวยอร์ค
สไปเดอร์เเมนได้รับพลังมากมายมาจากเเมงมุมกัมมันตรังสี ทั้งความเเข็งเเกร่งเหนือมนุษย์ รวมทั้งพละกำลังมหาศาลที่ปกติเค้าใช้พละกำลังในการต่อสู้ไม่ถึงครึ่งด้วยซ้ำ เพราะสไปเดอร์เเมนมีกฏว่า “ไม่ฆ่า” ก่อนจะเพิ่มกฏใหม่เป็น “จะต้องไม่มีใครตายทั้งนั้นถ้ามีเค้าอยู่!” ทำให้เค้าต้องคอยเก็บพลังจริงๆเอาไว้
พละกำลังของสไปดี้นั้นสามารถยกรถบรรทุกได้สบายๆ ทั้งยังเคยต่อยทีเร็กซ์ใน “Savage Land” (ดินเเดนดึกดำบรรพ์) จนน็อคในหมัดเดียว! เค้าเคยพูดไว้ว่าเค้าสามารถน็อคคนธรรมดาด้วยการเอานิ้วเเตะไปหัวเท่านั้น นี่จึงเป็นเหตุให้เค้าต้องคอยควบคุมพลังตนเองเสมอ
นอกจากนี้ยังมีความสามารถอีกมากมาย ทั้งการยคดเกาะกับกำเเพงหรือสิ่งต่างๆได้อย่างเเมงมุม มีความเร็ว ความคล่องตัว รวมทั้งมีสัมผัสเเมงมุม (Spider-Sense) ที่คอยเตือนภัยเมื่อมีอันตรายเข้ามาใกล้ตัว
มีความสามารถในการฟื้นตัว (Healing Factor) ในระดับหนึ่ง กล่าวคือ เมื่อเค้าได้รับพลังมันทำให้สายเค้ากลับมาเป็นปกติ เลยไม่ต้องใส่เเว่นอีกต่อไป (สไปดี้เคยต่อสู้จนตาบอด เเต่หลังจากนั้น 2 วันสายตาก็กลับมาเป็นปกติ) สามารถรักษาอาการบาดเจ็บอย่างกระดูกหัก หรือเเผลฉีกขาดได้ด้วยตัวเอง
ในส่วนของใยเเมงมุมนั้นยิงออกมาจากอุปกรณ์ที่ปีเตอร์ประดิษฐ์ขึ้นเอง ซึ่สามารถยิงออกมาได้หลายเเบบทั้งใยหัวกระสุน หรือใยตาข่าย นอกจากนี้ปีเตอร์ยังมีความเป็นอัจฉริยะอีกด้วย เค้ามีไอคิว 250 เก่งขนาดเเฮ็คเทคโนโลยีของโทนี่ สตาร์คได้ เชี่ยวชาญในวิทยาศาสตร์ เอาจัวรอดเก่ง มีความชำนาญในการถ่ายรูป ที่สำคัญคือมีพลังใจที่ไม่เคยหมด ทำให้เค้าสามารถต่อสู้กับทุกอุปสรรคในชีวิตได้
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // พื้นหลังรูป
          Positioned.fill(
            child: Image.asset('lib/images/backonboarding.jpg', fit: BoxFit.cover),
          ),
          // ไล่เฉด + เบลอให้อ่านง่าย
         
        
          // เนื้อหา
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final firstCard = _newsCard(
                        title: 'Spider-Man History',
                        imagePath: '', // Pass empty string to indicate no image
                        body: _longThai,
                      );

                      final secondCard = Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.92),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                'Spider-Man History',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'lib/images/model.jpg',
                                  width: 500,
                                  height: 730,
                                 
                                ),
                              ),
                            ],
                          ),
                        ),
                      );

                      if (constraints.maxWidth < 600) {
                        // 1 คอลัมน์ (จอเล็ก)
                        return Column(
                          children: [
                            firstCard,
                            const SizedBox(height: 16),
                            secondCard,
                          ],
                        );
                      } else {
                        // 2 คอลัมน์ (จอกว้าง)
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: firstCard),
                            const SizedBox(width: 16),
                            Expanded(child: secondCard),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // การ์ดข่าวแบบ reuse
  Widget _newsCard({
    required String title,
    required String imagePath,
    required String body,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 12),
            if (imagePath.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                ),
              ),
            if (imagePath.isNotEmpty) const SizedBox(height: 12),
            Text(
              body,
              style: const TextStyle(
                fontSize: 15,
                height: 1.4,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
