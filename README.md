# Différences avec StreamLauncher

Je repars sur une nouvelle base, on refait StreamLauncher en orienté objet.

Je fais ça pour faciliter l'implémentation de différentes interfaces.
Donc on va partir sur un simulacre de MVC.

Dans un premier temps, je vais faire une Command Line Interface ainsi qu'une interface graphique
en Tk puisque c'est dans la librairie standard de Ruby, et que créer un exécutable avec Shoes
donne quelque chose d'aléatoire (code dans l'exécutable plus vieux que le code utilisé pour le
créer).

Je crois qu'une gemme nommée ocra permettra de créer l'exécutable.

Essayer aussi permettre le choix de langue : Français ou Anglais

# Problèmes

Twitch a changé son API donc livestreamer ne marche plus sans token, je vais utiliser
le token associé à livestreamer pour être moins emmerdant.
