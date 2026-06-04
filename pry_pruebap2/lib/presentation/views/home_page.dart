import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/character_viewmodel.dart';
import '../../domain/entities/character.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<CharacterViewModel>(
        context,
        listen: false,
      ).loadCharacters();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CharacterViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      appBar: AppBar(
        title: const Text(
          'Dragon Ball Characters',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF2563EB),
        elevation: 0,
        centerTitle: true,
      ),
      body: vm.loading
          ? const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF38BDF8),
        ),
      )
          : vm.errorMessage != null
          ? Center(
        child: Text(
          vm.errorMessage!,
          style: const TextStyle(color: Colors.white),
        ),
      )
          : LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 2;
          double childAspectRatio = 0.72;
          double imageHeight = 230;
          bool isMobile = false;

          if (constraints.maxWidth >= 1100) {
            crossAxisCount = 4;
            childAspectRatio = 0.72;
            imageHeight = 230;
            isMobile = false;
          } else if (constraints.maxWidth >= 800) {
            crossAxisCount = 3;
            childAspectRatio = 0.68;
            imageHeight = 210;
            isMobile = false;
          } else {
            crossAxisCount = 2;
            childAspectRatio = 0.52;
            imageHeight = 135;
            isMobile = true;
          }

          return GridView.builder(
            padding: EdgeInsets.all(isMobile ? 12 : 24),
            itemCount: vm.characters.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: isMobile ? 12 : 28,
              mainAxisSpacing: isMobile ? 12 : 28,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder: (_, index) {
              final character = vm.characters[index];

              return CharacterGridItem(
                character: character,
                imageHeight: imageHeight,
                isMobile: isMobile,
              );
            },
          );
        },
      ),
    );
  }
}

class CharacterGridItem extends StatelessWidget {
  final Character character;
  final double imageHeight;
  final bool isMobile;

  const CharacterGridItem({
    super.key,
    required this.character,
    required this.imageHeight,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.pushNamed(
          context,
          "/detalle",
          arguments: character,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F2937),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: imageHeight,
                width: double.infinity,
                child: Container(
                  color: const Color(0xFFE5E7EB),
                  child: Hero(
                    tag: character.id,
                    child: Padding(
                      padding: EdgeInsets.all(isMobile ? 6 : 10),
                      child: Image.network(
                        character.image,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image_not_supported,
                            color: Color(0xFF64748B),
                            size: 45,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    isMobile ? 9 : 14,
                    isMobile ? 8 : 10,
                    isMobile ? 9 : 14,
                    isMobile ? 8 : 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        character.name,
                        style: TextStyle(
                          color: const Color(0xFFF9FAFB),
                          fontSize: isMobile ? 15 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 3),

                      Text(
                        "${character.race} - ${character.gender}",
                        style: TextStyle(
                          color: const Color(0xFF38BDF8),
                          fontSize: isMobile ? 12 : 15,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: isMobile ? 6 : 10),

                      _InfoLabelValue(
                        label: "Base Ki:",
                        value: character.ki,
                        isMobile: isMobile,
                      ),

                      SizedBox(height: isMobile ? 4 : 6),

                      _InfoLabelValue(
                        label: "Total Ki:",
                        value: character.maxKi,
                        isMobile: isMobile,
                      ),

                      SizedBox(height: isMobile ? 4 : 6),

                      _InfoLabelValue(
                        label: "Affiliation:",
                        value: character.affiliation,
                        isMobile: isMobile,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoLabelValue extends StatelessWidget {
  final String label;
  final String value;
  final bool isMobile;

  const _InfoLabelValue({
    required this.label,
    required this.value,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFFD1D5DB),
            fontSize: isMobile ? 10.5 : 13,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 1),

        Text(
          value,
          style: TextStyle(
            color: const Color(0xFF5EEAD4),
            fontSize: isMobile ? 11.5 : 14,
            fontWeight: FontWeight.w700,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}