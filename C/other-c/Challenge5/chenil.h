#include <stdio.h>
#include <stdlib.h>
#include <assert.h>


typedef struct {
	unsigned short jour;
	unsigned short mois;
	unsigned short annee;
} Date;


typedef struct {
	char *nom;
	char sexe; // 'F' ou 'M'
	char vaccine; // 0 pas vacciné, 1 vacciné
} Chien;


typedef struct {
	Chien *pere;
	Chien *mere;
	Chien *chiots; //tableau de chiens
	unsigned short nb_chiots;
	Date date_naissance;
} Portee;


/*
* Charge, depuis un fichier, {nb_chiots} chiots et les place dans un tableau.
*
* PRÉ C O N D I T I O N : {nom_fichier} valide, {chiots} est un tableau de chiens valide
* POST C O N D I T I O N : 1 si {chiots} a bien été rempli depuis le fichier dont le
* nom est contenu dans {nom_fichier}. -1 sinon.
*/
int charger_chiots(char *nom_fichier, Chien *chiots, unsigned short nb_chiots);


/*
* Crée un chien ayant un nom, un sexe et une information quant à sa
* vaccination. Cette fonction alloue de la mémoire à libérer après usage.
*
* PR ÉCO N D I T I O N : {nom} valide, {sexe} ∈ {0M0,0 F0}, vacciné ∈ [0, 1]
* PO S TCO N D I T I O N : Un pointeur vers un chien valide. NULL en cas d’erreur.
*/
Chien *cree_chien(char *nom, char sexe, char vaccine);


/*
* Crée une portée de chiots en fonction d’un père et d’une mère et charge,
* depuis un fichier, les différents chiots. Cette fonction alloue de la
* mémoire à libérer après usage.
*
* PR ÉCO N D I T I O N : {nom_pere} est un nom de chien valide, {nom_mere} est un nom
* de chien valide. Le père et la mère ont été vaccinés,
* {nb_chiots} > 0, {nom_fichier} est valide.
* PO S TCO N D I T I O N : un pointeur vers une portée valide. Les chiots de la portée
* ont été chargés depuis le fichier {nom_fichier}.
* NULL en cas d’erreur
*/
Portee *cree_portee(char *nom_pere, char *nom_mere, unsigned short nb_chiots, char *nom_fichier, Date date_naissance);