vveloc = vveloc + gravidade;

switch (estado) {
    
    case ESTADO_BOSS.PERSEGUINDO:
        sprite_index = spr_idle; 
        image_speed = 1;
        timer_atual -= 1;
        timer_descanso -= 1;
        
        // Movimento constante na direção atual
        hveloc = direcao * spd;
        image_xscale = -direcao; // Mantém o sprite virado para onde anda

        // Descanso periódico
        if (timer_descanso <= 0) {
            hveloc = 0;
            estado = ESTADO_BOSS.DESCANSO;
            timer_atual_descanso = duracao_descanso;
            image_index = 0;
        }

        // Checagem de Ataque (se o jogador estiver por perto)
        if (instance_exists(obj_personagem)) {
            var _dist = distance_to_object(obj_personagem);
            
            if (timer_atual <= 0) {
                if (_dist <= distancia_fogo) {
                    hveloc = 0;
                    estado = ESTADO_BOSS.FOGO;
                    sprite_index = spr_fogo;
                    image_index = 0;
                    deu_dano = false;
                } else {
                    hveloc = 0;
                    estado = ESTADO_BOSS.PULO;
                    sprite_index = spr_pulo;
                    image_index = 0;
                    vveloc = -8; 
                }
            } 
            else if (_dist <= distancia_espada) {
                hveloc = 0;
                estado = ESTADO_BOSS.ESPADA;
                sprite_index = spr_espada;
                image_index = 0;
                deu_dano = false;
            }
        }
        break;

    case ESTADO_BOSS.DESCANSO:
        hveloc = 0;
        sprite_index = spr_descanso; 
        image_speed = 1; 
        timer_atual_descanso -= 1;
        if (timer_atual_descanso <= 0) {
            estado = ESTADO_BOSS.PERSEGUINDO;
            timer_descanso = tempo_entre_descansos;
        }
        break;

    case ESTADO_BOSS.ESPADA:
        hveloc = 0;
        if (image_index >= 3 && image_index <= 4 && !deu_dano) {
            if (instance_exists(obj_personagem)) {
                if (distance_to_object(obj_personagem) <= 60) {
                    obj_personagem.vida -= 1; 
                    deu_dano = true;
                }
            }
        }
        break;

    case ESTADO_BOSS.FOGO:
        hveloc = 0;
        if (image_index >= 4 && image_index <= 6 && !deu_dano) {
            if (instance_exists(obj_personagem)) {
                if (distance_to_object(obj_personagem) <= 150) {
                    obj_personagem.vida -= 1; 
                    deu_dano = true;
                }
            }
        }
        break;

    case ESTADO_BOSS.PULO:
        if (instance_exists(obj_personagem)) {
            hveloc = sign(obj_personagem.x - x) * 2;
        }
        if (place_meeting(x, y + 1, obj_parede)) { 
            hveloc = 0;
            if (instance_exists(obj_personagem)) {
                if (place_meeting(obj_personagem.x, obj_personagem.y + 1, obj_parede)) {
                    obj_personagem.vida -= 1;
                }
            }
            timer_atual = timer_ataques;
            estado = ESTADO_BOSS.PERSEGUINDO;
        }
        break;

    case ESTADO_BOSS.MORTE:
        hveloc = 0;
        sprite_index = spr_morte;
        break;
}

// --- COLISÕES HORIZONTAL (VIRAR AO BATER NA PAREDE) ---
if (place_meeting(x + hveloc, y, obj_parede)) {
    
    direcao = -direcao; // INVERTE A DIREÇÃO PARA O LADO CONTRÁRIO
    
    while (!place_meeting(x + sign(hveloc), y, obj_parede)) { 
        x += sign(hveloc); 
    }
    hveloc = 0;
}
x += hveloc;

// --- Colisões Vertical ---
if (place_meeting(x, y + vveloc, obj_parede)) {
    while (!place_meeting(x, y + sign(vveloc), obj_parede)) { 
        y += sign(vveloc); 
    }
    vveloc = 0;
}
y += vveloc;

// --- Checagem de Morte ---
if (vida_boss <= 0 && estado != ESTADO_BOSS.MORTE) {
    estado = ESTADO_BOSS.MORTE;
    sprite_index = spr_morte;
    image_index = 0;
}
