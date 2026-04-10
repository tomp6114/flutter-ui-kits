import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/features/catalog/domain/entities/catalog_component.dart';

import 'package:flutter_ui_kits/shared/widgets/buttons/primary_button.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/secondary_button.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/neumorphic_button.dart';
import 'package:flutter_ui_kits/shared/widgets/inputs/text_field_kit.dart';
import 'package:flutter_ui_kits/shared/widgets/inputs/otp_input.dart';
import 'package:flutter_ui_kits/shared/widgets/cards/glassmorphism_card.dart';
import 'package:flutter_ui_kits/features/dashboard/stats_row.dart';
import 'package:flutter_ui_kits/features/dashboard/activity_feed.dart';
import 'package:flutter_ui_kits/shared/painters/shapes/wave_painter.dart';
import 'package:flutter_ui_kits/shared/painters/charts/bar_chart_painter.dart';

class CatalogDataRegistry {
  static List<CatalogCategory> get categories => [
    CatalogCategory(
      name: 'Modern Patterns',
      icon: Icons.auto_awesome_mosaic_rounded,
      components: [
        CatalogComponent(
          name: 'Dashboard Stats',
          category: 'Patterns',
          importPath: "import 'patterns/dashboard/stats_row.dart';",
          preview: const StatsRow(stats: []),
        ),
        CatalogComponent(
          name: 'Activity Timeline',
          category: 'Patterns',
          importPath: "import 'patterns/dashboard/activity_feed.dart';",
          preview: const ActivityFeed(groups: []),
        ),
      ],
    ),
    CatalogCategory(
      name: 'Visual Effects',
      icon: Icons.blur_on_rounded,
      components: [
        CatalogComponent(
          name: 'Glassmorphism Card',
          category: 'Effects',
          importPath: "import 'components/cards/glassmorphism_card.dart';",
          preview: const GlassmorphismCard(child: Text('Frosted Glass')),
        ),
        CatalogComponent(
          name: 'Neumorphic Button',
          category: 'Effects',
          importPath: "import 'components/buttons/neumorphic_button.dart';",
          preview: const NeumorphicButton(child: Text('Press Me')),
        ),
      ],
    ),
    CatalogCategory(
      name: 'Buttons',
      icon: Icons.smart_button_rounded,
      components: [
        CatalogComponent(
          name: 'Primary Action',
          category: 'Buttons',
          importPath: "import 'components/buttons/primary_button.dart';",
          preview: PrimaryButton(label: 'Get Started', onPressed: () {}),
        ),
        CatalogComponent(
          name: 'Secondary Action',
          category: 'Buttons',
          importPath: "import 'components/buttons/secondary_button.dart';",
          preview: SecondaryButton(label: 'Cancel', onPressed: () {}),
        ),
      ],
    ),
    CatalogCategory(
      name: 'Inputs',
      icon: Icons.input_rounded,
      components: [
        CatalogComponent(
          name: 'Adaptive Text Field',
          category: 'Inputs',
          importPath: "import 'components/inputs/text_field_kit.dart';",
          preview: const TextFieldKit(label: 'Username', hint: 'Enter name', prefixIcon: Icon(Icons.person)),
        ),
        CatalogComponent(
          name: 'Otp Input Grid',
          category: 'Inputs',
          importPath: "import 'components/inputs/otp_input.dart';",
          preview: OtpInput(onCompleted: (_) {}),
        ),
      ],
    ),
    CatalogCategory(
      name: 'Painters & Charts',
      icon: Icons.brush_rounded,
      components: [
        CatalogComponent(
          name: 'Custom Wave',
          category: 'Painters',
          importPath: "import 'painters/shapes/wave_painter.dart';",
          preview: SizedBox(height: 100, width: 200, child: CustomPaint(painter: WavePainter(color: Colors.blue))),
        ),
        CatalogComponent(
          name: 'Bar Trends',
          category: 'Painters',
          importPath: "import 'painters/charts/bar_chart_painter.dart';",
          preview: const SizedBox(height: 150, width: 250, child: BarChartPainter(data: [BarData(value: 60, label: 'X'), BarData(value: 90, label: 'Y')])),
        ),
      ],
    ),
  ];
}
