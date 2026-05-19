/// @description Controle da tela de vitória

// Variáveis para verificar se as teclas foram pressionadas
var _apertou_r = keyboard_check_pressed(ord("R"));
var _apertou_enter = keyboard_check_pressed(vk_enter);

// Se o jogador apertou R ou ENTER, resetamos os status
if (_apertou_r || _apertou_enter) {
    // ===============================
    // RESET DOS STATUS
    // ===============================
    global.vida_save = 5;            // Define a vida do jogador como 5
    global.faca_save = 0;            // Zera a posse da faca
    global.faca_cargas_save = 0;     // Zera as cargas das facas
    global.frutas_save = 0;          // Zera as frutas coletadas
    global.inv_save = 0;             // Zera o tempo de invencibilidade
    
    // Desativa o checkpoint se existir
    if (variable_global_exists("checkpoint_ativo")) {
        global.checkpoint_ativo = false;
    }

    // Reinicia o jogo para a fase 1 se apertar R
    if (_apertou_r) {
        room_goto(rm_fase1);
    }
    // Volta para o menu se apertar Enter
    else if (_apertou_enter) {
        room_goto(rm_menu);
    }
}
