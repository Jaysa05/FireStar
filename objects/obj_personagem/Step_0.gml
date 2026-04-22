/// @description Insert description here
script_execute(estado)
// -----------------------------
// SISTEMA DE COMBATE (EFEITO DE DANO)
// -----------------------------

// se o alarme ainda estiver ativo
if (alarm[0] > 0){

	// se estiver totalmente visível
	if (image_alpha >= 1){

		// começa a ficar invisível
		alfa_hit = -0.05;

	// se estiver invisível
	}else if (image_alpha < 0){

		// começa a ficar visível novamente
		alfa_hit = 0.05;
	}

	// altera a transparência do sprite
	image_alpha += alfa_hit;

}else {

	// quando o alarme acabar volta ao normal
	image_alpha = 1;
}

depth = -bbox_bottom; //Quanto mais embaixo o personagem estiver na tela, mais na frente ele aparece

	//Se a vida chegar a 0
if (vida <= 0 && !morreu) {
    morreu = true;
    
    // Se houver um checkpoint ativo, resetamos os dados para o renascimento
    if (variable_global_exists("checkpoint_ativo")) {
        global.vida_save = 5;
        global.faca_save = 0;
        global.faca_cargas_save = 0;
        global.frutas_save = 0;
    }
    
    vida = global.vida_save;
    faca = global.faca_save;
    faca_cargas = global.faca_cargas_save;
    frutas = global.frutas_save;
    room_goto(rm_gameover);
}