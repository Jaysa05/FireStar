function scr_personagem_movendo() {
    // Inputs
    direita = keyboard_check(ord("D"));
    esquerda = keyboard_check(ord("A"));
    cima = keyboard_check_pressed(vk_space);

    // Direção e Sprite
    if (direita) {
        direct = 0;
        sprite_index = spr_personagem_andando_direita;
    } else if (esquerda) {
        direct = 1;
        sprite_index = spr_personagem_andando_esquerda;
    } else {
        if (direct == 0)
            sprite_index = spr_personagem_parado_direita;
        else if (direct == 1)
            sprite_index = spr_personagem_parado_esquerda;
    }

    // Velocidade Horizontal
    hveloc = (direita - esquerda) * veloc;

    // Controle de Plataforma Especial na Fase 4 (Boss)
    var _pode_usar_plat2 = true;

    if (room == rm_fase4) {
        _pode_usar_plat2 = false;

        if (instance_exists(obj_boss)) {
            if (obj_boss.estado == ESTADO_BOSS.ESPADA
            || obj_boss.estado == ESTADO_BOSS.PULO
            || obj_boss.estado == ESTADO_BOSS.FEITICO) {
                _pode_usar_plat2 = true;
            }
        }
    }

    // Detecção de Chão
    var _chao = place_meeting(x, y + 1, obj_parede) ||
                place_meeting(x, y + 1, obj_trampolim) ||
                (place_meeting(x, y + 1, obj_plataforma_cair) && 
                 bbox_bottom <= instance_place(x, y + 1, obj_plataforma_cair).bbox_top + 5) ||
                (_pode_usar_plat2 && place_meeting(x, y + 1, obj_plataforma2) && !place_meeting(x, y, obj_plataforma2)) ||
                (place_meeting(x, y + 1, obj_plataforma_fase2) && !place_meeting(x, y, obj_plataforma_fase2)) ||
                (place_meeting(x, y + 1, obj_plataforma) && !place_meeting(x, y, obj_plataforma));

    // Gravidade
    if (!_chao) {
        vveloc += gravidade;

        if (pulos == pulos_max) {
            pulos = pulos_max - 1;
        }
    } else {
        pulos = pulos_max;
    }

    // Pulo
    if (cima && pulos > 0) {
        vveloc = -abs(forca_pulo);
        pulos -= 1;
    }

    // Colisão Horizontal (Paredes)
    if (place_meeting(x + hveloc, y, obj_parede)) {
        while (!place_meeting(x + sign(hveloc), y, obj_parede)) {
            x += sign(hveloc);
        }
        hveloc = 0;
    }
    x += hveloc;

    // Colisão Vertical (Paredes e Trampolins)
    if (place_meeting(x, y + vveloc, obj_parede)
    || place_meeting(x, y + vveloc, obj_trampolim)) {
        while (!place_meeting(x, y + sign(vveloc), obj_parede)
        && !place_meeting(x, y + sign(vveloc), obj_trampolim)) {
            y += sign(vveloc);
        }
        vveloc = 0;
    }

    // Colisão com Plataformas
    var _plat = instance_place(x, y + vveloc, obj_plataforma_cair);

    if (_plat == noone)
        _plat = instance_place(x, y + vveloc, obj_plataforma);

    if (_plat == noone && _pode_usar_plat2)
        _plat = instance_place(x, y + vveloc, obj_plataforma2);

    if (_plat == noone)
        _plat = instance_place(x, y + vveloc, obj_plataforma_fase2);

    if (_plat != noone) {
        var _tolerancia = (_plat.object_index == obj_plataforma_cair) ? 5 : 0;
        
        if (vveloc > 0 && bbox_bottom <= _plat.bbox_top + _tolerancia) {
            while (!place_meeting(x, y + sign(vveloc), _plat)) {
                y += sign(vveloc);
            }
            vveloc = 0;
            pulos = pulos_max;
        }
    }

    y += vveloc;

    // Ataque
    if (keyboard_check_pressed(vk_enter)) {
        image_index = 0;
        estado = scr_personagem_atacando;

        if (direct == 0) {
            instance_create_layer(x + 20, y - 8, "Instances_2", obj_hitbox);
        } else if (direct == 1) {
            instance_create_layer(x - 20, y - 8, "Instances_2", obj_hitbox);
        }
    }

    // Limite Inferior da Tela (Morte por Queda)
    if (y > room_height + 64) {
        vida = 0;
        room_goto(rm_gameover);
    }

    // Dano por Espinhos
    if (place_meeting(x, y, obj_espinhos)
    || place_meeting(x, y, obj_caixa_espinhenta)) {
        if (alarm[0] <= 0) {
            vida -= 1;
            alarm[0] = inv_tempo;
            vveloc = -3;
        }
    }

    if (vida <= 0) {
        room_goto(rm_gameover);
    }
}

function scr_personagem_atacando() {
    if (direct == 0) {
        sprite_index = spr_personagem_atacando_direita;
    } else if (direct == 1) {
        sprite_index = spr_personagem_atacando_esquerda;
    }
    
    if (scr_fim_da_animacao()) {
        estado = scr_personagem_movendo;
    }
}