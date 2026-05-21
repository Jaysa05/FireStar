// Se for necessário pausar o jogo
if (pausar_proximo_frame) {

    // Remove a imagem antiga da pausa
    if (sprite_exists(pause_sprite)) {
        sprite_delete(pause_sprite);
    }

    // Tira uma "foto" da tela atual para congelar o jogo visualmente
    if (surface_exists(application_surface)) {
        pause_sprite = sprite_create_from_surface(
            application_surface,
            0, 0,
            surface_get_width(application_surface),
            surface_get_height(application_surface),
            false, false, 0, 0
        );
    }

    // Salva vida, frutas, facas e posição do jogador
    if (instance_exists(obj_personagem)) {
        vida_pause = obj_personagem.vida;
        frutas_pause = obj_personagem.frutas;
        faca_pause = obj_personagem.faca;
        faca_cargas_pause = obj_personagem.faca_cargas;
        player_x_pause = obj_personagem.x;
        player_y_pause = obj_personagem.y;
    }

    // Congela todos os objetos do jogo
    instance_deactivate_all(true);

    pausado = true;
    pausar_proximo_frame = false;
}


// Desenha a tela congelada da pausa
if (pausado) {

    if (sprite_exists(pause_sprite)) {
        draw_sprite_stretched(
            pause_sprite,
            0,
            0,
            0,
            display_get_gui_width(),
            display_get_gui_height()
        );
    }

    // Escurece a tela
    draw_set_color(c_black);
    draw_set_alpha(0.6);

    draw_rectangle(
        0,
        0,
        display_get_gui_width(),
        display_get_gui_height(),
        false
    );

    draw_set_alpha(1);
}


// Define se a HUD deve aparecer
var _desenhar_hud = false;

if (pausado) {

    _desenhar_hud = true;

} else {

    // Só desenha HUD se o jogador existir
    // e a tela de vitória não estiver ativa
    if (instance_exists(obj_personagem)) {

        if (!instance_exists(obj_vitoria)) {
            _desenhar_hud = true;
        }
    }
}


// Desenha HUD
if (_desenhar_hud) {

    var _sprl = sprite_get_width(spr_vida) * 2;
    var _buffer = 20;

    var _vidas = 0;

    // Usa a vida salva se estiver pausado
    if (pausado) {
        _vidas = vida_pause;
    } else {
        _vidas = obj_personagem.vida;
    }

    // Desenha os corações/vidas
    for (var i = 0; i < _vidas; i++) {

        draw_sprite_ext(
            spr_vida,
            0,
            20 + (_sprl * i) + (_buffer * i),
            20,
            2,
            2,
            0,
            c_white,
            1
        );
    }

    // Calcula posição da fruta
    var _x_fruta = 20 + (_sprl + _buffer) * _vidas + 30;

    var _centro_guia = 20 + sprite_get_height(spr_vida);

    // Desenha fruta e quantidade
    if (sprite_exists(spr_fruta)) {

        var _escala_fruta = 3;

        var _y_fruta_alinhada =
            _centro_guia
            - ((sprite_get_height(spr_fruta) * _escala_fruta) / 2)
            - 4;

        draw_sprite_ext(
            spr_fruta,
            0,
            _x_fruta,
            _y_fruta_alinhada,
            _escala_fruta,
            _escala_fruta,
            0,
            c_white,
            1
        );

        draw_set_font(fnt_menu);

        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);

        var _txt_frutas = "0";

        // Escolhe valor das frutas
        if (pausado) {
            _txt_frutas = string(frutas_pause);
        } else {
            _txt_frutas = string(obj_personagem.frutas);
        }

        // Desenha texto da quantidade de frutas
        draw_text_transformed(
            _x_fruta + (sprite_get_width(spr_fruta) * _escala_fruta) + 10,
            _centro_guia + 7,
            "x" + _txt_frutas,
            0.7,
            0.7,
            0
        );

        draw_set_valign(fa_top);
        draw_set_font(-1);
    }

    // Sistema de tempo da fase 3
    if (room == rm_fase3) {

        var _tempo_arredondado = ceil(tempo_fase3);

        var _meio_tela = display_get_gui_width() / 2;

        var _texto_palavra = "Tempo: ";
        var _texto_numero = string(_tempo_arredondado);

        // Calcula largura do texto para centralizar
        var _largura_palavra = string_width(_texto_palavra) * 2;
        var _largura_numero = string_width(_texto_numero) * 2;

        var _largura_total =
            _largura_palavra + _largura_numero;

        var _x_inicial =
            _meio_tela - (_largura_total);

        draw_set_halign(fa_left);

        draw_set_color(c_white);

        draw_text_transformed(
            _x_inicial,
            30,
            _texto_palavra,
            2,
            2,
            0
        );

        // Tempo fica vermelho quando estiver acabando
        if (_tempo_arredondado <= 10) {
            draw_set_color(c_red);
        } else {
            draw_set_color(c_white);
        }

        draw_text_transformed(
            _x_inicial + _largura_palavra,
            30,
            _texto_numero,
            2,
            2,
            0
        );

        draw_set_color(c_white);
    }
}


// Desenha o menu de pausa
if (pausado) {

    draw_set_font(fnt_menu);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    var _meio_x = display_get_gui_width() / 2;
    var _meio_y = display_get_gui_height() / 2;

    // Título do menu
    draw_set_color(c_white);

    draw_text_transformed(
        _meio_x,
        _meio_y - 100,
        "PAUSADO",
        2,
        2,
        0
    );

    // Desenha as opções do menu
    for (var i = 0; i < array_length(opcoes_pause); i++) {

        var _y_opcao = _meio_y + (i * 50);

        // Opção selecionada fica amarela
        if (i == opcao_selecionada) {
            draw_set_color(c_yellow);
        } else {
            draw_set_color(c_white);
        }

        draw_text(
            _meio_x,
            _y_opcao,
            opcoes_pause[i]
        );
    }

    // Exibe a mensagem de jogo salvo se o timer estiver ativo
    if (salvo_mensagem_timer > 0) {
        draw_set_color(c_lime);
        draw_text(
            _meio_x,
            _meio_y + (array_length(opcoes_pause) * 50) + 30,
            "JOGO SALVO COM SUCESSO!"
        );
    }

    // Volta configurações padrões
    draw_set_color(c_white);

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    draw_set_font(-1);
}