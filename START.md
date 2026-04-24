# ▶️ Lancer l'Application

## 1. Ouvrir le Projet

```bash
open /Users/banou/Documents/ecole/BetterthanNGL/BetterthanNGL.xcodeproj
```

## 2. Ajouter les Fichiers

Dans Xcode :

1. **Clic droit** sur `BetterthanNGL` (dossier jaune)
2. **"Add Files to BetterthanNGL..."**
3. Sélectionner les dossiers :
   - `Models/`
   - `Views/`
4. Cocher **"Copy items if needed"**
5. Cocher **"Create groups"**
6. Cliquer **"Add"**

## 3. Vérifier la Structure

```
BetterthanNGL/
├── BetterthanNGLApp.swift
├── ContentView.swift
├── Models/
│   └── Session.swift
└── Views/
    ├── LoginView.swift
    ├── SessionsListView.swift
    ├── SessionRow.swift
    ├── SignatureOptionsView.swift
    ├── CodeInputView.swift
    ├── QRCodeScannerView.swift
    ├── LocationView.swift
    ├── SignatureView.swift
    └── ConfirmationView.swift
```

## 4. Compiler

**⌘B** pour compiler

## 5. Lancer

**⌘R** pour lancer sur iPhone 15 simulator

## ✅ Fichiers Créés

- **12 fichiers Swift** avec composants natifs iOS
- **1 modèle** : Session.swift
- **9 vues** : LoginView, SessionsListView, etc.
- **1 row component** : SessionRow.swift

## 🎯 Composants Natifs Utilisés

- `NavigationStack`
- `Form`
- `List`
- `Section`
- `GroupBox`
- `Label` & `LabeledContent`
- `Picker` segmented
- `Button` avec styles natifs
- `MapKit` Map
- `PencilKit` Canvas
- **SF Symbols** pour toutes les icônes

## 📱 Parcours de Test

1. **Login** → Saisir email/mdp → Se connecter
2. **Sessions** → Observer liste et stats
3. **Méthode 1** → Code à 6 chiffres → 123456 → Signer
4. **Méthode 2** → QR Scanner → Simuler → Signer
5. **Méthode 3** → Géoloc → Attendre → Signer
6. **Confirmation** → Animation → Retour auto

---

**Tout est prêt ! Lancez et testez !** 🚀
