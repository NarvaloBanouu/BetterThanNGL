# BetterThanNGL - Application iOS de Signature de Présence

## 📱 Aperçu

Application iOS native développée en SwiftUI pour la gestion des émargements dans les organismes de formation. Cette application offre une alternative sécurisée et moderne aux solutions web classiques avec une interface européenne élégante.

## ✨ Fonctionnalités UX/UI Implémentées

### 🎨 Design Européen Classique
- **Palette de couleurs professionnelle** : Bleu marine (#2E405B), bleu clair (#5A8DBF), or (#D9A640)
- **Typographie claire et lisible** : Hiérarchie visuelle bien définie
- **Espacements généreux** : Interface aérée et confortable
- **Composants réutilisables** : Cohérence visuelle sur toute l'application

### 🔐 Authentification
- Écran de connexion avec identifiant école
- Connexion par mot de passe
- Option de connexion par lien magique
- Interface élégante avec logo et branding

### 📋 Gestion des Sessions
- **Liste des sessions** avec statuts visuels :
  - Non signée
  - Signée matin
  - Signée après-midi
  - Complète
- **Tableau de bord** avec statistiques :
  - Nombre total de sessions
  - Sessions signées
  - Sessions en attente
- **Filtres** : Aujourd'hui, Cette semaine, Toutes
- **Cartes de session détaillées** avec :
  - Titre du cours
  - Date et horaires
  - Salle et formateur
  - Statuts matin/après-midi

### ✍️ Méthodes de Signature

#### 1. Code TOTP à 6 chiffres
- Interface de saisie numérique élégante
- Affichage visuel de chaque chiffre
- Validation automatique
- Indication du renouvellement du code (30 secondes)

#### 2. Scanner QR Code ⭐
- **Interface de scan professionnelle** :
  - Cadre de scan avec coins dorés animés
  - Ligne de scan animée
  - Effet de caméra réaliste
  - Contrôles de flash
  - Simulation de scan pour la démo

#### 3. Géolocalisation ⭐
- **Carte interactive** avec MapKit
- **Vérification de position** :
  - Animation de chargement
  - Cercle de zone autorisée
  - Affichage de la distance
  - Indicateur de rayon autorisé (50m)
- **Statuts visuels** :
  - Vérification en cours
  - Position vérifiée
  - Trop éloigné
  - Localisation impossible

### ✏️ Signature Manuscrite
- **Intégration PencilKit** pour signature naturelle
- Support Apple Pencil (pression, inclinaison)
- Zone de signature dédiée avec ligne de base
- Boutons effacer et valider
- Récapitulatif des informations de session

### ✅ Confirmation
- **Animation de succès** élégante avec :
  - Checkmark animé
  - Cercles expansifs
  - Gradient de fond vert
- **Détails de confirmation** :
  - Session signée
  - Heure exacte
  - Lieu
  - Statut validé
- Retour automatique après 5 secondes
- Option de partage de confirmation

## 🏗️ Architecture

```
BetterthanNGL/
├── Models/
│   └── Session.swift                 # Modèle de données des sessions
├── Views/
│   ├── LoginView.swift               # Écran de connexion
│   ├── SessionsListView.swift        # Liste des sessions
│   ├── SignatureOptionsView.swift    # Choix de la méthode
│   ├── CodeInputView.swift           # Saisie code TOTP
│   ├── QRCodeScannerView.swift       # Scanner QR Code
│   ├── LocationView.swift            # Géolocalisation
│   ├── SignatureView.swift           # Signature manuscrite
│   └── ConfirmationView.swift        # Confirmation finale
├── Components/
│   ├── CustomButton.swift            # Bouton personnalisé
│   ├── CustomTextField.swift         # Champ de texte personnalisé
│   └── SessionCard.swift             # Carte de session
├── Utilities/
│   └── Theme.swift                   # Thème et styles
└── ContentView.swift                 # Vue principale
```

## 🎨 Système de Design

### Couleurs Principales
- **Primary** : `#2E405B` - Bleu marine professionnel
- **Secondary** : `#5A8DBF` - Bleu clair élégant
- **Accent** : `#D9A640` - Or raffiné
- **Success** : `#40A658` - Vert de validation
- **Warning** : `#F2A626` - Orange d'alerte
- **Error** : `#D94040` - Rouge d'erreur

### Typographie
- **Large Title** : 34pt Bold
- **Title 1** : 28pt Bold
- **Title 2** : 22pt Semibold
- **Body** : 17pt Regular
- **Caption** : 12pt Regular

### Espacements
- **XXS** : 4px
- **XS** : 8px
- **SM** : 12px
- **MD** : 16px
- **LG** : 24px
- **XL** : 32px
- **XXL** : 48px

## 🚀 Comment Tester

1. **Ouvrir le projet** dans Xcode 15+
2. **Sélectionner un simulateur** iOS 17+ ou un appareil physique
3. **Build & Run** (⌘R)

### Parcours de Test Recommandé

1. **Connexion** :
   - Saisir un identifiant et mot de passe quelconques
   - Cliquer sur "Se connecter"

2. **Liste des Sessions** :
   - Observer le tableau de bord avec statistiques
   - Consulter les 3 sessions exemples
   - Utiliser les filtres

3. **Signature par Code TOTP** :
   - Sélectionner une session
   - Choisir "Code à 6 chiffres"
   - Saisir 6 chiffres (ex: 123456)
   - Signer avec PencilKit
   - Observer la confirmation

4. **Signature par QR Code** :
   - Sélectionner une session
   - Choisir "Scanner QR Code"
   - Observer l'interface de scan
   - Cliquer sur "Simuler un scan"
   - Signer et confirmer

5. **Signature par Géolocalisation** :
   - Sélectionner une session
   - Choisir "Géolocalisation"
   - Observer la carte et la vérification
   - Attendre la validation automatique
   - Signer et confirmer

## 📝 Notes Importantes

### Version Actuelle : UX/UI Uniquement
Cette version implémente **uniquement l'interface utilisateur** avec :
- ✅ Navigation complète entre tous les écrans
- ✅ Animations et transitions fluides
- ✅ Design européen classique et professionnel
- ✅ Données d'exemple pour la démonstration
- ✅ Simulations des fonctionnalités (scan QR, géolocalisation)

### Non Implémenté (Fonctionnel)
- ❌ Authentification réelle (backend)
- ❌ Validation TOTP avec serveur
- ❌ Scanner QR Code fonctionnel (AVFoundation)
- ❌ Géolocalisation réelle (CoreLocation)
- ❌ Envoi des signatures au backend
- ❌ Persistance des données (SwiftData)

## 🔜 Prochaines Étapes

1. **Backend Integration** :
   - Connexion à l'API Supabase
   - Authentification réelle
   - Validation TOTP côté serveur

2. **Fonctionnalités Natives** :
   - Scanner QR Code avec AVFoundation
   - Géolocalisation avec CoreLocation
   - Notifications Push
   - Widgets iOS
   - Live Activities

3. **Sécurité** :
   - Device binding
   - Chiffrement des données
   - Géofencing strict
   - Rate limiting

## 👨‍💻 Développement

### Prérequis
- macOS 14+ (Sonoma)
- Xcode 15+
- iOS 17+ (Simulateur ou appareil)
- Swift 5.9+

### Technologies Utilisées
- **SwiftUI** : Interface utilisateur déclarative
- **PencilKit** : Signature manuscrite
- **MapKit** : Affichage de carte
- **Combine** : Gestion d'état réactif

## 📄 Licence

Projet pédagogique Master 1 - Cours de développement iOS

---

**Fait avec ❤️ en SwiftUI**
