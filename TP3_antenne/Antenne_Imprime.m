%simulation d'une antenne formée de deux patch circulaire fonctionnant à 1.5 GHz
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
sep = 3*r_patch; %séparation centre à centre entre les deux patchs circulaires
%dimensions du plan de masse (forme rectangulaire)
L_gnd = 6*r_patch;
W_gnd = 3*r_patch;
%création du modèle de l'antenne
%plan de masse
GndPlane = antenna.Rectangle('Length',L_gnd,'Width',W_gnd);
% les deux patchs
RadElement1 = antenna.Circle('Radius',r_patch,'Center',[-sep/2 0]);
RadElement2 = antenna.Circle('Radius',r_patch,'Center',[sep/2 0]);
RadElement = RadElement1+RadElement2; %assemblage sur la même couche
%création du diélectrique composant le substrat
MonDielec =dielectric('Name','Mon_dielectrique','EpsilonR',epsr,'LossTangent',tan_d);
%génération du modèle de l'antenne
MyPatch = pcbStack;
MyPatch.Name = 'Deux Patchs circulaires';
MyPatch.BoardThickness = h_patch;
MyPatch.BoardShape = GndPlane; %les bords de l'antenne sont définis par les dimensions
%du plan de masse
MyPatch.Layers = {RadElement,MonDielec,GndPlane}; %définition des différentes couches
%du pcb, en commençant par la couche supérieure.
%ajout de deux excitations (sur chaque patch)
MyPatch.FeedLocations = [-sep/2+pos_exc 0 1 3;sep/2+pos_exc 0 1 3]; %[x y Couche_signal Couche_gnd]
%maillage et affichage du modèle
figure(1);
show(MyPatch);