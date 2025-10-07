import 'package:flutter/material.dart';
import 'dart:math' as math;

class Molecularvisualizer extends StatefulWidget {
  const Molecularvisualizer({super.key});

  @override
  State<Molecularvisualizer> createState() => _MolecularvisualizerState();
}

class _MolecularvisualizerState extends State<Molecularvisualizer> with SingleTickerProviderStateMixin {
  // Current view mode
  String _currentView = '3D View';
  
  // Currently selected molecule
  String _currentMolecule = 'Water';
  
  // Drawing mode for 2D editor
  String _drawingMode = 'Select';
  
  // Animation controller for 3D rotation
  late AnimationController _rotationController;
  
  // Track if visualization is rotating
  bool _isRotating = false;
  
  // Rotation angles for 3D view
  double _rotationX = 0.0;
  double _rotationY = 0.0;
  double _rotationZ = 0.0;
  
  // Scale factor for zoom
  double _scale = 1.0;
  
  // Structural properties
  final Map<String, dynamic> _structuralProperties = {
    'Molecular Formula': 'H2O',
    'Molecular Weight': '18.02 g/mol',
    'Bond Angles': '104.5°',
    'Bond Lengths': 'O-H: 0.96 Å',
    'Hybridization': 'sp3',
    'Polarity': 'Polar',
    'Geometry': 'Bent',
  };
  
  // List of available molecules for quick selection
  final List<Map<String, dynamic>> _availableMolecules = [
    {'name': 'Water', 'formula': 'H2O', 'structure': 'assets/structures/water.mol'},
    {'name': 'Methane', 'formula': 'CH4', 'structure': 'assets/structures/methane.mol'},
    {'name': 'Benzene', 'formula': 'C6H6', 'structure': 'assets/structures/benzene.mol'},
    {'name': 'Ethanol', 'formula': 'C2H5OH', 'structure': 'assets/structures/ethanol.mol'},
    {'name': 'Glucose', 'formula': 'C6H12O6', 'structure': 'assets/structures/glucose.mol'},
  ];
  
  // For 2D drawing - tracking points and bonds
  final List<Offset> _atoms = [];
  final List<Map<String, dynamic>> _bonds = [];
  String _selectedAtomType = 'C';
  String _selectedBondType = 'Single';
  
  @override
  void initState() {
    super.initState();
    
    // Initialize the rotation animation controller
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10000),
    )..addListener(() {
      setState(() {
        // Continuous rotation effect
        _rotationY = _rotationController.value * 2 * math.pi;
      });
    });
    
    // Add some example atoms and bonds for the 2D editor
    // This would normally be dynamically updated based on user interaction
    _atoms.add(const Offset(150, 150));
    _atoms.add(const Offset(200, 100));
    _atoms.add(const Offset(250, 150));
    
    _bonds.add({
      'from': 0,
      'to': 1,
      'type': 'Single',
    });
    _bonds.add({
      'from': 1,
      'to': 2,
      'type': 'Single',
    });
  }
  
  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }
  
  // Method to toggle auto-rotation
  void _toggleRotation() {
    setState(() {
      _isRotating = !_isRotating;
      if (_isRotating) {
        _rotationController.repeat();
      } else {
        _rotationController.stop();
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Molecular Visualizer',
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
            icon: const Icon(Icons.file_upload),
            tooltip: 'Import Structure',
            onPressed: () {
              // Implement file import
              _showImportDialog();
            },
          ),
          IconButton(
            icon: const Icon(Icons.file_download),
            tooltip: 'Export Structure',
            onPressed: () {
              // Implement file export
              _showExportDialog();
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Help',
            onPressed: () {
              _showHelpDialog();
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Left sidebar - Molecule selection and tools
          Container(
            width: 250,
            color: Colors.grey[100],
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'View Mode',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: '2D Editor',
                      label: Text('2D Editor'),
                      icon: Icon(Icons.edit),
                    ),
                    ButtonSegment(
                      value: '3D View',
                      label: Text('3D View'),
                      icon: Icon(Icons.view_in_ar),
                    ),
                  ],
                  selected: {_currentView},
                  onSelectionChanged: (Set<String> selection) {
                    setState(() {
                      _currentView = selection.first;
                    });
                  },
                ),
                const SizedBox(height: 16),
                
                const Text(
                  'Quick Access Molecules',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: _availableMolecules.length,
                    itemBuilder: (context, index) {
                      final molecule = _availableMolecules[index];
                      final isSelected = molecule['name'] == _currentMolecule;
                      
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.indigo.withOpacity(0.1) : null,
                          borderRadius: BorderRadius.circular(8),
                          border: isSelected ? Border.all(color: Colors.indigo) : null,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.indigo.withOpacity(0.7),
                            child: Text(
                              molecule['formula'].substring(0, 1),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(molecule['name']),
                          subtitle: Text(molecule['formula']),
                          dense: true,
                          selected: isSelected,
                          onTap: () {
                            setState(() {
                              _currentMolecule = molecule['name'];
                              // Here you would load the molecular structure
                              // and update the visualization
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                
                const Divider(),
                
                // Structural Properties section
                ExpansionTile(
                  title: const Text(
                    'Structural Properties',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  initiallyExpanded: true,
                  childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
                  children: _structuralProperties.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            entry.key,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            entry.value.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          
          // Main content area
          Expanded(
            child: Column(
              children: [
                // Controls for the current view
                _buildViewControls(),
                
                // Main visualization area
                Expanded(
                  child: _currentView == '3D View'
                      ? _build3DVisualization()
                      : _build2DEditor(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Build controls specific to the current view mode
  Widget _buildViewControls() {
    if (_currentView == '3D View') {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(_isRotating ? Icons.pause : Icons.play_arrow),
              tooltip: _isRotating ? 'Pause Rotation' : 'Start Rotation',
              onPressed: _toggleRotation,
            ),
            const SizedBox(width: 16),
            const Text('Zoom:'),
            Slider(
              value: _scale,
              min: 0.5,
              max: 2.0,
              divisions: 6,
              label: _scale.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _scale = value;
                });
              },
            ),
            const SizedBox(width: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.restart_alt),
              label: const Text('Reset View'),
              onPressed: () {
                setState(() {
                  _rotationX = 0.0;
                  _rotationY = 0.0;
                  _rotationZ = 0.0;
                  _scale = 1.0;
                  _rotationController.reset();
                });
              },
            ),
          ],
        ),
      );
    } else {
      // 2D Editor controls
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
        ),
        child: Row(
          children: [
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: 'Select',
                  label: Text('Select'),
                  icon: Icon(Icons.touch_app),
                ),
                ButtonSegment(
                  value: 'Atom',
                  label: Text('Add Atom'),
                  icon: Icon(Icons.add_circle),
                ),
                ButtonSegment(
                  value: 'Bond',
                  label: Text('Add Bond'),
                  icon: Icon(Icons.timeline),
                ),
                ButtonSegment(
                  value: 'Erase',
                  label: Text('Erase'),
                  icon: Icon(Icons.delete),
                ),
              ],
              selected: {_drawingMode},
              onSelectionChanged: (Set<String> selection) {
                setState(() {
                  _drawingMode = selection.first;
                });
              },
            ),
            const SizedBox(width: 16),
            if (_drawingMode == 'Atom') ...[
              const Text('Atom:'),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: _selectedAtomType,
                items: const [
                  DropdownMenuItem(value: 'C', child: Text('C')),
                  DropdownMenuItem(value: 'H', child: Text('H')),
                  DropdownMenuItem(value: 'O', child: Text('O')),
                  DropdownMenuItem(value: 'N', child: Text('N')),
                  DropdownMenuItem(value: 'S', child: Text('S')),
                  DropdownMenuItem(value: 'P', child: Text('P')),
                  DropdownMenuItem(value: 'F', child: Text('F')),
                  DropdownMenuItem(value: 'Cl', child: Text('Cl')),
                  DropdownMenuItem(value: 'Br', child: Text('Br')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedAtomType = value!;
                  });
                },
              ),
            ],
            if (_drawingMode == 'Bond') ...[
              const Text('Bond:'),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: _selectedBondType,
                items: const [
                  DropdownMenuItem(value: 'Single', child: Text('Single')),
                  DropdownMenuItem(value: 'Double', child: Text('Double')),
                  DropdownMenuItem(value: 'Triple', child: Text('Triple')),
                  DropdownMenuItem(value: 'Wedge', child: Text('Wedge')),
                  DropdownMenuItem(value: 'Dash', child: Text('Dash')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedBondType = value!;
                  });
                },
              ),
            ],
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Clear Canvas',
              onPressed: () {
                setState(() {
                  _atoms.clear();
                  _bonds.clear();
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.auto_fix_high),
              tooltip: 'Auto-Optimize Structure',
              onPressed: () {
                // Implement structure optimization
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Structure optimization initiated')),
                );
              },
            ),
          ],
        ),
      );
    }
  }
  
  // Build 3D visualization widget
  Widget _build3DVisualization() {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _rotationY += details.delta.dx * 0.01;
          _rotationX += details.delta.dy * 0.01;
        });
      },
      child: Container(
        color: Colors.grey[900],
        child: Center(
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateX(_rotationX)
              ..rotateY(_rotationY)
              ..rotateZ(_rotationZ)
              ..scale(_scale),
            alignment: Alignment.center,
            child: CustomPaint(
              painter: Molecule3DPainter(
                formula: _structuralProperties['Molecular Formula'],
                isWater: _currentMolecule == 'Water',
              ),
              size: const Size(300, 300),
            ),
          ),
        ),
      ),
    );
  }
  
  // Build 2D structure editor
  Widget _build2DEditor() {
    return GestureDetector(
      onTapDown: (details) {
        if (_drawingMode == 'Atom') {
          setState(() {
            _atoms.add(details.localPosition);
          });
        }
      },
      child: Container(
        color: Colors.white,
        child: CustomPaint(
          painter: Molecule2DPainter(
            atoms: _atoms,
            bonds: _bonds,
            selectedAtomType: _selectedAtomType,
          ),
          child: Container(),
        ),
      ),
    );
  }
  
  // Show import dialog
  void _showImportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Import Molecular Structure'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select file format:'),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: 'MOL',
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'MOL', child: Text('MDL MOL file (.mol)')),
                DropdownMenuItem(value: 'PDB', child: Text('Protein Data Bank (.pdb)')),
                DropdownMenuItem(value: 'XYZ', child: Text('XYZ coordinates (.xyz)')),
                DropdownMenuItem(value: 'CML', child: Text('Chemical Markup Language (.cml)')),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.file_open),
              label: const Text('Browse Files'),
              onPressed: () {
                // Implement file picking
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('File import not implemented in this preview')),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Or enter SMILES string:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                hintText: 'e.g., C1=CC=CC=C1 (benzene)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Structure imported successfully')),
              );
            },
            child: const Text('Import'),
          ),
        ],
      ),
    );
  }
  
  // Show export dialog
  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Molecular Structure'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select export format:'),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: 'MOL',
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'MOL', child: Text('MDL MOL file (.mol)')),
                DropdownMenuItem(value: 'PDB', child: Text('Protein Data Bank (.pdb)')),
                DropdownMenuItem(value: 'XYZ', child: Text('XYZ coordinates (.xyz)')),
                DropdownMenuItem(value: 'PNG', child: Text('PNG Image (.png)')),
                DropdownMenuItem(value: 'SVG', child: Text('SVG Vector Image (.svg)')),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            const Text('Export Options:'),
            CheckboxListTile(
              title: const Text('Include Hydrogens'),
              value: true,
              onChanged: (value) {},
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
            CheckboxListTile(
              title: const Text('Include 3D Coordinates'),
              value: true,
              onChanged: (value) {},
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Structure exported successfully')),
              );
            },
            child: const Text('Export'),
          ),
        ],
      ),
    );
  }
  
  // Show help dialog
  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Molecular Visualizer Help'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '3D View Controls:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('• Drag to rotate the molecule'),
            Text('• Use the slider to zoom in/out'),
            Text('• Click the play button for auto-rotation'),
            SizedBox(height: 12),
            
            Text(
              '2D Editor Controls:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('• Select "Add Atom" and click to place atoms'),
            Text('• Select "Add Bond" to create bonds between atoms'),
            Text('• Use Select mode to move atoms or bonds'),
            Text('• Use Erase to delete atoms or bonds'),
            SizedBox(height: 12),
            
            Text(
              'Import/Export:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('• Import from MOL, PDB, XYZ files or SMILES strings'),
            Text('• Export to various molecule formats or images'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

// Custom painter for 3D molecule visualization
class Molecule3DPainter extends CustomPainter {
  final String formula;
  final bool isWater;
  
  Molecule3DPainter({
    required this.formula,
    this.isWater = true,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    // This is a placeholder visualization that would be replaced
    // with a proper 3D rendering library in a production app
    
    final center = Offset(size.width / 2, size.height / 2);
    
    if (isWater) {
      // Draw a simple water molecule
      final oxygenPaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill;
      
      final hydrogenPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      
      final bondPaint = Paint()
        ..color = Colors.white
        ..strokeWidth = 5.0
        ..style = PaintingStyle.stroke;
      
      // Oxygen atom
      canvas.drawCircle(center, 30, oxygenPaint);
      
      // Hydrogen atoms
      final h1Pos = Offset(center.dx - 60, center.dy + 40);
      final h2Pos = Offset(center.dx + 60, center.dy + 40);
      
      canvas.drawCircle(h1Pos, 20, hydrogenPaint);
      canvas.drawCircle(h2Pos, 20, hydrogenPaint);
      
      // Bonds
      canvas.drawLine(center, h1Pos, bondPaint);
      canvas.drawLine(center, h2Pos, bondPaint);
      
      // Labels
      const textStyle = TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );
      
      final textPainter = TextPainter(
        text: const TextSpan(text: 'O', style: textStyle),
        textDirection: TextDirection.ltr,
      );
      
      textPainter.layout();
      textPainter.paint(canvas, center.translate(-textPainter.width / 2, -textPainter.height / 2));
      
      textPainter.text = const TextSpan(text: 'H', style: textStyle);
      textPainter.layout();
      textPainter.paint(canvas, h1Pos.translate(-textPainter.width / 2, -textPainter.height / 2));
      textPainter.paint(canvas, h2Pos.translate(-textPainter.width / 2, -textPainter.height / 2));
    } else {
      // For other molecules, just show a message
      const textStyle = TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );
      
      final textPainter = TextPainter(
        text: TextSpan(
          text: 'Visualization for $formula',
          style: textStyle,
        ),
        textDirection: TextDirection.ltr,
      );
      
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          center.dx - textPainter.width / 2,
          center.dy - textPainter.height / 2,
        ),
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Custom painter for 2D molecule editor
class Molecule2DPainter extends CustomPainter {
  final List<Offset> atoms;
  final List<Map<String, dynamic>> bonds;
  final String selectedAtomType;
  
  Molecule2DPainter({
    required this.atoms,
    required this.bonds,
    required this.selectedAtomType,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    // Draw grid background for reference
    _drawGrid(canvas, size);
    
    // Draw bonds first so they appear behind atoms
    for (var bond in bonds) {
      if (bond['from'] < atoms.length && bond['to'] < atoms.length) {
        _drawBond(
          canvas,
          atoms[bond['from']],
          atoms[bond['to']],
          bond['type'],
        );
      }
    }
    
    // Draw atoms
    for (int i = 0; i < atoms.length; i++) {
      _drawAtom(canvas, atoms[i], 'C'); // Default to carbon for this demo
    }
  }
  
  void _drawGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[200]!
      ..strokeWidth = 1.0;
    
    const gridSize = 20.0;
    
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
    
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }
  
  void _drawAtom(Canvas canvas, Offset position, String element) {
    // Element to color mapping
    final colors = {
      'C': Colors.black,
      'H': Colors.grey,
      'O': Colors.red,
      'N': Colors.blue,
      'S': Colors.yellow,
      'P': Colors.orange,
      'F': Colors.green[300],
      'Cl': Colors.green,
      'Br': Colors.brown,
    };
    
    final color = colors[element] ?? Colors.purple;
    
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    // Draw atom circle
    canvas.drawCircle(position, 15, paint);
    
    // Draw element text
    final textStyle = TextStyle(
      color: element == 'S' ? Colors.black : Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
    
    final textPainter = TextPainter(
      text: TextSpan(text: element, style: textStyle),
      textDirection: TextDirection.ltr,
    );
    
    textPainter.layout();
    textPainter.paint(
      canvas,
      position.translate(-textPainter.width / 2, -textPainter.height / 2),
    );
  }
  
  void _drawBond(Canvas canvas, Offset start, Offset end, String bondType) {
    final direction = (end - start);
    final unitDirection = direction / direction.distance;
    final perpendicular = Offset(-unitDirection.dy, unitDirection.dx);
    
    // Adjust start and end points to connect to atom circles
    final adjustedStart = start + unitDirection * 15;
    final adjustedEnd = end - unitDirection * 15;
    
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    
    switch (bondType) {
      case 'Single':
        canvas.drawLine(adjustedStart, adjustedEnd, paint);
        break;
      case 'Double':
        final offset = perpendicular * 4;
        canvas.drawLine(adjustedStart + offset, adjustedEnd + offset, paint);
        canvas.drawLine(adjustedStart - offset, adjustedEnd - offset, paint);
        break;
      case 'Triple':
        final offset1 = perpendicular * 6;
        canvas.drawLine(adjustedStart, adjustedEnd, paint);
        canvas.drawLine(adjustedStart + offset1, adjustedEnd + offset1, paint);
        canvas.drawLine(adjustedStart - offset1, adjustedEnd - offset1, paint);
        break;
      case 'Wedge':
        final trianglePath = Path()
          ..moveTo(start.dx, start.dy)
          ..lineTo(end.dx + perpendicular.dx * 8, end.dy + perpendicular.dy * 8)
          ..lineTo(end.dx - perpendicular.dx * 8, end.dy - perpendicular.dy * 8)
          ..close();
        
        final wedgePaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.fill;
        
        canvas.drawPath(trianglePath, wedgePaint);
        break;
      case 'Dash':
        final dashPaint = Paint()
          ..color = Colors.black
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke;
        
        final dashPath = Path();
        final totalDistance = (adjustedEnd - adjustedStart).distance;
        final unitVector = (adjustedEnd - adjustedStart) / totalDistance;
        
        for (double i = 0; i < totalDistance; i += 10) {
          if (i + 5 > totalDistance) break;
          final dashStart = adjustedStart + unitVector * i;
          final dashEnd = adjustedStart + unitVector * (i + 5);
          dashPath.moveTo(dashStart.dx, dashStart.dy);
          dashPath.lineTo(dashEnd.dx, dashEnd.dy);
        }
        
        canvas.drawPath(dashPath, dashPaint);
        break;
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}