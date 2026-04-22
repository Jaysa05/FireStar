	// Script assets have changed for v2.3.0 see
	//script personagem movendo
	function scr_personagem_movendo(){
		// -----------------------------
		// MOVIMENTAÇÃO
		// -----------------------------
		direita = keyboard_check(ord("D"));
		esquerda = keyboard_check(ord("A"));
		cima = keyboard_check_pressed(vk_space);

		// -----------------------------
		// DEFININDO DIREÇÃO E SPRITES
		// -----------------------------
		if direita {
			direct = 0;
			sprite_index = spr_personagem_andando_direita;
		} else if esquerda {
			direct = 1;
			sprite_index = spr_personagem_andando_esquerda;
		} else {
			if direct == 0 { sprite_index = spr_personagem_parado_direita; }
			else if direct == 1 { sprite_index = spr_personagem_parado_esquerda; }
		}

		// -----------------------------
		// VELOCIDADE HORIZONTAL
		// -----------------------------
		hveloc = (direita - esquerda) * veloc;

		// -----------------------------
		// GRAVIDADE E PULO
		// -----------------------------
		// Verifica se o personagem está no chão
var _chao = place_meeting(x, y + 1, obj_parede) ||
			place_meeting(x, y + 1, obj_trampolim)||
			(place_meeting(x, y + 1, obj_plataforma_cair) && !place_meeting(x, y, obj_plataforma_cair)) ||
			(place_meeting(x, y + 1, obj_plataforma) && !place_meeting(x, y, obj_plataforma));

// Se NÃO estiver no chão
if (!_chao) {
	
	// Aplica gravidade (faz o personagem cair)
	vveloc += gravidade;
	
	// Se caiu da borda sem pular
	if (pulos == pulos_max) {
		// Remove um pulo para evitar "pulo extra" no ar
		pulos = pulos_max - 1;
	}

} else {
	
	// Se estiver no chão, recarrega todos os pulos
	pulos = pulos_max;
}

// Se o jogador apertou o botão de pulo e ainda tem pulos disponíveis
if (cima && pulos > 0) {
	
	// Define a velocidade vertical para cima (pulo)
	// abs() garante que o valor seja positivo antes de inverter
	vveloc = -abs(forca_pulo);
	
	// Diminui a quantidade de pulos restantes
	pulos -= 1;
}

		// -----------------------------
		// COLISÃO HORIZONTAL
		// -----------------------------
		if place_meeting(x + hveloc, y, obj_parede) {
			while !place_meeting(x + sign(hveloc), y, obj_parede) {
				x += sign(hveloc);
			}
			hveloc = 0;
		}
		x += hveloc;

		// -----------------------------
		// COLISÃO VERTICAL COM O CHÃO (obj_parede)
		// -----------------------------
		// Verifica se, ao se mover verticalmente (y + vveloc),
		// o objeto vai colidir com uma parede OU com um trampolim
		if place_meeting(x, y + vveloc, obj_parede) || place_meeting(x, y + vveloc, obj_trampolim) {
			// Enquanto NÃO houver colisão ao mover apenas 1 pixel na direção do movimento
			// (sign(vveloc) define se vai subir (-1) ou descer (1))
			while !place_meeting(x , y + sign(vveloc), obj_parede) && !place_meeting(x, y + sign(vveloc), obj_trampolim) {
				 // Move o objeto 1 pixel na direção da velocidade vertical
				// Isso garante que ele pare exatamente antes da colisão
				y += sign(vveloc);
			}
			// Quando encostar no objeto (parede ou trampolim),
			// zera a velocidade vertical para parar o movimento
			vveloc = 0;
		}
		
// -----------------------------
// COLISÃO VERTICAL COM A PLATAFORMA (Snap para o topo)
// -----------------------------
// Procura qualquer uma das plataformas no caminho
var _plat = instance_place(x, y + vveloc, obj_plataforma_cair);
if (_plat == noone) _plat = instance_place(x, y + vveloc, obj_plataforma);

// Se encontrou uma plataforma (seja vindo de cima ou de baixo)
if (_plat != noone) {
	
	// Puxa o personagem para o topo da plataforma
	// Move o personagem para cima até ele não estar mais "dentro" da plataforma
	while (place_meeting(x, y + vveloc, _plat.object_index)) {
		y -= 1;
	}
	
	// Garante que ele fique exatamente em cima
	while (!place_meeting(x, y + 1, _plat.object_index)) {
		y += 1;
	}
	
	// Zera a velocidade e recarrega os pulos
	vveloc = 0;
	pulos = pulos_max;
}

// Aplica o movimento vertical (sobe ou desce)
y += vveloc;

		
		// -----------------------------
		// ATAQUE
		// -----------------------------
		if keyboard_check_pressed(vk_enter) {
			image_index = 0;                // resetar a animação
			estado = scr_personagem_atacando;  // mudar o estado para atacando
			
			// criar a hitbox do nosso ataque dependendo pro lado que ele olha
			if direct == 0 { // Direita
				instance_create_layer(x + 20, y - 8, "Instances_2", obj_hitbox);
			} else if direct == 1 { // Esquerda
				instance_create_layer(x - 20, y - 8, "Instances_2", obj_hitbox);
			}
		}
		
		// -----------------------------
// GAME OVER AO CAIR NO BURACO
// -----------------------------

// Verifica se o personagem caiu para fora da tela (um pouco abaixo da sala)
if (y > room_height + 64) {
	
	// Define a vida do personagem como zero (morreu)
	vida = 0;
	
	// Muda para a sala de Game Over
	room_goto(rm_gameover);
}


		// -----------------------------
		// COLISÃO COM ESPINHOS OU CAIXAS (DANO)
		// -----------------------------
		if (place_meeting(x, y, obj_espinhos) || place_meeting(x, y, obj_caixa_espinhenta)) {
			// Só toma dano se não estiver no tempo de invencibilidade (alarm 0)
			if (alarm[0] <= 0) {
				vida -= 1;        // Perde 1 vida
				alarm[0] = inv_tempo; // Fica invencível por um tempo
				vveloc = -3;      // Pequeno pulo de "susto" ao tomar dano
			}
		}

		// Se a vida chegar a 0 por causa do dano
		if (vida <= 0) {
			room_goto(rm_gameover);
		}
	}

function scr_personagem_atacando(){

	// Verifica para qual lado o personagem está olhando
	
	if direct == 0{
		// Se direct for 0 significa que o personagem está olhando para direita
		// Então trocamos o sprite para o ataque para direita
		sprite_index = spr_personagem_atacando_direita;

	}else if direct == 1{
		// Se direct for 1 significa que o personagem está olhando para esquerda
		// Então trocamos o sprite para o ataque para esquerda
		sprite_index = spr_personagem_atacando_esquerda;
	}
	
	
	// Aqui verificamos se a animação do ataque terminou
	
	if scr_fim_da_animacao(){
		
		// Quando a animação termina, voltamos o estado do personagem para o estado de movimento
		
		estado = scr_personagem_movendo;
	}
	
}

