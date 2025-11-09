# 📖 MatchUp - Documentation Complète pour IA

**Version** : 1.0.0 (Navigation complète)  
**Dernière mise à jour** : Session initiale  
**Durée de lecture** : 10 minutes

---

## 📋 Table des matières

1. [Vue d'ensemble](#vue-densemble)
2. [Architecture technique](#architecture-technique)
3. [Fonctionnalités détaillées](#fonctionnalités-détaillées)
4. [Structure des données](#structure-des-données)
5. [Conventions de code](#conventions-de-code)
6. [Workflow de développement](#workflow-de-développement)
7. [Problèmes connus et solutions](#problèmes-connus-et-solutions)
8. [Roadmap](#roadmap)

---

## 📱 Vue d'ensemble

### Concept
**MatchUp** est une application de rencontre moderne utilisant l'IA pour connecter des utilisateurs compatibles. Interface style Tinder avec swipe, chat intégré et filtres intelligents.

### Technologies
- **Framework** : Flutter 3.35.4 (⚠️ VERSION VERROUILLÉE)
- **Langage** : Dart 3.9.2 (⚠️ VERSION VERROUILLÉE)
- **Plateforme cible** : Web (preview) + Android (production future)
- **État actuel** : Prototype fonctionnel avec données mock

### Dépendances principales
```yaml
dependencies:
  flutter_card_swiper: ^7.2.0    # Deck swipable Tinder-style
  go_router: ^14.8.1              # Navigation avancée
  provider: ^6.1.5                # State management
  cupertino_icons: ^1.0.8         # Icônes iOS
```

---

## 🏗️ Architecture technique

### Structure globale

```
flutter_app/
├── lib/
│   ├── main.dart                         # Point d'entrée + MainScreen
│   ├── constants/
│   │   └── colors.dart                   # Charte graphique
│   ├── models/
│   │   ├── profile.dart                  # Modèle Profile
│   │   └── message.dart                  # Modèles Message + Conversation
│   ├── data/
│   │   └── mock_profiles.dart            # 30 profils + 3 conversations mock
│   ├── widgets/
│   │   ├── custom_button.dart            # Bouton primaire
│   │   ├── custom_text_field.dart        # Champ de texte stylisé
│   │   ├── profile_card.dart             # Carte profil pour deck
│   │   ├── swipe_buttons.dart            # 3 boutons d'action (Refuser/Match/Like)
│   │   └── chat_bubble.dart              # Bulle de message
│   └── screens/
│       ├── start_screen.dart             # Écran de démarrage
│       ├── sign_in_screen.dart           # Connexion
│       ├── sign_up_screen.dart           # Inscription
│       ├── home_screen.dart              # Deck swipable + filtres
│       ├── matches_screen.dart           # Placeholder (à développer)
│       ├── profile_screen.dart           # Placeholder (à développer)
│       ├── chat_list_screen.dart         # Liste conversations
│       └── chat_detail_screen.dart       # Détail conversation
├── assets/
│   └── icons/
│       └── app_icon.png                  # Icône personnalisée (coeur rouge)
├── android/                               # Config Android
├── web/                                   # Config Web
├── pubspec.yaml                          # Dépendances
├── AI_QUICK_START.md                     # Guide express (ce fichier)
└── CONTEXT.md                            # Documentation complète

```

### Navigation

**Architecture de navigation à 2 niveaux :**

1. **Niveau Auth** (Stack navigation)
   - `StartScreen` (écran d'accueil)
     - Bouton "Accès Démo" → MainScreen (direct)
     - Bouton "Démarrer" → SignInScreen
   - `SignInScreen`
     - Bouton "Se connecter" → MainScreen (après validation)
     - Lien "Créer un compte" → SignUpScreen
   - `SignUpScreen`
     - Bouton "S'inscrire" → MainScreen (après validation)
     - Lien "J'ai déjà un compte" → SignInScreen (pop)

2. **Niveau Main** (Bottom Navigation)
   - `MainScreen` (Container avec BottomNavigationBar)
     - Tab 0: HomeScreen (Accueil)
     - Tab 1: MatchesScreen (Matchs)
     - Tab 2: ChatListScreen (Chat)
     - Tab 3: ProfileScreen (Profil)
   
   **Navigation depuis Chat :**
   - ChatListScreen → ChatDetailScreen (push)
   - ChatDetailScreen → retour (pop)

### Pattern de state management

**Approche actuelle** : StatefulWidget local (simple pour prototype)

```dart
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Profile> _currentProfiles = [];
  int _selectedTab = 0;
  
  @override
  void initState() {
    super.initState();
    _loadProfilesForTab(0);
  }
  
  void _loadProfilesForTab(int index) {
    setState(() {
      // Mise à jour des profils selon le filtre
    });
  }
}
```

**Future** : Provider ou Riverpod pour gérer l'état global (likes, matchs, messages).

---

## ⚙️ Fonctionnalités détaillées

### 1. Écran de démarrage (StartScreen)

**Fichier** : `lib/screens/start_screen.dart`

**Éléments UI** :
- Icône app (Container rouge avec cœur blanc)
- Titre : "Trouvez votre match parfait avec l'IA"
- Sous-titre descriptif
- **Bouton "Accès Démo"** (primaire) → Navigation directe vers MainScreen
- **Bouton "Démarrer"** (outlined) → Navigation vers SignInScreen
- Footer mentions légales

**Points clés** :
- Bouton "Accès Démo" ajouté pour faciliter les tests (pas de formulaire requis)
- Utilise `CustomButton` widget

### 2. Authentification (SignInScreen / SignUpScreen)

**Fichiers** :
- `lib/screens/sign_in_screen.dart`
- `lib/screens/sign_up_screen.dart`

**SignInScreen** :
- Champs : Email, Mot de passe (avec toggle visibilité)
- Validation : Email doit contenir @, mot de passe min 6 caractères
- Bouton "Se connecter" → `Navigator.pushAndRemoveUntil` vers MainScreen
- Lien "Créer un compte" → push vers SignUpScreen
- Lien "Mot de passe oublié ?" (placeholder)

**SignUpScreen** :
- Champs : Nom, Email, Mot de passe, Confirmer mot de passe
- Validation : Nom min 2 caractères, vérification correspondance mots de passe
- Bouton "S'inscrire" → `Navigator.pushAndRemoveUntil` vers MainScreen
- Lien "J'ai déjà un compte" → pop vers SignInScreen

**Pattern de navigation** :
```dart
void _handleSignIn() {
  if (_formKey.currentState!.validate()) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (route) => false, // Supprime toute la stack
    );
  }
}
```

### 3. Écran Accueil (HomeScreen)

**Fichier** : `lib/screens/home_screen.dart`

**Composants** :
- **TabController** : 3 onglets (Tout, Recommandés, New)
- **CardSwiper** : Deck de cartes swipable
- **ProfileCard** : Widget carte profil
- **SwipeButtons** : 3 boutons d'action

**Logique des filtres** :
```dart
void _loadProfilesForTab(int index) {
  setState(() {
    switch (index) {
      case 0: // Tout
        _currentProfiles = List.from(mockProfiles);
        break;
      case 1: // Recommandés (filtré par âge 24-30)
        _currentProfiles = mockProfiles
            .where((p) => p.age >= 24 && p.age <= 30)
            .toList();
        break;
      case 2: // New (20 derniers profils par date)
        final sorted = List<Profile>.from(mockProfiles)
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        _currentProfiles = sorted.take(20).toList();
        break;
    }
  });
}
```

**Gestes swipe** :
- Gauche → Refuser
- Droite → Like
- Haut → Match (super like)

**Callback swipe** :
```dart
bool _handleSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
  final action = direction == CardSwiperDirection.left
      ? 'Refusé'
      : direction == CardSwiperDirection.right
          ? 'Like'
          : 'Match';
  
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('$action : ${_currentProfiles[previousIndex].name}')),
  );
  
  return true; // Important : renvoyer true pour valider le swipe
}
```

**ProfileCard widget** :
- Image pleine taille avec NetworkImage
- Gradient overlay (transparent → noir en bas)
- Informations : Nom, âge, métier, distance
- Chips d'intérêts (badges arrondis)

### 4. Chat (ChatListScreen / ChatDetailScreen)

**ChatListScreen** (`lib/screens/chat_list_screen.dart`) :
- Barre de recherche (placeholder)
- Liste des conversations (ListTile)
- Badge rouge pour messages non lus
- Format heure relative : "Il y a 5 min", "Hier", etc.

**ChatDetailScreen** (`lib/screens/chat_detail_screen.dart`) :
- Header : Avatar + nom du match
- Liste de messages (ChatBubble widget)
- Zone de saisie en bas (TextField + bouton Send)
- Envoi de messages fonctionnel (ajout immédiat à la liste)

**Pattern d'envoi message** :
```dart
void _sendMessage() {
  if (_messageController.text.trim().isEmpty) return;

  final newMessage = Message(
    id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
    senderId: 'me',
    senderName: 'Moi',
    content: _messageController.text.trim(),
    timestamp: DateTime.now(),
    isMe: true,
  );

  setState(() {
    _messages.add(newMessage);
  });

  _messageController.clear();
}
```

### 5. Placeholders (MatchesScreen / ProfileScreen)

**Fichiers** :
- `lib/screens/matches_screen.dart`
- `lib/screens/profile_screen.dart`

**État actuel** : Écrans vides avec texte "Contenu à venir"

**À développer** :
- **MatchesScreen** : Grille de profils matchés, filtres, animations
- **ProfileScreen** : Formulaire édition profil, photos, préférences

---

## 💾 Structure des données

### Modèle Profile

**Fichier** : `lib/models/profile.dart`

```dart
class Profile {
  final String id;
  final String name;
  final int age;
  final String jobTitle;
  final double distanceKm;
  final List<String> interests;
  final String photo;           // URL ou asset
  final DateTime createdAt;
  final String gender;          // 'male', 'female', 'other'

  const Profile({...});
}
```

### Modèle Message

**Fichier** : `lib/models/message.dart`

```dart
class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String content;
  final DateTime timestamp;
  final bool isMe;

  const Message({...});
}
```

### Modèle Conversation

```dart
class Conversation {
  final String id;
  final String matchId;
  final String matchName;
  final String matchAvatar;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final List<Message> messages;

  const Conversation({...});
}
```

### Données mock

**Fichier** : `lib/data/mock_profiles.dart`

**Contenu** :
- `mockProfiles` : Liste de 30 profils variés
  - Noms français réalistes
  - Âges 24-33 ans
  - Métiers diversifiés
  - Distances 1-8 km
  - 3 intérêts par profil
  - Avatars depuis https://i.pravatar.cc
  
- `mockConversations` : Liste de 3 conversations
  - Sophie (2 messages non lus)
  - Emma (0 message non lu)
  - Léa (0 message non lu)

**Exemple de profil** :
```dart
Profile(
  id: '1',
  name: 'Sophie',
  age: 26,
  jobTitle: 'Designer UX/UI',
  distanceKm: 2.5,
  interests: ['Yoga', 'Photographie', 'Voyages'],
  photo: 'https://i.pravatar.cc/400?img=1',
  createdAt: DateTime.now().subtract(const Duration(days: 1)),
  gender: 'female',
)
```

---

## 🎨 Conventions de code

### Charte graphique

**Fichier** : `lib/constants/colors.dart`

```dart
class AppColors {
  static const Color primary = Color(0xFFFF3B3B);         // Rouge vif
  static const Color primaryPressed = Color(0xFFE23333);  // Rouge foncé
  static const Color background = Color(0xFFFFF5F2);      // Beige rosé
  static const Color card = Color(0xFFFFFFFF);            // Blanc
  static const Color text = Color(0xFF1F2937);            // Gris foncé
  static const Color muted = Color(0xFF6B7280);           // Gris moyen
}
```

**Couleur chip d'intérêt** : `Color(0xFFFFE2DF)` (rose pâle)

### Style de boutons

**Primaire** (CustomButton) :
- Couleur : `AppColors.primary`
- Border radius : 24
- Height : 56
- Font weight : 600

**Outlined** :
- Border : `AppColors.primary`, width 2
- Border radius : 24
- Transparent background

### Naming conventions

**Classes** : PascalCase
```dart
class ProfileCard extends StatelessWidget { }
```

**Fichiers** : snake_case
```dart
sign_in_screen.dart
custom_button.dart
```

**Variables/Fonctions** : camelCase
```dart
void _handleSignIn() { }
final List<Profile> _currentProfiles = [];
```

**Constantes** : lowerCamelCase (dans classe) ou UPPER_SNAKE_CASE (globals)
```dart
class AppColors {
  static const Color primary = ...;
}
```

### Commentaires

**Utiliser des commentaires de section** :
```dart
// Header avec avatar
Row(
  children: [
    CircleAvatar(...),
    ...
  ],
)

// Liste des messages
Expanded(
  child: ListView.builder(...),
)
```

**Documenter les classes principales** :
```dart
/// Écran d'accueil avec deck swipable
class HomeScreen extends StatefulWidget { }
```

---

## 🔄 Workflow de développement

### Commandes courantes

**1. Lancer l'app en preview web**
```bash
cd /home/user/flutter_app
flutter build web --release
cd build/web
python3 -m http.server 5060 --bind 0.0.0.0 &
```

**2. Redémarrer après modifications**
```bash
# Arrêter le serveur
lsof -ti:5060 | xargs -r kill -9 && sleep 2

# Nettoyer le cache
cd /home/user/flutter_app
rm -rf build/web .dart_tool/build_cache

# Rebuild et relancer
flutter build web --release
cd build/web
python3 -m http.server 5060 --bind 0.0.0.0 &
```

**3. Analyser le code**
```bash
cd /home/user/flutter_app
flutter analyze
```

**4. Formater le code**
```bash
cd /home/user/flutter_app
dart format .
```

**5. Installer/Mettre à jour dépendances**
```bash
cd /home/user/flutter_app
flutter pub get
```

### Git workflow

**Vérifier la branche courante** :
```bash
cd /home/user/flutter_app
git branch
```

**Créer une branche de fonctionnalité** :
```bash
git checkout -b feature/matches-screen
```

**Commit et push** :
```bash
git add .
git commit -m "feat: Implémente l'écran Matchs avec grille"
git push origin feature/matches-screen
```

**Revenir à la branche base** :
```bash
git checkout base
```

### Pattern de développement

**1. Comprendre la demande** → Lire AI_QUICK_START.md puis CONTEXT.md

**2. Planifier** → Identifier les fichiers à modifier/créer

**3. Développer** → Implémenter en respectant les conventions

**4. Tester** → `flutter analyze` + preview web

**5. Commit** → Message clair et descriptif

---

## 🐛 Problèmes connus et solutions

### 1. Navigation ne fonctionne pas après connexion

**Symptôme** : Cliquer sur "Se connecter" ne redirige pas vers MainScreen

**Causes possibles** :
- Validation du formulaire échoue (champs vides ou invalides)
- MainScreen n'est pas importé correctement

**Solution** :
- Utiliser le bouton "Accès Démo" pour contourner la validation
- Ou remplir les champs :
  - Email : `test@exemple.fr`
  - Mot de passe : `123456` (min 6 caractères)

### 2. Erreur de build "argument_type_not_assignable"

**Symptôme** : Erreur lors du build liée à `flutter_card_swiper`

**Cause** : Signature de fonction `onSwipe` incorrecte

**Solution** :
```dart
// ❌ Mauvais
void _handleSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
  // ...
}

// ✅ Correct
bool _handleSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
  // ...
  return true; // Important !
}
```

### 3. Images ne s'affichent pas (NetworkImage)

**Symptôme** : Profils sans photos

**Cause** : Service pravatar.cc indisponible ou CORS

**Solution** :
- Vérifier la connexion internet
- Ou remplacer par des assets locaux :
```dart
// Au lieu de NetworkImage
Image.network(profile.photo)

// Utiliser AssetImage
Image.asset('assets/images/placeholder.png')
```

### 4. Port 5060 déjà utilisé

**Symptôme** : Erreur "Address already in use"

**Solution** :
```bash
lsof -ti:5060 | xargs -r kill -9
sleep 2
# Puis relancer le serveur
```

---

## 🗺️ Roadmap

### Phase 1 : MVP Actuel ✅
- [x] Authentification (mock)
- [x] Navigation à 4 onglets
- [x] Deck swipable avec 30 profils
- [x] 3 filtres (Tout, Recommandés, New)
- [x] Chat avec envoi messages
- [x] Charte graphique cohérente

### Phase 2 : Fonctionnalités manquantes 🚧
- [ ] **MatchesScreen** : Grille des profils likés
- [ ] **ProfileScreen** : Édition profil utilisateur
- [ ] Persistance locale des actions (likes/refus)
- [ ] Animations et transitions
- [ ] Badge notifications sur onglet Chat

### Phase 3 : Backend Firebase 🔮
- [ ] Firebase Authentication
- [ ] Firestore pour profils et messages
- [ ] Firebase Storage pour photos
- [ ] Cloud Functions pour matching IA
- [ ] Push notifications

### Phase 4 : Fonctionnalités avancées 🚀
- [ ] Géolocalisation réelle
- [ ] Appels vidéo
- [ ] Stories
- [ ] Super likes payants
- [ ] Algorithme de matching IA avancé

### Phase 5 : Production 📱
- [ ] Build Android APK
- [ ] Optimisations performance
- [ ] Tests unitaires et intégration
- [ ] Déploiement Google Play Store

---

## 📞 Pour l'IA assistant

### Lorsque tu reprends le projet

**1. Lis d'abord AI_QUICK_START.md** (2 min)
**2. Lis ensuite CONTEXT.md** (10 min) - ce fichier
**3. Identifie la demande** de l'utilisateur
**4. Vérifie les fichiers concernés** avec `Read`
**5. Développe en respectant** les conventions
**6. Teste avec** `flutter analyze`
**7. Rebuild et preview** pour validation

### Patterns à suivre

✅ **Toujours utiliser** :
- `const` pour les widgets immuables
- `SafeArea` pour éviter les overlaps système
- Validation de formulaire avec `GlobalKey<FormState>`
- `Navigator.pushAndRemoveUntil` pour réinitialiser la stack après auth

✅ **Ne jamais** :
- Modifier les versions de Flutter/Dart (verrouillées)
- Utiliser `print()` (utiliser `debugPrint` si besoin)
- Oublier de disposer les contrôleurs (`dispose()`)
- Ignorer les warnings de `flutter analyze`

### Structure de réponse recommandée

1. **Résumé** de ce que tu vas faire
2. **Lecture** des fichiers concernés
3. **Modifications** avec `Edit` ou `MultiEdit`
4. **Vérification** avec `flutter analyze`
5. **Rebuild** et test
6. **Résumé** de ce qui a été fait + URL preview

---

**Fin de la documentation complète** 🎉

