function scr_personagem_movendo(){ // Função principal: controla o personagem andando

    // -----------------------------
    // INPUT (TECLADO)
    // -----------------------------
    direita = keyboard_check(ord("D")); // Verifica se tecla D está pressionada
    esquerda = keyboard_check(ord("A")); // Verifica se tecla A está pressionada
    cima = keyboard_check_pressed(vk_space); // Verifica se apertou espaço (pulo)

    // -----------------------------
    // DIREÇÃO E SPRITE
    // -----------------------------
    if (direita) { // Se estiver andando para direita
        direct = 0; // Guarda direção como direita
        sprite_index = spr_personagem_andando_direita; // Sprite andando direita

    } else if (esquerda) { // Se estiver andando para esquerda
        direct = 1; // Guarda direção como esquerda
        sprite_index = spr_personagem_andando_esquerda; // Sprite andando esquerda

    } else { // Se não está se movendo
        if (direct == 0)
            sprite_index = spr_personagem_parado_direita; // Parado olhando direita
        else if (direct == 1)
            sprite_index = spr_personagem_parado_esquerda; // Parado olhando esquerda
    }

    // -----------------------------
    // VELOCIDADE HORIZONTAL
    // -----------------------------
    hveloc = (direita - esquerda) * veloc;
    // direita = 1 → anda pra direita
    // esquerda = 1 → anda pra esquerda

    // -----------------------------
    // CONTROLE DA PLATAFORMA 2
    // -----------------------------
    var _pode_usar_plat2 = true; // Começa podendo usar

    if (room == rm_fase4) { // Se está na fase do boss
        _pode_usar_plat2 = false; // Bloqueia plataforma2

        if (instance_exists(obj_boss)) { // Se o boss existe
            if (obj_boss.estado == ESTADO_BOSS.ESPADA
            || obj_boss.estado == ESTADO_BOSS.PULO
            || obj_boss.estado == ESTADO_BOSS.FEITICO) {
                _pode_usar_plat2 = true; // Libera dependendo do ataque
            }
        }
    }

    // -----------------------------
    // DETECÇÃO DE CHÃO
    // -----------------------------
 // Cria a variável _chao (vai dizer se o personagem está no chão ou não)
var _chao =

    // Verifica se existe uma parede 1 pixel abaixo do personagem
    // Se tiver, significa que está no chão
    place_meeting(x, y + 1, obj_parede) ||

    // OU: verifica se tem um trampolim logo abaixo
    // Também conta como chão
    place_meeting(x, y + 1, obj_trampolim) ||

    // OU: verifica plataforma que cai
    (
        // Tem uma plataforma desse tipo logo abaixo?
        place_meeting(x, y + 1, obj_plataforma_cair)

        && // E ao mesmo tempo...

        // Garante que o personagem NÃO está dentro da plataforma
        // Isso evita bugs de atravessar ou travar
        !place_meeting(x, y, obj_plataforma_cair)
    ) ||

    // OU: verifica plataforma normal
    (
        // Tem uma plataforma normal logo abaixo?
        place_meeting(x, y + 1, obj_plataforma)

        && // E ao mesmo tempo...

        // Garante que NÃO está dentro da plataforma
        !place_meeting(x, y, obj_plataforma)
    ) ||

    // OU: verifica plataforma especial (plat2)
    (
        // Só entra aqui se for permitido usar essa plataforma
        _pode_usar_plat2

        && // E...

        // Verifica se tem essa plataforma logo abaixo
        place_meeting(x, y + 1, obj_plataforma2)

        && // E...

        // Garante que não está dentro dela
        !place_meeting(x, y, obj_plataforma2)
    ) ||

    // OU: verifica plataforma da fase 2
    (
        place_meeting(x, y + 1, obj_plataforma_fase2)
        &&
        !place_meeting(x, y, obj_plataforma_fase2)
    );

    // -----------------------------
    // GRAVIDADE
    // -----------------------------
    if (!_chao) { // Se está no ar
        vveloc += gravidade; // Aplica gravidade (cai)

        if (pulos == pulos_max) {
            pulos = pulos_max - 1; // Evita pulo extra ao cair
        }

    } else {
        pulos = pulos_max; // No chão → recarrega pulos
    }

    // -----------------------------
    // PULO
    // -----------------------------
    if (cima && pulos > 0) { // Se apertou pulo e pode pular
        vveloc = -abs(forca_pulo); // Aplica força para cima
        pulos -= 1; // Gasta um pulo
    }

    // -----------------------------
    // COLISÃO HORIZONTAL
    // -----------------------------
    if (place_meeting(x + hveloc, y, obj_parede)) { // Vai bater?

        while (!place_meeting(x + sign(hveloc), y, obj_parede)) {
            x += sign(hveloc); // Move até encostar
        }

        hveloc = 0; // Para movimento
    }

    x += hveloc; // Aplica movimento horizontal

    // -----------------------------
    // COLISÃO VERTICAL
    // -----------------------------
    if (place_meeting(x, y + vveloc, obj_parede)
    || place_meeting(x, y + vveloc, obj_trampolim)) {

        while (!place_meeting(x, y + sign(vveloc), obj_parede)
        && !place_meeting(x, y + sign(vveloc), obj_trampolim)) {
            y += sign(vveloc); // Move até encostar
        }

        vveloc = 0; // Para movimento vertical
    }

    // -----------------------------
    // COLISÃO COM PLATAFORMAS
    // -----------------------------
    var _plat = instance_place(x, y + vveloc, obj_plataforma_cair); // Procura plataforma

    if (_plat == noone)
        _plat = instance_place(x, y + vveloc, obj_plataforma);

    if (_plat == noone && _pode_usar_plat2)
        _plat = instance_place(x, y + vveloc, obj_plataforma2);

    if (_plat == noone)
        _plat = instance_place(x, y + vveloc, obj_plataforma_fase2);

    if (_plat != noone) {

        if (vveloc > 0 && bbox_bottom <= _plat.bbox_top) {
            // Só colide se estiver caindo e acima da plataforma

            while (!place_meeting(x, y + sign(vveloc), _plat)) {
                y += sign(vveloc);
            }

            vveloc = 0; // Para queda
            pulos = pulos_max; // Reseta pulos
        }
    }

    y += vveloc; // Aplica movimento vertical

    // -----------------------------
    // ATAQUE
    // -----------------------------
    if (keyboard_check_pressed(vk_enter)) {

        image_index = 0; // Reinicia animação
        estado = scr_personagem_atacando; // Muda estado

        if (direct == 0) {
            instance_create_layer(x + 20, y - 8, "Instances_2", obj_hitbox); // Hitbox direita
        } else if (direct == 1) {
            instance_create_layer(x - 20, y - 8, "Instances_2", obj_hitbox); // Hitbox esquerda
        }
    }

    // -----------------------------
    // MORTE AO CAIR
    // -----------------------------
    if (y > room_height + 64) {
        vida = 0;
        room_goto(rm_gameover);
    }

    // -----------------------------
    // DANO
    // -----------------------------
    if (place_meeting(x, y, obj_espinhos)
    || place_meeting(x, y, obj_caixa_espinhenta)) {

        if (alarm[0] <= 0) { // Invencibilidade
            vida -= 1;
            alarm[0] = inv_tempo;
            vveloc = -3; // Empurrão para cima
        }
    }

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