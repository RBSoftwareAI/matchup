# 🚀 MatchUp - Guide Express IA

**Durée de lecture : 2 minutes**

## 📱 C'est quoi MatchUp ?

Application de rencontre style Tinder, développée en **Flutter 3.35.4** avec navigation complète et données mock.

## ⚡ Démarrage ultra-rapide

### 1. État actuel du projet
- ✅ **Authentication** : Écrans Démarrage/Connexion/Inscription fonctionnels
- ✅ **Navigation** : 4 onglets (Accueil, Matchs, Chat, Profil)
- ✅ **Accueil** : Deck swipable avec 30 profils mock + 3 filtres
- ✅ **Chat** : Liste conversations + détail avec envoi messages
- 🚧 **Matchs** : Placeholder (à développer)
- 🚧 **Profil** : Placeholder (à développer)

### 2. Commandes essentielles

```bash
# Lancer l'app en preview web
cd /home/user/flutter_app && flutter build web --release && cd build/web && python3 -m http.server 5060 --bind 0.0.0.0 &

# Analyser le code
cd /home/user/flutter_app && flutter analyze

# Installer les dépendances
cd /home/user/flutter_app && flutter pub get

# Redémarrer après modifications
lsof -ti:5060 | xargs -r kill -9 && sleep 2 && cd /home/user/flutter_app && rm -rf build/web .dart_tool/build_cache && flutter build web --release && cd build/web && python3 -m http.server 5060 --bind 0.0.0.0 &
```

### 3. Structure rapide

```
lib/
├── main.dart                    # Point d'entrée + MainScreen (BottomNav)
├── screens/                     # 8 écrans
│   ├── start_screen.dart       # Écran démarrage (avec bouton "Accès Démo")
│   ├── sign_in_screen.dart     # Connexion
│   ├── sign_up_screen.dart     # Inscription
│   ├── home_screen.dart        # Deck swipable + 3 filtres
│   ├── matches_screen.dart     # 🚧 Placeholder
│   ├── profile_screen.dart     # 🚧 Placeholder
│   ├── chat_list_screen.dart   # Liste conversations
│   └── chat_detail_screen.dart # Détail conversation
├── widgets/                     # 5 widgets réutilisables
├── models/                      # Profile, Message, Conversation
├── data/                        # mock_profiles.dart (30 profils + 3 conversations)
└── constants/                   # colors.dart (charte graphique)
```

### 4. Charte graphique

```dart
Primary: #FF3B3B (rouge vif)
Background: #FFF5F2 (beige rosé)
Text: #1F2937 (gris foncé)
Muted: #6B7280 (gris moyen)
```

### 5. Dépendances clés

```yaml
flutter_card_swiper: ^7.2.0  # Deck swipable
go_router: ^14.8.1            # Navigation
provider: ^6.1.5              # State management
```

## 🎯 Prochaines tâches suggérées

1. **MatchesScreen** : Grille des profils likés/matchés
2. **ProfileScreen** : Édition profil utilisateur
3. **Backend Firebase** : Remplacer les données mock
4. **Animations** : Transitions et effets visuels
5. **Notifications** : Badge messages non lus

## 📚 Pour aller plus loin

Lis **CONTEXT.md** pour la documentation complète (architecture, conventions, patterns).

---
**Dernière mise à jour** : Session initiale (navigation complète)
