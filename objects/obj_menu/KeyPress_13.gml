/// @description Seleção do Menu
if (index == 0) {
    // ===============================
    // RESET DOS STATUS PARA NOVO JOGO
    // ===============================
    global.vida_save = 5;
    global.faca_save = 0;
    global.faca_cargas_save = 0;
    global.frutas_save = 0;
    global.inv_save = 0;
    // Verifica se existe checkpoint criado
    if (variable_global_exists("Checkpoint_ativo")) {
		// Desativa checkpoint antigo
        global.checkpoint_ativo = false;
    }
	 // Vai para a próxima sala (início do jogo)
    room_goto_next();
    

}

 // ===============================
    // NOVO JOGO
    // ===============================

// Se o jogador apertar "Carregar Jogo"
else if (index == 1){
	
	// ===============================
    // CARREGAR JOGO SALVO
    // ===============================
	
	if (file_exists("save.ini")){
		ini_open("save.ini");
		
		// Lê se existe checkpoint ativo
        // Caso não exista usa false
		global.checkpoint_ativo = ini_read_real("Checkpoint", "ativo", false);
		
		 // Verifica se o checkpoint está ativo
		 if (global.checkpoint_ativo) {
			 
			  // Lê posição X salva
			  global.checkpoint_x = ini_read_real("Checkpoint", "x", 0);
			  
			  global.checkpoint_sala = ini_read_real("Checkpoint", "sala", room);
			  
			  global.checkpoint_y = ini_read_real("checkpoint", "y", 0);
			  
			  global.vida_save = ini_read_real("player", "vida", 5 );
			  
			  global.faca_save = ini_read_real("player", "faca", 0);
			  
			  global.faca_cargas_save = ini_read_real("player", "faca_cargas", 0);
			  
			  global.frutas_save = ini_read_real("player", "frutas", 0);
			  
			   // Reinicia tempo de invencibilidade
			   global.inv_save = 0;
			   
			    // Fecha o arquivo após leitura
				ini_close();
				
				// Marca que o jogo está carregando
				// Evita substituir dados durante carregamento
				global.carregando_jogo = true;
				
				// Vai para a sala salva
				room_goto(global.checkpoint_sala);
				
		 }
		 
		 else {
			 
			  // Fecha arquivo caso não exista checkpoint
			  ini_close();
			  
			   // Informa ao jogador
			   show_message("Nenhum checkpoint salvo encontrado");   
		 
		 } 
	}
	else {
	// Informa que não existe save
	show_message("Nenhum arquivo de jogo salvo encontrado!");
	}
	
		 
	}

 
 else if (index == 3 ){
	 
	  // ===============================
	// SAIR DO JOGO
    // ===============================
	
		if (file_exists("save.ini")){
			
			// Apaga o save
			file_delete("save.ini");
		}
		
		 // Fecha completamente o jogo
		 game_end();
 }
