#Compute the value of the parameter of the axis


scoreboard players operation #d0 bs.screen_detection = #o0 bs.screen_detection
scoreboard players operation #d1 bs.screen_detection = #o1 bs.screen_detection
scoreboard players operation #d2 bs.screen_detection = #o2 bs.screen_detection

scoreboard players operation #d0 bs.screen_detection -= #v0 bs.screen_detection
scoreboard players operation #d1 bs.screen_detection -= #v1 bs.screen_detection
scoreboard players operation #d2 bs.screen_detection -= #v2 bs.screen_detection

scoreboard players operation #t0 bs.screen_detection = #d0 bs.screen_detection
scoreboard players operation #t1 bs.screen_detection = #d1 bs.screen_detection
scoreboard players operation #t2 bs.screen_detection = #d2 bs.screen_detection

scoreboard players operation #t0 bs.screen_detection *= #n0 bs.screen_detection
scoreboard players operation #t1 bs.screen_detection *= #n1 bs.screen_detection
scoreboard players operation #t2 bs.screen_detection *= #n2 bs.screen_detection


scoreboard players operation #dz bs.screen_detection = #t0 bs.screen_detection
scoreboard players operation #dz bs.screen_detection += #t1 bs.screen_detection
scoreboard players operation #dz bs.screen_detection += #t2 bs.screen_detection

scoreboard players operation #dz bs.screen_detection /= #dot0 bs.screen_detection


#Compute the relative positon of the intersection and plane origin

scoreboard players operation #w0 bs.screen_detection = #u0 bs.screen_detection
scoreboard players operation #w1 bs.screen_detection = #u1 bs.screen_detection
scoreboard players operation #w2 bs.screen_detection = #u2 bs.screen_detection

scoreboard players operation #w0 bs.screen_detection *= #dz bs.screen_detection
scoreboard players operation #w1 bs.screen_detection *= #dz bs.screen_detection
scoreboard players operation #w2 bs.screen_detection *= #dz bs.screen_detection

scoreboard players operation #w0 bs.screen_detection /= #1000 bs.screen_detection
scoreboard players operation #w1 bs.screen_detection /= #1000 bs.screen_detection
scoreboard players operation #w2 bs.screen_detection /= #1000 bs.screen_detection

scoreboard players operation #w0 bs.screen_detection -= #d0 bs.screen_detection
scoreboard players operation #w1 bs.screen_detection -= #d1 bs.screen_detection
scoreboard players operation #w2 bs.screen_detection -= #d2 bs.screen_detection


#compute the plane coord

scoreboard players operation #dx bs.screen_detection = #w0 bs.screen_detection
scoreboard players operation #wp1 bs.screen_detection = #w1 bs.screen_detection
scoreboard players operation #wp2 bs.screen_detection = #w2 bs.screen_detection
scoreboard players operation #dx bs.screen_detection *= #i0 bs.screen_detection
scoreboard players operation #wp1 bs.screen_detection *= #i1 bs.screen_detection
scoreboard players operation #wp2 bs.screen_detection *= #i2 bs.screen_detection

scoreboard players operation #dx bs.screen_detection += #wp1 bs.screen_detection
scoreboard players operation #dx bs.screen_detection += #wp2 bs.screen_detection
scoreboard players operation #dx bs.screen_detection /= #1000 bs.screen_detection

scoreboard players operation #dy bs.screen_detection = #w0 bs.screen_detection
scoreboard players operation #wp1 bs.screen_detection = #w1 bs.screen_detection
scoreboard players operation #wp2 bs.screen_detection = #w2 bs.screen_detection
scoreboard players operation #dy bs.screen_detection *= #j0 bs.screen_detection
scoreboard players operation #wp1 bs.screen_detection *= #j1 bs.screen_detection
scoreboard players operation #wp2 bs.screen_detection *= #j2 bs.screen_detection

scoreboard players operation #dy bs.screen_detection += #wp1 bs.screen_detection
scoreboard players operation #dy bs.screen_detection += #wp2 bs.screen_detection
scoreboard players operation #dy bs.screen_detection /= #1000 bs.screen_detection

