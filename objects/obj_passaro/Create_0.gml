/// @description Insert description here
event_inherited(); 
// Usaremos a animação do tomate, mas vamos "esconder" o tomate com o flash branco
// O segredo do Rinoceronte é usar esse sprite abaixo como fumaça:
sprite_morrendo = spr_tomate_morrendo; 


item_drop = noone; 

hveloc = 1;       // velocidade horizontal de voo
vveloc = -2;             // velocidade vertical (sobe levemente)
image_xscale = -1;    // começa voando para a esquerda
