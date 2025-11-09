# 💖 MatchUp - Application de Rencontre avec IA

Application de rencontre moderne développée en Flutter, avec swipe Tinder-style, chat intégré et filtres intelligents.

## 🚀 Démarrage rapide

### Pour l'utilisateur

1. **Cloner le projet**
   ```bash
   git clone https://github.com/RBSoftwareAI/matchup.git
   cd matchup
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Lancer l'application**
   ```bash
   flutter run -d chrome  # Pour web
   # ou
   flutter run            # Pour Android/iOS
   ```

### Pour l'IA assistant (sessions futures)

**📂 Repository** : https://github.com/RBSoftwareAI/matchup  
**🌿 Branche recommandée** : `base`

**📄 Documentation à lire** (dans l'ordre) :
1. **AI_QUICK_START.md** - Guide express (2 min)
2. **CONTEXT.md** - Documentation complète (10 min)

**💡 Template de message pour nouvelle session** :
```
Bonjour ! Je continue le développement de l'application MatchUp.

📂 Repository : https://github.com/RBSoftwareAI/matchup
🌿 Branche : base
📄 Documentation : Lis d'abord les fichiers dans cet ordre :
   1. AI_QUICK_START.md (guide express)
   2. CONTEXT.md (documentation complète)

🎯 Ma demande pour cette session :
[Décris ici ce que tu veux développer]
```

## 📱 Fonctionnalités actuelles

- ✅ **Authentication** : Écrans démarrage, connexion, inscription
- ✅ **Navigation** : 4 onglets (Accueil, Matchs, Chat, Profil)
- ✅ **Deck swipable** : 30 profils mock avec gestes et boutons
- ✅ **Filtres** : Tout, Recommandés (âge), New (récents)
- ✅ **Chat** : Liste conversations + détail avec envoi messages
- 🚧 **Matchs** : Placeholder (à développer)
- 🚧 **Profil** : Placeholder (à développer)

## 🎨 Charte graphique

- **Couleur principale** : #FF3B3B (Rouge vif)
- **Background** : #FFF5F2 (Beige rosé)
- **Texte** : #1F2937 (Gris foncé)
- **Texte secondaire** : #6B7280 (Gris moyen)

## 🛠️ Technologies

- **Framework** : Flutter 3.35.4
- **Langage** : Dart 3.9.2
- **Navigation** : go_router + Bottom Tabs
- **Swipe** : flutter_card_swiper
- **State** : Provider (+ StatefulWidget)

## 📦 Dépendances principales

```yaml
dependencies:
  flutter_card_swiper: ^7.2.0
  go_router: ^14.8.1
  provider: ^6.1.5
```

## 📂 Structure du projet

```
lib/
├── main.dart              # Point d'entrée + MainScreen
├── screens/               # 8 écrans de l'app
├── widgets/               # 5 widgets réutilisables
├── models/                # Modèles de données
├── data/                  # Données mock
└── constants/             # Couleurs et constantes
```

## 🗺️ Roadmap

### Phase actuelle : MVP ✅
- [x] Auth + Navigation
- [x] Deck swipable
- [x] Chat fonctionnel

### Prochaine phase : Fonctionnalités 🚧
- [ ] Écran Matchs (grille)
- [ ] Écran Profil (édition)
- [ ] Persistance locale
- [ ] Animations

### Phases futures 🔮
- [ ] Backend Firebase
- [ ] Géolocalisation
- [ ] Push notifications
- [ ] Build Android APK

## 📝 Commandes utiles

```bash
# Analyser le code
flutter analyze

# Formater le code
dart format .

# Lancer en mode release web
flutter build web --release

# Tests
flutter test
```

## 🤝 Contribuer

1. Créer une branche depuis `base`
   ```bash
   git checkout base
   git checkout -b feature/nom-fonctionnalite
   ```

2. Développer et commiter
   ```bash
   git add .
   git commit -m "feat: Description de la fonctionnalité"
   ```

3. Pousser et créer une Pull Request
   ```bash
   git push origin feature/nom-fonctionnalite
   ```

## 📄 License

Ce projet est sous license MIT.

## 👥 Auteur

**RBSoftwareAI**  
GitHub : [@RBSoftwareAI](https://github.com/RBSoftwareAI)

---

**Version** : 1.0.0  
**Dernière mise à jour** : Session initiale (Navigation complète)
