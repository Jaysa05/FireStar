// ==============================
// SISTEMA DE DANO (HIT)
// ==============================

if (hit == true) {
    // Só recebe dano se estiver vulnerável (estado de descanso)
    if (estado == ESTADO_BOSS.DESCANSO) {
        alarm[1] = 5;
        vida_boss -= 1;
    }
    hit = false;
}

// ==============================
// GRAVIDADE
// ==============================

vveloc += gravidade;

// ==============================
// MÁQUINA DE ESTADOS (BOSS AI)
// ==============================

switch (estado) {

    // ==============================
    // ESTADO: PERSEGUINDO
    // ==============================
    case ESTADO_BOSS.PERSEGUINDO:
        image_blend = c_white;
        timer_perseguicao -= 1;

        if (timer_ataque > 0) timer_ataque -= 1;

        if (instance_exists(obj_personagem)) {
            var _dif_x = obj_personagem.x - x;
            var _dist_horizontal = abs(_dif_x);

            if (_dist_horizontal > 5) direct = sign(_dif_x);
            if (direct != 0) image_xscale = -direct;

            var _sprite_alvo = sprite_index;
            var _vel_anim = 1;
            var _distancia_alvo = 70;
            var _margem = 5;

            var _alvo_longe = _distancia_alvo + _margem;
            var _alvo_perto = _distancia_alvo - _margem;

            // Ajustes finos de movimento horizontal
            if (sprite_index == spr_andando && hveloc != 0 && sign(hveloc) == direct) {
                _alvo_longe = _distancia_alvo;
            }

            if (sprite_index == spr_andando && hveloc != 0 && sign(hveloc) == -direct) {
                _alvo_perto = _distancia_alvo;
            }

            // Decisão de movimento lateral
            if (_dist_horizontal > _alvo_longe) {
                hveloc = spd * direct;
                _sprite_alvo = spr_andando;
            } else if (_dist_horizontal < _alvo_perto) {
                hveloc = spd * -direct;
                _sprite_alvo = spr_andando;
            } else {
                hveloc = 0;
                _sprite_alvo = spr_parado;
            }

            var _no_chao = place_meeting(x, y + 1, obj_parede);

            // Ataques aleatórios
            if (timer_ataque <= 0 && _no_chao && _dist_horizontal <= _distancia_alvo) {
                var _ataque_escolhido = irandom(2);

                if (_ataque_escolhido == 0) {
                    estado = ESTADO_BOSS.ESPADA;
                } else if (_ataque_escolhido == 1) {
                    estado = ESTADO_BOSS.PULO;
                    pulo_fase = 0;
                } else {
                    estado = ESTADO_BOSS.FEITICO;
                    ja_deu_dano = false;
                }
                image_index = 0;
            }
        }

        if (sprite_index != _sprite_alvo) {
            sprite_index = _sprite_alvo;
            image_index = 0;
        }

        image_speed = _vel_anim;

        if (timer_perseguicao <= 0) {
            estado = ESTADO_BOSS.DESCANSO;
            timer_descanso = tempo_descanso;
            hveloc = 0;
        }
        break;

    // ==============================
    // ESTADO: DESCANSO (VULNERÁVEL)
    // ==============================
    case ESTADO_BOSS.DESCANSO:
        if (sprite_index != spr_parado) {
            sprite_index = spr_parado;
            image_index = 0;
        }

        hveloc = 0;
        timer_descanso -= 1;
        image_blend = c_aqua; // Efeito visual de vulnerabilidade
        image_speed = 0.5;

        if (timer_descanso <= 0) {
            estado = ESTADO_BOSS.PERSEGUINDO;
            timer_perseguicao = tempo_perseguindo;
            image_blend = c_white;
        }
        break;

    // ==============================
    // ESTADO: MORTE
    // ==============================
    case ESTADO_BOSS.MORTE:
        hveloc = 0;
        image_blend = c_white;

        if (sprite_index != spr_morte) {
            sprite_index = spr_morte;
            image_index = 0;
        }
        image_speed = 1;
        break;

    // ==============================
    // ATAQUE: ESPADA
    // ==============================
    case ESTADO_BOSS.ESPADA:
        hveloc = 0;

        if (sprite_index != spr_ataque) {
            sprite_index = spr_ataque;
            image_index = 0;
        }

        image_speed = 1;
        mask_index = spr_parado;

        // Dano apenas nos frames ativos do ataque
        if (image_index >= 12 && image_index <= 14) {
            var _x_espada = x + (70 * -image_xscale);
            var _alvo = collision_circle(_x_espada, y - 10, 40, obj_personagem, false, true);
            
            if (_alvo != noone) {
                with (_alvo) {
                    if (alarm[0] <= 0) {
                        vida -= 1;
                        alarm[0] = inv_tempo;
                    }
                }
            }
        }

        if (image_index >= image_number - 1) {
            timer_ataque = tempo_ataque;
            estado = ESTADO_BOSS.PERSEGUINDO;
            sprite_index = spr_parado;
            mask_index = spr_parado;
        }
        break;

    // ==============================
    // ATAQUE: PULO (ÁREA)
    // ==============================
    case ESTADO_BOSS.PULO:
        hveloc = 0;

        if (sprite_index != spr_pulo) {
            sprite_index = spr_pulo;
            image_index = 0;
            mask_index = spr_parado;
        }

        // FASE 0: PREPARAÇÃO (Carregando pulo)
        if (pulo_fase == 0) {
            image_speed = 0.8;

            if (floor(image_index) % 2 == 0) image_blend = c_red;
            else image_blend = c_white;

            if (image_index >= 5) {
                vveloc = -10;
                pulo_fase = 1;
            }
        }

        // FASE 1: NO AR
        if (pulo_fase == 1) {
            image_speed = 0.8;

            if (vveloc > 0 && place_meeting(x, y + 2, obj_parede)) {
                pulo_fase = 2;
                ja_deu_dano = false;
                image_index = 10;
            }
        }

        // FASE 2: IMPACTO (Onda de choque terrestre)
        if (pulo_fase == 2) {
            image_speed = 1;

            if (!ja_deu_dano && instance_exists(obj_personagem)) {
                var _player_no_chao = false;

                with (obj_personagem) {
                    if (place_meeting(x, y + 2, obj_parede)) 
                        _player_no_chao = true;
                }

                var _dist = point_distance(x, y, obj_personagem.x, obj_personagem.y);

                if (_player_no_chao && _dist <= 250) {
                    with (obj_personagem) {
                        if (alarm[0] <= 0) {
                            vida -= 1;
                            alarm[0] = inv_tempo;
                        }
                    }
                    ja_deu_dano = true;
                }
            }

            if (image_index >= image_number - 1) {
                timer_ataque = tempo_ataque;
                estado = ESTADO_BOSS.PERSEGUINDO;
                pulo_fase = 0;
                ja_deu_dano = false;

                image_blend = c_white;
                sprite_index = spr_parado;
                mask_index = spr_parado;
            }
        }
        break;

    // ==============================
    // ATAQUE: FEITIÇO (BOLA DE FOGO)
    // ==============================
    case ESTADO_BOSS.FEITICO:
        if (instance_exists(obj_personagem)) {
            var _dist = abs(obj_personagem.x - x);
            var _batendo_na_parede = place_meeting(x + (spd * -direct), y , obj_parede);
            
            // FASE DE RECUO (Garante espaço para o tiro)
            if (_dist < 115 && !ja_deu_dano && !_batendo_na_parede) {
                hveloc = spd * -direct;
                sprite_index = spr_andando;
                image_speed = 1;
                image_blend = c_white;
            }
            // FASE DE ATAQUE
            else {
                hveloc = 0;
                
                if (sprite_index != spr_boss_lanca_feitico) {
                    sprite_index = spr_boss_lanca_feitico;
                    image_index = 0;
                }
                
                image_speed = 0.5;
                
                // Sinalização de disparo eminente (Piscar roxo)
                if (!ja_deu_dano) {
                    if (floor(image_index) % 2 == 0)
                        image_blend = c_purple;
                    else
                        image_blend = c_white;   
                } else {
                    image_blend = c_white;
                }
                
                // Criação do projétil no frame 4
                if (floor(image_index) == 4 && !ja_deu_dano) {
                    var _x_fogo = x + (90 * -image_xscale);
                    var _y_fogo = y - 25;
                    var _fogo = instance_create_depth(_x_fogo , _y_fogo, depth - 1 , obj_bola_fogo);
                    
                    var _direcao_tiro = (image_xscale == 1) ? 180 : 0;
                    
                    _fogo.direction = _direcao_tiro;
                    _fogo.speed = 1;
                    _fogo.image_angle = _direcao_tiro;
                    
                    ja_deu_dano = true;
                }
            }
        }
        
        if (image_index >= image_number - 1 && sprite_index == spr_boss_lanca_feitico) {
            timer_ataque = tempo_ataque;
            estado = ESTADO_BOSS.PERSEGUINDO;
            image_blend = c_white;
            sprite_index = spr_parado;
            ja_deu_dano = false;
        }
        break;
}

// ==============================
// COLISÃO HORIZONTAL
// ==============================

if (place_meeting(x + hveloc, y, obj_parede)) {
    // Se estiver na fase 4, o jogador toma dano se o boss bater nas paredes laterais
    if (room == rm_fase4) {
        if (instance_exists(obj_personagem)) {
            with (obj_personagem) {
                if (alarm[0] <= 0) {
                    vida -= 1;
                    alarm[0] = inv_tempo;
                }
            }
        }
    }

    while (!place_meeting(x + sign(hveloc), y, obj_parede)) {
        x += sign(hveloc);
    }
    hveloc = 0;
}
x += hveloc;

// ==============================
// COLISÃO VERTICAL
// ==============================

if (place_meeting(x, y + vveloc, obj_parede)) {
    while (!place_meeting(x, y + sign(vveloc), obj_parede)) {
        y += sign(vveloc);
    }
    vveloc = 0;
}
y += vveloc;

// ==============================
// MORTE
// ==============================

if (vida_boss <= 0 && estado != ESTADO_BOSS.MORTE) {
    estado = ESTADO_BOSS.MORTE;
    image_index = 0;
}