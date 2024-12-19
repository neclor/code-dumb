#include "chenil.h"


int charger_chiots(char *nom_fichier, Chien *chiots, unsigned short nb_chiots) {
	for (int i = 0; i < nb_chiots; i++) {
		chiots[i].nom = "test";
		chiots[i].sexe = 'M';
		chiots[i].vaccine = 1;
	}
	return 1;
}



Chien *cree_chien(char *nom, char sexe, char vaccine) {
	Chien *chien = malloc(sizeof(Chien));
	if (!chien) return NULL;

	chien->nom = nom;
	chien->sexe = sexe;
	chien->vaccine = vaccine;

	return chien;
}


Portee *cree_portee(char *nom_pere, char *nom_mere, unsigned short nb_chiots, char *nom_fichier, Date date_naissance) {
	if (!nom_pere || !nom_mere || !nom_fichier || nb_chiots < 1) return NULL;

	Chien *chiots = malloc(nb_chiots * sizeof(Chien));
	if (!chiots) return NULL;
	if (charger_chiots(nom_fichier, chiots, nb_chiots) != 1) {
		free(chiots);
		return NULL;
	}

	Chien *pere = cree_chien(nom_pere, 'M', 1);
	if (!pere) {
		free(chiots);
		return NULL;
	}

	Chien *mere = cree_chien(nom_mere, 'F', 1);
	if (!mere) {
		free(chiots);
		free(pere);
		return NULL;
	}

	Portee *portee = malloc(sizeof(Portee));
	if (!portee) {
		free(chiots);
		free(pere);
		free(mere);
		return NULL;
	}

	portee->pere = pere;
	portee->mere = mere;
	portee->chiots = chiots;
	portee->nb_chiots = nb_chiots;
	portee->date_naissance = date_naissance;

	return portee;}