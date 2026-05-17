var _apertou_r = keyboard_check_pressed(ord("R"));

var _apertou_enter = keyboard_check_pressed(vk_enter);

if ( _apertou_r || _apertou_enter){
	// ===============================
    // RESET DOS STATUS (acontece para os dois casos)
    // ===============================
	global.vida_save = 5;
    global.faca_save = 0;
    global.faca_cargas_save = 0;
    global.frutas_save = 0;
    
	 // ===============================
    // SE APERTAR A TECLA R
    // ===============================
	if (_apertou_r) {
		if ( variable_global_exists("checkpoint_ativo") && global.checkpoint_ativo){
			 room_goto(global.checkpoint_sala);
		}else {
			room_goto(rm_fase1);
		}
	}

// ===============================
    // SE APERTAR ENTER
    // ===============================
	else if (_apertou_enter) {
		if (variable_global_exists("checkpoint_ativo")){
			 // Desativa o checkpoint (como se apagasse ele)
			 global.checkpoint_ativo = false;
		}
		room_goto(rm_menu);
	}
}