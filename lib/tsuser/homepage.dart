import 'package:flutter/material.dart';

class Homepageuser extends StatefulWidget {
  const Homepageuser({super.key});

  @override
  State<Homepageuser> createState() => _HomepageuserState();
}

class _HomepageuserState extends State<Homepageuser> {
  // Mock data for recent calculations
  final List<Map<String, dynamic>> _recentCalculations = [
    {
      'title': 'H2SO4 Molecular Weight',
      'type': 'Molecular Weight',
      'date': '15 Apr 2025',
      'icon': Icons.science,
    },
    {
      'title': 'NaOH + HCl → NaCl + H2O',
      'type': 'Equation Balancer',
      'date': '14 Apr 2025',
      'icon': Icons.balance,
    },
    {
      'title': 'pH of 0.1M Acetic Acid',
      'type': 'pH Calculator',
      'date': '12 Apr 2025',
      'icon': Icons.calculate,
    },
  ];

  // Mock data for news
  final List<Map<String, dynamic>> _chemistryNews = [
    {
      'title': 'New Carbon Capture Method Developed',
      'source': 'Chemistry World',
      'date': '15 Apr 2025',
      'image': 'assets/images/carbon_capture.jpg',
    },
    {
      'title': 'Breakthrough in Catalytic Converters',
      'source': 'Science Daily',
      'date': '10 Apr 2025',
      'image': 'assets/images/catalyst.jpg',
    },
    {
      'title': 'Advancements in Green Chemistry',
      'source': 'Chemical & Engineering News',
      'date': '08 Apr 2025',
      'image': 'assets/images/green_chem.jpg',
    },
  ];

  // Mock user data
  final Map<String, dynamic> _userData = {
    'name': 'Lisa Chen',
    'email': 'lisa.chen@example.com',
    'avatar': 'assets/images/avatar.png',
    'lastLogin': '15 Apr 2025',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 40,
              // Add a placeholder image or comment this out if you don't have an image yet
            ),
            const SizedBox(width: 8),
            const Text(
              'ChemGeek',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.indigo),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.indigo),
            onPressed: () {
              // Implement notifications
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                // Navigate to profile page
              },
              child: CircleAvatar(
                backgroundImage: AssetImage(_userData['avatar']),
                radius: 16,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User welcome section
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(_userData['avatar']),
                      radius: 30,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back, ${_userData['name']}!',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Last login: ${_userData['lastLogin']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Quick access tools section
            const Text(
              'Quick Access Tools',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildToolCard(
                  context,
                  'Periodic Table',
                  Icons.table_chart,
                  Colors.blue,
                  () {
                    // Navigate to Periodic Table
                  },
                ),
                _buildToolCard(
                  context,
                  'Molecular Weight',
                  Icons.scale,
                  Colors.green,
                  () {
                    // Navigate to Molecular Weight Calculator
                  },
                ),
                _buildToolCard(
                  context,
                  'Equation Balancer',
                  Icons.balance,
                  Colors.purple,
                  () {
                    // Navigate to Equation Balancer
                  },
                ),
                _buildToolCard(
                  context,
                  'pH Calculator',
                  Icons.calculate,
                  Colors.orange,
                  () {
                    // Navigate to pH Calculator
                  },
                ),
                _buildToolCard(
                  context,
                  'Visualizer',
                  Icons.visibility,
                  Colors.red,
                  () {
                    // Navigate to Molecular Visualizer
                  },
                ),
                _buildToolCard(
                  context,
                  'More Tools',
                  Icons.more_horiz,
                  Colors.indigo,
                  () {
                    // Navigate to All Tools page
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Recent calculations section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Calculations',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to view all calculations
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _recentCalculations.length,
              itemBuilder: (context, index) {
                final calculation = _recentCalculations[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo[100],
                      child: Icon(
                        calculation['icon'],
                        color: Colors.indigo,
                      ),
                    ),
                    title: Text(calculation['title']),
                    subtitle: Text(calculation['type']),
                    trailing: Text(
                      calculation['date'],
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    onTap: () {
                      // Open the calculation details
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Chemistry news section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Chemistry News',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to view all news
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _chemistryNews.length,
                itemBuilder: (context, index) {
                  final news = _chemistryNews[index];
                  return Container(
                    width: 280,
                    margin: const EdgeInsets.only(right: 16),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Container(
                              height: 120,
                              width: double.infinity,
                              color: Colors.indigo[200], // Placeholder color
                              child: Center(
                                child: Icon(
                                  Icons.science,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                // Replace with the actual image
                                // Image.asset(
                                //   news['image'],
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  news['title'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      news['source'],
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      news['date'],
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}