import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../constants/colors.dart';
import '../models/profile.dart';
import '../data/mock_profiles.dart';
import '../widgets/profile_card.dart';
import '../widgets/swipe_buttons.dart';

/// Écran d'accueil avec deck swipable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final CardSwiperController _cardController = CardSwiperController();
  List<Profile> _currentProfiles = [];
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _selectedTab = _tabController.index;
          _loadProfilesForTab(_selectedTab);
        });
      }
    });
    _loadProfilesForTab(0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  void _loadProfilesForTab(int index) {
    setState(() {
      switch (index) {
        case 0: // Tout
          _currentProfiles = List.from(mockProfiles);
          break;
        case 1: // Recommandés (filtre par âge)
          _currentProfiles = mockProfiles
              .where((p) => p.age >= 24 && p.age <= 30)
              .toList();
          break;
        case 2: // New (20 derniers profils)
          final sorted = List<Profile>.from(mockProfiles)
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
          _currentProfiles = sorted.take(20).toList();
          break;
      }
    });
  }

  bool _handleSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    final action = direction == CardSwiperDirection.left
        ? 'Refusé'
        : direction == CardSwiperDirection.right
            ? 'Like'
            : 'Match';
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$action : ${_currentProfiles[previousIndex].name}'),
        duration: const Duration(milliseconds: 800),
        backgroundColor: AppColors.primary,
      ),
    );
    
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Accueil',
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.text,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: 'Tout'),
                Tab(text: 'Recommandés'),
                Tab(text: 'New'),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: _currentProfiles.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 80,
                      color: AppColors.muted,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Plus de profils pour l\'instant',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  const SizedBox(height: 16),
                  
                  // Deck de cartes
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CardSwiper(
                        controller: _cardController,
                        cardsCount: _currentProfiles.length,
                        onSwipe: _handleSwipe,
                        numberOfCardsDisplayed: 3,
                        backCardOffset: const Offset(0, 40),
                        padding: const EdgeInsets.all(0),
                        cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                          return ProfileCard(profile: _currentProfiles[index]);
                        },
                      ),
                    ),
                  ),
                  
                  // Compteur de profils
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      '${_currentProfiles.length} profils restants',
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  
                  // Boutons d'action
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SwipeButtons(
                      onReject: () => _cardController.swipe(CardSwiperDirection.left),
                      onLike: () => _cardController.swipe(CardSwiperDirection.right),
                      onMatch: () => _cardController.swipe(CardSwiperDirection.top),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
