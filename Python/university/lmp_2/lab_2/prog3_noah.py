import math
import pygame
import sys

# Constantes

BLEUCLAIR = (127, 191, 255)
ROUGE = (255, 0, 0)
NOIR = (0, 0, 0)
K = 8.9876 * 10 ** 9
RAYON = 10
C = 10 ** -7

# Paramètres

dimensions_fenetre = (1600, 900)
images_par_seconde = 60

masse_mobile = 10**-10

# Fonctions
def ajouter_objet(x, y, q):
    objet = (x, y, q)
    liste_objet.append(objet)

def retirer_objet(x, y):
    for o in liste_objet:
        if o[0] - 10 <= x <= o[0] + 10 and o[1] - 10 <= y <= o[1] + 10:
            liste_objet.remove(o)

def dessiner_objet():
    for objet in liste_objet:
        if objet[2] >= 0:
            pygame.draw.circle(fenetre, ROUGE, (objet[0], objet[1]), 10)
        else:
            pygame.draw.circle(fenetre, NOIR, (objet[0], objet[1]), 10)

def dessiner_mobile():
    if mobile_est_present:
        if mobile_charge >= 0:
            pygame.draw.circle(fenetre, ROUGE, (mobile_x, mobile_y), 10, 4)
        else:
            pygame.draw.circle(fenetre, NOIR, (mobile_x, mobile_y), 10, 4)

def traiter_action():
    if evenement.button == 1:
        ajouter_objet(evenement.pos[0], evenement.pos[1], 10**-7)
    elif evenement.button == 3:
        ajouter_objet(evenement.pos[0], evenement.pos[1], -10**-7)
    elif evenement.button == 2:
        retirer_objet(evenement.pos[0], evenement.pos[1])

def creer_mobile(x, y, q):
    global mobile_est_present, mobile_x, mobile_y, mobile_vx, mobile_vy, mobile_charge
    mobile_x, mobile_y = x, y
    mobile_vx, mobile_vy = 0, 0
    mobile_charge = q
    mobile_est_present = True


def calculer_champ(x, y):
    global mobile_est_present
    champ_elec_y = 0
    champ_elec_x = 0
    for objet in liste_objet:
        dx = x - objet[0]
        dy = y - objet[1]
        dist = math.sqrt(dx**2 + dy**2)
        if dist<= 15:
            mobile_est_present =  False
            return 0, 0, mobile_est_present
        else:
            n = K * objet[2] / (dist**2)
            champ_elec_x += (dx/dist)*n
            champ_elec_y += (dy/dist)*n
    return champ_elec_x, champ_elec_y, mobile_est_present

def mettre_a_jour_mobile(dt):
    global mobile_est_present, mobile_x, mobile_y, mobile_vx, mobile_vy, mobile_charge

    champ_elec_x, champ_elec_y, mobile_est_present = calculer_champ(mobile_x, mobile_y)
    if mobile_est_present:

        ax = champ_elec_x*mobile_charge/masse_mobile
        ay = champ_elec_y*mobile_charge/masse_mobile

        mobile_vx += ax*dt
        mobile_vy += ay*dt

        mobile_x += mobile_vx*dt + (ax*dt**2)/2
        mobile_y += mobile_vy*dt + (ay*dt**2)/2


def calculer_energie_potentielle(x, y, charge):
    global mobile_est_present, mobile_vx, mobile_vy
    ep = 0
    ec = 0
    if mobile_est_present:
        ec = masse_mobile* (mobile_vx**2 + mobile_vy**2) / 2
        for o in liste_objet:
            dx = x - o[0]
            dy = y - o[1]
            dist = math.sqrt(dx**2 + dy**2)
            ep += K*charge*o[2] / dist
    et = ep + ec
    return ep, ec, et

def calculer_potentiel(x, y):
    global mobile_charge, mobile_est_present, mobile_x, mobile_y
    eps = 0
    for o in liste_objet:
        dx = x - o[0]
        dy = y - o[1]
        dist = math.sqrt(dx**2 + dy**2)
        if dist > 10:
            eps += K*o[2] / dist
    if mobile_est_present:
        dx = x - mobile_x
        dy = y - mobile_y
        dist = math.sqrt(dx**2 + dy**2)
        if dist > 10:
            eps += K*mobile_charge /dist

    return eps




def afficher_texte():
    texte = "Energie cinétique : {0:.2f}".format(ec)
    police  = pygame.font.SysFont("monospace", 16)
    image = police.render(texte, True, NOIR)
    fenetre.blit(image, (100, 100))

    texte2 = "Energie potentiel : {0:.2f}".format(ep)
    image2 = police.render(texte2, True, NOIR)
    fenetre.blit(image2, (100, 125))

    texte3 = "Energie Totale    : {0:.2f}".format(et)
    image3 = police.render(texte3, True, NOIR)
    fenetre.blit(image3, (100, 150))

    texte4 = "Potentiel souris  : {0:.2f}".format(eps)
    image4 = police.render(texte4, True, NOIR)
    fenetre.blit(image4, (100, 175))

# Initialisation
pygame.init()

liste_objet = []

fenetre = pygame.display.set_mode(dimensions_fenetre)
pygame.display.set_caption("Programme 1")

horloge = pygame.time.Clock()
couleur_fond = BLEUCLAIR

mobile_est_present = False
mobile_x = 0
mobile_y = 0
mobile_vx = 0
mobile_vy = 0
mobile_charge = 0

ec = 0
ep = 0
et = 0
eps = 0

# Boucle principale
while True:
    dt = horloge.tick(images_par_seconde) / 1000
    x_souris, y_souris = pygame.mouse.get_pos()
    for evenement in pygame.event.get():
        if evenement.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
        elif evenement.type == pygame.MOUSEBUTTONDOWN:
            traiter_action()
        elif evenement.type == pygame.KEYDOWN:
            if evenement.key == pygame.K_p:
                x_souris, y_souris = pygame.mouse.get_pos()
                creer_mobile(x_souris, y_souris, C)
            elif evenement.key == pygame.K_n:
                x_souris, y_souris = pygame.mouse.get_pos()
                creer_mobile(x_souris, y_souris, -C)


    ep, ec, et  = calculer_energie_potentielle(mobile_x, mobile_y, mobile_charge)
    eps = calculer_potentiel(x_souris, y_souris)
    fenetre.fill(couleur_fond)
    mettre_a_jour_mobile(dt)
    afficher_texte()
    dessiner_mobile()
    dessiner_objet()
    pygame.display.flip()
    horloge.tick(images_par_seconde)
