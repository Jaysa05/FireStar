/// @description Seleção do Menu
if(index == 0) {
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

    room_goto_next();
} else if(index == 3) {
    game_end();
}
