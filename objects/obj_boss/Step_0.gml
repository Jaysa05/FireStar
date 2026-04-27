// ==============================
// SISTEMA DE DANO (HIT)
// ==============================

// Se o boss foi atingido
if (hit == true) {

    // Só recebe dano se estiver no estado de descanso (vulnerável)
    if (estado == ESTADO_BOSS.DESCANSO) {
        
        // Ativa efeito visual de "piscar"
        alarm[1] = 5;
        
        // Diminui a vida do boss
        vida_boss -= 1;
    }

    // Reseta o hit para não tomar dano várias vezes no mesmo frame
    hit = false;
}

// NÃO usamos event_inherited() porque o dano já está sendo controlado manualmente


// ==============================
// GRAVIDADE
// ==============================

// Aplica gravidade (faz o boss cair)
vveloc += gravidade;


// ==============================
// MÁQUINA DE ESTADOS
// ==============================

switch (estado) {

    // ------------------------------
    // ESTADO: PERSEGUINDO
    // ------------------------------
    case ESTADO_BOSS.PERSEGUINDO:

        // Cor normal
        image_blend = c_white;

        // Diminui tempo de perseguição
        timer_perseguicao -= 1;

        // Diminui cooldown do ataque
        if (timer_ataque > 0) timer_ataque -= 1;

        // Se o jogador existe
        if (instance_exists(obj_personagem)) {

            // Diferença de posição horizontal
            var _dif_x = obj_personagem.x - x;

            // Distância horizontal (sempre positiva)
            var _dist_horizontal = abs(_dif_x);

            // Atualiza direção (evita tremedeira quando muito perto)
            if (_dist_horizontal > 5) direct = sign(_dif_x);

            // Faz o boss olhar para o jogador
            if (direct != 0) image_xscale = -direct;

            // Sprite atual
            var _sprite_alvo = sprite_index;

            // Velocidade da animação
            var _vel_anim = 1;

            // Distância ideal que o boss quer manter
            var _distancia_alvo = 70;

            // ------------------------------
            // LONGE DEMAIS → SE APROXIMA
            // ------------------------------
            if (_dist_horizontal > _distancia_alvo) {

                // Quanto precisa andar
                var _pode_andar = _dist_horizontal - _distancia_alvo;

                // Anda sem ultrapassar o limite
                hveloc = min(spd, _pode_andar) * direct;

                // Usa animação de andar
                _sprite_alvo = spr_andando;
            }

            // ------------------------------
            // PERTO DEMAIS → RECUA
            // ------------------------------
            else if (_dist_horizontal < _distancia_alvo) {

                // Quanto precisa recuar
                var _pode_recuar = _distancia_alvo - _dist_horizontal;

                // Anda para trás
                hveloc = min(spd, _pode_recuar) * -direct;

                // Continua andando
                _sprite_alvo = spr_andando;
            }

            // ------------------------------
            // DISTÂNCIA PERFEITA
            // ------------------------------
            else {

                // Para de andar
                hveloc = 0;

                // Sprite parado
                _sprite_alvo = spr_parado;
            }

            // Verifica se está no chão
            var _no_chao = place_meeting(x, y + 1, obj_parede);

            // Se pode atacar
            if (timer_ataque <= 0 && _no_chao) {
                estado = ESTADO_BOSS.ESPADA;
                image_index = 0;
            }
        }

        // Aplica sprite escolhido
        if (sprite_index != _sprite_alvo) {
            sprite_index = _sprite_alvo;
            image_index = 0;
        }

        // Aplica velocidade da animação
        image_speed = _vel_anim;

        // Se tempo acabar → descanso
        if (timer_perseguicao <= 0) {
            estado = ESTADO_BOSS.DESCANSO;
            timer_descanso = tempo_descanso;
            hveloc = 0;
        }

        break;


    // ------------------------------
    // ESTADO: DESCANSO
    // ------------------------------
    case ESTADO_BOSS.DESCANSO:

        // Garante sprite parado
        if (sprite_index != spr_parado) {
            sprite_index = spr_parado;
            image_index = 0;
        }

        // Não se move
        hveloc = 0;

        // Conta tempo de descanso
        timer_descanso -= 1;

        // Fica azul (indica vulnerável)
        image_blend = c_aqua;

        // Animação lenta
        image_speed = 0.5;

        // Volta a perseguir quando terminar
        if (timer_descanso <= 0) {
            estado = ESTADO_BOSS.PERSEGUINDO;
            timer_perseguicao = tempo_perseguindo;
            image_blend = c_white;
        }

        break;


    // ------------------------------
    // ESTADO: MORTE
    // ------------------------------
    case ESTADO_BOSS.MORTE:

        // Para completamente
        hveloc = 0;

        image_blend = c_white;

        // Troca para sprite de morte
        if (sprite_index != spr_morte) {
            sprite_index = spr_morte;
            image_index = 0;
        }

        // Animação normal
        image_speed = 1;

        break;


    // ------------------------------
    // ESTADO: ATAQUE (ESPADA)
    // ------------------------------
    case ESTADO_BOSS.ESPADA:

        // Para de andar
        hveloc = 0;

        // Define sprite de ataque
        if (sprite_index != spr_ataque) {
            sprite_index = spr_ataque;
            image_index = 0;
        }

        image_speed = 1;

        // Usa colisão do sprite parado
        mask_index = spr_parado;

        // Dano só em frames específicos
        if (image_index >= 11 && image_index <= 14) {

            // Posição da espada
            var _x_espada = x + (70 * -image_xscale);

            // Área de dano
            var _alvo = collision_circle(_x_espada, y - 10, 40, obj_personagem, false, true);

            if (_alvo != noone) {

                with (_alvo) {

                    // Só toma dano se não estiver invencível
                    if (alarm[0] <= 0) {
                        vida -= 1;
                        alarm[0] = inv_tempo;
                    }
                }
            }
        }

        // Quando animação termina
        if (image_index >= image_number - 1) {

            timer_ataque = tempo_ataque;

            estado = ESTADO_BOSS.PERSEGUINDO;

            sprite_index = spr_parado;
            mask_index = spr_parado;
        }

        break;
}


// ==============================
// COLISÃO HORIZONTAL
// ==============================

// Se vai bater na parede
if (place_meeting(x + hveloc, y, obj_parede)) {

    // Anda pixel por pixel até encostar
    while (!place_meeting(x + sign(hveloc), y, obj_parede)) {
        x += sign(hveloc);
    }

    // Para movimento
    hveloc = 0;
}

// Aplica movimento
x += hveloc;


// ==============================
// COLISÃO VERTICAL
// ==============================

// Se vai bater verticalmente
if (place_meeting(x, y + vveloc, obj_parede)) {

    // Ajusta posição até encostar
    while (!place_meeting(x, y + sign(vveloc), obj_parede)) {
        y += sign(vveloc);
    }

    // Para queda/subida
    vveloc = 0;
}

// Aplica movimento vertical
y += vveloc;


// ==============================
// CHECAGEM DE MORTE
// ==============================

// Se vida acabou e ainda não morreu
if (vida_boss <= 0 && estado != ESTADO_BOSS.MORTE) {

    // Entra no estado de morte
    estado = ESTADO_BOSS.MORTE;

    // Reinicia animação
    image_index = 0;
}