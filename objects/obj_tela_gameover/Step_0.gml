// Verifica se a tecla R foi pressionada neste exato momento
var _apertou_r = keyboard_check_pressed(ord("R"));

// Verifica se a tecla ENTER foi pressionada neste exato momento
var _apertou_enter = keyboard_check_pressed(vk_enter);

// Se o jogador apertou R OU ENTER
if (_apertou_r || _apertou_enter){

	// ===============================
    // SE APERTAR A TECLA R (RECOMECAR DO CHECKPOINT)
    // ===============================
	if (_apertou_r) {
		
		// Tenta recarregar dados do save.ini para garantir estado salvo
		if (file_exists("save.ini")){
			ini_open("save.ini");
			global.checkpoint_ativo    = ini_read_real("Checkpoint", "ativo", false);
			global.checkpoint_sala     = ini_read_real("Checkpoint", "sala", room);
			global.checkpoint_x        = ini_read_real("Checkpoint", "x", 0);
			global.checkpoint_y        = ini_read_real("Checkpoint", "y", 0);
			global.vida_save           = ini_read_real("Player", "vida", 5);
			global.faca_save           = ini_read_real("Player", "faca", 0);
			global.faca_cargas_save    = ini_read_real("Player", "faca_cargas", 0);
			global.frutas_save         = ini_read_real("Player", "frutas", 0);
			ini_close();
			if (global.checkpoint_ativo) {
				global.carregando_jogo = true;
			}
		}
		
		// Verifica se o checkpoint esta ativo e vai para a sala salva
		if (variable_global_exists("checkpoint_ativo") && global.checkpoint_ativo){
			room_goto(global.checkpoint_sala);
		} else {
			// Se NAO tiver checkpoint, reseta e volta para a fase inicial
			global.vida_save        = 5;
			global.faca_save        = 0;
			global.faca_cargas_save = 0;
			global.frutas_save      = 0;
			room_goto(rm_fase1);
		}
	}

	// ===============================
    // SE APERTAR ENTER (VOLTAR AO MENU)
    // ===============================
	else if (_apertou_enter) {
		room_goto(rm_menu);
	}
}
