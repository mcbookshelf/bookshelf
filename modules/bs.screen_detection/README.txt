
##ENG

Let P be a plane, D a line with origin O, and M their point of intersection:

This library allows you to retrieve the coordinates of M in plane P using three commands.

[[Step 1—Initialization]] (the most performance-intensive step)
-Execute the `get_line` command to obtain line D
    -Based on the execution context of this function (position and rotation), calculate the internal variables defining D
    - To obtain D corresponding to a player’s line of sight, have them execute the command: ‘execute at @s anchored eyes positioned ^ ^ ^ run function sd:api/get_line’ 

- Execute the get_plane command to obtain P
    - Based on this function’s execution context (position and rotation), calculate the internal variables defining P

[[Step 2—Calculations]]
-Execute the `plane_coord` command
    -No execution context required; this is a scoreboard operation
    -The result is stored in:
        -#dx bs.out: the x-coordinate of point M in plane P
        -#dy bs.out: the y-coordinate of point M in plane P
        -#dz bs.out: the algebraic distance between O and M


Note:
-If the direction vectors of plane P and line D are orthogonal (scalar product is zero), the returned values will be empty

----------------------------------------------------------------

##FR
Soit un plan P, une droite D d'origine O et leur point d'intersection M:

Cette librairie permet en trois commandes de récupérer la coordonée de M dans le plan P.

[[1re étape- initialisation]] (l'étape la plus couteuse en performance, même si assez optimisée)
-executer la commande `get_line` pour obtenir D
    -à partir du contexte d'execution de cette fonction (position et rotation) calcul les variables internes definissant D
    -pour obtenir D correspondant à la ligne de regard d'un joueur lui faire executer la commande: `execute at @s anchored eyes positioned ^ ^ ^ run function bs.const:api/get_line` 

-executer la commande get_plane pour obtenir P
    -à partir du contexte d'execution de cette fonction (position et rotation) calcul les variables internes definissant P

[[2sd étape- calculs]]
-executer la commande `plane_coord`
    -pas de contexte d'execution requis, il s'agit d'operation via scoreboard
    -le resultat est stocké dans:
        -#dx bs.out l'abscisse du point M dans le plan P
        -#dy bs.out l'ordonnée du point M dans le plan P
        -#dz bs.out la distance algébrique entre O et M


Attention:
-si les vecteurs directeurs du plan P et de la droite D sont orthogonaux (produit scalaire nul), les valeurs retournées seront vides
