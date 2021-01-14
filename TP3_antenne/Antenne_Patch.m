%simulation d'une antenne patch circulaire fonctionnant à 1.5 GHz
%calcul de la longueur d'onde dans le patch à 1.5 GHz
c0 = 3e8;
f0 = 1.5e9;
epsr = 2.2; %constante diélectrique du substrat
tan_d = 0.01; %tan de pertes du substrat
lambda_0 = c0/(2*sqrt(epsr)*f0);
%dimensions géométriques du patch
r_patch = 0.99*1.841*c0/(2*pi*f0*sqrt(epsr));
h_patch = 2e-3; %hauteur du patch = séparation entre le patch et le plan de masse
pos_exc = 0.36*r_patch; %position du point d'excitation par rapport au centre du patch
W_gnd = 3*r_patch; %dimensions du plan de masse (forme carrée)
%création du diélectrique composant le substrat
d =dielectric('Name','Mon_dielectrique','EpsilonR',epsr,'LossTangent',tan_d);
%création du modèle de l'antenne
MyPatch = patchMicrostripCircular('Radius',r_patch,'Height',h_patch,'GroundPlaneLength' ,W_gnd,'GroundPlaneWidth',W_gnd,'Substrate',d,'FeedOffset',[pos_exc 0]);
%maillage et affichage du modèle
figure(1);
show(MyPatch);
%définition des fréquences de calcul
freq_calc = linspace(1.3e9,1.7e9,21);
%lancement des différents calculs et affichage
%impédance
figure(2);
impedance(MyPatch,freq_calc);
%diagramme de Smith
figure(3);
ParamS = sparameters(MyPatch,freq_calc);
Smith = smithplot(ParamS,'GridType','Z');
%affichage de la distribution du courant à la fréquence f0
figure(4);
current(MyPatch,f0);
%affichage du diagramme de rayonnement (gain) en 3D
figure(5);
pattern(MyPatch,f0,'Type','gain');
%beamwidth en fonction de l'angle d'élévation (azimuth = 0°)
figure(6);
beamwidth(MyPatch,f0,0,1:1:360);