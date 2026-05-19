/// @description Insert description here
event_inherited(); 
// Usaremos a animação do tomate, mas vamos "esconder" o tomate com o flash branco
// O segredo do Rinoceronte é usar esse sprite abaixo como fumaça:
sprite_morrendo = spr_tomate_morrendo; 


item_drop = noone; 

hveloc = 1;       // velocidade horizontal de voo
vveloc = -2;             // velocidade vertical (sobe levemente)
image_xscale = -1;    // começa voando para a esquerda

// ------------------------------
// CONTROLE DO MERGULHO
// ------------------------------

// Guarda a posição vertical inicial do pássaro
// (serve como "altura original" para ele voltar depois)
y_inicial = y;

// Indica que o pássaro NÃO está mergulhando no momento
mergulhando = false;

// Indica que o pássaro NÃO está voltando (subindo) no momento
voltando = false;

