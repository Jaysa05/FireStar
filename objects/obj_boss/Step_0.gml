// ==============================
// SISTEMA DE DANO (HIT)
// ==============================

if( hit == true){
	// Só recebe dano se estiver no estado de descanso
	if (estado == ESTADO_BOSS.DESCANSO){
		
		// Ativa o efeito visual de "piscar"(Herdado do obj_parente_inimigo)
		alarm[1] = 5;
		
		// Diminui 1 da vida real do boss
		vida_boss -=1;
	}
	
	// Reseta o hit para evitar múltiplos danos no mesmo frame
	hit = false;

}

// NÃO usamos event_inherited() aqui no Step
// porque já estamos controlando o efeito de dano manualmente


// ==============================
// GRAVIDADE
// ==============================

// Aplica gravidade aumentando a velocidade vertical
vveloc += gravidade;

// ==============================
// MÁQUINA DE ESTADOS
// ==============================

switch (estado){
	
	 // ------------------------------
    // ESTADO: PERSEGUINDO
    // ------------------------------
	
	case ESTADO_BOSS.PERSEGUINDO:
	
	 // Cor normal (sem efeito)
	 image_blend = c_white;
	 
	 // Diminui o tempo de perseguição
	 timer_perseguicao -= 1;
	 
	 // Diminui o cooldown de ataque
	 if (timer_ataque > 0) timer_ataque -= 1;

	 
	  // Verifica se o jogador existe
	  if (instance_exists(obj_personagem)){
		  // Distância até o jogador
		  var _distancia = distance_to_object(obj_personagem);
		  
		   // Define direção: -1 (esquerda) ou 1 (direita)
		   // Adicionamos uma "zona morta" de 5 pixels para evitar que ele mude de lado freneticamente
		   var _dif_x = obj_personagem.x - x;
		   if (abs(_dif_x) > 5) {
			   direct = sign(_dif_x);
		   }
		   
		   // Vira o sprite para olhar para o jogador
		   if (direct != 0) image_xscale = - direct;
		   
		  // O sprite que eu quero usar começa sendo o sprite atual
		  var _sprite_alvo = sprite_index;
		  
		  //A velocidade da animação
		  var _vel_anim = 1;
		  
		  // Calculamos a distância APENAS horizontal (ignora se o player está no alto)
		  var _distancia = abs(_dif_x);
		  
		  // Se estiver MUITO perto → Tenta atacar
		  if( _distancia <= 50){
			  hveloc = 0;
			  _sprite_alvo = spr_parado;
			  _vel_anim = 1;
			  
			  // Se o cooldown acabou e está no chão, ataca
			  var _no_chao = place_meeting(x, y + 1, obj_parede);
			  if (timer_ataque <= 0 && _no_chao) {
				  estado = ESTADO_BOSS.ESPADA;
				  image_index = 0;
			  }
		  }
			// Se estiver longe o suficiente → volta a andar
			// Usamos 60 aqui para criar um "buffer" e evitar flicker
			else if (_distancia >= 60) {
				hveloc = direct * spd;
				_sprite_alvo = spr_andando;
				_vel_anim = 1;
			}


			
			 // Troca o sprite apenas se necessário
			 if (sprite_index != _sprite_alvo){
				 sprite_index = _sprite_alvo;
				 
				 // Reinicia a animação
				 image_index = 0;
			 }
			 
			 // Define velocidade da animação
			 image_speed = _vel_anim;
	  }

			// Se o tempo acabar → entra em descanso
			if (timer_perseguicao <= 0 ) {
				estado = ESTADO_BOSS.DESCANSO;
				timer_descanso = tempo_descanso;
				hveloc = 0;
			}
			
			break;
			
			// ------------------------------
			// ESTADO: DESCANSO
			// ------------------------------
			
			case ESTADO_BOSS.DESCANSO:
			
			// Garante que está com sprite parado
			if (sprite_index != spr_parado) {
				sprite_index = spr_parado;
				image_index = 0;
			}
			 // Não se move
			 hveloc = 0;
			 
			  // Conta o tempo de descanso
			  timer_descanso -= 1;
			  
			  // Fica com cor azul (indica vulnerável)
			  image_blend = c_aqua;
			  
			  // Animação mais lenta
			  image_speed = 0.5;
			  
			   // Quando o descanso acaba → volta a perseguir
			   if ( timer_descanso <= 0) {
				   estado = ESTADO_BOSS.PERSEGUINDO;
				   timer_perseguicao = tempo_perseguindo;
				   image_blend = c_white;
			   }
			   
			   break;
			   
			   // ------------------------------
			 // ESTADO: MORTE
			 // ------------------------------
			 
			  case ESTADO_BOSS.MORTE:

				// Para totalmente
				hveloc = 0;
				
				image_blend = c_white;
				
				// Troca para sprite de morte
				if (sprite_index != spr_morte){
					sprite_index = spr_morte;
					image_index = 0;
				}
				
				// Animação normal
				image_speed = 1;
				
				break;
				
			// ------------------------------
			// ESTADO: ESPADA (ATAQUE)
			// ------------------------------
			
			case ESTADO_BOSS.ESPADA:
			
				// Para o movimento
				hveloc = 0;
				
				// Define o sprite de ataque
				if (sprite_index != spr_ataque) {
					sprite_index = spr_ataque;
					image_index = 0;
				}
				
				// Velocidade da animação
				image_speed = 1;
				
				// Garante que a máscara física seja sempre a do boss parado
				// Isso evita que o player tome dano "pela máscara" antes da hora
				mask_index = spr_parado;
				
				// --- DANO DA ESPADA POR CÓDIGO (HITBOX VIRTUAL) ---
				// Só aplica o dano quando a animação chega no frame do balanço (frame 11 em diante)
				if (image_index >= 11 && image_index <= 14) {
					// Detecta o jogador em uma área circular à frente do boss
					// Aumentamos o alcance para 70 e o raio para 40 para pegar a ponta
					var _x_espada = x + (70 * -image_xscale); 
					var _alvo = collision_circle(_x_espada, y - 10, 40, obj_personagem, false, true);
					
					if (_alvo != noone) {

						with(_alvo) {
							if (alarm[0] <= 0) {
								vida -= 1;
								alarm[0] = inv_tempo;
								vveloc = -3; // Pequeno pulo ao tomar dano
							}
						}
					}
				}
				
				// Quando a animação terminar
				if (image_index >= image_number - 1) {
					// Reinicia o cooldown
					timer_ataque = tempo_ataque;
					
					// Volta a perseguir
					estado = ESTADO_BOSS.PERSEGUINDO;
					
					// Garante que o sprite e a máscara voltem ao normal
					sprite_index = spr_parado;
					mask_index = spr_parado;
				}
				
				break;

}

// ==============================
// COLISÃO HORIZONTAL
// ==============================

// Se vai bater na parede
if (place_meeting(x + hveloc, y, obj_parede)){
	
	// Anda pixel por pixel até encostar
	while ( !place_meeting(x + sign(hveloc), y , obj_parede)){
		x += sign(hveloc);
	}
	
	// Para movimento horizontal
	hveloc = 0;
}

// Aplica movimento horizontal
	x += hveloc;
	
	
// ==============================
// COLISÃO VERTICAL
// ==============================

// Se vai bater na parede verticalmente
if (place_meeting(x, y + vveloc, obj_parede)) {
	
    // Ajusta posição até encostar pixel por pixel
    while (!place_meeting(x, y + sign(vveloc), obj_parede)) {
        y += sign(vveloc);
    }

    vveloc = 0;
}

// Aplica movimento vertical
y += vveloc;

	
// ==============================
// CHECAGEM DE MORTE REAL
// ==============================

// Se a vida acabou e ainda não está morto
if (vida_boss <= 0 && estado != ESTADO_BOSS.MORTE){
	
	// Entra no estado de morte
	estado = ESTADO_BOSS.MORTE;
	
	// Reinicia animação de morte
	   image_index = 0;
}