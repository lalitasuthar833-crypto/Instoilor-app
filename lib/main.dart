import 'package:flutter/material.dart';

void main() {
  runApp(const InstoilorApp());
}

class InstoilorApp extends StatefulWidget {
  const InstoilorApp({super.key});

  @override
  State<InstoilorApp> createState() => _InstoilorAppState();
}

class _InstoilorAppState extends State<InstoilorApp> {
  Color _accentColor = Colors.purpleAccent;

  void _updateAccentColor(Color newColor) {
    setState(() {
      _accentColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instoilor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: _accentColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
        ),
      ),
      home: MainNavigationScreen(
        accentColor: _accentColor,
        onColorChanged: _updateAccentColor,
      ),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  final Color accentColor;
  final Function(Color) onColorChanged;

  const MainNavigationScreen({
    super.key,
    required this.accentColor,
    required this.onColorChanged,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(accentColor: widget.accentColor),
      GhostModeScreen(accentColor: widget.accentColor),
      VaultScreen(accentColor: widget.accentColor),
      ProfileScreen(
        accentColor: widget.accentColor,
        onColorChanged: widget.onColorChanged,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: widget.accentColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF1E1E1E),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.security), label: 'Ghost'),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'Vault'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Color accentColor;
  const HomeScreen({super.key, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Instoilor 🚀',
          style: TextStyle(color: accentColor, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xFF1E1E1E),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: accentColor,
                    child: Text('U$index', style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text('Instoilor_User_$index', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: const Text('Ghost Shield Active 👻', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
                Container(
                  height: 200,
                  color: Colors.black26,
                  child: Center(
                    child: Icon(Icons.security, size: 70, color: accentColor.withOpacity(0.7)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Icon(Icons.favorite, color: accentColor),
                      const SizedBox(width: 16),
                      const Icon(Icons.chat_bubble_outline, color: Colors.white),
                      const SizedBox(width: 16),
                      const Icon(Icons.send_outlined, color: Colors.white),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class GhostModeScreen extends StatefulWidget {
  final Color accentColor;
  const GhostModeScreen({super.key, required this.accentColor});

  @override
  State<GhostModeScreen> createState() => _GhostModeScreenState();
}

class _GhostModeScreenState extends State<GhostModeScreen> {
  bool _unseenStory = true;
  bool _unseenMessage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ghost Mode Settings 👻')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SwitchListTile(
              activeColor: widget.accentColor,
              title: const Text('Unseen Stories', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: const Text('Watch stories without view count', style: TextStyle(color: Colors.grey)),
              value: _unseenStory,
              onChanged: (val) => setState(() => _unseenStory = val),
            ),
            const Divider(color: Colors.grey),
            SwitchListTile(
              activeColor: widget.accentColor,
              title: const Text('Unseen DMs', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: const Text('Read messages without seen tag', style: TextStyle(color: Colors.grey)),
              value: _unseenMessage,
              onChanged: (val) => setState(() => _unseenMessage = val),
            ),
          ],
        ),
      ),
    );
  }
}

class VaultScreen extends StatelessWidget {
  final Color accentColor;
  const VaultScreen({super.key, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Private Vault 🔐')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock, size: 80, color: accentColor),
            const SizedBox(height: 15),
            const Text('Private Storage Secured', style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final Color accentColor;
  final Function(Color) onColorChanged;

  const ProfileScreen({
    super.key,
    required this.accentColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Themes 🎨')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Choose Accent Color Theme:', style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.circle, color: Colors.purpleAccent, size: 40),
                  onPressed: () => onColorChanged(Colors.purpleAccent),
                ),
                IconButton(
                  icon: const Icon(Icons.circle, color: Colors.cyanAccent, size: 40),
                  onPressed: () => onColorChanged(Colors.cyanAccent),
                ),
                IconButton(
                  icon: const Icon(Icons.circle, color: Colors.greenAccent, size: 40),
                  onPressed: () => onColorChanged(Colors.greenAccent),
                ),
                IconButton(
                  icon: const Icon(Icons.circle, color: Colors.orangeAccent, size: 40),
                  onPressed: () => onColorChanged(Colors.orangeAccent),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
