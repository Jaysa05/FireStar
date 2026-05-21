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
        salvo_mensagem_timer = 0; // Reseta o timer da mensagem de salvo

        // Reativa todos os objetos do jogo
        instance_activate_all();

        if (sprite_exists(pause_sprite)){
            sprite_delete(pause_sprite);
        }
    }
}

if (pausado) {

    // Decrementa o timer da mensagem de salvamento
    if (salvo_mensagem_timer > 0) {
        salvo_mensagem_timer--;
    }

    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))){

        // Volta uma opção no menu
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
            salvo_mensagem_timer = 0; // Reseta o timer da mensagem de salvo
            instance_activate_all();

            if (sprite_exists(pause_sprite)){
                sprite_delete(pause_sprite);
            }

        // SALVAR O JOGO
        } else if (opcao_selecionada == 1){

            // Define e grava dados do Checkpoint e jogador em save.ini
            var _chk_ativo = false;
            var _chk_sala = room;
            var _chk_x = 0;
            var _chk_y = 0;

            if (variable_global_exists("Checkpoint_ativo") && global.checkpoint_ativo) {
                _chk_ativo = true;
                _chk_sala = global.checkpoint_sala;
                _chk_x = global.checkpoint_x;
                _chk_y = global.checkpoint_y;
            } else {
                // Se não há checkpoint ativo ainda, salva a última posição capturada ao pausar
                _chk_ativo = true;
                _chk_sala = room;
                _chk_x = player_x_pause;
                _chk_y = player_y_pause + 32; // Adiciona compensação para o spawn
            }

            ini_open("save.ini");
            ini_write_real("Checkpoint", "ativo", _chk_ativo);
            ini_write_real("Checkpoint", "sala", _chk_sala);
            ini_write_real("Checkpoint", "x", _chk_x);
            ini_write_real("Checkpoint", "y", _chk_y);

            ini_write_real("Player", "vida", vida_pause);
            ini_write_real("Player", "faca", faca_pause);
            ini_write_real("Player", "faca_cargas", faca_cargas_pause);
            ini_write_real("Player", "frutas", frutas_pause);
            ini_close();

            salvo_mensagem_timer = 120; // Mostra a mensagem por 2 segundos (120 frames)

        // SAIR DO JOGO (Voltar para o Menu)
        } else if (opcao_selecionada == 2){

            // Limpa o estado da pausa e reativa instâncias
            pausado = false;
            salvo_mensagem_timer = 0;
            instance_activate_all();

            if (sprite_exists(pause_sprite)){
                sprite_delete(pause_sprite);
            }

            // Vai para o menu principal
            room_goto(rm_menu);
        }
    }

    // Para o restante do código enquanto estiver pausado
    exit;
}

if (room == rm_fase3) {
    if (tempo_fase3 > 0) {
        // Diminui o tempo baseado no tempo real (delta_time)
        tempo_fase3 -= delta_time / 1000000;
    } else {
        tempo_fase3 = 0;
        // Se o tempo acabar, o jogador morre
        if (instance_exists(obj_personagem)) {
            obj_personagem.vida = 0;
        }
    }
} else {
    // Mantém o tempo em 60 nas outras fases
    tempo_fase3 = 60;
}