function scr_personagem_movendo() { // Início da Função de Movimento
    
    // =========================================================================
    // SISTEMA ANTI-TRAVAMENTO / DESENGATE (Prepara contra travamentos de spawn/subpixel)
    // =========================================================================
    if (place_meeting(x, y, obj_parede) || place_meeting(x, y, obj_trampolim)) {
        var _subiu = false;
        // Tenta empurrar o personagem para cima até 16 pixels para descolar
        for (var i = 1; i <= 16; i++) {
            if (!place_meeting(x, y - i, obj_parede) && !place_meeting(x, y - i, obj_trampolim)) {
                y -= i;
                _subiu = true;
                break;
            }
        }
        // Se subir não funcionou, tenta empurrar para as laterais
        if (!_subiu) {
            for (var i = 1; i <= 16; i++) {
                if (!place_meeting(x - i, y, obj_parede) && !place_meeting(x - i, y, obj_trampolim)) {
                    x -= i;
                    break;
                }
                if (!place_meeting(x + i, y, obj_parede) && !place_meeting(x + i, y, obj_trampolim)) {
                    x += i;
                    break;
                }
            }
        }
    }

    // -----------------------------
    // INPUT (BOTÕES DO TECLADO)
    // -----------------------------
    var _apertou_baixo = keyboard_check(ord("S")) || keyboard_check(vk_down);
    direita = keyboard_check(ord("D"));
    esquerda = keyboard_check(ord("A"));
    cima = keyboard_check_pressed(vk_space) && !_apertou_baixo;

    // -----------------------------
    // DIREÇÃO E SPRITE (VISUAL)
    // -----------------------------
    if (direita) { 
        direct = 0; // 0 = Direita
        sprite_index = spr_personagem_andando_direita;
    } else if (esquerda) { 
        direct = 1; // 1 = Esquerda
        sprite_index = spr_personagem_andando_esquerda;
    } else { 
        // Se estiver parado, mantém o lado que estava olhando
        if (direct == 0) sprite_index = spr_personagem_parado_direita;
        else if (direct == 1) sprite_index = spr_personagem_parado_esquerda;
    }

    // -----------------------------
    // VELOCIDADE HORIZONTAL
    // -----------------------------
    hveloc = (direita - esquerda) * veloc;

    // -----------------------------
    // CONTROLE DA PLATAFORMA DO BOSS
    // -----------------------------
    var _pode_usar_plat2 = true;

    if (room == rm_fase4) { 
        _pode_usar_plat2 = false; 

        if (instance_exists(obj_boss)) { 
            // Só libera a plataforma em estados específicos do boss
            if (obj_boss.estado == ESTADO_BOSS.ESPADA || obj_boss.estado == ESTADO_BOSS.PULO || obj_boss.estado == ESTADO_BOSS.FEITICO) {
                _pode_usar_plat2 = true; 
            }
        }
    }

    // -----------------------------
    // DETECÇÃO DE CHÃO (Física)
    // -----------------------------
    var _chao = 
        place_meeting(x, y + 1, obj_parede) || 
        place_meeting(x, y + 1, obj_trampolim) ||
        (place_meeting(x, y + 1, obj_plataforma_cair) && bbox_bottom <= instance_place(x, y + 1, obj_plataforma_cair).bbox_top + 5) ||
        (_pode_usar_plat2 && place_meeting(x, y + 1, obj_plataforma2) && !place_meeting(x, y, obj_plataforma2)) ||
        (place_meeting(x, y + 1, obj_plataforma_fase2) && !place_meeting(x, y, obj_plataforma_fase2)) ||
        (place_meeting(x, y + 1, obj_plataforma) && !place_meeting(x, y, obj_plataforma));

    // -----------------------------
    // DESCER DA PLATAFORMA (Down + Jump)
    // -----------------------------
    if (_chao && _apertou_baixo && keyboard_check_pressed(vk_space)) {
        var _plat_sob_pes = instance_place(x, y + 1, obj_plataforma_cair);
        if (_plat_sob_pes == noone) _plat_sob_pes = instance_place(x, y + 1, obj_plataforma);
        if (_plat_sob_pes == noone && _pode_usar_plat2) _plat_sob_pes = instance_place(x, y + 1, obj_plataforma2);
        if (_plat_sob_pes == noone) _plat_sob_pes = instance_place(x, y + 1, obj_plataforma_fase2);
        
        if (_plat_sob_pes != noone) {
            y += 8; // Move o jogador para baixo da plataforma para ignorar a colisão
            vveloc = 1;
            _chao = false;
        }
    }

    // -----------------------------
    // GRAVIDADE
    // -----------------------------
    if (!_chao) { // Se não está no chão (está caindo ou pulando)
        vveloc += gravidade; 
        if (pulos == pulos_max) pulos = pulos_max - 1; // Tira 1 pulo para evitar pulo duplo no ar
    } else {
        pulos = pulos_max; // Se pisou no chão, recarrega os pulos
    }

    // -----------------------------
    // MECÂNICA DE ESCALAR PAREDE (Fase 5)
    // -----------------------------
    if (room == rm_fase5 && !_chao) {
        var _parede_dir = place_meeting(x + 1, y, obj_parede);
        var _parede_esq = place_meeting(x - 1, y, obj_parede);
         
        if (_parede_dir || _parede_esq) { // Se encostou em alguma parede
            if (vveloc > 0.5) vveloc = 0.5; // Escorrega devagarzinho
              
            var _subir = keyboard_check(ord("W")) || keyboard_check(vk_up) || keyboard_check(vk_space);
            if (_subir) vveloc = -1.5; // Faz escalar
                
            pulos = pulos_max; // Permite pular para fora da parede
                
            if (_parede_dir) {
                direct = 1;
                sprite_index = spr_personagem_parado_esquerda;
            } else if (_parede_esq) {
                direct = 0;
                sprite_index = spr_personagem_parado_direita;
            }
        }
    }

    // -----------------------------
    // SISTEMA DE PULO
    // -----------------------------
    if (cima && pulos > 0) { 
        vveloc = -abs(forca_pulo); 
        pulos -= 1; 
    }

    // -----------------------------
    // COLISÃO HORIZONTAL (Paredes)
    // -----------------------------
    if (place_meeting(x + hveloc, y, obj_parede)) { 
        while (!place_meeting(x + sign(hveloc), y, obj_parede)) {
            x += sign(hveloc); 
        }
        hveloc = 0; 
    }
    x += hveloc; // Aplica o movimento depois de checar

    // -----------------------------
    // COLISÃO VERTICAL (Teto/Chão sólido)
    // -----------------------------
    if (place_meeting(x, y + vveloc, obj_parede) || place_meeting(x, y + vveloc, obj_trampolim)) {
        while (!place_meeting(x, y + sign(vveloc), obj_parede) && !place_meeting(x, y + sign(vveloc), obj_trampolim)) {
            y += sign(vveloc); 
        }
        vveloc = 0; 
    }

    // -----------------------------
    // COLISÃO COM PLATAFORMAS (Que dá para pular por baixo)
    // -----------------------------
    var _plat = instance_place(x, y + vveloc, obj_plataforma_cair); 
    if (_plat == noone) _plat = instance_place(x, y + vveloc, obj_plataforma);
    if (_plat == noone && _pode_usar_plat2) _plat = instance_place(x, y + vveloc, obj_plataforma2);
    if (_plat == noone) _plat = instance_place(x, y + vveloc, obj_plataforma_fase2);

    if (_plat != noone) { // Se tocou em alguma plataforma
        var _tolerancia = (_plat.object_index == obj_plataforma_cair) ? 5 : 0;
        
        if (vveloc > 0 && bbox_bottom <= _plat.bbox_top + _tolerancia) { // Se está caindo em cima dela
            while (!place_meeting(x, y + sign(vveloc), _plat)) {
                y += sign(vveloc);
            }
            vveloc = 0; 
            pulos = pulos_max; 
        }
    }

    y += vveloc; // Aplica o movimento vertical

    // -----------------------------
    // SISTEMA DE ATAQUE (ESPADA)
    // -----------------------------
    if (keyboard_check_pressed(vk_enter)) {
        atacando = true;
        alarm[1] = 20; // Tempo do ataque
        
        image_index = 0; // Reinicia a animação
        estado = scr_personagem_atacando; // Muda o cérebro do personagem para o "Modo Ataque"
        
        // Cria a caixa de colisão do ataque na frente do personagem
        var _hit = noone;
        if (direct == 0) {
            _hit = instance_create_depth(x + 20, y - 8, depth, obj_hitbox); // Direita
        } else if (direct == 1) {
            _hit = instance_create_depth(x - 20, y - 8, depth, obj_hitbox); // Esquerda
        }
        
        // ==========================================
        // SISTEMA DE COLISÃO MANUAL À PROVA DE FALHAS
        // ==========================================
        with (_hit) { // Entra dentro da hitbox
            // Procura qualquer inimigo que esteja encostando nela AGORA
            var _inimigo = instance_place(x, y, obj_parente_inimigo);
            
            if (_inimigo != noone) { // Se achou um inimigo
                with (_inimigo) { // Entra dentro do inimigo
                    if (alarm[1] <= 0 && (!variable_instance_exists(id, "vulneravel") || vulneravel == true)) { // Se não estiver invulnerável e for vulnerável
                        vida -= 1; // Tira vida
                        hit = true; // Pisca e congela
                        alarm[1] = 20; // Força o timer do flash branco (fog) diretamente!
                    }
                }
            }
        }
    }

    // -----------------------------
    // MORTE AO CAIR DA FASE
    // -----------------------------
    if (y > room_height + 64) {
        vida = 0;
        room_goto(rm_gameover);
    }

    // -----------------------------
    // TOMAR DANO EM ARMADILHAS
    // -----------------------------
    if (place_meeting(x, y, obj_espinhos) || place_meeting(x, y, obj_caixa_espinhenta)) {
        if (alarm[0] <= 0) { // Se não estiver invulnerável
            vida -= 1;
            alarm[0] = inv_tempo; // Tempo de invulnerabilidade
            vveloc = -3; // Dá um pulinho para trás
        }
    }

    if (vida <= 0) { // Morre se a vida zerar
        room_goto(rm_gameover);
    }

} // <--- ESTA É A CHAVE QUE ESTAVA PERDIDA NO MEIO DO CÓDIGO! ELA FECHA O MOVIMENTO.

// =========================================================================

function scr_personagem_atacando() { // Início da Função de Ataque

    // Define para qual lado a animação vai tocar
    if (direct == 0) {
        sprite_index = spr_personagem_atacando_direita;
    } else if (direct == 1) {
        sprite_index = spr_personagem_atacando_esquerda;
    }
    
    // Quando a animação de bater acaba, ele volta a se mover
    if (scr_fim_da_animacao()) {
        estado = scr_personagem_movendo;
    }

} // Fim da Função de Ataque
