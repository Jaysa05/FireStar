// ==============================
// SISTEMA DE DANO (HIT)
// ==============================

// Se o boss foi atingido (algum ataque marcou "hit = true")
if (hit == true) {

    // Só recebe dano se estiver no estado de descanso (único momento vulnerável)
    if (estado == ESTADO_BOSS.DESCANSO) {
        
        alarm[1] = 5;
        // Ativa um efeito visual (ex: piscar por alguns frames)

        vida_boss -= 1;
        // Diminui a vida do boss em 1
    }

    hit = false;
    // Reseta o hit para evitar dano repetido no mesmo frame
}

// NÃO usamos event_inherited()
// porque todo o sistema de dano está sendo controlado aqui manualmente


// ==============================
// GRAVIDADE
// ==============================

vveloc += gravidade;
// Aplica gravidade → aumenta velocidade vertical para baixo


// ==============================
// MÁQUINA DE ESTADOS (CÉREBRO DO BOSS)
// ==============================

switch (estado) {

    // ==============================
    // ESTADO: PERSEGUINDO
    // ==============================
    case ESTADO_BOSS.PERSEGUINDO:

        image_blend = c_white;
        // Cor normal

        timer_perseguicao -= 1;
        // Tempo de perseguição vai diminuindo

        if (timer_ataque > 0) timer_ataque -= 1;
        // Diminui o tempo de recarga do ataque

        // Só faz lógica se o jogador existir
        if (instance_exists(obj_personagem)) {

            var _dif_x = obj_personagem.x - x;
            // Diferença horizontal entre boss e jogador

            var _dist_horizontal = abs(_dif_x);
            // Distância horizontal (sempre positiva)

            if (_dist_horizontal > 5) direct = sign(_dif_x);
            // Define direção (evita tremedeira quando está muito perto)

            if (direct != 0) image_xscale = -direct;
            // Faz o boss virar para olhar o jogador

            var _sprite_alvo = sprite_index;
            // Guarda qual sprite deveria usar

            var _vel_anim = 1;
            // Velocidade padrão da animação

            var _distancia_alvo = 70;
            // Distância ideal do jogador

            var _margem = 5;
            // Margem para evitar tremedeira

            var _alvo_longe = _distancia_alvo + _margem;
            var _alvo_perto = _distancia_alvo - _margem;

            // Ajustes finos para deixar o movimento suave
            if (sprite_index == spr_andando && hveloc != 0 && sign(hveloc) == direct){
                _alvo_longe = _distancia_alvo;
            }

            if (sprite_index == spr_andando && hveloc != 0 && sign(hveloc) == -direct){
                _alvo_perto = _distancia_alvo;
            }

            // LONGE → SE APROXIMA
            if (_dist_horizontal > _alvo_longe){
                hveloc = spd * direct;
                _sprite_alvo = spr_andando;
            }

            // PERTO → RECUA
            else if (_dist_horizontal < _alvo_perto){
                hveloc = spd * -direct;
                _sprite_alvo = spr_andando;
            }

            // DISTÂNCIA IDEAL → PARA
            else {
                hveloc = 0;
                _sprite_alvo = spr_parado;
            }

            var _no_chao = place_meeting(x, y + 1, obj_parede);
            // Verifica se está no chão

            // Se pode atacar
            if (timer_ataque <= 0 && _no_chao && _dist_horizontal <= _distancia_alvo) {

                var _ataque_escolhido = irandom(2);
                // Escolhe ataque aleatório

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
                // Reinicia animação
            }
        }

        // Aplica o sprite escolhido
        if (sprite_index != _sprite_alvo) {
            sprite_index = _sprite_alvo;
            image_index = 0;
        }

        image_speed = _vel_anim;

        // Se tempo acabar → entra em descanso
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
        // Não se move

        timer_descanso -= 1;
        // Conta o tempo de descanso

        image_blend = c_aqua;
        // Azul → indica vulnerabilidade

        image_speed = 0.5;
        // Animação mais lenta

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
        // Para completamente

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
        // Para de andar

        if (sprite_index != spr_ataque) {
            sprite_index = spr_ataque;
            image_index = 0;
        }

        image_speed = 1;

        mask_index = spr_parado;
        // Colisão menor

        // Dano só em frames específicos
        if (image_index >= 12 && image_index <= 14) {

            var _x_espada = x + (70 * -image_xscale);
            // Posição da espada

            var _alvo = collision_circle(_x_espada, y - 10, 40, obj_personagem, false, true);
            // Área circular de dano
            
            if (_alvo != noone) {

                with (_alvo) {
                    if (alarm[0] <= 0) {
                        vida -= 1;
                        alarm[0] = inv_tempo;
                    }
                }
            }
        }

        // Final do ataque
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
        // Para movimento horizontal

        if (sprite_index != spr_pulo){
            sprite_index = spr_pulo;
            image_index = 0;
            mask_index = spr_parado;
        }

        // FASE 0 → PREPARAÇÃO
        if(pulo_fase == 0) {

            image_speed = 0.8;

            // Pisca vermelho/branco
            if (floor(image_index) % 2 == 0) image_blend = c_red;
            else image_blend = c_white;

            if(image_index >= 5){
                vveloc = -10;
                // Pula

                pulo_fase = 1;
            }
        }

        // FASE 1 → NO AR
        if (pulo_fase == 1){

            image_speed = 0.8;

            if (vveloc > 0 && place_meeting(x, y + 2, obj_parede)){
                
                pulo_fase = 2; // ⚠️ CORRIGIDO (antes estava ==)
                ja_deu_dano = false;
                image_index = 10;
            }
        }

        // FASE 2 → IMPACTO
        if (pulo_fase == 2){

            image_speed = 1;

            if (!ja_deu_dano && instance_exists(obj_personagem)){

                var _player_no_chao = false;

                with(obj_personagem){
                    if (place_meeting(x, y + 2, obj_parede)) 
                        _player_no_chao = true;
                }

                var _dist = point_distance(x, y, obj_personagem.x, obj_personagem.y);

                if (_player_no_chao && _dist <= 250){

                    with (obj_personagem){
                        if (alarm[0] <= 0){
                            vida -= 1;
                            alarm[0] = inv_tempo;
                        }
                    }

                    ja_deu_dano = true;
                }
            }

            if (image_index >= image_number -1 ){

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
       case ESTADO_BOSS.FEITICO:// Estado onde o boss usa magia
	   
	   // Verifica se o jogador existe na sala
	   if(instance_exists(obj_personagem)){
		   
		    // Calcula a distância horizontal entre boss e jogador
			var _dist = abs(obj_personagem.x - x);
			
			 // Verifica se vai bater em uma parede ao tentar recuar
			 var _batendo_na_parede = place_meeting(x + (spd * -direct), y , obj_parede);
			 
			 
		// ------------------------------
        // 1. FASE DE RECUO (fugir)
        // ------------------------------
		
		 // Só recua se:
        // - o jogador estiver perto
        // - ainda não atacou
        // - não tem parede atrás
		if (_dist < 115 && !ja_deu_dano && !_batendo_na_parede){
			
			hveloc = spd * -direct;// Move para trás (foge do jogador)
			sprite_index = spr_andando;// Usa animação de andar
			image_speed = 1;// Velocidade normal da animação
			image_blend = c_white;
			
		}
		
		// ------------------------------
        // 2. FASE DE ATAQUE
        // ------------------------------
		
		else {
			hveloc = 0; // Para de se mover
			
			// Troca para animação de ataque (se ainda não estiver nela)
			if (sprite_index != spr_boss_lanca_feitico){
				sprite_index = spr_boss_lanca_feitico;
				image_index = 0; // Reinicia animação 
			}
			
			image_speed = 0.5; // Animação mais lenta (dá tempo de reação)
			
			// ------------------------------
            // SINALIZAÇÃO VISUAL (AVISO)
            // ------------------------------
			
			 // Enquanto ainda não atacou, o boss pisca roxo
			 if (!ja_deu_dano) {
				 
				 // Alterna entre roxo e branco (efeito de piscar)
				  if (floor(image_index) % 2 == 0)
						image_blend = c_purple;
				   else
						image_blend = c_white;   
				 
			 } else {
				 image_blend = c_white; // Após atacar, volta ao normal
			 }
			 
			  // ------------------------------
            // DISPARO DO FEITIÇO
            // ------------------------------
			
			// No frame 4 da animação, cria a bola de fogo
			if (floor(image_index) == 4 && !ja_deu_dano){
				
				 // Define posição de onde a bola vai sair
				 var _x_fogo = x + (90 * -image_xscale);
				 var _y_fogo = y - 25;
				 
				 // Cria a bola de fogo
				 var _fogo = instance_create_depth(_x_fogo , _y_fogo, depth -1 , obj_bola_fogo);
				 
				 // Define direção do tiro (esquerda ou direita)
				var _direcao_tiro = (image_xscale == 1) ? 180 : 0;
				 
				  // Aplica movimento à bola
				  _fogo.direction = _direcao_tiro; // Para onde vai
				  _fogo.speed = 1; // Velocidade da bola
				  _fogo.image_angle = _direcao_tiro; // Rotação da imagem
				  
				  ja_deu_dano = true; // Marca que já atacou (evita repetir)
				 	  
				
			}

		}
		
		
	   }
	   
	   // ------------------------------
    // FINAL DO ATAQUE
    // ------------------------------
	
	// Quando a animação termina
	 if (image_index >= image_number - 1 && sprite_index == spr_boss_lanca_feitico) {
		timer_ataque = tempo_ataque; // Reseta tempo de ataque
		estado = ESTADO_BOSS.PERSEGUINDO;  // Volta a perseguir o jogador
		image_blend = c_white; // Volta cor normal
		sprite_index = spr_parado; // Fica parado
		ja_deu_dano = false; // Permite atacar novamente
	}
	
	break; // Final do estado

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

    hveloc = 0;
    // Para movimento
}

x += hveloc;
// Aplica movimento horizontal


// ==============================
// COLISÃO VERTICAL
// ==============================

if (place_meeting(x, y + vveloc, obj_parede)) {

    while (!place_meeting(x, y + sign(vveloc), obj_parede)) {
        y += sign(vveloc);
    }

    vveloc = 0;
    // Para movimento vertical
}

y += vveloc;
// Aplica movimento vertical


// ==============================
// MORTE
// ==============================

// Se a vida acabou
if (vida_boss <= 0 && estado != ESTADO_BOSS.MORTE) {

    estado = ESTADO_BOSS.MORTE;
    // Entra no estado de morte

    image_index = 0;
    // Reinicia animação
}