// --- SISTEMA DE DANO (HIT) ---
if (hit == true) {
    // Ativa o efeito visual de piscar (Fog do pai)
    alarm[1] = 5; 
    
    // SÓ tira vida se estiver no descanso
    if (estado == ESTADO_BOSS.DESCANSO) {
        vida_boss -= 1;
    }
    
    // Reseta o hit DEPOIS de tirar a vida do boss
    hit = false; 
}

// NÃO USE event_inherited() aqui no Step, nós já ativamos o alarme acima!

vveloc += gravidade;

switch (estado) {
    
    case ESTADO_BOSS.PERSEGUINDO:
        image_blend = c_white;
        timer_perseguicao -= 1;

        if (instance_exists(obj_personagem)) {
            var _distancia = distance_to_object(obj_personagem);
            direct = sign(obj_personagem.x - x);
            if (direct != 0) image_xscale = -direct;

            var _sprite_alvo = sprite_index;
            var _vel_anim = 1;

            if (_distancia < 50) {
                hveloc = 0;
                _sprite_alvo = spr_parado;
                _vel_anim = 0.5;
            } else if (_distancia > 70) {
                hveloc = direct * spd;
                _sprite_alvo = spr_andando;
                _vel_anim = 1;
            }

            if (sprite_index != _sprite_alvo) {
                sprite_index = _sprite_alvo;
                image_index = 0;
            }
            image_speed = _vel_anim;
        }

        if (timer_perseguicao <= 0) {
            estado = ESTADO_BOSS.DESCANSO;
            timer_descanso = tempo_descanso;
            hveloc = 0;
        }
        break;

    case ESTADO_BOSS.DESCANSO:
        if (sprite_index != spr_parado) {
            sprite_index = spr_parado;
            image_index = 0;
        }
        
        hveloc = 0;
        timer_descanso -= 1;
        
        image_blend = c_aqua; 
        image_speed = 0.5;
        
        if (timer_descanso <= 0) {
            estado = ESTADO_BOSS.PERSEGUINDO;
            timer_perseguicao = tempo_perseguindo;
            image_blend = c_white;
        }
        break;

    case ESTADO_BOSS.MORTE:
        hveloc = 0;
        image_blend = c_white;
        if (sprite_index != spr_morte) {
            sprite_index = spr_morte;
            image_index = 0;
        }
        image_speed = 1;
        break;
}

// --- COLISÕES ---
if (place_meeting(x + hveloc, y, obj_parede)) {
    while (!place_meeting(x + sign(hveloc), y, obj_parede)) { x += sign(hveloc); }
    hveloc = 0;
}
x += hveloc;

if (place_meeting(x, y + vveloc, obj_parede)) {
    while (!place_meeting(x, y + sign(vveloc), obj_parede)) { y += sign(vveloc); }
    vveloc = 0;
}
y += vveloc;

// --- CHECAGEM DE MORTE REAL ---
if (vida_boss <= 0 && estado != ESTADO_BOSS.MORTE) {
    estado = ESTADO_BOSS.MORTE;
    image_index = 0;
}
