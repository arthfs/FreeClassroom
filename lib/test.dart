import "package:flutter/material.dart";
import 'package:audioplayers/audioplayers.dart';
import "horaire.dart";

const drawerItemColor = Colors.red;
bool hasCapitalLetter(String input) {
  return RegExp(r'[A-Z]').hasMatch(input);
}

bool hasDigit(String input) {
  return RegExp(r'\d').hasMatch(input);
}

bool hasSymbol(String input) {
  return RegExp(r"[^\w\s]").hasMatch(input);
}

int evalComplexity(String temp) {
  int sol = 0;
  if (hasCapitalLetter(temp)) {
    sol += 1;
  }
  if (hasDigit(temp)) {
    sol += 1;
  }
  if (temp.length >= 8) {
    sol += 1;
  }
  if (hasSymbol(temp)) {
    sol += 1;
  }
  /* if (sol == 4) {
    return "Excellent";
  } else if (sol == 3) {
    return "Moyen";
  }
  return "Trop faible";*/
  return sol;
}

Future<void> playsound(String sound) async {
  AudioPlayer audioplayer = AudioPlayer();
  await audioplayer.play(AssetSource(sound));
}

SnackBar notif = const SnackBar(
  content: Text("hey"),
  duration: Duration(seconds: 2),
);

class PageTitle extends StatefulWidget {
  final String title;
  const PageTitle(this.title, {super.key});

  @override
  State<PageTitle> createState() => _PageTitleState();
}

class _PageTitleState extends State<PageTitle> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
    );
  }
}

class Heure {
  int heure, minute;
  Heure(this.heure, this.minute);
  @override
  toString() {
    return ('$heure h: $minute');
  }
}

String privacypolicy =
        '''Chez Free Classrooms, nous nous engageons à protéger votre vie privée et à sécuriser les informations personnelles que vous nous fournissez lorsque vous utilisez notre application mobile. Cette politique de confidentialité explique comment nous collectons, utilisons, stockons et partageons vos informations. Veuillez lire attentivement cette politique pour comprendre comment nous traitons vos données.

1. Collecte d'informations

Lorsque vous créez un compte dans notre application mobile, nous pouvons collecter des informations personnelles telles que votre nom, votre adresse e-mail, votre identifiant d'utilisateur et d'autres informations que vous choisissez de fournir. Nous pouvons également collecter des informations sur votre utilisation de l'application, y compris les fonctionnalités que vous utilisez, les actions que vous effectuez, les données de localisation et les préférences que vous sélectionnez.

2. Utilisation des informations

Nous utilisons les informations collectées pour fournir, maintenir et améliorer notre application mobile universitaire. Les principales utilisations de vos informations personnelles sont les suivantes :

- Personnalisation de votre expérience : Nous utilisons vos informations pour vous offrir une expérience personnalisée, en vous proposant des contenus, des fonctionnalités et des recommandations adaptés à vos préférences et à vos besoins spécifiques.

- Communication avec vous : Nous utilisons votre adresse e-mail pour vous envoyer des notifications importantes liées à l'application, telles que des mises à jour, des annonces de nouveaux services ou des informations relatives à votre compte.

- Amélioration de l'application : Vos informations nous aident à comprendre comment vous utilisez notre application, quels sont vos besoins et vos intérêts, ce qui nous permet d'améliorer nos fonctionnalités, nos services et notre interface utilisateur.

- Support technique : Si vous avez des questions, des problèmes ou des demandes d'assistance, nous utilisons vos informations pour vous fournir le support nécessaire et résoudre vos problèmes.

3. Partage des informations

Nous ne vendons pas vos informations personnelles à des tiers. Cependant, dans certaines circonstances, nous pouvons partager vos informations avec des tiers de confiance pour les raisons suivantes :

- Prestataires de services : Nous collaborons avec des prestataires de services tiers qui nous aident à fournir et à améliorer notre application. Ces prestataires de services n'ont accès qu'aux informations nécessaires pour effectuer leurs tâches et sont tenus de respecter la confidentialité de vos informations.

- Exigences légales : Nous pouvons divulguer vos informations si cela est exigé par la loi, par une procédure judiciaire, par une demande gouvernementale ou pour protéger nos droits, notre sécurité ou celle des autres utilisateurs.

- Consentement : Nous pouvons partager vos informations avec des tiers si nous avons obtenu votre consentement explicite.

4. Protection des informations

Nous prenons des mesures de sécurité appropriées pour protéger vos informations personnelles contre tout accès, utilisation, divulgation ou destruction non autorisés. Nous utilisons des mesures de sécurité techniques, telles que le cryptage des données, pour protéger vos informations. Cependant, malgré nos efforts pour maintenir des normes de sécurité élevées, aucun système n'est totalement sécurisé, et nous ne pouvons garantir la sécurité absolue de vos informations.

5. Conservation des informations

Nous conservons vos informations personnelles aussi longtemps que nécessaire pour atteindre les objectifs décrits dans cette politique de confidentialité, sauf si une période de conservation plus longue est requise ou autorisée par la loi. Nous effacerons ou anonymiserons vos informations dès qu'elles ne seront plus nécessaires.

6. Vos droits et choix

Vous avez certains droits concernant vos informations personnelles. Vous pouvez accéder, corriger, mettre à jour ou supprimer vos données personnelles en utilisant les fonctionnalités disponibles dans l'application. Vous pouvez également choisir de ne plus recevoir de communications promotionnelles de notre part en modifiant vos préférences dans les paramètres de l'application.

7. Modifications de la politique de confidentialité

Nous nous réservons le droit de modifier cette politique de confidentialité à tout moment. En cas de modifications importantes, nous vous en informerons par le biais de l'application ou par d'autres moyens appropriés. Veuillez consulter régulièrement cette politique de confidentialité pour vous tenir informé des éventuelles mises à jour.

8. Nous contacter

Si vous avez des questions, des préoccupations ou des demandes concernant notre politique de confidentialité ou la manière dont nous traitons vos informations personnelles, veuillez nous contacter à l'adresse suivante : arthursaintlouis96@gmail.com

Merci d'utiliser notre application mobile universitaire. Nous nous engageons à protéger votre vie privée et à traiter vos informations personnelles de manière responsable et sécurisée.

L'équipe de l'application mobile de Free Classrooms. ''',
    terms =
        '''Conditions générales d'utilisation de l'application mobile "Free Classrooms"

Les présentes conditions générales d'utilisation (ci-après dénommées "CGU") régissent votre utilisation de l'application mobile "Free Classrooms" (ci-après dénommée "l'application"). Veuillez lire attentivement les CGU avant d'utiliser l'application. En utilisant l'application, vous acceptez d'être lié par les présentes CGU.

1. Utilisation de l'application

1.1 Vous pouvez utiliser l'application "Free Classrooms" pour accéder aux fonctionnalités suivantes :
    a) Horaire des travaux dirigés (TD) : Vous pouvez consulter les horaires des travaux dirigés associés à votre université.
    b) Écrire une note : Vous pouvez saisir et enregistrer des notes concernant vos cours ou tout autre sujet relatif à votre université.
    c) Mes notes : Vous pouvez accéder à l'ensemble des notes que vous avez saisies dans l'application.
    d) Suggestions : Vous pouvez soumettre des suggestions pour améliorer l'application ou signaler des problèmes techniques éventuels.
    e) Déconnexion : Vous pouvez vous déconnecter de votre compte utilisateur.

1.2 Vous vous engagez à utiliser l'application conformément aux lois en vigueur et aux présentes CGU. Vous acceptez de ne pas utiliser l'application de manière abusive, frauduleuse ou illégale.

2. Compte utilisateur

2.1 Pour utiliser pleinement l'application, vous devez créer un compte utilisateur. Vous êtes entièrement responsable de la confidentialité de votre compte et des informations d'identification associées.

2.2 Vous acceptez de fournir des informations exactes, complètes et à jour lors de la création de votre compte utilisateur. Vous acceptez également de ne pas usurper l'identité d'une autre personne ou entité.

2.3 Vous êtes responsable de toutes les activités effectuées sous votre compte utilisateur. Si vous pensez qu'une utilisation non autorisée de votre compte a eu lieu, vous devez nous en informer immédiatement.

3. Propriété intellectuelle

3.1 L'application "Free Classrooms" et tous ses contenus, y compris mais sans s'y limiter, les textes, les graphiques, les logos, les icônes, les images, les clips audio, les vidéos, les logiciels et les codes sources, sont la propriété exclusive de l'exploitant de l'application ou de ses concédants de licence.

3.2 Vous acceptez de ne pas copier, modifier, distribuer, transmettre, afficher, reproduire, publier, accorder une licence, créer des œuvres dérivées, transférer ou vendre tout contenu de l'application, sauf autorisation expresse de l'exploitant de l'application.

4. Confidentialité des données

4.1 Nous respectons votre vie privée et nous engageons à protéger vos données personnelles conformément à notre politique de confidentialité. En utilisant l'application, vous consentez à la collecte, au stockage et à l'utilisation de vos données conformément à notre politique de confidentialité.

4.2 Vous reconnaissez que la transmission de données via Internet n'est jamais entièrement sécurisée et que vous utilisez l'application à vos propres risques.

5. Modification et résiliation

5.1 Nous nous réservons le droit de modifier, suspendre ou interrompre l'application ou une partie de ses fonctionnalités à tout moment, avec ou sans préavis.

5.2 Vous pouvez résilier votre utilisation de l'application à tout moment en supprimant votre compte utilisateur.

6. Limitation de responsabilité

6.1 Dans toute la mesure permise par la loi applicable, nous déclinons toute responsabilité découlant de votre utilisation de l'application. L'application est fournie "telle quelle" et "telle que disponible", sans aucune garantie expresse ou implicite.

6.2 Nous ne serons pas responsables des dommages directs, indirects, accessoires, spéciaux, consécutifs ou punitifs découlant de votre utilisation de l'application.

7. Dispositions générales

7.1 Les présentes CGU constituent l'intégralité de l'accord entre vous et nous concernant l'utilisation de l'application et remplacent tous les accords antérieurs, écrits ou verbaux, entre vous et nous.

7.2 Si une disposition des présentes CGU est jugée invalide, illégale ou inapplicable par un tribunal compétent, cette disposition sera modifiée dans la mesure minimale nécessaire pour la rendre valide, légale et applicable, tout en préservant l'intention des parties.

7.3 Les présentes CGU sont régies et interprétées conformément aux lois du pays où est enregistré l'exploitant de l'application.

En utilisant l'application "Free Classrooms", vous confirmez avoir lu, compris et accepté les présentes conditions générales d'utilisation. Si vous n'acceptez pas ces CGU, vous ne devez pas utiliser l'application.
 ''';

void main() {
  String jour = "Jeudi";
  String heure = "9:04";
  print(nexthour(jour, heure, "H103"));
}

String nexthour(String jour, String heure, String salle) {
  String difference = "";
  List<String> jours = [
    "Lundi",
    "Mardi",
    "Mercredi",
    "Jeudi",
    "Vendredi",
    "Samedi",
    "Dimanche"
  ];
  int a = jours.indexOf(jour);
  String sol = "";
  Heure target =
      Heure(int.parse(heure.split(":")[0]), int.parse(heure.split(':')[1]));
  for (var t in horaires) {
    Heure debut = Heure(int.parse(t['heure']!.substring(0, 5).split(":")[0]),
        int.parse(t['heure']!.substring(0, 5).split(':')[1]));

    if (t['salle']!.compareTo(salle) == 0 &&
        t['jour']!.compareTo(jours[a]) == 0) {
      if (debut.heure > target.heure ||
          (debut.heure == target.heure && debut.minute > target.minute)) {
        // print("${t['salle']} $salle");
        sol = debut.toString();
        //print(sol);
        difference = (DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day, debut.heure, debut.minute)
                .difference(DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day, target.heure, target.minute)))
            .toString();
        //print(difference);
      }

      /* 
      */
      break;
    }
  }

  if (sol.isEmpty) {
    int i = 1;
    while (difference.isEmpty) {
      a += 1;
      if (a == jours.length) {
        a = jours.indexOf(jour);
      }
      for (var t in horaires) {
        if (t['salle']!.compareTo(salle) == 0 &&
            t['jour']!.compareTo(jours[a]) == 0) {
          Heure s = Heure(int.parse(t['heure']!.substring(0, 5).split(":")[0]),
              int.parse(t['heure']!.substring(0, 5).split(':')[1]));
          //   print(t);
          difference = (DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day + i, s.heure, s.minute)
                  .difference(DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      target.heure,
                      target.minute)))
              .toString();
          // print(difference);
          // print(24*(a-jours.indexOf(jour)));
          break;
        }
        //  if (t['salle']!.compareTo(salle) == 0) {
        //   print(t);
        // }
      }
      i += 1;
    }
  }
//  print(target.minute);
  return difference;
}
