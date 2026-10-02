/// @description Controle da tela de vitoria

var _apertou_r     = keyboard_check_pressed(ord("R"));
var _apertou_enter = keyboard_check_pressed(vk_enter);

if (_apertou_r || _apertou_enter) {
    // ===============================
    // RESET DOS STATUS AO TERMINAR O JOGO
    // ===============================
    global.vida_save        = 5;
    global.faca_save        = 0;
    global.faca_cargas_save = 0;
    global.frutas_save      = 0;
    global.inv_save         = 0;
    
    // Desativa o checkpoint e apaga o arquivo de save
    if (variable_global_exists("checkpoint_ativo")) {
        global.checkpoint_ativo = false;
    }
    if (file_exists("save.ini")) {
        file_delete("save.ini");
    }

    if (_apertou_r) {
        room_goto(rm_fase1);
    }
    else if (_apertou_enter) {
        room_goto(rm_menu);
    }
}
