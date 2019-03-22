
# Chargement du .Rprofile (packages "tidyverse","plotly").


###########################################################
##### 	Création du df #####
###########################################################

# Après une recherche auprès de plusieurs sources (articles de recherche, sites institutionnels, cf README), j'ai fais en sorte de définir des valeurs qui simulent l'évolution du taux de glycémie chez un diabétique de type 1 au cours d'une journée.

# col time
time <- seq(as.POSIXct("2019-03-03 06:00:00"), as.POSIXct("2019-03-04 06:00:00"), by = "30 min")

# col glycemia 
glycemia <- c(39,38,35,36,40,59,99,102,122,114,98,88,56,57,66,188,190,189,188,167,142,135,109,99,56,58,49,51,57,124,140,144,120,77,68,68,67,66,56,54,56,53,52,54,55,55,51,51,50)

df <- data.frame(time=time , glycemia=glycemia)

###########################################################
##### 	Les plots 		#####
###########################################################

# Créer le cadre du graphique

p <- ggplot(df, aes(time, glycemia))

# Mettre une graduation chaque 2 heures pour plus de lisibilité sur l'axe des abcisses (temps) 

p <- p + scale_x_datetime( date_labels ="%H:%M", date_breaks = "2 hours", expand=c(0,0)) + scale_y_continuous(breaks = c( 0,20,40,60,80,100,120,140,160,180,200,220 ))


# Dans ce graphique, je trace la courbe d'évolution de la glycemie (sans la charger avec la distinction des différents stades hypo et hyper)

p.evolution_glycemie <- p +
geom_line (color="lightblue", size=1) + 
geom_point(aes(time, glycemia),color="lightblue",size=1) + 
geom_area(fill="pink", alpha=1/4) 


# Ensuite, je définis les différents seuils de glycémie (taux normal,hyperglycemie,hypoglycemie, hypoglycemie sévère)


limite_hyperglycemie <- geom_hline(aes(yintercept= 200, linetype = "Hyperglycémie"), colour= 'red')

limite_glycemie_normale <-  geom_hline(aes(yintercept= 140, linetype = "Glycémie normale maximale"), colour= 'darkgreen')

limite_hypoglycemie <-  geom_hline(aes(yintercept= 60, linetype = "Hypoglycémie"), colour= 'red')

limite_hypoglycemie_severe <- geom_hline(aes(yintercept= 40, linetype = "Hypoglycémie sévère"), colour= 'red')


# Je surcharge le graphique avec les différents seuils

p.evolution_glycemie <- p.evolution_glycemie + limite_hyperglycemie

p.evolution_glycemie

p.evolution_glycemie <- p.evolution_glycemie + limite_glycemie_normale 

p.evolution_glycemie

p.evolution_glycemie <- p.evolution_glycemie + limite_hypoglycemie

p.evolution_glycemie

p.evolution_glycemie <- p.evolution_glycemie + limite_hypoglycemie_severe

p.evolution_glycemie

# J'execute un premier graphique simulant une évolution glycémique chez un diabétique type 1 sans cibler un évènement particulier.

p.evolution_glycemie <- p.evolution_glycemie +
ggtitle ("EVOLUTION GLYCEMIQUE CHEZ UN DIABETIQUE DE TYPE I") +
theme (plot.title = element_text(hjust=0.5))+
ylab("TAUX DE GLYCEMIE (mg/dl)") +
xlab("HEURE DE LA JOURNEE")+
theme_classic()+
theme(legend.title = element_blank())+
theme(legend.position="right")


ggplotly(p.evolution_glycemie)

## --------------------------------------

## Plot1. Simuler une hypoglycémie sévère.

# Identification d'un évènement d'hypoglycémie sévère

hypoglycemie_severe <- p.evolution_glycemie + 

annotate ("text", x = as.POSIXct("2019-03-03 07:00:00"), y=30,label = sprintf('\u2191'),color="red",size=6)+ 
annotate(geom="text",x=as.POSIXct("2019-03-03 08:30:00"),y=15,label=" Evenement\n\ d'hypoglycémie\n\ sévère > 40mg/dl",color="red",size=3)

# Je mets en forme le graphique ( titre, légende)


hypoglycemie_severe <- hypoglycemie_severe +
ggtitle ("EVENEMENT D'HYPOGLYCEMIE SEVERE CHEZ DIABETIQUE TYPE 1") +
theme (plot.title = element_text(hjust=0.5))+
ylab("TAUX DE GLYCEMIE (mg/dl)") +
xlab("HEURE DE LA JOURNEE")+
theme_classic()+
theme(legend.title = element_blank())+
theme(legend.background = element_rect(fill="transparent",size=0.5, linetype="solid"))+
theme(legend.position="right")


ggplotly(hypoglycemie_severe)


## --------------------------------------

## Plot2. Simuler une hyperglycémie prolongée (>2h).

# Je simule une hyperglycémie de plus de 2h.

# col time
time <- seq(as.POSIXct("2019-03-03 06:00:00"), as.POSIXct("2019-03-04 06:00:00"), by = "30 min")

# col glycemia

glycemia <- c(39,38,35,36,40,59,99,102,122,114,98,88,56,57,73,200,201,204,207,203,200,145,109,99,56,58,49,51,57,124,140,144,120,77,68,68,67,66,56,54,56,53,52,54,55,55,51,51,50)

df <- data.frame(time=time , glycemia=glycemia)

## Je crée le cadre du graphique

p <- ggplot(df, aes(time, glycemia))

# Mettre une graduation chaque 2 heures pour plus de lisibilité sur l'axe des abcisses (temps) 

p <- p + scale_x_datetime( date_labels ="%H:%M", date_breaks = "2 hours", expand=c(0,0)) + scale_y_continuous(breaks = c( 0,20,40,60,80,100,120,140,160,180,200,220 ))


## Je trace la courbe d'évolution de la glycemie.

p.evolution_glycemie <- p +
geom_line (color="lightblue", size=1) + 
geom_point(aes(time, glycemia),color="lightblue",size=1) + 
geom_area(fill="pink", alpha=1/4)


## J"execute les memes commandes que précédemment et je définis les seuils de glycémie (taux normal,hyperglycemie,hypoglycemie)


limite_hyperglycemie <- geom_hline(aes(yintercept= 200, linetype = "Hyperglycémie"), colour= 'red')

limite_glycemie_normale <-  geom_hline(aes(yintercept= 140, linetype = "Glycémie normale maximale"), colour= 'darkgreen')

limite_hypoglycemie <-  geom_hline(aes(yintercept= 60, linetype = "Hypoglycémie"), colour= 'red')


# Comme précédemment, je surcharge le graphique avec les différents seuils

p.evolution_glycemie <- p.evolution_glycemie + limite_hyperglycemie 

p.evolution_glycemie

p.evolution_glycemie <- p.evolution_glycemie + limite_glycemie_normale 

p.evolution_glycemie

p.evolution_glycemie <- p.evolution_glycemie + limite_hypoglycemie

p.evolution_glycemie


# Identification d'un évènement d'hyperglycemie prolongée (c'est-à-dire supérieur à 2h)


hyperglycemie_prolongee <- p.evolution_glycemie +

annotate ("text", x = as.POSIXct("2019-03-03 15:00:00"), y=195,label = sprintf('\u2191'),color="red",size=6)+

annotate(geom="text",x=as.POSIXct("2019-03-03 15:00:00"),y=180,label=" Hyperglycémie\n\ prolongée > 2H",color="red",size=3)


# Je mets en forme le graphique

hyperglycemie_prolongee <- hyperglycemie_prolongee +
ggtitle ("EVENEMENT D'HYPERGLYCEMIE PROLONGEE CHEZ UN PATIENT DIABETIQUE DE TYPE I")+
xlab ("HEURE DE LA JOURNEE")+
ylab ("TAUX DE GLYCEMIE (mg/dl)")

hyperglycemie_prolongee <- hyperglycemie_prolongee +
theme_classic()+
theme (legend.title = element_blank())+
theme(legend.position="right")


ggplotly(hyperglycemie_prolongee)


## -----------------------------------------

## Plot3. Visualiser les repas pris au cours de la journée.


# col time
time <- seq(as.POSIXct("2019-03-03 06:00:00"), as.POSIXct("2019-03-04 06:00:00"), by = "30 min")

# col glycemia 
glycemia <- c(39,38,35,36,40,59,99,102,122,114,98,88,56,57,66,188,190,189,188,167,142,135,109,99,56,58,49,51,57,124,140,144,120,77,68,68,67,66,56,54,56,53,52,54,55,55,51,51,50)

df <- data.frame(time=time , glycemia=glycemia)

# Créer le cadre du graphique

p <- ggplot(df, aes(time, glycemia))

# Mettre une graduation chaque 2 heures pour plus de lisibilité sur l'axe des abcisses (temps) 

p <- p + scale_x_datetime( date_labels ="%H:%M", date_breaks = "2 hours", expand=c(0,0)) + scale_y_continuous(breaks = c( 0,20,40,60,80,100,120,140,160,180,200,220 ))


# Dans ce graphique, je trace la courbe d'évolution de la glycemie (sans la charger avec la distinction des différents stades hypo et hyper)

p.evolution_glycemie <- p +
geom_line (color="lightblue", size=1) + 
geom_point(aes(time, glycemia),color="lightblue",size=1) + 
geom_area(fill="pink", alpha=1/4)

p.evolution_glycemie

# Je définis les plages horaires des repas pris en journée (petit-déjeuner, déjeuner, diner)

# Diner 

interval_diner_start <- annotate("segment",x=as.POSIXct("2019-03-03 22:00:00"),xend=as.POSIXct("2019-03-03 20:00:00"),y=1,yend=1,arrow=arrow(length=unit(0.2,"cm")),color="darkgrey",linetype="dashed")

interval_diner_end <- annotate("segment",x=as.POSIXct("2019-03-03 20:00:00"),xend=as.POSIXct("2019-03-03 22:00:00"),y=1,yend=1,arrow=arrow(length=unit(0.2,"cm")),color="darkgrey",linetype="dashed")


# Déjeuner

interval_dejeuner_start <-annotate("segment",x=as.POSIXct("2019-03-03 14:00:00"),xend=as.POSIXct("2019-03-03 12:00:00"),y=1,yend=1,arrow=arrow(length=unit(0.2,"cm")),color="darkgrey",linetype="dashed")

interval_dejeuner_end <- annotate("segment",x=as.POSIXct("2019-03-03 12:00:00"),xend=as.POSIXct("2019-03-03 14:00:00"),y=1,yend=1,arrow=arrow(length=unit(0.2,"cm")),color="darkgrey",linetype="dashed")

# Petit-Déjeuner

interval_petit_dejeuner_start <-annotate("segment",x=as.POSIXct("2019-03-03 10:00:00"),xend=as.POSIXct("2019-03-03 08:00:00"),y=1,yend=1,arrow=arrow(length=unit(0.2,"cm")),color="darkgrey",linetype="dashed")

interval_petit_dejeuner_end <-annotate("segment",x=as.POSIXct("2019-03-03 08:00:00"),xend=as.POSIXct("2019-03-03 10:00:00"),y=1,yend=1,arrow=arrow(length=unit(0.2,"cm")),color="darkgrey",linetype="dashed")



visualisation_des_repas_dans_la_journee <- p.evolution_glycemie +
interval_diner_start+
interval_diner_end+
interval_dejeuner_start+
interval_dejeuner_end+
interval_petit_dejeuner_start+
interval_diner_end +
annotate(geom="text",x=as.POSIXct("2019-03-03 21:00:00"),y=5,label="Dîner",color="darkgreen",size=3)+
annotate(geom="text",x=as.POSIXct("2019-03-03 13:00:00"),y=5,label="Déjeuner",color="darkblue",size=3)+
annotate(geom="text",x=as.POSIXct("2019-03-03 09:00:00"),y=5,label="Petit-Déjeuner",color="purple",size=3)


# Je mets en forme le graphique

visualisation_des_repas_dans_la_journee <- visualisation_des_repas_dans_la_journee +
ggtitle("VISUALISATION DES PERIODES DE REPAS AU COURS DE LA JOURNEE")+
xlab("HEURE DE LA JOURNEE")+
ylab("TAUX DE GLYCEMIE (mg/dl)")+
theme_classic()+
theme (legend.title = element_blank())+
theme(legend.position="right")


visualisation_des_repas_dans_la_journee


## -----------------------------------------

## Plot4. Visualiser les injections d'insuline.

# Visualisation des "injections rapides"

# Je cible les moments d'injections d'insuline rapide. Celles-ci sont généralement faite avant le repas. Elles permettent de contrôler l'hyperglycémie qui suit l'ingestion de nourriture lors des repas.

# Insuline rapide avant petit-déjeuner

injection_insuline_matin <- geom_segment(aes(x=as.POSIXct("2019-03-03 07:30:00"),y=20,xend=as.POSIXct("2019-03-03 07:30:00"),yend=0,linetype="Injections d'insuline rapide avant repas"),arrow=arrow(),size=1,color="red") 


# Insuline rapide avant repas du midi

injection_insuline_midi <- geom_segment(aes(x=as.POSIXct("2019-03-03 11:30:00"),y=20,xend=as.POSIXct("2019-03-03 11:30:00"),yend=0),arrow=arrow(),size=1,color="red") 

# Insuline rapide avant repas du soir

injection_insuline_soir <- geom_segment(aes(x=as.POSIXct("2019-03-03 19:30:00"),y=20,xend=as.POSIXct("2019-03-03 19:30:00"),yend=0),arrow=arrow(),size=1,color="red") 


injections_insuline_rapides_dans_la_journee <- visualisation_des_repas_dans_la_journee + 
injection_insuline_matin + 
injection_insuline_midi + 
injection_insuline_soir


# Je mets en forme le graphique

injections_insuline_rapides_dans_la_journee <- injections_insuline_rapides_dans_la_journee +
ggtitle("INJECTIONS D'INSULINE DANS LA JOURNEE")+
theme (plot.title = element_text(hjust=0.5))+
xlab("HEURE DE LA JOURNEE")+
ylab("TAUX DE GLYCEMIE (mg/dl)")+
theme_classic()+
theme(legend.title = element_blank())+
theme(legend.position="right")

 injections_insuline_rapides_dans_la_journee
