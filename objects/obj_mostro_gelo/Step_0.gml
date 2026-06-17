// ==============================
// SISTEMA DE DANO (HIT E MORTE)
// ==============================

// Se o boss foi golpeado (marcado como hit pelo ataque do jogador)
if (hit == true) {
    if (vulneravel == true) {
        alarm[1] = 20; // Ativa piscar branco do pai
        vida_monstro_gelo -= 1;
    }
    hit = false; // Limpa o flag
}


// Se a vida real acabar, ativa a morte através do comportamento do pai
if (vida_monstro_gelo <= 0) {
    vida = 0; // Isso faz o script do pai (Step de obj_parente_inimigo) cuidar da animação de morte e drop
    event_inherited(); // MÁGICA: Executa a morte, drops de itens e destruição do pai!
    exit;
}

// =========================================================================
// SISTEMA ANTI-TRAVAMENTO / DESENGATE (Prepara contra travamentos de spawn/subpixel)
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

// ==============================
// FISICA E GRAVIDADE
// ==============================
vveloc += gravidade;

// ==============================
// MÁQUINA DE ESTADOS DO CÉREBRO
// ==============================
switch (estado) {

    // ==============================
    // ESTADO: PERSEGUINDO
    // ==============================
    case ESTADO_MONSTRO_GELO.PERSEGUINDO:
        hveloc = 0;
        scale_x_visual = 1;
        scale_y_visual = 1;
        
        if (timer_ataque > 0) timer_ataque -= 1;

        if (instance_exists(obj_personagem)) {
            var _monster_center = (bbox_left + bbox_right) / 2;
            var _dif_x = obj_personagem.x - _monster_center;
            var _dist_horizontal = abs(_dif_x);

            // Ajusta a direção para onde olhar
            if (_dist_horizontal > 10) {
                direct = sign(_dif_x);
            }

            // AJUSTE DE DISTÂNCIA: Para a 105px do centro para respeitar o corpo largo (170px)
            // Isso evita que o boss sobreponha o jogador e cause dano de contato contínuo!
            if (_dist_horizontal > 105) {
                hveloc = spd * direct;
                sprite_index = (direct == 1) ? spr_andando_direita : spr_andando_esquerda;
            } else {
                hveloc = 0;
                sprite_index = spr_parado;
            }

            // Checa se está no chão (parede ou plataformas)
            var _no_chao = place_meeting(x, y + 1, obj_parede) || 
                           place_meeting(x, y + 1, obj_plataforma_fase2) || 
                           place_meeting(x, y + 1, obj_plataforma) || 
                           place_meeting(x, y + 1, obj_plataforma2);

            // Escolhe o próximo ataque na sequência cíclica se o jogador estiver ao alcance (máx 120px) e o cooldown zerar
            if (timer_ataque <= 0 && _no_chao && _dist_horizontal <= 120) {
                if (proximo_ataque == 0) {
                    estado = ESTADO_MONSTRO_GELO.SOCAO;
                    proximo_ataque = 1;
                    sprite_index = spr_socao;
                    image_speed = 0.5; // Socão lento
                } else if (proximo_ataque == 1) {
                    estado = ESTADO_MONSTRO_GELO.PISADA;
                    proximo_ataque = 2;
                    sprite_index = spr_pisada;
                    image_speed = 0.3; // Pisada ainda mais lenta para dar tempo de desviar
                } else {
                    estado = ESTADO_MONSTRO_GELO.BRACADA;
                    proximo_ataque = 0;
                    sprite_index = spr_bracada;
                    image_speed = 0.5; // Braçada lenta
                }
                timer_estado = 0;
                ja_deu_dano = false;
                image_index = 0;
            }
        } else {
            sprite_index = spr_parado;
            hveloc = 0;
        }
        break;

    // ==============================
    // ESTADO: DESCANSO (VULNERÁVEL)
    // ==============================
    case ESTADO_MONSTRO_GELO.DESCANSO:
        hveloc = 0;
        sprite_index = spr_parado;
        scale_x_visual = 1;
        scale_y_visual = 1;

        if (timer_descanso > 0) {
            timer_descanso -= 1;
        } else {
            estado = ESTADO_MONSTRO_GELO.PERSEGUINDO;
            timer_ataque = tempo_ataque;
            vulneravel = false; // Retorna a ficar invulnerável ao sair do descanso
        }
        break;

    // ==============================
    // ATAQUE: SOCÃO (DANO DIRETO)
    // ==============================
    case ESTADO_MONSTRO_GELO.SOCAO:
        hveloc = 0;
        timer_estado += 1;
        sprite_index = spr_socao;

        // Fase 1: Wind-up / Preparação (Telegrafando)
        if (image_index < 5) {
            shake_x = random_range(-2, 2);
            scale_x_visual = 0.95;
            scale_y_visual = 1.05; // Estica um pouco para cima na preparação
        } 
        // Fase 2: Impacto / Golpe (Executa o dano somente nos frames de impacto do sprite)
        else {
            shake_x = 0;
            scale_x_visual = 1.15;
            scale_y_visual = 0.95; // Achata um pouco no golpe

            if (image_index >= 5 && image_index <= 8) {
                if (!ja_deu_dano && instance_exists(obj_personagem)) {
                    var _range = 70;
                    var _punch_left = (direct == 1) ? bbox_right : bbox_left - _range;
                    var _punch_right = (direct == 1) ? bbox_right + _range : bbox_left;
                    
                    var _punch_top = bbox_bottom - 64;
                    var _punch_bottom = bbox_bottom;

                    var _hit = collision_rectangle(_punch_left, _punch_top, _punch_right, _punch_bottom, obj_personagem, false, true);
                    if (_hit != noone) {
                        with (_hit) {
                            if (alarm[0] <= 0) {
                                vida -= 1;
                                alarm[0] = inv_tempo;
                                hveloc = 2.5 * other.direct;
                                vveloc = -2;
                            }
                        }
                        ja_deu_dano = true;
                    }
                }
            }
        }

        // Final do ataque quando a animação terminar
        if (scr_fim_da_animacao() || timer_estado >= 180) {
            shake_x = 0;
            scale_x_visual = 1;
            scale_y_visual = 1;
            estado = ESTADO_MONSTRO_GELO.DESCANSO;
            timer_descanso = tempo_descanso;
            image_speed = 1.0; // Restaura a velocidade padrão da animação
        }
        break;

    // ==============================
    // ATAQUE: PISADA (DANO EM ÁREA)
    // ==============================
    case ESTADO_MONSTRO_GELO.PISADA:
        hveloc = 0;
        timer_estado += 1;
        sprite_index = spr_pisada;

        // Fase 1: Wind-up / Elevação
        if (image_index < 5) {
            y_offset = -16 * sin((image_index / 5) * pi); // Sobe o boss de acordo com a animação
            shake_x = random_range(-1, 1);
            scale_x_visual = 0.90;
            scale_y_visual = 1.15;
            stomp_wave_radius = 0;
        } 
        // Fase 2: Impacto
       else{
		   
		   // Volta o monstro para sua posição vertical normal.
    // Durante a preparação ele pode ter sido deslocado para cima.
			y_offset = 0;
			
			// Remove qualquer tremor horizontal.
			shake_x = 0;
			
			// Estica o monstro horizontalmente para dar sensação de peso no impacto.
			scale_x_visual = 1.25;
			
			 // Achata o monstro verticalmente.
			 scale_y_visual = 0.75;
			 
			 // EXPANSÃO DA ONDA DE CHOQUE
			 
			  // A onda cresce 4 pixels por frame.
			// Ela nunca ultrapassa 160 pixels de alcance.
			if (stomp_wave_radius < 160) {
				stomp_wave_radius = min(160, stomp_wave_radius + 4);
			}
			
			 //JANELA DE DANO DA ANIMAÇÃO
			 
			 // Só verifica dano quando a animação já chegou
			// na parte do impacto (frame 5 em diante).
			if (image_index >= 5 && image_index < image_number){
				
				// Verifica se este ataque ainda não causou dano
				// e se o jogador existe na sala.
				if (!ja_deu_dano && instance_exists(obj_personagem)){
					
					 // VERIFICA SE O JOGADOR ESTÁ NO CHÃO
					 
					 // Compara a parte inferior da hitbox do jogador
					 // com a parte inferior da hitbox do monstro.
					//
					// Se o jogador estiver praticamente na mesma altura
					 // do chão onde a onda se propaga, considera que ele
					 // está em contato com o solo.
					 var _player_no_chao = (obj_personagem.bbox_bottom >= bbox_bottom - 2);
					 
					  // CENTRO DO MONSTRO
					  
					   // Calcula o ponto central da hitbox do monstro.
					   var _monster_center = (bbox_left + bbox_right) / 2;
					   
					   // DISTÂNCIA ENTRE O JOGADOR E O CENTRO DO MONSTRO
					   
					    // abs() garante que o resultado seja sempre positivo.
			            //
			            // Exemplo:
			            // Jogador à esquerda  = 50 pixels
			            // Jogador à direita   = 50 pixels
			            //
			            // Em ambos os casos a distância será 50.
						var _dist = abs(obj_personagem.x - _monster_center);
						
						 // VERIFICA SE A ONDA ALCANÇOU O JOGADOR
						 
						  // Só causa dano se:
				            //
				            // 1) O jogador estiver no chão.
				            // 2) A onda de choque (frente de colisão) estiver passando exatamente pela posição do jogador.
						
						var _wave_width = 12; // Tolerância da largura da onda de choque (frente de colisão)
						if (_player_no_chao && _dist >= stomp_wave_radius - _wave_width && _dist <= stomp_wave_radius + _wave_width){
							
							 // Executa código dentro do objeto jogador.
							 with (obj_personagem){
								 
								  // Só recebe dano se não estiver
			                    // em período de invulnerabilidade.
			                    if (alarm[0] <= 0) {

		                        // Remove 1 ponto de vida.
		                        vida -= 1;

		                        // Ativa a invulnerabilidade temporária.
		                        alarm[0] = inv_tempo;
								
										 // Lança o jogador para cima.
		                        //
		                        // No GameMaker:
		                        // valor negativo = sobe
		                        // valor positivo = desce
								vveloc = -3.5;
							 }
						}
						
						// Marca que esta pisada já causou dano.
						// Impede múltiplos acertos no mesmo ataque.
						ja_deu_dano = true;
						
				}
			}
	   }
	   
	   }

        // Final do ataque quando a animação terminar
        if (scr_fim_da_animacao() || timer_estado >= 180) {
            stomp_wave_radius = 0;
            scale_x_visual = 1;
            scale_y_visual = 1;
            estado = ESTADO_MONSTRO_GELO.DESCANSO;
            timer_descanso = tempo_descanso;
            image_speed = 1.0; // Restaura a velocidade padrão da animação
        }
        break;

    // ==============================
    // ATAQUE: BRAÇADA (DANO EM ÁREA RASTEIRO)
    // ==============================
    case ESTADO_MONSTRO_GELO.BRACADA:
        hveloc = 0;
        timer_estado += 1;
        sprite_index = spr_bracada;

        // Fase 1: Wind-up / Puxada de braço
        if (image_index < 6) {
            shake_x = -direct * 4; // Puxa para trás
            scale_x_visual = 0.85;
            scale_y_visual = 1.05;
            sweep_progress = 0;
        } 
        // Fase 2: Sweep ativo (Executa o dano somente nos frames de varredura do sprite)
        else {
            shake_x = 0;
            scale_x_visual = 1.20;
            scale_y_visual = 0.90;
            
            sweep_progress = (image_index - 6) / (image_number - 6);

            if (image_index >= 6 && image_index <= 10) {
                if (!ja_deu_dano && instance_exists(obj_personagem)) {
                    var _sweep_range = 110;
                    var _sweep_left = (direct == 1) ? bbox_right : bbox_left - _sweep_range;
                    var _sweep_right = (direct == 1) ? bbox_right + _sweep_range : bbox_left;

                    var _sweep_top = bbox_bottom - 48;
                    var _sweep_bottom = bbox_bottom;

                    var _hit = collision_rectangle(_sweep_left, _sweep_top, _sweep_right, _sweep_bottom, obj_personagem, false, true);
                    if (_hit != noone) {
                        with (_hit) {
                            if (alarm[0] <= 0) {
                                vida -= 1;
                                alarm[0] = inv_tempo;
                                hveloc = 3 * other.direct;
                                vveloc = -2.5;
                            }
                        }
                        ja_deu_dano = true;
                    }
                }
            }
        }

        // Final do ataque quando a animação terminar
        if (scr_fim_da_animacao() || timer_estado >= 180) {
            sweep_progress = 0;
            scale_x_visual = 1;
            scale_y_visual = 1;
            estado = ESTADO_MONSTRO_GELO.DESCANSO;
            timer_descanso = 180; // Descanso estendido para 180 frames (3 segundos)
            vulneravel = true;    // Fica vulnerável a ataques do jogador
            image_speed = 1.0; // Restaura a velocidade padrão da animação
        }
        break;
}

// ==============================
// COLISÃO HORIZONTAL (PAREDES / BLOQUEIOS DE INIMIGO)
// ==============================
var _colidiu_h = place_meeting(x + hveloc, y, obj_parede) || place_meeting(x + hveloc, y, obj_parede_inimigo);
if (_colidiu_h) {
    var _obj_colisao = place_meeting(x + hveloc, y, obj_parede) ? obj_parede : obj_parede_inimigo;
    while (!place_meeting(x + sign(hveloc), y, _obj_colisao)) {
        x += sign(hveloc);
    }
    hveloc = 0;
}
x += hveloc;

// ==============================
// COLISÃO VERTICAL (CHÃO/TETO/PLATAFORMAS)
// ==============================
// 1. Colisão sólida com obj_parede
if (place_meeting(x, y + vveloc, obj_parede)) {
    while (!place_meeting(x, y + sign(vveloc), obj_parede)) {
        y += sign(vveloc);
    }
    vveloc = 0;
}

// 2. Colisão passável unidirecional com plataformas
var _plat = instance_place(x, y + vveloc, obj_plataforma_fase2);
if (_plat == noone) _plat = instance_place(x, y + vveloc, obj_plataforma);
if (_plat == noone) _plat = instance_place(x, y + vveloc, obj_plataforma2);

if (_plat != noone) {
    // Só colide se estiver caindo (vveloc > 0) e a base do monstro estiver acima do topo da plataforma
    if (vveloc > 0 && bbox_bottom <= _plat.bbox_top + 4) {
        while (!place_meeting(x, y + sign(vveloc), _plat)) {
            y += sign(vveloc);
        }
        vveloc = 0;
    }
}
y += vveloc;
