/// @description Comportamento do Minotauro
event_inherited();

// Se o minotauro morreu, não executa o resto do código (o Step do pai cuida da morte)
if (vida <= 0) {
    exit;
}

// =========================================================================
// SISTEMA ANTI-TRAVAMENTO / DESENGATE (Prepara contra travamentos de spawn/subpixel/coluna)
// =========================================================================
var _chao_atual = place_meeting(x, y, obj_parede) || 
                  place_meeting(x, y, obj_plataforma_fase2) || 
                  place_meeting(x, y, obj_plataforma) || 
                  place_meeting(x, y, obj_plataforma2);

if (_chao_atual) {
    for (var i = 1; i <= 32; i++) {
        if (!place_meeting(x, y - i, obj_parede) && 
            !place_meeting(x, y - i, obj_plataforma_fase2) && 
            !place_meeting(x, y - i, obj_plataforma) && 
            !place_meeting(x, y - i, obj_plataforma2)) {
            y -= i;
            break;
        }
    }
}

// 1. Física e Gravidade
vveloc += gravidade;

// 2. Máquina de Estados (Inteligência Artificial)
if (instance_exists(obj_personagem)) {
    // CORREÇÃO: Calcula a distância e a direção usando o centro horizontal do minotauro
    // em vez do canto superior esquerdo (x). Isso impede que ele se afaste incorretamente.
    var _minotauro_centro = (bbox_left + bbox_right) / 2;
    var _dif_x = obj_personagem.x - _minotauro_centro;
    var _dist_h = abs(_dif_x);
    
    // Atualiza cooldown de investida
    if (cooldown_investida > 0) {
        cooldown_investida -= 1;
    }
    
    // Estados do minotauro
    switch (estado) {
        // ==========================================
        // ESTADO: PERSEGUIÇÃO (VULNERÁVEL)
        // ==========================================
        case "chase":
            vulneravel = true;
            image_xscale = 1; // Garante que a colisão permaneça estável
            image_blend = c_white; // Garante que a cor normal seja restaurada
            
            if (_dist_h > 60) {
                direct = sign(_dif_x);
                hveloc = direct * veloc_chase;
                
                // Define sprites correspondentes
                if (direct == 1) {
                    sprite_index = sprite_andando_dir;
                } else {
                    sprite_index = sprite_andando_esq;
                }
            } else {
                hveloc = 0;
                sprite_index = sprite_idle;
            }
            
            // Inicia a preparação da investida se estiver próximo e fora do cooldown
            if (cooldown_investida <= 0 && _dist_h <= 200 && _dist_h > 40) {
                estado = "prepara_investida";
                timer_estado = 50; // 50 frames (pouco menos de 1 segundo) para o jogador reagir e fugir!
                hveloc = 0;
                image_blend = c_red; // Pisca em vermelho para alertar o jogador!
            }
            break;
            
        // ==========================================
        // ESTADO: PREPARAÇÃO DA INVESTIDA (VULNERÁVEL)
        // ==========================================
        case "prepara_investida":
            vulneravel = true; // Permite que o jogador cause dano enquanto ele se prepara!
            image_xscale = 1;
            timer_estado -= 1;
            hveloc = 0;
            
            // Encarar o jogador durante a preparação
            direct = sign(_dif_x);
            if (direct == 0) direct = 1;
            
            sprite_index = sprite_idle;
            
            // Se o tempo de preparação acabou, inicia a investida de fato!
            if (timer_estado <= 0) {
                estado = "investida";
                timer_estado = 60; // 1 segundo de ataque no mesmo lugar!
                vulneravel = false; // Invulnerável durante o ataque
                image_blend = c_white; // Volta para a cor normal
                
                // Avança o ciclo para os próximos tipos de investida/ataques no futuro
                if (proximo_ataque == 0) proximo_ataque = 1;
                else if (proximo_ataque == 1) proximo_ataque = 2;
                else if (proximo_ataque == 2) proximo_ataque = 0;
            }
            break;
            
        // ==========================================
        // ESTADO: INVESTIDA CORTANTE (INVULNERÁVEL)
        // ==========================================
        case "investida":
            vulneravel = false;
            image_xscale = 1; // Garante que a colisão permaneça estável (não teletransporta)
            timer_estado -= 1;
            image_blend = c_white; // Garante a cor branca
            
            // Fica parado atacando (sem movimento horizontal!)
            hveloc = 0;
            
            // Sprite de investida
            sprite_index = sprite_investida;
            
            // Se o tempo do ataque acabar, entra em cansaço
            if (timer_estado <= 0) {
                estado = "exhausted";
                timer_estado = 120; // 2 segundos = 120 frames de cansaço
                hveloc = 0;
            }
            break;
            
        // ==========================================
        // ESTADO: ATAQUE 2 (FUTURO / PLACEHOLDER)
        // ==========================================
        case "ataque_2":
            hveloc = 0;
            image_xscale = 1;
            break;
            
        // ==========================================
        // ESTADO: ATAQUE 3 (FUTURO / PLACEHOLDER)
        // ==========================================
        case "ataque_3":
            hveloc = 0;
            image_xscale = 1;
            break;
            
        // ==========================================
        // ESTADO: EXHAUSTED / CANSAÇO (VULNERÁVEL)
        // ==========================================
        case "exhausted":
            vulneravel = true;
            image_xscale = 1;
            timer_estado -= 1;
            hveloc = 0;
            image_blend = c_lime; // Pintado de verde/lima para mostrar que está vulnerável a ataques!
            
            // Fica parado no sprite normal/idle
            sprite_index = sprite_idle;
            
            // Após 2 segundos parado, volta a perseguir com um tempo de recarga
            if (timer_estado <= 0) {
                estado = "chase";
                cooldown_investida = 180; // 3 segundos de cooldown antes do próximo ataque
                image_blend = c_white; // Retorna à cor branca normal
            }
            break;
    }
} else {
    // Se o personagem não existir, o minotauro fica parado
    hveloc = 0;
    sprite_index = sprite_idle;
    image_xscale = 1;
}

// ====================================================
// DETECÇÃO DE COLISÕES
// ====================================================

// Colisão Horizontal com paredes sólidas ou cercas inimigas
var _colidiu_h = place_meeting(x + hveloc, y, obj_parede) || place_meeting(x + hveloc, y, obj_parede_inimigo);
if (_colidiu_h) {
    var _obj_colisao = place_meeting(x + hveloc, y, obj_parede) ? obj_parede : obj_parede_inimigo;
    while (!place_meeting(x + sign(hveloc), y, _obj_colisao)) {
        x += sign(hveloc);
    }
    hveloc = 0;
}
x += hveloc;

// Colisão Vertical com paredes sólidas
if (place_meeting(x, y + vveloc, obj_parede)) {
    while (!place_meeting(x, y + sign(vveloc), obj_parede)) {
        y += sign(vveloc); // CORREÇÃO: Substituído vfancy por vveloc para evitar travamentos
    }
    vveloc = 0;
}

// Colisão Vertical Unidirecional com Plataformas
var _plat = instance_place(x, y + vveloc, obj_plataforma_fase2);
if (_plat == noone) _plat = instance_place(x, y + vveloc, obj_plataforma);
if (_plat == noone) _plat = instance_place(x, y + vveloc, obj_plataforma2);

if (_plat != noone) {
    if (vveloc > 0 && bbox_bottom <= _plat.bbox_top + 4) {
        while (!place_meeting(x, y + sign(vveloc), _plat)) {
            y += sign(vveloc);
        }
        vveloc = 0;
    }
}
y += vveloc;
