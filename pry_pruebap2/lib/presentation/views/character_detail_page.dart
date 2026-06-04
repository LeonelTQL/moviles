import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/character.dart';
import '../viewmodels/character_viewmodel.dart';

class CharacterDetailPage extends StatelessWidget {
  const CharacterDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final character = ModalRoute.of(context)!.settings.arguments as Character;

    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        backgroundColor: const Color(0xFF2563EB),
      ),
      body: FutureBuilder<Character?>(
        future: Provider.of<CharacterViewModel>(context, listen: false)
            .getCharacterDetails(character.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final fullCharacter = snapshot.data ?? character;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Hero(
                    tag: character.id,
                    child: Image.network(
                      fullCharacter.image,
                      height: 300,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  fullCharacter.name,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${fullCharacter.race} - ${fullCharacter.gender}",
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                const Divider(),
                const Text(
                  "Descripción",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(fullCharacter.description),
                const SizedBox(height: 20),
                _InfoRow(label: "Ki", value: fullCharacter.ki),
                _InfoRow(label: "Max Ki", value: fullCharacter.maxKi),
                _InfoRow(label: "Afiliación", value: fullCharacter.affiliation),
                if (fullCharacter.originPlanet != null) ...[
                  const Divider(),
                  const Text(
                    "Planeta de Origen",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(fullCharacter.originPlanet!.name),
                    subtitle: Text(fullCharacter.originPlanet!.description),
                    leading: Image.network(fullCharacter.originPlanet!.image, width: 50),
                  ),
                ],
                if (fullCharacter.transformations != null &&
                    fullCharacter.transformations!.isNotEmpty) ...[
                  const Divider(),
                  const Text(
                    "Transformaciones",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: fullCharacter.transformations!.length,
                      itemBuilder: (context, index) {
                        final trans = fullCharacter.transformations![index];
                        return Container(
                          width: 120,
                          margin: const EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.network(trans.image, fit: BoxFit.contain),
                              ),
                              Text(trans.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12)),
                              Text(trans.ki,
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.orange)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
