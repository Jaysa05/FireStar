/// @description Posicionamento ao entrar na fase

// ---------------------------------------------------
// CHECKPOINT: Se existe checkpoint ativo nesta sala, spawna lá
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
    
    // --- RESET DE STATUS AO VOLTAR PARA O CHECKPOINT ---
    global.vida_save = 5;          // Vida cheia
    global.faca_save = 0;          // Sem facas
    global.faca_cargas_save = 0;   // Sem cargas
    global.frutas_save = 0;        // Sem frutas
    
    vida = global.vida_save;
    faca = global.faca_save;
    faca_cargas = global.faca_cargas_save;
    frutas = global.frutas_save;
    
    alarm[0] = 60;
    
    show_debug_message("Respawn no checkpoint!");
    exit; // Sai do evento, não executa o spawn padrão abaixo
}

// ---------------------------------------------------
// SPAWN PADRÃO (só roda se NÃO há checkpoint ativo)
// ---------------------------------------------------
var _nome_sala = room_get_name(room);

if (_nome_sala == "rm_fase3") {
	
	// POSIÇÃO DE SEGURANÇA: Nasce no ar (y=200) para cair no chão suavemente
	x = 32; 
	y = 200; 
	
	// RESET TOTAL DE FÍSICA
	vveloc = 0;
	hveloc = 0;
	gravidade = 0.2; 
	morreu = false;  // SUPREMA BLINDAGEM: Cancela o estado de morte
	
	// RESTAURAÇÃO DE VIDA SEGURA (Força 5 vidas no spawn)
	global.vida_save = 5;
	vida = global.vida_save;
	
	// INVENCIBILIDADE TEMPORÁRIA: 1 segundo de segurança ao nascer
	alarm[0] = 60; 
	
	// Restaurar itens
	faca = global.faca_save;
	faca_cargas = global.faca_cargas_save;
	
	show_debug_message("Personagem ressuscitado e spawnado na Fase 3 com imunidade temporária.");
}
