import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appium Testing App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const HomePage(),
    );
  }
}

// Home Page - Navigation hub
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appium Testing App'),
        key: const Key('home_app_bar'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Select a test screen:',
            key: Key('home_title'),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _NavCard(
            key: const Key('nav_login'),
            icon: Icons.login,
            title: 'Login Form',
            subtitle: 'Text fields, buttons, validation',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            ),
          ),
          _NavCard(
            key: const Key('nav_inputs'),
            icon: Icons.toggle_on,
            title: 'Input Controls',
            subtitle: 'Switches, checkboxes, sliders, dropdowns',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const InputControlsPage()),
            ),
          ),
          _NavCard(
            key: const Key('nav_list'),
            icon: Icons.list,
            title: 'Scrollable List',
            subtitle: 'ListView with tap and long-press actions',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ListPage()),
            ),
          ),
          _NavCard(
            key: const Key('nav_dialog'),
            icon: Icons.message,
            title: 'Dialogs & Alerts',
            subtitle: 'AlertDialog, SnackBar, BottomSheet',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DialogPage()),
            ),
          ),
          _NavCard(
            key: const Key('nav_tabs'),
            icon: Icons.tab,
            title: 'Tabs & Swipe',
            subtitle: 'TabBar with swipeable content',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TabsPage()),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _NavCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

// Login Page - Text input & validation
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _statusMessage = '';

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        if (_usernameController.text == 'admin' &&
            _passwordController.text == 'password123') {
          _statusMessage = 'Login Successful!';
        } else {
          _statusMessage = 'Invalid Credentials';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Form')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.account_circle, size: 80, color: Colors.deepPurple),
              const SizedBox(height: 24),
              TextFormField(
                key: const Key('username_field'),
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Username is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('password_field'),
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Password is required' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  key: const Key('login_button'),
                  onPressed: _handleLogin,
                  child: const Text('Login'),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _statusMessage,
                key: const Key('login_status'),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _statusMessage == 'Login Successful!'
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Input Controls Page
class InputControlsPage extends StatefulWidget {
  const InputControlsPage({super.key});

  @override
  State<InputControlsPage> createState() => _InputControlsPageState();
}

class _InputControlsPageState extends State<InputControlsPage> {
  bool _switchValue = false;
  bool _checkboxValue = false;
  double _sliderValue = 50;
  String _dropdownValue = 'Option 1';
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Controls')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          SwitchListTile(
            key: const Key('toggle_switch'),
            title: const Text('Toggle Switch'),
            subtitle: Text(_switchValue ? 'ON' : 'OFF', key: const Key('switch_status')),
            value: _switchValue,
            onChanged: (val) => setState(() => _switchValue = val),
          ),
          const Divider(),
          CheckboxListTile(
            key: const Key('checkbox'),
            title: const Text('Accept Terms'),
            subtitle: Text(
              _checkboxValue ? 'Accepted' : 'Not Accepted',
              key: const Key('checkbox_status'),
            ),
            value: _checkboxValue,
            onChanged: (val) => setState(() => _checkboxValue = val ?? false),
          ),
          const Divider(),
          ListTile(
            title: const Text('Slider'),
            subtitle: Slider(
              key: const Key('slider'),
              value: _sliderValue,
              min: 0,
              max: 100,
              divisions: 100,
              label: _sliderValue.round().toString(),
              onChanged: (val) => setState(() => _sliderValue = val),
            ),
            trailing: Text(
              '${_sliderValue.round()}',
              key: const Key('slider_value'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Dropdown'),
            trailing: DropdownButton<String>(
              key: const Key('dropdown'),
              value: _dropdownValue,
              items: ['Option 1', 'Option 2', 'Option 3']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => _dropdownValue = val!),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Counter'),
            subtitle: Text(
              'Value: $_counter',
              key: const Key('counter_value'),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                key: const Key('decrement_button'),
                icon: const Icon(Icons.remove_circle, size: 40),
                onPressed: () => setState(() => _counter--),
              ),
              const SizedBox(width: 24),
              IconButton(
                key: const Key('increment_button'),
                icon: const Icon(Icons.add_circle, size: 40),
                onPressed: () => setState(() => _counter++),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// List Page - Scrollable list with actions
class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final List<String> _items = List.generate(30, (i) => 'Item ${i + 1}');
  String _lastTapped = 'None';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scrollable List'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Last tapped: $_lastTapped',
              key: const Key('last_tapped'),
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        key: const Key('item_list'),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListTile(
            key: Key('list_item_$index'),
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(_items[index]),
            subtitle: Text('Subtitle for item ${index + 1}'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              setState(() => _lastTapped = _items[index]);
            },
            onLongPress: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Long pressed: ${_items[index]}'),
                  key: const Key('long_press_snackbar'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Dialog Page - Alerts, SnackBars, BottomSheets
class DialogPage extends StatelessWidget {
  const DialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dialogs & Alerts')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              key: const Key('show_alert_button'),
              icon: const Icon(Icons.warning),
              label: const Text('Show Alert Dialog'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    key: const Key('alert_dialog'),
                    title: const Text('Alert'),
                    content: const Text('This is a test alert dialog.'),
                    actions: [
                      TextButton(
                        key: const Key('alert_cancel'),
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        key: const Key('alert_ok'),
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              key: const Key('show_snackbar_button'),
              icon: const Icon(Icons.info),
              label: const Text('Show SnackBar'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    key: const Key('test_snackbar'),
                    content: const Text('This is a test SnackBar!'),
                    action: SnackBarAction(
                      label: 'UNDO',
                      key: const Key('snackbar_undo'),
                      onPressed: () {},
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              key: const Key('show_bottom_sheet_button'),
              icon: const Icon(Icons.expand_less),
              label: const Text('Show Bottom Sheet'),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) => Container(
                    key: const Key('bottom_sheet'),
                    padding: const EdgeInsets.all(24),
                    height: 200,
                    child: Column(
                      children: [
                        const Text(
                          'Bottom Sheet',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        const Text('This is a test bottom sheet.'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          key: const Key('close_bottom_sheet'),
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              key: const Key('show_date_picker_button'),
              icon: const Icon(Icons.calendar_today),
              label: const Text('Show Date Picker'),
              onPressed: () async {
                await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Tabs Page - TabBar with swipeable content
class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tabs & Swipe'),
          bottom: const TabBar(
            key: Key('tab_bar'),
            tabs: [
              Tab(key: Key('tab_home'), icon: Icon(Icons.home), text: 'Home'),
              Tab(key: Key('tab_search'), icon: Icon(Icons.search), text: 'Search'),
              Tab(key: Key('tab_profile'), icon: Icon(Icons.person), text: 'Profile'),
            ],
          ),
        ),
        body: TabBarView(
          key: const Key('tab_bar_view'),
          children: [
            Center(
              child: Text(
                'Home Tab Content',
                key: const Key('home_tab_content'),
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Center(
              child: Text(
                'Search Tab Content',
                key: const Key('search_tab_content'),
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Center(
              child: Text(
                'Profile Tab Content',
                key: const Key('profile_tab_content'),
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
