/// @description Selecao do Menu
if (index == 0) {
    // ===============================
    // RESET DOS STATUS PARA NOVO JOGO
    // ===============================
    global.vida_save = 5;
    global.faca_save = 0;
    global.faca_cargas_save = 0;
    global.frutas_save = 0;
    global.inv_save = 0;
    
    if (variable_global_exists("checkpoint_ativo")) {
        global.checkpoint_ativo = false;
    }
    
    // Deleta save antigo ao iniciar um Novo Jogo
    if (file_exists("save.ini")) {
        file_delete("save.ini");
    }
    
    // Vai para a proxima sala (inicio do jogo)
    room_goto_next();
}
// Se o jogador apertar "Carregar Jogo"
else if (index == 1) {
    // ===============================
    // CARREGAR JOGO SALVO
    // ===============================
    if (file_exists("save.ini")) {
        ini_open("save.ini");
        
        // Le se existe checkpoint ativo
        global.checkpoint_ativo = ini_read_real("Checkpoint", "ativo", false);
        
        // Verifica se o checkpoint esta ativo
        if (global.checkpoint_ativo) {
            global.checkpoint_x    = ini_read_real("Checkpoint", "x", 0);
            global.checkpoint_sala = ini_read_real("Checkpoint", "sala", room);
            global.checkpoint_y    = ini_read_real("Checkpoint", "y", 0);
            
            global.vida_save         = ini_read_real("Player", "vida", 5);
            global.faca_save         = ini_read_real("Player", "faca", 0);
            global.faca_cargas_save  = ini_read_real("Player", "faca_cargas", 0);
            global.frutas_save       = ini_read_real("Player", "frutas", 0);
            
            // Reinicia tempo de invencibilidade
            global.inv_save = 0;
            
            // Fecha o arquivo apos leitura
            ini_close();
            
            // Marca que o jogo esta carregando
            global.carregando_jogo = true;
            
            // Vai para a sala salva
            room_goto(global.checkpoint_sala);
        } else {
            ini_close();
            show_message("Nenhum checkpoint salvo encontrado!");
        } 
    } else {
        show_message("Nenhum arquivo de jogo salvo encontrado!");
    }
}
else if (index == 3) {
    // ===============================
    // SAIR DO JOGO (salvo permanece intacto)
    // ===============================
    game_end();
}
