#include <stdio.h>
#include <stdlib.h>
#include <assert.h>


#include "chenil.h"


void afficher_chien(Chien *chien) {
    if (chien) {
        printf("Nom: %s\n", chien->nom);
        printf("Sexe: %c\n", chien->sexe);
        printf("Vaccine: %d\n", chien->vaccine);
    }
}



int main() {
	Date date = {0, 0, 0};
	Portee *portee = cree_portee("pere", "mere", 2, "chiots.txt", date);
    if (!portee) {
        printf("null");
        return 0;
    }

    afficher_chien(portee->pere);
    afficher_chien(portee->mere);

    for (int i = 0; i < portee->nb_chiots; i++) {
        afficher_chien(&portee->chiots[i]);
    }
}