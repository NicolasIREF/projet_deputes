
install.packages("readxl")
install.packages("questionr")
install.packages("ggplot2")
library("readxl")
library("xlsx")
library("questionr")



deputestable1<-read_excel("deputes_table1net.xlsx")
deputestable2<-read_excel("deputes_table2.xlsx")
deputestable3<-read_excel("deputes_table3.xlsx")
"Il y a des problèmes avec la table 4 je pense que ca vient de la table Excel"
deputestable4<-read_excel("deputes_table4net.xlsx")

"On récupère le genre, il n y a que 573 deputes dont le genre est renseigne"
genre_deputes<-read_excel("genre_deputes.xlsx")
Titre<-genre_deputes$Titre<-paste(genre_deputes$Prénom,genre_deputes$Nom,sep=" ")
"Il convient de créer une nouvelle colonne dans deputestable1 pour pouvoir merge avec les deux autres"

Titre<-deputestable1$Titre<-paste(deputestable1$Prénom,deputestable1$Nom_Propre,sep=" ")

"On passe le contenu des titres en majuscule pour proceder au merge"
deputestable1$Titre<-toupper(deputestable1$Titre)
deputestable2$Titre<-toupper(deputestable2$Titre)
deputestable3$Titre<-toupper(deputestable3$Titre)
genre_deputes$Titre<-toupper(genre_deputes$Titre)


deputes<-merge(deputestable2,deputestable3, by="Titre")
deputes<-merge(deputes,deputestable1, by="Titre",all.x = TRUE)
deputes<-merge(deputes,genre_deputes, by="Titre",all.x = TRUE)
"Avec la nouvelle table1 on corrige bien les problemes de merge. Une seule personne disparait ce qui est normal cependant on veut la garder donc on va rajouter all.x=TRUE"



"Point de doute pour le problème de merge à vérifier dans la table1 On arrive à 571 merge"

"Problème trouvé : des personnes n'ont pas exactement le même prénom dans les deux bases j'essai donc de les repertoriers "

"Amal-Amélia Lakrafi"
"Table 2 et 3 : Amal-Amélia Lakrafi ; Table 1 : Amélia Lakrafi"

"Constance le Grip"
"Table 2 : Constance le Grip ; Table 3: Constance le Grip ; Table 1 : Constance Le Grip             Le problème se règle lorsqu'on passe titre ne majuscule"

"	Thierry Benoît"
"Table 2 : Thierry Benoît ;Table 3 : Thierry Benoit ; TABLE 1 : Thierry Benoit"

"Patricia Miralles"
"Table 2 : Patricia Miralles; TABLE 3 : Patricia Miralles; TABLE 1 : 	Patricia Mirallès"

"Pierre Venteau"
"Table 2 :Pierre Venteau ; TABLE 3: 	Pierre Venteau; TABLE1: Il n'existe pas dans la base 1"


"********************* NETTOYAGE DE LA BASE FUSIONNEE ********************* "


names(deputes)
"On enlève les prenoms et noms en trop."
"On veut enlever la colonne : 4 ; 18; 19;27;28"
deputes<-deputes[,-c(4,18,19,27,28)]
names(deputes)
age<-c(rep(2019,576))
deputes<-cbind(deputes,age)



"Je veux creer des bases de naissance" 

"**************************** GRAPHIQUES **********************************"
library(ggplot2)

"genres"
table(deputes$Sexe)
g1<-ggplot(deputes, aes(x=Sexe)) + geom_bar()
g1

"Distribution des ages"
x<-quantile(deputes$age, probs=c(0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1))
x
g2<-
  
"Camembert siège"
Parti<-deputes$`Groupe politique (abrégé)`
tableau<-table(Parti)
tableau<-data.frame(tableau)
repartition<-ggplot(tableau,aes(x="sieges",y=Freq, fill=Parti))+geom_bar(width = 1,stat="identity")
repartition
pie<-repartition+coord_polar("y",start=0)
pie

"Je voudrai faire un graphique sur la frequence de premier mandat par partie politique"


