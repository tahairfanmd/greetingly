import 'package:flutter/material.dart';

void main() {
  runApp(const GreetinglyApp());
}

const Color purple = Color(0xFF8656B5);
const Color ink = Color(0xFF583778);
const Color page = Color(0xFFFFF8FC);

final CardStore cardStore = CardStore();

class GreetinglyApp extends StatelessWidget {
  const GreetinglyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Greetingly - Greeting Card Creator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: page,
        colorScheme: ColorScheme.fromSeed(seedColor: purple),
        appBarTheme: const AppBarTheme(
          backgroundColor: page,
          foregroundColor: ink,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE4D8ED)),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class GreetingCard {
  final String receiver;
  final String sender;
  final String occasion;
  final String message;
  final int templateIndex;

  const GreetingCard({
    required this.receiver,
    required this.sender,
    required this.occasion,
    required this.message,
    required this.templateIndex,
  });
}

class CardStore extends ChangeNotifier {
  final List<GreetingCard> _cards = [];

  List<GreetingCard> get cards => List.unmodifiable(_cards);

  void add(GreetingCard card) {
    _cards.insert(0, card);
    notifyListeners();
  }
}

class CardTemplate {
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color secondColor;

  const CardTemplate({
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.secondColor,
  });
}

const List<CardTemplate> cardTemplates = [
  CardTemplate(
    name: 'Birthday',
    subtitle: 'Make their day special',
    icon: Icons.cake_rounded,
    color: Color(0xFFFFD6E7),
    secondColor: Color(0xFFFFEAF2),
  ),
  CardTemplate(
    name: 'Anniversary',
    subtitle: 'Celebrate togetherness',
    icon: Icons.favorite_rounded,
    color: Color(0xFFFFDCE0),
    secondColor: Color(0xFFFFEEF0),
  ),
  CardTemplate(
    name: 'Wedding',
    subtitle: 'A beautiful new beginning',
    icon: Icons.diamond_rounded,
    color: Color(0xFFE1D7FF),
    secondColor: Color(0xFFF1ECFF),
  ),
  CardTemplate(
    name: 'Eid',
    subtitle: 'Spread joy and blessings',
    icon: Icons.nightlight_round,
    color: Color(0xFFD5F0E4),
    secondColor: Color(0xFFECFAF3),
  ),
  CardTemplate(
    name: 'Festival',
    subtitle: 'Celebrate every moment',
    icon: Icons.celebration_rounded,
    color: Color(0xFFFFE9C9),
    secondColor: Color(0xFFFFF4E4),
  ),
  CardTemplate(
    name: 'Congratulations',
    subtitle: 'Celebrate achievements',
    icon: Icons.emoji_events_rounded,
    color: Color(0xFFDCE8FF),
    secondColor: Color(0xFFEEF3FF),
  ),
  CardTemplate(
    name: 'Love & Care',
    subtitle: 'Send a little love',
    icon: Icons.volunteer_activism_rounded,
    color: Color(0xFFFFE0EF),
    secondColor: Color(0xFFFFF0F7),
  ),
  CardTemplate(
    name: 'Special Moments',
    subtitle: 'Make memories last',
    icon: Icons.stars_rounded,
    color: Color(0xFFE9E0FF),
    secondColor: Color(0xFFF5F0FF),
  ),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void openCreate(BuildContext context, {String occasion = 'Birthday'}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CreateCardScreen(initialOccasion: occasion),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Greetingly ✨',
          style: TextStyle(fontWeight: FontWeight.bold, color: ink),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TemplatesScreen()),
            ),
            child: const Text('Templates'),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SavedCardsScreen()),
            ),
            child: const Text('My Cards'),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final desktop = constraints.maxWidth > 700;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: desktop ? 48 : 20,
              vertical: 24,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(desktop ? 36 : 24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFEAD9FF), Color(0xFFFFDDEB)],
                        ),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Flex(
                        direction: desktop ? Axis.horizontal : Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: desktop ? 3 : 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Make Every Moment Special ❤️',
                                  style: TextStyle(
                                    fontSize: desktop ? 32 : 25,
                                    fontWeight: FontWeight.bold,
                                    color: ink,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Create beautiful personalized greeting cards '
                                  'for the people you love.',
                                  style: TextStyle(fontSize: 16, height: 1.5),
                                ),
                                const SizedBox(height: 22),
                                FilledButton.icon(
                                  onPressed: () => openCreate(context),
                                  icon: const Icon(Icons.add),
                                  label: const Text('Create Your Card'),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: purple,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 22,
                                      vertical: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (desktop)
                            const Expanded(
                              flex: 2,
                              child: Icon(
                                Icons.card_giftcard_rounded,
                                size: 150,
                                color: purple,
                              ),
                            )
                          else
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Icon(
                                Icons.card_giftcard_rounded,
                                size: 90,
                                color: purple,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 34),
                    const SectionTitle('Choose an Occasion'),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: cardTemplates.map((template) {
                        return ActionChip(
                          avatar: Icon(template.icon, size: 18),
                          label: Text(template.name),
                          onPressed: () => openCreate(
                            context,
                            occasion: template.name,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 34),
                    const SectionTitle('Explore Card Templates'),
                    const SizedBox(height: 14),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: desktop ? 4 : 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: desktop ? 1.25 : 0.95,
                      ),
                      itemBuilder: (context, index) => TemplateTile(
                        template: cardTemplates[index],
                        onTap: () => openCreate(
                          context,
                          occasion: cardTemplates[index].name,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Center(
                      child: Text(
                        'Made with ❤️ for your loved ones',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}

class TemplateTile extends StatelessWidget {
  final CardTemplate template;
  final VoidCallback onTap;

  const TemplateTile({
    super.key,
    required this.template,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.92, end: 1),
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) =>
          Transform.scale(scale: scale, child: child),
      child: Card(
        elevation: 2,
        color: template.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(template.icon, size: 48, color: purple),
                const SizedBox(height: 12),
                Text(
                  template.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 7),
                const Text('Create now →'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TemplatesScreen extends StatelessWidget {
  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Greeting Card Templates ✨')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth > 950
              ? 4
              : constraints.maxWidth > 600
                  ? 3
                  : 2;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle('Choose Your Favourite Design ❤️'),
                    const SizedBox(height: 8),
                    const Text(
                      'Select a template and personalize it with your own message.',
                    ),
                    const SizedBox(height: 22),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cardTemplates.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,
                        childAspectRatio: 0.95,
                      ),
                      itemBuilder: (context, index) {
                        final template = cardTemplates[index];
                        return TemplateTile(
                          template: template,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CreateCardScreen(
                                initialOccasion: template.name,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CreateCardScreen extends StatefulWidget {
  final String initialOccasion;

  const CreateCardScreen({
    super.key,
    this.initialOccasion = 'Birthday',
  });

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _receiverController = TextEditingController();
  final _senderController = TextEditingController();
  final _messageController = TextEditingController();

  late String _occasion;
  int _templateIndex = 0;

  @override
  void initState() {
    super.initState();
    _occasion = widget.initialOccasion;
    _templateIndex = cardTemplates.indexWhere((t) => t.name == _occasion);
    if (_templateIndex < 0) _templateIndex = 0;
  }

  @override
  void dispose() {
    _receiverController.dispose();
    _senderController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Your Card')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle('Design Your Greeting Card ✨'),
                  const SizedBox(height: 8),
                  const Text('Fill in the details to create a special card.'),
                  const SizedBox(height: 25),
                  const Text('Receiver Name'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _receiverController,
                    decoration: const InputDecoration(
                      hintText: 'Enter receiver name',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Please enter receiver name'
                        : null,
                  ),
                  const SizedBox(height: 18),
                  const Text('Your Name'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _senderController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                      prefixIcon: Icon(Icons.edit_outlined),
                    ),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Please enter your name'
                        : null,
                  ),
                  const SizedBox(height: 18),
                  const Text('Select Occasion'),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _occasion,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.celebration_outlined),
                    ),
                    items: cardTemplates
                        .map((t) => DropdownMenuItem(
                              value: t.name,
                              child: Text(t.name),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _occasion = value;
                        _templateIndex =
                            cardTemplates.indexWhere((t) => t.name == value);
                      });
                    },
                  ),
                  const SizedBox(height: 18),
                  const Text('Your Message'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _messageController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Write your special message...',
                      alignLabelWithHint: true,
                    ),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Please enter a message'
                        : null,
                  ),
                  const SizedBox(height: 24),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: cardTemplates[_templateIndex].color,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        Icon(cardTemplates[_templateIndex].icon,
                            size: 38, color: purple),
                        const SizedBox(height: 8),
                        Text(
                          'Preview style: $_occasion',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ink,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _generateCard,
                      icon: const Icon(Icons.card_giftcard),
                      label: const Text('Generate Greeting Card'),
                      style: FilledButton.styleFrom(
                        backgroundColor: purple,
                        padding: const EdgeInsets.symmetric(vertical: 17),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _generateCard() {
    if (!_formKey.currentState!.validate()) return;

    final card = GreetingCard(
      receiver: _receiverController.text.trim(),
      sender: _senderController.text.trim(),
      occasion: _occasion,
      message: _messageController.text.trim(),
      templateIndex: _templateIndex,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PreviewScreen(card: card)),
    );
  }
}

class PreviewScreen extends StatefulWidget {
  final GreetingCard card;
  const PreviewScreen({super.key, required this.card});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  bool _saved = false;

  @override
  Widget build(BuildContext context) {
    final template = cardTemplates[widget.card.templateIndex];
    return Scaffold(
      appBar: AppBar(title: const Text('Your Greeting Card')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.85, end: 1),
              duration: const Duration(milliseconds: 650),
              curve: Curves.easeOutBack,
              builder: (context, scale, child) =>
                  Transform.scale(scale: scale, child: child),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [template.color, template.secondColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: purple.withOpacity(0.15),
                      blurRadius: 22,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(template.icon, size: 58, color: purple),
                    const SizedBox(height: 20),
                    Text(
                      '${widget.card.occasion} Wishes!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                        color: ink,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      'Dear ${widget.card.receiver},',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.card.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 17, height: 1.5),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'With love, ${widget.card.sender} ❤️',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ink,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Made with Greetingly ✨',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.edit),
                label: const Text('Edit Card'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: _saved
                    ? null
                    : () {
                        cardStore.add(widget.card);
                        setState(() => _saved = true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Card saved in My Cards!'),
                          ),
                        );
                      },
                icon: Icon(_saved ? Icons.check : Icons.bookmark_add),
                label: Text(_saved ? 'Saved' : 'Save Card'),
                style: FilledButton.styleFrom(backgroundColor: purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SavedCardsScreen extends StatelessWidget {
  const SavedCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Saved Cards')),
      body: AnimatedBuilder(
        animation: cardStore,
        builder: (context, _) {
          final cards = cardStore.cards;
          if (cards.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.card_giftcard, size: 65, color: purple),
                    SizedBox(height: 14),
                    Text(
                      'No saved cards yet',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Create a greeting card and tap Save Card.'),
                  ],
                ),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(18),
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];
              final template = cardTemplates[card.templateIndex];
              return Card(
                color: template.color,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Icon(template.icon, color: purple, size: 32),
                  title: Text(
                    '${card.occasion} for ${card.receiver}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('From ${card.sender}: ${card.message}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
