# 📱 Guide Visuel - BetterThanNGL

## Vue d'ensemble des écrans

Ce document présente tous les écrans de l'application avec leurs fonctionnalités UX/UI.

---

## 1. 🔐 Écran de Connexion (`LoginView`)

### Description
Premier écran de l'application avec design minimaliste et professionnel.

### Éléments Visuels
- **Logo** : Icône signature avec taille 80pt
- **Titre** : "Signature" en Large Title (34pt)
- **Sous-titre** : "Gestion des émargements"
- **Formulaire** :
  - Champ identifiant avec icône personne
  - Champ mot de passe sécurisé avec icône cadenas
  - Lien "Mot de passe oublié"
- **Boutons** :
  - Primaire : "Se connecter" (bleu marine)
  - Secondaire : "Connexion par lien magique" (contour)
- **Pied de page** : Version et description du projet

### Palette de Couleurs
- Fond : Gris très clair (#FAFAFA)
- Bouton principal : Bleu marine (#2E405B)
- Bouton secondaire : Contour bleu (#5A8DBF)

---

## 2. 📋 Liste des Sessions (`SessionsListView`)

### Description
Écran principal après connexion montrant toutes les sessions de formation.

### Sections

#### A. En-tête Récapitulatif
- **Salutation** : "Bonjour, Étudiant M1"
- **Icône** : Graduation cap
- **Statistiques** :
  - 3 Sessions (icône calendrier)
  - 4 Signées (icône checkmark vert)
  - 2 En attente (icône horloge orange)

#### B. Filtres
- Boutons de filtre : "Aujourd'hui" | "Cette semaine" | "Toutes"
- Style : Pills avec fond bleu pour sélection active

#### C. Cartes de Session
Chaque carte affiche :
- **En-tête** :
  - Titre du cours (Title 3)
  - Date formatée (français)
  - Badge de complétion si toutes signatures faites
- **Informations** :
  - Horaires (avec icône horloge)
  - Salle (avec icône location)
  - Formateur (avec icône personne)
- **Statuts** :
  - Matin : icône + statut + texte
  - Après-midi : icône + statut + texte

### Couleurs de Statut
- ✅ Signé : Vert (#40A658)
- ⏱️ En attente : Orange (#F2A626)
- ⚪ Non signé : Gris clair (#A6A6A6)

---

## 3. 🎯 Choix de la Méthode (`SignatureOptionsView`)

### Description
Modal présentant les 3 méthodes de signature disponibles.

### Éléments Visuels
- **En-tête** :
  - Icône crayon (60pt)
  - Titre "Choisir une méthode"
  - Description explicative

### Options (3 Cartes)

#### Option 1 : Code à 6 chiffres
- Icône : `number.circle.fill`
- Titre : "Code à 6 chiffres"
- Description : "Saisissez le code affiché par votre formateur"
- Badge : Aucun

#### Option 2 : Scanner QR Code ⭐
- Icône : `qrcode.viewfinder`
- Titre : "Scanner QR Code"
- Description : "Scannez le QR code affiché à l'écran"
- Badge : "Rapide" (fond or #D9A640)

#### Option 3 : Géolocalisation ⭐
- Icône : `location.circle.fill`
- Titre : "Géolocalisation"
- Description : "Vérification automatique de votre position"
- Badge : "Auto" (fond or #D9A640)

### Carte Informations Session
- Fond blanc avec bordure légère
- Affiche : Cours, Horaires, Lieu, Formateur
- Style : Liste avec icônes

---

## 4. 🔢 Saisie du Code TOTP (`CodeInputView`)

### Description
Interface de saisie numérique élégante pour le code à 6 chiffres.

### Éléments Visuels
- **En-tête** :
  - Icône clavier (70pt)
  - Titre "Saisissez le code"
  - Instructions

### Zone de Saisie
- **6 boîtes de chiffres** :
  - Taille : 50x65px
  - Bordure bleue quand rempli
  - Police monospace 32pt
  - Ombre portée légère
  - Animation sur focus

### Fonctionnalités UX
- Auto-focus au chargement
- Validation automatique à 6 chiffres
- Bouton "Effacer" visible en permanence
- Clavier numérique natif iOS

### Indicateur
- Boîte info bleue : "Le code change toutes les 30 secondes"

---

## 5. 📷 Scanner QR Code (`QRCodeScannerView`) ⭐

### Description
Interface de scan professionnelle avec effet caméra.

### Design
- **Fond** : Noir complet (effet caméra)
- **Zone de scan** :
  - Rectangle central 280x280px
  - Coins dorés (30px de ligne)
  - Ligne de scan animée (or #D9A640)
  - Animation verticale continue

### États

#### État Inactif
- Icône QR Code géante au centre (120pt)
- Texte "Prêt à scanner"
- Bouton blanc "Commencer le scan"

#### État Actif
- Ligne de scan animée (2 secondes loop)
- Texte "Scannez le QR Code"
- Instructions en overlay
- Bouton vert "Simuler un scan (démo)"

### Toolbar
- Gauche : Bouton "Annuler"
- Droite : Contrôle flash (icône lampe)

### Indicateur de Statut
- Cercle vert + "Scan actif" quand en cours
- Cercle gris + "Scan inactif" sinon

---

## 6. 📍 Géolocalisation (`LocationView`) ⭐

### Description
Vérification de position avec carte interactive.

### Sections

#### A. Carte MapKit
- Hauteur : 350px
- Coins arrondis
- **Annotation personnalisée** :
  - 3 cercles concentriques (rayon décroissant)
  - Couleur bleu primaire avec opacité
  - Icône bâtiment au centre

#### B. Statut de Vérification

##### Vérification en cours
- Cercle de chargement animé
- Texte "Vérification en cours..."
- Message "Nous vérifions votre position"

##### Position vérifiée ✅
- Icône checkmark vert (40pt)
- Texte "Position vérifiée"
- Message de confirmation
- **Informations de distance** :
  - Distance : 15 m
  - Rayon autorisé : 50 m

##### Échec ❌
- Icône X rouge
- Messages d'erreur selon cause :
  - "Localisation impossible"
  - "Trop éloigné"
- Bouton "Réessayer"

### Animations
- Rotation du cercle de chargement (1 seconde)
- Transition douce entre états

---

## 7. ✍️ Signature Manuscrite (`SignatureView`)

### Description
Capture de signature avec PencilKit intégré.

### Éléments Visuels

#### En-tête
- Icône crayon (50pt)
- Titre "Signez ici"
- Instructions

#### Badge de Vérification
- Icône bouclier vert
- Texte "Vérifié par [Méthode]"
- Fond vert très clair

#### Zone de Signature
- **Canvas PencilKit** :
  - Fond blanc
  - Taille : Full width x 300px
  - Bordure épaisse (2px)
  - Ombres élégantes
- **Placeholder** (si vide) :
  - Icône main qui dessine
  - Texte "Tracez votre signature"
- **Ligne de base** : Fine ligne grise en bas

#### Carte d'Informations
- Fond blanc avec bordure
- Liste des détails :
  - Session
  - Date (format français)
  - Horaire
  - Méthode de vérification

### Boutons
- **Effacer** : Style outline, icône poubelle
- **Valider** : Style primaire, icône checkmark
  - Désactivé si canvas vide

### Support PencilKit
- Pression Apple Pencil
- Inclinaison
- Doigt compatible
- Trait noir 3px

---

## 8. ✅ Confirmation (`ConfirmationView`)

### Description
Animation de succès avec détails de confirmation.

### Design
- **Fond** : Gradient vert (#40A658 to lighter)
- **Animation de succès** :
  - 3 cercles expansifs blancs
  - Cercle central blanc solide (120px)
  - Checkmark vert qui apparaît avec rotation
  - Durée : 0.6 secondes (spring animation)

### Contenu

#### Textes
- Titre : "Signature enregistrée !" (white, bold)
- Sous-titre : "Votre présence a été confirmée"

#### Détails (fond blanc semi-transparent)
- Session signée
- Heure exacte (HH:mm:ss)
- Lieu de signature
- Statut : Validé

#### Actions
- Bouton blanc "Retour à l'accueil" (avec icône maison)
- Lien "Partager la confirmation" (texte blanc)

### Comportement
- Animation séquentielle :
  1. Checkmark apparaît (0s)
  2. Détails fade in (0.3s)
  3. Retour auto à l'accueil (5s)

---

## 🎨 Système de Design Global

### Composants Réutilisables

#### CustomButton
4 styles :
- **Primary** : Bleu marine, texte blanc
- **Secondary** : Bleu clair, texte blanc
- **Outline** : Transparent, bordure bleue
- **Text** : Transparent, texte bleu

#### CustomTextField
- Fond gris très clair
- Icône à gauche (optionnelle)
- Bordure légère
- Support SecureField
- Clavier personnalisable

#### SessionCard
- Fond blanc avec ombre portée
- Bordure gris clair
- Structure :
  - En-tête (titre + date)
  - Infos (horaires, salle, prof)
  - Statuts (matin + après-midi)

### Animations Utilisées

1. **Spring** : Checkmark de confirmation
2. **Linear** : Ligne de scan QR
3. **EaseOut** : Fade in des détails
4. **RepeatForever** : Cercle de chargement

### Gestion des États

- `.notSigned` : Gris clair
- `.pending` : Orange
- `.signed` : Vert
- `.checking` : Bleu info
- `.verified` : Vert succès
- `.failed` : Rouge erreur

---

## 📐 Grille de Espacements

| Nom | Valeur | Usage |
|-----|--------|-------|
| XXS | 4px | Espaces minimaux |
| XS | 8px | Entre éléments proches |
| SM | 12px | Padding interne |
| MD | 16px | Padding standard |
| LG | 24px | Sections |
| XL | 32px | Entre blocs majeurs |
| XXL | 48px | Grandes séparations |

---

## 🎯 Points Forts UX/UI

✅ **Design cohérent** : Thème unique réutilisé partout
✅ **Animations fluides** : Spring, fade, rotation
✅ **Feedback visuel** : Couleurs de statut claires
✅ **Hiérarchie claire** : Typographie bien structurée
✅ **Navigation intuitive** : Flow logique entre écrans
✅ **Accessibilité** : Tailles de police lisibles, contrastes respectés
✅ **États visuels** : Chaque action a un feedback
✅ **Design européen** : Palette sobre et professionnelle

---

**Documentation créée pour le projet BetterThanNGL**
*Version UX/UI - Avril 2026*
