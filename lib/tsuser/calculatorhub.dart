import 'package:flutter/material.dart';

class Calculatorhub extends StatefulWidget {
  const Calculatorhub({super.key});

  @override
  State<Calculatorhub> createState() => _CalculatorhubState();
}

class _CalculatorhubState extends State<Calculatorhub> {
  // Track which calculator is currently selected
  String _selectedCalculator = 'Molecular Weight';

  // List of available calculators
  final List<Map<String, dynamic>> _calculators = [
    {
      'title': 'Molecular Weight',
      'icon': Icons.scale,
      'color': Colors.blue,
      'description': 'Calculate the molecular weight of chemical compounds',
    },
    {
      'title': 'Stoichiometry',
      'icon': Icons.balance,
      'color': Colors.green,
      'description': 'Calculate reaction yields and limiting reagents',
    },
    {
      'title': 'Solution',
      'icon': Icons.opacity,
      'color': Colors.purple,
      'description': 'Prepare solutions of specific concentrations',
    },
    {
      'title': 'Equation Balancer',
      'icon': Icons.compare_arrows,
      'color': Colors.orange,
      'description': 'Balance chemical equations automatically',
    },
    {
      'title': 'pH',
      'icon': Icons.analytics,
      'color': Colors.red,
      'description': 'Calculate pH of various solutions',
    },
    {
      'title': 'Gas Laws',
      'icon': Icons.air,
      'color': Colors.teal,
      'description': 'PV=nRT and related gas law calculations',
    },
  ];

  // Controller for various text input fields
  final TextEditingController _formulaController = TextEditingController();
  final TextEditingController _massController = TextEditingController();
  final TextEditingController _reactionController = TextEditingController();
  final TextEditingController _limitingController = TextEditingController();
  final TextEditingController _yieldController = TextEditingController();
  final TextEditingController _concentrationController = TextEditingController();
  final TextEditingController _volumeController = TextEditingController();
  final TextEditingController _solventController = TextEditingController();
  final TextEditingController _equationController = TextEditingController();
  final TextEditingController _acidController = TextEditingController();
  final TextEditingController _kaController = TextEditingController();
  final TextEditingController _pressureController = TextEditingController();
  final TextEditingController _temperatureController = TextEditingController();
  final TextEditingController _molsController = TextEditingController();
  final TextEditingController _gasVolumeController = TextEditingController();

  // Results for various calculators
  String _molecularWeightResult = '';
  String _stoichiometryResult = '';
  String _solutionResult = '';
  String _equationBalancerResult = '';
  String _phResult = '';
  String _gasLawResult = '';

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    _formulaController.dispose();
    _massController.dispose();
    _reactionController.dispose();
    _limitingController.dispose();
    _yieldController.dispose();
    _concentrationController.dispose();
    _volumeController.dispose();
    _solventController.dispose();
    _equationController.dispose();
    _acidController.dispose();
    _kaController.dispose();
    _pressureController.dispose();
    _temperatureController.dispose();
    _molsController.dispose();
    _gasVolumeController.dispose();
    super.dispose();
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
              'Calculator Hub',
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
      ),
      body: Row(
        children: [
          // Sidebar with calculator options
          Container(
            width: 250,
            color: Colors.grey[100],
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ListView.builder(
              itemCount: _calculators.length,
              itemBuilder: (context, index) {
                final calculator = _calculators[index];
                final isSelected = calculator['title'] == _selectedCalculator;
                
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? calculator['color'].withOpacity(0.1) : null,
                    borderRadius: BorderRadius.circular(8),
                    border: isSelected
                        ? Border.all(color: calculator['color'])
                        : null,
                  ),
                  child: ListTile(
                    leading: Icon(
                      calculator['icon'],
                      color: calculator['color'],
                    ),
                    title: Text(
                      calculator['title'],
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    subtitle: Text(
                      calculator['description'],
                      style: const TextStyle(fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      setState(() {
                        _selectedCalculator = calculator['title'];
                      });
                    },
                    selected: isSelected,
                  ),
                );
              },
            ),
          ),
          
          // Calculator content
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: _buildSelectedCalculator(),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build the UI for the selected calculator
  Widget _buildSelectedCalculator() {
    switch (_selectedCalculator) {
      case 'Molecular Weight':
        return _buildMolecularWeightCalculator();
      case 'Stoichiometry':
        return _buildStoichiometryCalculator();
      case 'Solution':
        return _buildSolutionCalculator();
      case 'Equation Balancer':
        return _buildEquationBalancerCalculator();
      case 'pH':
        return _buildPHCalculator();
      case 'Gas Laws':
        return _buildGasLawsCalculator();
      default:
        return _buildMolecularWeightCalculator();
    }
  }

  // Molecular Weight Calculator
  Widget _buildMolecularWeightCalculator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Molecular Weight Calculator',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Enter a chemical formula to calculate its molecular weight',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        
        // Formula input
        TextField(
          controller: _formulaController,
          decoration: InputDecoration(
            labelText: 'Chemical Formula',
            hintText: 'e.g., H2O, NaCl, C6H12O6',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: const Icon(Icons.science, color: Colors.blue),
          ),
        ),
        const SizedBox(height: 16),
        
        // Calculate button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Here you would call a function to calculate molecular weight
              setState(() {
                // This is a placeholder. In a real app, you'd implement the actual calculation
                _molecularWeightResult = 'Calculating the molecular weight of ${_formulaController.text}...';
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Calculate Molecular Weight',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // Results section
        if (_molecularWeightResult.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.withOpacity(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Result:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(_molecularWeightResult),
              ],
            ),
          ),
        
        const SizedBox(height: 24),
        
        // Common compounds reference
        const Text(
          'Common Compounds',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildCompoundChip('H2O', 'Water - 18.02 g/mol'),
            _buildCompoundChip('CO2', 'Carbon Dioxide - 44.01 g/mol'),
            _buildCompoundChip('NaCl', 'Sodium Chloride - 58.44 g/mol'),
            _buildCompoundChip('C6H12O6', 'Glucose - 180.16 g/mol'),
            _buildCompoundChip('NH3', 'Ammonia - 17.03 g/mol'),
            _buildCompoundChip('H2SO4', 'Sulfuric Acid - 98.08 g/mol'),
          ],
        ),
      ],
    );
  }

  // Stoichiometry Calculator
  Widget _buildStoichiometryCalculator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Stoichiometry Calculator',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Calculate reaction yields and limiting reagents',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        
        // Balanced reaction equation
        TextField(
          controller: _reactionController,
          decoration: InputDecoration(
            labelText: 'Balanced Reaction',
            hintText: 'e.g., 2H2 + O2 = 2H2O',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: const Icon(Icons.equalizer, color: Colors.green),
          ),
        ),
        const SizedBox(height: 16),
        
        // Potentially limiting reagent
        TextField(
          controller: _limitingController,
          decoration: InputDecoration(
            labelText: 'Limiting Reagent',
            hintText: 'e.g., H2',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: const Icon(Icons.search, color: Colors.green),
          ),
        ),
        const SizedBox(height: 16),
        
        // Mass or moles available
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _massController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Mass Available (g)',
                  hintText: 'e.g., 10',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.scale, color: Colors.green),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _yieldController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Percent Yield (%)',
                  hintText: 'e.g., 85',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.percent, color: Colors.green),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Calculate button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Placeholder for stoichiometry calculation
              setState(() {
                _stoichiometryResult = 'Calculating stoichiometry for ${_reactionController.text}...';
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Calculate Yields',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // Results section
        if (_stoichiometryResult.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.withOpacity(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Result:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(_stoichiometryResult),
              ],
            ),
          ),
      ],
    );
  }

  // Solution Calculator
  Widget _buildSolutionCalculator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Solution Calculator',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Prepare solutions of specific concentrations',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        
        // Solute formula
        TextField(
          controller: _formulaController,
          decoration: InputDecoration(
            labelText: 'Solute Formula',
            hintText: 'e.g., NaCl, CuSO4',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: const Icon(Icons.science, color: Colors.purple),
          ),
        ),
        const SizedBox(height: 16),
        
        // Target concentration and volume
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _concentrationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Concentration (mol/L)',
                  hintText: 'e.g., 0.1',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.opacity, color: Colors.purple),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _volumeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Volume (mL)',
                  hintText: 'e.g., 250',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.water, color: Colors.purple),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Solvent
        TextField(
          controller: _solventController,
          decoration: InputDecoration(
            labelText: 'Solvent',
            hintText: 'e.g., Water, Ethanol',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: const Icon(Icons.local_drink, color: Colors.purple),
          ),
        ),
        const SizedBox(height: 16),
        
        // Calculate button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Placeholder for solution calculation
              setState(() {
                _solutionResult = 'Calculating solution preparation for ${_formulaController.text}...';
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Calculate Solution Preparation',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // Results section
        if (_solutionResult.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.purple.withOpacity(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Result:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(_solutionResult),
              ],
            ),
          ),
        
        const SizedBox(height: 24),
        
        // Common solution types
        const Text(
          'Common Solution Types',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildSolutionChip('Buffer', 'pH Control'),
            _buildSolutionChip('Standard', 'Calibration'),
            _buildSolutionChip('Isotonic', 'Same Osmotic Pressure'),
            _buildSolutionChip('Saturated', 'Maximum Concentration'),
          ],
        ),
      ],
    );
  }

  // Equation Balancer Calculator
  Widget _buildEquationBalancerCalculator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Equation Balancer',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Balance chemical equations automatically',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        
        // Unbalanced equation input
        TextField(
          controller: _equationController,
          decoration: InputDecoration(
            labelText: 'Unbalanced Equation',
            hintText: 'e.g., H2 + O2 = H2O',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: const Icon(Icons.compare_arrows, color: Colors.orange),
          ),
        ),
        const SizedBox(height: 16),
        
        // Balance button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Placeholder for equation balancing
              setState(() {
                _equationBalancerResult = 'Balancing equation: ${_equationController.text}...';
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Balance Equation',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // Results section
        if (_equationBalancerResult.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.withOpacity(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Balanced Equation:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(_equationBalancerResult),
                const SizedBox(height: 16),
                const Text(
                  'Step-by-step Explanation:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '1. Count atoms on each side\n'
                  '2. Set up algebraic equations\n'
                  '3. Solve for the coefficients\n'
                  '4. Verify the balance',
                ),
              ],
            ),
          ),
        
        const SizedBox(height: 24),
        
        // Common reaction types
        const Text(
          'Common Reaction Types',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildReactionChip('Synthesis', 'A + B → AB'),
            _buildReactionChip('Decomposition', 'AB → A + B'),
            _buildReactionChip('Single Displacement', 'A + BC → AC + B'),
            _buildReactionChip('Double Displacement', 'AB + CD → AD + CB'),
            _buildReactionChip('Combustion', 'CxHy + O2 → CO2 + H2O'),
            _buildReactionChip('Redox', 'Oxidation-Reduction'),
          ],
        ),
      ],
    );
  }

  // pH Calculator
  Widget _buildPHCalculator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'pH Calculator',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Calculate pH values for various solutions',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        
        // Type of solution dropdown
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Solution Type',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: const Icon(Icons.category, color: Colors.red),
          ),
          items: const [
            DropdownMenuItem(value: 'Strong Acid', child: Text('Strong Acid')),
            DropdownMenuItem(value: 'Weak Acid', child: Text('Weak Acid')),
            DropdownMenuItem(value: 'Strong Base', child: Text('Strong Base')),
            DropdownMenuItem(value: 'Weak Base', child: Text('Weak Base')),
            DropdownMenuItem(value: 'Salt', child: Text('Salt')),
            DropdownMenuItem(value: 'Buffer', child: Text('Buffer')),
          ],
          onChanged: (value) {},
          hint: const Text('Select solution type'),
        ),
        const SizedBox(height: 16),
        
        // Concentration or pKa/Ka
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _acidController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Concentration (M)',
                  hintText: 'e.g., 0.1',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.opacity, color: Colors.red),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _kaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Ka or pKa Value',
                  hintText: 'e.g., 1.8 × 10^-5',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.functions, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Calculate button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Placeholder for pH calculation
              setState(() {
                _phResult = 'Calculating pH...';
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Calculate pH',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // Results section
        if (_phResult.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.withOpacity(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'pH Result:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(_phResult),
                const SizedBox(height: 16),
                // pH scale visualization
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.orange,
                        Colors.yellow,
                        Colors.green,
                        Colors.blue,
                        Colors.indigo,
                        Colors.purple,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('0', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      Text('7', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text('14', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Acidic'),
                    Text('Neutral'),
                    Text('Basic'),
                  ],
                ),
              ],
            ),
          ),
        
        const SizedBox(height: 24),
        
        // Common acids and bases
        const Text(
          'Common Acids and Bases',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildAcidBaseChip('HCl', 'Strong Acid, pKa = -7'),
            _buildAcidBaseChip('H2SO4', 'Strong Acid, pKa = -3, 1.92'),
            _buildAcidBaseChip('CH3COOH', 'Weak Acid, pKa = 4.76'),
            _buildAcidBaseChip('NaOH', 'Strong Base, pKb = -0.8'),
            _buildAcidBaseChip('NH3', 'Weak Base, pKb = 4.75'),
            _buildAcidBaseChip('H3PO4', 'Weak Acid, pKa = 2.15, 7.20, 12.35'),
          ],
        ),
      ],
    );
  }

  // Gas Laws Calculator
  Widget _buildGasLawsCalculator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gas Laws Calculator',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Calculate gas properties using various gas laws',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        
        // Gas law type dropdown
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Gas Law',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: const Icon(Icons.air, color: Colors.teal),
          ),
          items: const [
            DropdownMenuItem(value: 'Ideal Gas Law', child: Text('Ideal Gas Law (PV = nRT)')),
            DropdownMenuItem(value: 'Boyle\'s Law', child: Text('Boyle\'s Law (P₁V₁ = P₂V₂)')),
            DropdownMenuItem(value: 'Charles\'s Law', child: Text('Charles\'s Law (V₁/T₁ = V₂/T₂)')),
            DropdownMenuItem(value: 'Avogadro\'s Law', child: Text('Avogadro\'s Law (V₁/n₁ = V₂/n₂)')),
            DropdownMenuItem(value: 'Gay-Lussac\'s Law', child: Text('Gay-Lussac\'s Law (P₁/T₁ = P₂/T₂)')),
            DropdownMenuItem(value: 'Combined Gas Law', child: Text('Combined Gas Law (P₁V₁/T₁ = P₂V₂/T₂)')),
          ],
          onChanged: (value) {},
          hint: const Text('Select gas law to use'),
        ),
        const SizedBox(height: 16),
        
        // Input variables
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _pressureController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Pressure (atm)',
                  hintText: 'e.g., 1.0',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.compress, color: Colors.teal),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _gasVolumeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Volume (L)',
                  hintText: 'e.g., 22.4',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.view_in_ar, color: Colors.teal),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _molsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Moles (mol)',
                  hintText: 'e.g., 1.0',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.scale, color: Colors.teal),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _temperatureController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Temperature (K)',
                  hintText: 'e.g., 273.15',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.thermostat, color: Colors.teal),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Calculate button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Placeholder for gas law calculation
              setState(() {
                _gasLawResult = 'Calculating using gas laws...';
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Calculate',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // Results section
        if (_gasLawResult.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.teal.withOpacity(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Gas Law Calculation Result:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(_gasLawResult),
                const SizedBox(height: 16),
                const Text(
                  'Key Constants:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '• R = 0.08206 L·atm/(mol·K)\n'
                  '• R = 8.314 J/(mol·K)\n'
                  '• Standard Temperature: 273.15 K (0°C)\n'
                  '• Standard Pressure: 1 atm (101.325 kPa)',
                ),
              ],
            ),
          ),
        
        const SizedBox(height: 24),
        
        // Gas law information
        const Text(
          'Gas Law Relationships',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _buildGasLawInfo('Boyle\'s Law', 'P₁V₁ = P₂V₂', 'Pressure and volume are inversely proportional'),
              const Divider(),
              _buildGasLawInfo('Charles\'s Law', 'V₁/T₁ = V₂/T₂', 'Volume and temperature are directly proportional'),
              const Divider(),
              _buildGasLawInfo('Gay-Lussac\'s Law', 'P₁/T₁ = P₂/T₂', 'Pressure and temperature are directly proportional'),
              const Divider(),
              _buildGasLawInfo('Avogadro\'s Law', 'V₁/n₁ = V₂/n₂', 'Volume and moles are directly proportional'),
              const Divider(),
              _buildGasLawInfo('Ideal Gas Law', 'PV = nRT', 'Combines all gas laws into one equation'),
            ],
          ),
        ),
      ],
    );
  }

  // Helper widget for compound chips
  Widget _buildCompoundChip(String formula, String description) {
    return Chip(
      avatar: const CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(Icons.science, size: 16, color: Colors.white),
      ),
      label: Text(
        '$formula: $description',
        style: const TextStyle(fontSize: 12),
      ),
      backgroundColor: Colors.blue.withOpacity(0.1),
    );
  }

  // Helper widget for solution chips
  Widget _buildSolutionChip(String type, String description) {
    return Chip(
      avatar: const CircleAvatar(
        backgroundColor: Colors.purple,
        child: Icon(Icons.opacity, size: 16, color: Colors.white),
      ),
      label: Text(
        '$type: $description',
        style: const TextStyle(fontSize: 12),
      ),
      backgroundColor: Colors.purple.withOpacity(0.1),
    );
  }

  // Helper widget for reaction chips
  Widget _buildReactionChip(String type, String example) {
    return Chip(
      avatar: const CircleAvatar(
        backgroundColor: Colors.orange,
        child: Icon(Icons.compare_arrows, size: 16, color: Colors.white),
      ),
      label: Text(
        '$type: $example',
        style: const TextStyle(fontSize: 12),
      ),
      backgroundColor: Colors.orange.withOpacity(0.1),
    );
  }

  // Helper widget for acid/base chips
  Widget _buildAcidBaseChip(String formula, String description) {
    return Chip(
      avatar: const CircleAvatar(
        backgroundColor: Colors.red,
        child: Icon(Icons.science, size: 16, color: Colors.white),
      ),
      label: Text(
        '$formula: $description',
        style: const TextStyle(fontSize: 12),
      ),
      backgroundColor: Colors.red.withOpacity(0.1),
    );
  }

  // Helper widget for gas law info
  Widget _buildGasLawInfo(String name, String equation, String description) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.teal.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            equation,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}