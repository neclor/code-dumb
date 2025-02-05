import math
import pygame
import sys

# Constantes

BLEUCLAIR = (127, 191, 255)
ROUGE = (255, 0, 0)
BLEU = (0, 0, 255)
NOIR = (0, 0, 0)
K = 8.9876
RAYON = 10
A = 2
B = 5
C = 20

# ParamÃ¨tres

dimensions_fenetre = (1600, 900)  # en pixels
images_par_seconde = 25

# Initialisation
def ajouter_objet(x, y, q):
    objet = (x, y, q)
    liste_objet.append(objet)

def dessiner_objet():
    for objet in liste_objet:
        if(objet[2] >= 0):
            pygame.draw.circle(fenetre, ROUGE, (objet[0], objet[1]), 10)
        else:
            pygame.draw.circle(fenetre, NOIR, (objet[0], objet[1]), 10)

def deplacer_pol(point, distance, orientation):
    x, y = point
    x2 = x + distance * math.cos(orientation)
    y2= y + distance * math.sin(orientation)

    return (x2, y2)


def dessiner_vecteur(fenetre, couleur, origine, vecteur):
    x, y = vecteur
    alpha = math.atan2(y, x)
    longueur_vecteur = math.sqrt(vecteur[0]**2 + vecteur[1]**2)


    if longueur_vecteur >= C:
        p4 = deplacer_pol(origine, longueur_vecteur, alpha)
        p1 = deplacer_pol(origine, A, (alpha) - math.pi/2)
        p2 = deplacer_pol(p1, longueur_vecteur - C, alpha)
        p7 = deplacer_pol(origine, A, alpha + math.pi/2)
        p6 = deplacer_pol(p7, longueur_vecteur - C, alpha)
        p3 = deplacer_pol(p2, B, alpha - math.pi/2)
        p5 = deplacer_pol(p6, - B, alpha - math.pi/2)
        polygone = [ p1, p2, p3, p4, p5, p6, p7 ]
    else:
        p3 = deplacer_pol(origine, longueur_vecteur, alpha)
        p1 = deplacer_pol(p3, C, alpha + math.pi)
        p2 = deplacer_pol(p1, A+B, alpha - math.pi/2)
        p4 = deplacer_pol(p1, A+B, alpha + math.pi/2)
        polygone = [ p1, p2, p3, p4 ]

    pygame.draw.polygon(fenetre, couleur, polygone)
    return

def dessiner_champ():
    for y in range(-50, 950, 50):
        for x in range(-50, 1650, 50):
            calculer_champ(x, y)


def calculer_champ(x, y):
    champ_elec_y = 0
    champ_elec_x = 0
    for objet in liste_objet:
        dx = x - objet[0]
        dy = y - objet[1]
        dist = math.sqrt(dx**2 + dy**2)
        if dist <= 20:
            return
        else:
            n = K * objet[2] / (dist ** 2)
            champ_elec_x += (dx/dist) * n
            champ_elec_y += (dy/dist) * n

    force = math.sqrt(champ_elec_x**2 + champ_elec_y**2)
    if force < 10 ** -10:
        return
    else:
        fx = champ_elec_x / force * 40
        fy = champ_elec_y / force * 40
        v = math.sqrt(force * 1000)
        if 0 < v <= 8:
            couleur = (255, 255*v/8, 0)
        if 8<v<=16:
            couleur = (255- (255*v/16), 255, 255*v/16)
        if 16<v<=24:
            couleur = (0,255*v/24, 255)
        if 24<v<=32:
            couleur = (255*v/32, 0, 255)
        if v>32:
            couleur = (255, 0, 255)
        dessiner_vecteur(fenetre, couleur, (x-fx/2,y-fy/2), (fx, fy))



pygame.init()


liste_objet = []

fenetre = pygame.display.set_mode(dimensions_fenetre)
pygame.display.set_caption("Programme 1")

horloge = pygame.time.Clock()
couleur_fond = BLEUCLAIR
couleur = BLEU

# Dessin

fenetre.fill(couleur_fond)


ajouter_objet(800, 200, 10 ** -6)
ajouter_objet(800, 700, -10 ** -6)

while True:
    for evenement in pygame.event.get():
        if evenement.type == pygame.QUIT:
            pygame.quit()
            sys.exit()

    dessiner_objet()
    dessiner_champ()

    pygame.display.flip()
    horloge.tick(images_par_seconde)
