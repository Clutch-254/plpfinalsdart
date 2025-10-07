# chemgeekplp


## Overview
ChemGeek is a comprehensive mobile application built with Flutter, designed for chemistry enthusiasts, students, and professionals. It provides powerful computational and visualization tools for chemical equations, molecular structures, and various chemistry calculations, making chemistry more accessible and interactive for users at all expertise levels.

## Application Structure

### 1. Bottom Navigation Bar (`bottomnav.dart`)
The primary navigation interface using Flutter's `curved_navigation_bar` package.

**Features:**
- Four main sections: Home, Molecular Visualizer, Calculator Hub, and Profile
- Indigo color scheme with smooth 500ms animations
- Curved design for visual appeal and clear navigation feedback
- State management for tab switching

**Key Code Components:**
```dart
- StatefulWidget for dynamic navigation
- List<Widget> pages for managing screen content
- CurvedNavigationBar widget with custom icons
- currentTabIndex tracking for active page
```

### 2. Homepage (`homepage.dart`)
The central dashboard and landing page for users.

**Features:**
- Personalized welcome card with user info and last login
- Quick Access Tools grid (6 cards) for instant feature navigation
- Recent Calculations list tracking user history
- Horizontally scrollable Chemistry News section
- Search, notifications, and profile access in app bar

**Key Code Components:**
```dart
- SingleChildScrollView for scrollable content
- GridView.count for Quick Access Tools layout
- ListView.builder for Recent Calculations
- Mock data structures for user info, calculations, and news
- Card-based UI design with color-coded icons
```

### 3. Calculator Hub (`calculatorhub.dart`)
A comprehensive toolkit with six specialized chemistry calculators.

**Features:**
- **Molecular Weight Calculator**: Calculate compound molecular weights
- **Stoichiometry Calculator**: Reaction yields and limiting reagents
- **Solution Calculator**: Prepare solutions with specific concentrations
- **Equation Balancer**: Auto-balance chemical equations with explanations
- **pH Calculator**: Calculate pH for acids, bases, and buffers with visual scale
- **Gas Laws Calculator**: PV=nRT and related gas law computations

**Key Code Components:**
```dart
- Split-screen layout with sidebar and main content area
- Multiple TextEditingControllers for input fields
- Switch-case structure for calculator selection
- Custom helper widgets for chips and info cards
- Color-coded calculators for easy identification
- Reference materials (common compounds, constants, formulas)
```

### 4. Molecular Visualizer (`molecularvisualizer.dart`)
Advanced dual-mode molecular structure tool with 3D and 2D capabilities.

**Features:**
- **3D View Mode**: 
  - Interactive rotation (drag to rotate)
  - Auto-rotation toggle
  - Zoom controls
  - Real-time visualization with proper atom colors
  
- **2D Editor Mode**:
  - Draw custom molecular structures
  - Add atoms (C, H, O, N, S, P, F, Cl, Br)
  - Create bonds (single, double, triple, wedge, dash)
  - Select, move, and erase tools
  - Grid-based precision placement

- **Additional Features**:
  - Quick Access Molecules library (Water, Methane, Benzene, Ethanol, Glucose)
  - Structural properties panel (formula, weight, angles, geometry, etc.)
  - Import/Export support (MOL, PDB, XYZ, CML, SMILES, PNG, SVG)

**Key Code Components:**
```dart
- SingleTickerProviderStateMixin for animations
- AnimationController for 3D rotation
- CustomPainter classes (Molecule3DPainter, Molecule2DPainter)
- GestureDetector for interactive controls
- Transform matrix for 3D rotations
- Lists for tracking atoms and bonds in 2D editor
- Dialog widgets for import/export/help
```

## Coding Breakdown

### Development Process

**1. Setup & Dependencies**
```yaml
dependencies:
  flutter: sdk
  curved_navigation_bar: ^1.0.3
```

**2. Navigation Structure**
- Created `Bottomnavuser` as the root widget
- Implemented state management for tab switching
- Connected all four main pages

**3. UI Development**
- Designed consistent indigo color scheme
- Built reusable card-based components
- Implemented responsive layouts with Row, Column, Grid
- Added icons and visual feedback elements

**4. Calculator Implementation**
- Created modular calculator widgets
- Set up input controllers for all fields
- Designed result display containers
- Added reference materials and helper chips

**5. Visualizer Development**
- Implemented CustomPainter for 2D/3D rendering
- Added animation controller for rotations
- Created gesture handling for interactivity
- Built atom/bond drawing logic

**6. Data Management**
- Used mock data structures for demonstration
- Implemented state management with setState()
- Created data models for molecules, calculations, and news

### Code Architecture

```
lib/
├── user/
│   ├── bottomnavuser.dart      (Navigation root)
│   ├── homepageuser.dart        (Dashboard)
│   ├── calculatorhub.dart       (Calculators)
│   ├── molecularvisualizer.dart (3D/2D viewer)
│   └── profileuser.dart         (User profile)
└── assets/
    ├── images/
    │   └── logo.png
    └── structures/
        └── *.mol files
```

### Key Flutter Concepts Used

1. **State Management**: StatefulWidget with setState()
2. **Custom Painting**: CustomPainter for molecular rendering
3. **Animations**: AnimationController and Transform
4. **Gestures**: GestureDetector for drag and tap events
5. **Layouts**: Row, Column, GridView, ListView
6. **Navigation**: Page switching with indexed display
7. **Forms**: TextEditingController for input handling
8. **Dialogs**: AlertDialog for import/export/help

## Installation & Setup

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Add logo and structure files to assets folder
4. Update `pubspec.yaml` with asset paths
5. Run `flutter run` to launch the app

## Future Enhancements

- Backend integration for real calculations
- Database for saving user data and calculations
- Actual 3D rendering library integration (Three.js equivalent)
- Real-time chemistry news API integration
- User authentication and cloud sync
- Periodic table feature implementation
- Advanced molecular modeling algorithms



**Built with Flutter**