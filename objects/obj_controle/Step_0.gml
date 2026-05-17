if (keyboard_check_pressed(vk_escape)) {

    if (!pausado){

        // Pede para pausar o jogo
        if (!pausar_proximo_frame){

            pausar_proximo_frame = true;

            // Seleciona a primeira opção do menu
            opcao_selecionada = 0;
        }

    } else {

        pausado = false;

        // Reativa todos os objetos do jogo
        instance_activate_all();

        if (sprite_exists(pause_sprite)){
            sprite_delete(pause_sprite);
        }
    }
}

if (pausado) {

    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))){

        opcao_selecionada--;

        // Se passar do começo da lista, vai para a última opção
        if (opcao_selecionada < 0){
            opcao_selecionada = array_length(opcoes_pause) - 1;
        }
    }

    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))){

        opcao_selecionada++;

        // Se passar da última opção, volta para a primeira
        if (opcao_selecionada >= array_length(opcoes_pause)){
            opcao_selecionada = 0;
        }
    }

    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)){

        // RETORNAR
        if (opcao_selecionada == 0){

            pausado = false;
            instance_activate_all();

            if (sprite_exists(pause_sprite)){
                sprite_delete(pause_sprite);
            }

        // SALVAR O JOGO
        } else if (opcao_selecionada == 1){

            game_save("save.dat");

        // SAIR DO JOGO
        } else if (opcao_selecionada == 2){

            game_end();
        }
    }

    // Para o restante do código enquanto estiver pausado
    exit;
}

if (room == rm_fase3) {
    if (tempo_fase3 > 0) {
        tempo_fase3 -= delta_time / 1000000;
    } else {
        tempo_fase3 = 0;
        if (instance_exists(obj_personagem)) {
            obj_personagem.vida = 0;
        }
    }
} else {
    // Mantém o tempo em 60 nas outras fases
    tempo_fase3 = 60;
}