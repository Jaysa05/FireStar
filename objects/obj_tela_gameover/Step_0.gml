// Verifica se a tecla R foi pressionada neste exato momento
var _apertou_r = keyboard_check_pressed(ord("R"));

// Verifica se a tecla ENTER foi pressionada neste exato momento
var _apertou_enter = keyboard_check_pressed(vk_enter);

// Se o jogador apertou R OU ENTER
if ( _apertou_r || _apertou_enter){
	// ===============================
    // RESET DOS STATUS (acontece para os dois casos)
    // ===============================
	global.vida_save = 5;            // Define a vida do jogador como 5
    global.faca_save = 0;            // Zera a quantidade de facas
    global.faca_cargas_save = 0;     // Zera as cargas das facas
    global.frutas_save = 0;          // Zera as frutas coletadas
    
	 // ===============================
    // SE APERTAR A TECLA R
    // ===============================
	if (_apertou_r) {
		// Verifica se a variável de checkpoint existe E está ativada
		if ( variable_global_exists("checkpoint_ativo") && global.checkpoint_ativo){
			 // Se tiver checkpoint ativo, vai para a sala salva nele
			 room_goto(global.checkpoint_sala);
		}else {
			// Se NÃO tiver checkpoint, volta para a fase inicial
			room_goto(rm_fase1);
		}
	}


// ===============================
    // SE APERTAR ENTER
    // ===============================
	else if (_apertou_enter) {
		// Verifica se a variável checkpoint existe
		if (variable_global_exists("checkpoint_ativo")){
			 // Desativa o checkpoint (como se apagasse ele)
			 global.checkpoint_ativo = false;
		}
		// Vai para o menu principal do jogo
		room_goto(rm_menu);
	}
}