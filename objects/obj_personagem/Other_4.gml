/// @description Posicionamento ao entrar na fase

// ---------------------------------------------------
// CHECKPOINT: Se existe checkpoint ativo nesta sala, spawna la
// ---------------------------------------------------
if (variable_global_exists("checkpoint_ativo") 
    && global.checkpoint_ativo 
    && global.checkpoint_sala == room) {
    
    x = global.checkpoint_x;
    y = global.checkpoint_y - 32;
    
    vveloc = 0;
    hveloc = 0;
    gravidade = 0.2;
    morreu = false;
    
    // Consome a flag de carregamento se existir
    if (variable_global_exists("carregando_jogo") && global.carregando_jogo) {
        global.carregando_jogo = false;
    }
    
    vida       = global.vida_save;
    faca       = global.faca_save;
    faca_cargas = global.faca_cargas_save;
    frutas     = global.frutas_save;
    
    // Mantem a invencibilidade atual ou da 60 frames de seguranca
    alarm[0] = max(alarm[0], 60);
    
    show_debug_message("Respawn no checkpoint!");
    exit; // Sai do evento, nao executa o spawn padrao abaixo
}

// ---------------------------------------------------
// SPAWN PADRAO (so roda se NAO ha checkpoint ativo nesta sala)
// ---------------------------------------------------
var _nome_sala = room_get_name(room);

if (_nome_sala == "rm_fase3") {
	
	x = 32; 
	y = 200; 
	
	vveloc = 0;
	hveloc = 0;
	gravidade = 0.2; 
	morreu = false;
	
	// Restauracao de vida segura
	if (!variable_global_exists("vida_save") || global.vida_save <= 0) {
		global.vida_save = 5;
	}
	vida = global.vida_save;
	
	alarm[0] = max(alarm[0], 60); 
	
	faca        = global.faca_save;
	faca_cargas = global.faca_cargas_save;
	frutas      = global.frutas_save;
	
	show_debug_message("Personagem spawnado na Fase 3 com imunidade temporaria.");
}
