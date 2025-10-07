import 'package:flutter/material.dart';

class Profileuser extends StatefulWidget {
  const Profileuser({super.key});

  @override
  State<Profileuser> createState() => _ProfileuserState();
}

class _ProfileuserState extends State<Profileuser> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  
  // Mock user data
  final Map<String, dynamic> _userData = {
    'name': 'Lisa Chen',
    'email': 'lisa.chen@example.com',
    'avatar': 'assets/images/avatar.png',
    'institution': 'University of Chemistry',
    'role': 'Chemistry Student',
    'memberSince': 'January 2025',
  };
  
  // Mock saved calculations
  final List<Map<String, dynamic>> _savedCalculations = [
    {
      'title': 'H2SO4 Molecular Weight',
      'date': '15 Apr 2025',
      'type': 'Molecular Weight',
      'result': '98.08 g/mol',
      'isFavorite': true,
    },
    {
      'title': 'NaOH + HCl → NaCl + H2O',
      'date': '14 Apr 2025',
      'type': 'Equation Balancer',
      'result': 'Balanced: NaOH + HCl → NaCl + H2O',
      'isFavorite': false,
    },
    {
      'title': 'pH of 0.1M Acetic Acid',
      'date': '12 Apr 2025',
      'type': 'pH Calculator',
      'result': 'pH = 2.87',
      'isFavorite': true,
    },
    {
      'title': 'Benzene Visualization',
      'date': '10 Apr 2025',
      'type': 'Molecular Visualizer',
      'result': '3D structure saved',
      'isFavorite': false,
    },
    {
      'title': 'Zinc Properties',
      'date': '08 Apr 2025',
      'type': 'Periodic Table',
      'result': 'Element details viewed',
      'isFavorite': false,
    },
  ];
  
  // Mock favorite compounds
  final List<Map<String, dynamic>> _favoriteCompounds = [
    {
      'name': 'Water',
      'formula': 'H2O',
      'molecularWeight': '18.02 g/mol',
      'date': '15 Apr 2025',
      'structure': 'assets/structures/water.png',
    },
    {
      'name': 'Glucose',
      'formula': 'C6H12O6',
      'molecularWeight': '180.16 g/mol',
      'date': '14 Apr 2025',
      'structure': 'assets/structures/glucose.png',
    },
    {
      'name': 'Caffeine',
      'formula': 'C8H10N4O2',
      'molecularWeight': '194.19 g/mol',
      'date': '12 Apr 2025',
      'structure': 'assets/structures/caffeine.png',
    },
  ];
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 40,
                // Comment this out if you don't have the image yet
              ),
              const SizedBox(width: 8),
              const Text(
                'User Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 2,
          iconTheme: const IconThemeData(color: Colors.indigo),
          actions: [
            IconButton(
              icon: Icon(_notificationsEnabled ? Icons.notifications_active : Icons.notifications_off),
              tooltip: 'Notifications',
              onPressed: () {
                setState(() {
                  _notificationsEnabled = !_notificationsEnabled;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _notificationsEnabled
                          ? 'Notifications enabled'
                          : 'Notifications disabled'
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                _showSettingsDialog();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // User profile header
            _buildProfileHeader(),
            
            // Tabs
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  icon: Icon(Icons.history),
                  text: 'History',
                ),
                Tab(
                  icon: Icon(Icons.favorite),
                  text: 'Favorites',
                ),
                Tab(
                  icon: Icon(Icons.account_circle),
                  text: 'Account',
                ),
              ],
              labelColor: Colors.indigo,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.indigo,
            ),
            
            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCalculationHistoryTab(),
                  _buildFavoritesTab(),
                  _buildAccountSettingsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // User profile header widget
  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(0.05),
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
      ),
      child: Row(
        children: [
          // Profile picture
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(_userData['avatar']),
            backgroundColor: Colors.grey[200],
          ),
          const SizedBox(width: 20),
          
          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userData['name'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _userData['email'],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_userData['role']} at ${_userData['institution']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Member since ${_userData['memberSince']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          // Dark mode toggle
          Column(
            children: [
              const Text(
                'Dark Mode',
                style: TextStyle(fontSize: 12),
              ),
              Switch(
                value: _isDarkMode,
                activeColor: Colors.indigo,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  // Calculation history tab
  Widget _buildCalculationHistoryTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _savedCalculations.length,
      itemBuilder: (context, index) {
        final calculation = _savedCalculations[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: _getIconForCalculationType(calculation['type']),
           title: Text(calculation['title']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(calculation['type']),
                Text(
                  calculation['date'],
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    calculation['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                    color: calculation['isFavorite'] ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      calculation['isFavorite'] = !calculation['isFavorite'];
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    _showCalculationOptions(calculation);
                  },
                ),
              ],
            ),
            isThreeLine: true,
            onTap: () {
              // Show calculation details
              _showCalculationDetails(calculation);
            },
          ),
        );
      },
    );
  }
  
  // Favorites tab
  Widget _buildFavoritesTab() {
    return Column(
      children: [
        // Filter tabs
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.calculate),
                  label: const Text('Calculations'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.science),
                  label: const Text('Compounds'),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Favorite items
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: _favoriteCompounds.length,
            itemBuilder: (context, index) {
              final compound = _favoriteCompounds[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.indigo.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        compound['formula'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  title: Text(compound['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('MW: ${compound["molecularWeight"]}'),
                      Text(
                        'Added on ${compound["date"]}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      // Remove from favorites
                      setState(() {
                        _favoriteCompounds.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${compound["name"]} removed from favorites'),
                          duration: const Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              setState(() {
                                _favoriteCompounds.insert(index, compound);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  isThreeLine: true,
                  onTap: () {
                    // View compound details
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  
  // Account settings tab
  Widget _buildAccountSettingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile info section
          const Text(
            'Profile Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSettingsTextField('Full Name', _userData['name']),
          const SizedBox(height: 12),
          _buildSettingsTextField('Email', _userData['email']),
          const SizedBox(height: 12),
          _buildSettingsTextField('Institution', _userData['institution']),
          const SizedBox(height: 12),
          _buildSettingsTextField('Role', _userData['role']),
          const SizedBox(height: 24),
          
          // App settings section
          const Text(
            'App Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSettingsToggle(
            'Enable Notifications',
            _notificationsEnabled,
            (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          _buildSettingsToggle(
            'Dark Mode',
            _isDarkMode,
            (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
          ),
          _buildSettingsToggle(
            'Save Calculation History',
            true,
            (value) {},
          ),
          _buildSettingsToggle(
            'Enable Analytics',
            false,
            (value) {},
          ),
          const SizedBox(height: 24),
          
          // Account actions section
          const Text(
            'Account Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildActionButton('Export Data', Icons.download, Colors.indigo),
          const SizedBox(height: 12),
          _buildActionButton('Delete Account', Icons.delete, Colors.red),
          const SizedBox(height: 24),
          
          // App info
          Center(
            child: Column(
              children: [
                const Text(
                  'ChemGeek v1.0.0',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: () {},
                  child: const Text('Terms of Service & Privacy Policy'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper widgets
  
  // Settings text field
  Widget _buildSettingsTextField(String label, String value) {
    return TextField(
      controller: TextEditingController(text: value),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
  
  // Settings toggle
  Widget _buildSettingsToggle(String label, bool value, Function(bool) onChanged) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.indigo,
            ),
          ],
        ),
      ),
    );
  }
  
  // Action button
  Widget _buildActionButton(String label, IconData icon, Color color) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(label),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
  
  // Get icon for calculation type
  Widget _getIconForCalculationType(String type) {
    IconData iconData;
    Color iconColor;
    
    switch (type) {
      case 'Molecular Weight':
        iconData = Icons.scale;
        iconColor = Colors.blue;
        break;
      case 'Equation Balancer':
        iconData = Icons.balance;
        iconColor = Colors.orange;
        break;
      case 'pH Calculator':
        iconData = Icons.calculate;
        iconColor = Colors.red;
        break;
      case 'Molecular Visualizer':
        iconData = Icons.visibility;
        iconColor = Colors.purple;
        break;
      case 'Periodic Table':
        iconData = Icons.table_chart;
        iconColor = Colors.green;
        break;
      default:
        iconData = Icons.science;
        iconColor = Colors.indigo;
    }
    
    return CircleAvatar(
      backgroundColor: iconColor.withOpacity(0.2),
      child: Icon(iconData, color: iconColor),
    );
  }
  
  // Show calculation options dialog
  void _showCalculationOptions(Map<String, dynamic> calculation) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.replay),
              title: const Text('Repeat Calculation'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to calculation tool
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Result'),
              onTap: () {
                Navigator.pop(context);
                // Share calculation
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete from History'),
              onTap: () {
                setState(() {
                  _savedCalculations.remove(calculation);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  
  // Show calculation details dialog
  void _showCalculationDetails(Map<String, dynamic> calculation) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(calculation['title']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Type: ${calculation['type']}'),
              Text('Date: ${calculation['date']}'),
              const Divider(),
              const Text(
                'Result:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(calculation['result']),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to repeat calculation
              },
              child: const Text('Repeat'),
            ),
          ],
        );
      },
    );
  }
  
  // Show settings dialog
  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('App Settings'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSettingsToggle(
                'Dark Mode',
                _isDarkMode,
                (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                  Navigator.of(context).pop();
                },
              ),
              _buildSettingsToggle(
                'Notifications',
                _notificationsEnabled,
                (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                trailing: const Text('English'),
                onTap: () {
                  // Show language options
                },
              ),
              ListTile(
                leading: const Icon(Icons.swap_horiz),
                title: const Text('Units'),
                trailing: const Text('SI'),
                onTap: () {
                  // Show unit options
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}