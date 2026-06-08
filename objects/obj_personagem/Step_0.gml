// Executa o script armazenado na variável "estado".
// Normalmente é usado para controlar comportamentos do objeto
// (andar, atacar, parado, etc.).
script_execute(estado);


// =====================================================
// SISTEMA DE BLOQUEIO DA PORTA DA DIREITA (FASE 5)
// =====================================================

// Verifica se o jogador está na Fase 5.
if (room == rm_fase5) {
    
    // Executa o código para todas as portas de transição da sala.
    with (obj_transicao) {
        
        // Verifica se esta é a porta da direita.
        // A porta da direita possui Y maior que 100.
        // A porta de cima possui Y negativo, então será ignorada.
        if (y > 100) {
            
            // Verifica se a variável "parede_bloqueio"
            // já existe nesta porta.
            if (!variable_instance_exists(id, "parede_bloqueio")) {
                
                // Cria a variável e define que ela não está
                // apontando para nenhuma parede ainda.
                parede_bloqueio = noone;
            }
            
            // Verifica se o demônio ainda existe na sala.
            if (instance_exists(obj_demonio)) {
                
                // Se ainda não existe uma parede criada...
                if (parede_bloqueio == noone) {
                    
                    // Cria uma parede invisível exatamente na
                    // posição da porta.
                    parede_bloqueio = instance_create_depth(
                        x,
                        y,
                        depth,
                        obj_parede
                    );
                    
                    // Faz a parede ter a mesma largura da porta.
                    parede_bloqueio.image_xscale = image_xscale;
                    
                    // Faz a parede ter a mesma altura da porta.
                    parede_bloqueio.image_yscale = image_yscale;
                }
            }
            
            // Se não existe mais demônio...
            else {
                
                // Verifica se existe uma parede bloqueando a porta.
                if (parede_bloqueio != noone) {
                    
                    // Remove a parede invisível.
                    instance_destroy(parede_bloqueio);
                    
                    // Limpa a referência da variável.
                    parede_bloqueio = noone;
                }
            }
        }
    }
}


// ----------------------------------------------------
// -----------------------------
// COLISÃO COM A LAVA
// -----------------------------
if (place_meeting(x, y, obj_lava)) {
	if (alarm[0] <= 0) {
		vida -= 1;
		alarm[0] = inv_tempo;
	}
	dano_lava = true; // Ativa o efeito de ficar vermelho
}

// -----------------------------
// SISTEMA DE COMBATE (EFEITO DE DANO)
// -----------------------------

// se o alarme ainda estiver ativo
if (alarm[0] > 0){

	// se estiver totalmente visível
	if (image_alpha >= 1){

		// começa a ficar invisível
		alfa_hit = -0.05;

	// se estiver invisível
	}else if (image_alpha < 0){

		// começa a ficar visível novamente
		alfa_hit = 0.05;
	}

	// altera a transparência do sprite
	image_alpha += alfa_hit;

	// Se o dano foi causado por lava, o personagem fica vermelho
	if (dano_lava) {
		image_blend = c_red;
	}

}else {

	// quando o alarme acabar volta ao normal
	image_alpha = 1;
	image_blend = c_white;
	dano_lava = false;
}

depth = -bbox_bottom; //Quanto mais embaixo o personagem estiver na tela, mais na frente ele aparece

	//Se a vida chegar a 0
if (vida <= 0 && !morreu) {
    morreu = true;
    
    // Se houver um checkpoint ativo, resetamos os dados para o renascimento
    if (variable_global_exists("checkpoint_ativo")) {
        global.vida_save = 5;
        global.faca_save = 0;
        global.faca_cargas_save = 0;
        global.frutas_save = 0;
        global.inv_save = 0;
    }
    
    vida = global.vida_save;
    faca = global.faca_save;
    faca_cargas = global.faca_cargas_save;
    frutas = global.frutas_save;
    room_goto(rm_gameover);
}

// -----------------------------------------------------------------------------
// SISTEMA DE INVENCIbilidade E PISCAR
// -----------------------------------------------------------------------------
if (invencivel) {
    timer_invencibilidade--;
    
    // Faz o personagem piscar alternando a transparência a cada 4 frames
    if ((timer_invencibilidade div 4) % 2 == 0) {
        image_alpha = 1;    // Visível
    } else {
        image_alpha = 0.2;  // Quase invisível (piscando)
    }
    
    // Quando o tempo acabar
    if (timer_invencibilidade <= 0) {
        invencivel = false;
        image_alpha = 1;    // Garante que o personagem volte a ficar 100% visível
    }
}
if (keyboard_check_pressed(vk_enter)) {
    atacando = true; // O personagem entra no modo de ataque
    
    // O ataque vai durar um tempo curtinho (ex: 20 frames) e depois desliga
    alarm[1] = 5; 
}

