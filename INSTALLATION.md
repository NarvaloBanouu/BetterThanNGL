# 🛠️ Guide d'Installation - BetterThanNGL

## ⚠️ Ajouter les Fichiers au Projet Xcode

Les fichiers Swift ont été créés dans votre projet, mais ils doivent être ajoutés manuellement au projet Xcode pour être compilés.

### Étapes à Suivre

#### 1. Ouvrir le Projet
```bash
cd /Users/banou/Documents/ecole/BetterthanNGL
open BetterthanNGL.xcodeproj
```

#### 2. Ajouter les Fichiers Manquants

Dans Xcode :

1. **Clic droit** sur le dossier `BetterthanNGL` (jaune) dans le navigateur de projet
2. Sélectionner **"Add Files to BetterthanNGL..."**
3. Naviguer vers le dossier du projet
4. **Sélectionner tous les nouveaux dossiers** :
   - `Models/`
   - `Views/`
   - `Components/`
   - `Utilities/`
5. **Cocher** "Copy items if needed"
6. **Cocher** "Create groups"
7. **S'assurer** que la target `BetterthanNGL` est cochée
8. Cliquer sur **"Add"**

#### 3. Vérifier la Structure

Votre navigateur de projet devrait maintenant afficher :

```
BetterthanNGL/
├── BetterthanNGLApp.swift
├── ContentView.swift
├── Models/
│   └── Session.swift
├── Views/
│   ├── LoginView.swift
│   ├── SessionsListView.swift
│   ├── SignatureOptionsView.swift
│   ├── CodeInputView.swift
│   ├── QRCodeScannerView.swift
│   ├── LocationView.swift
│   ├── SignatureView.swift
│   └── ConfirmationView.swift
├── Components/
│   ├── CustomButton.swift
│   ├── CustomTextField.swift
│   └── SessionCard.swift
├── Utilities/
│   └── Theme.swift
└── Assets.xcassets/
```

#### 4. Configurer les Permissions (Info.plist)

Pour que l'application fonctionne correctement (quand la partie fonctionnelle sera implémentée), ajoutez ces clés dans `Info.plist` :

1. Clic droit sur `Info.plist` → Open As → Source Code
2. Ajouter avant la balise `</dict>` finale :

```xml
<key>NSCameraUsageDescription</key>
<string>L'application a besoin d'accéder à la caméra pour scanner les QR codes de signature.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>L'application a besoin d'accéder à votre position pour vérifier votre présence sur le campus.</string>
```

#### 5. Compiler et Tester

1. Sélectionner un **simulateur iOS 17+** (ex: iPhone 15)
2. Appuyer sur **⌘R** pour compiler et lancer
3. Si erreurs de compilation, vérifier que tous les fichiers sont bien dans la target

---

## 🔍 Résolution de Problèmes

### Erreur "Cannot find type 'Theme' in scope"
➜ Le fichier `Utilities/Theme.swift` n'est pas dans la target
➜ Solution : Sélectionner le fichier → File Inspector → Target Membership → Cocher BetterthanNGL

### Erreur "Cannot find 'Session' in scope"
➜ Le fichier `Models/Session.swift` n'est pas dans la target
➜ Solution : Même chose que ci-dessus

### Erreur "No such module 'PencilKit'"
➜ PencilKit n'est pas importé correctement
➜ Solution : Nettoyer le build folder (⌘⇧K) puis recompiler (⌘B)

### Erreur "No such module 'MapKit'"
➜ MapKit n'est pas importé correctement
➜ Solution : Nettoyer le build folder puis recompiler

---

## 📱 Tester sur Simulateur

### Simulateurs Recommandés
- **iPhone 15** (écran standard)
- **iPhone 15 Pro Max** (grand écran)
- **iPad Pro 11"** (tablette, si besoin)

### Version iOS Minimale
- iOS 17.0 ou supérieur

---

## 🎯 Checklist de Vérification

Avant de tester, assurez-vous que :

- [ ] Tous les fichiers Swift sont visibles dans le navigateur de projet
- [ ] Tous les fichiers ont le target `BetterthanNGL` coché
- [ ] Le projet compile sans erreur (⌘B)
- [ ] Info.plist contient les descriptions de permissions
- [ ] Un simulateur iOS 17+ est sélectionné

---

## 🚀 Lancer l'Application

1. **Build & Run** : ⌘R
2. L'application devrait se lancer sur le simulateur
3. Vous verrez l'écran de connexion

### Parcours de Test Complet

#### Étape 1 : Connexion
- Saisir n'importe quel email/mot de passe
- Cliquer "Se connecter"
- ✅ Devrait afficher la liste des sessions

#### Étape 2 : Consulter les Sessions
- Observer 3 sessions d'exemple
- Tester les filtres "Aujourd'hui", "Cette semaine", "Toutes"
- ✅ Les sessions doivent s'afficher avec leurs statuts

#### Étape 3 : Tester Méthode 1 - Code TOTP
- Cliquer sur une session
- Choisir "Code à 6 chiffres"
- Saisir 6 chiffres (ex: 123456)
- ✅ Devrait passer à l'écran de signature

#### Étape 4 : Tester Méthode 2 - QR Code
- Retour → Choisir une session
- Choisir "Scanner QR Code"
- Observer l'animation de scan
- Cliquer "Simuler un scan"
- ✅ Devrait passer à l'écran de signature

#### Étape 5 : Tester Méthode 3 - Géolocalisation
- Retour → Choisir une session
- Choisir "Géolocalisation"
- Observer la carte et la vérification
- ✅ Devrait vérifier automatiquement puis permettre de continuer

#### Étape 6 : Signature Manuscrite
- Sur l'écran de signature
- Dessiner une signature (doigt ou souris)
- Tester "Effacer" et "Valider"
- ✅ Devrait afficher la confirmation

#### Étape 7 : Confirmation
- Observer l'animation de checkmark
- Observer les détails de signature
- ✅ Retour automatique après 5 secondes

---

## 🎨 Personnalisation (Optionnel)

### Modifier les Couleurs

Éditer `Utilities/Theme.swift` :

```swift
// Ligne 14-19
static let primary = Color(red: 0.18, green: 0.25, blue: 0.42)
// Remplacer par votre couleur primaire
```

### Modifier les Données d'Exemple

Éditer `Models/Session.swift` :

```swift
// Ligne 44+ : Session.sampleSessions
// Ajouter/modifier les sessions d'exemple
```

### Modifier les Textes

Chercher les textes dans chaque View et les remplacer :
- Titres
- Descriptions
- Messages

---

## 📞 Support

Si vous rencontrez des problèmes :

1. **Nettoyer le build** : ⌘⇧K
2. **Recompiler** : ⌘B
3. **Vérifier** que tous les fichiers sont dans la target
4. **Vérifier** la version iOS du simulateur (17+)
5. **Redémarrer** Xcode si nécessaire

---

## ✅ C'est Fait !

Une fois tout installé et compilé, vous avez une **application iOS complète en SwiftUI** avec :

- ✨ Design européen classique professionnel
- 🎨 8 écrans complets avec navigation
- 📱 3 méthodes de signature (Code, QR, Géolocalisation)
- ✍️ Signature manuscrite PencilKit
- ✅ Animations et confirmations élégantes
- 🧩 Composants réutilisables
- 🎯 Architecture propre et maintenable

**Prêt pour la démonstration et les tests UX !**

---

*BetterThanNGL - Version UX/UI - Avril 2026*
