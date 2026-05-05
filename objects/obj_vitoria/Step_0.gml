/// @description Controle da tela de vitória

// Reinicia o jogo ao pressionar R
if (keyboard_check_pressed(ord("R"))) {
    room_goto(rm_fase1);
}

// Volta para o menu ao pressionar Enter
if (keyboard_check_pressed(vk_enter)) {
    // Se você tiver uma sala de menu, coloque o nome dela aqui
    // Exemplo: room_goto(rm_menu);
     room_goto(rm_menu); // Por enquanto reinicia, ajuste para sua sala de menu se necessário
}
