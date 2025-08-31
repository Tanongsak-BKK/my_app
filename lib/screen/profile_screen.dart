import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // พื้นหลัง
          Positioned.fill(
            child: Image.asset(
              'lib/images/spider-man.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // กล่องโปรไฟล์กลาง
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: FractionallySizedBox(
                  widthFactor: 0.92,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: _ProfileCard(),
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

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1, // เหลือแท็บเดียว: About
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Avatar(),
            const SizedBox(height: 12),
            const Text(
              'Tanongsak Phetpila',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text('@b.bkkt', style: TextStyle(color: Colors.grey[600])),

            // ===== ไม่มีปุ่ม action และไม่มีแถวสถิติแล้ว =====

            const SizedBox(height: 12),
            const Divider(height: 1),

            const SizedBox(height: 8),
            const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black54,
              indicatorWeight: 2.5,
              tabs: [Tab(text: 'About')],
            ),
            const SizedBox(height: 8),

            SizedBox(
              height: 380,
              child: const TabBarView(children: [ _AboutTab() ]),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Sub Widgets ----------------

class _Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: CircleAvatar(
          radius: 42,
          // ถ้ามีรูป avatar ให้ใช้บรรทัดล่างแทน
           backgroundImage: AssetImage('lib/images/bkk.jpg'),
          backgroundColor: Colors.grey[200],
          //child: Icon(Icons.person, size: 42, color: Colors.grey[600]),
        ),
      ),
    );
  }
}

// About Tab (แท็บเดียวที่เหลือ)
class _AboutTab extends StatelessWidget {
  const _AboutTab();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        padding: const EdgeInsets.all(6),
        children: const [
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Bio'),
            subtitle: Text('Friendly neighborhood web-developer.'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.location_on_outlined),
            title: Text('Location'),
            subtitle: Text('Bangkok, Thailand'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.mail_outline),
            title: Text('Email'),
            subtitle: Text('jateva01@example.com'),
          ),
        ],
      ),
    );
  }
}
