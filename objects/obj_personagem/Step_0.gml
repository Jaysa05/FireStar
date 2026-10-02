// Executa o script armazenado na variavel "estado".
// Normalmente e usado para controlar comportamentos do objeto
// (andar, atacar, parado, etc.).
script_execute(estado);


// =====================================================
// SISTEMA DE BLOQUEIO DA PORTA DA DIREITA (FASE 5)
// =====================================================

// Verifica se o jogador esta na Fase 5.
if (room == rm_fase5) {
    
    // Executa o codigo para todas as portas de transicao da sala.
    with (obj_transicao) {
        
        // Verifica se esta e a porta da direita.
        // A porta da direita possui Y maior que 100.
        // A porta de cima possui Y negativo, entao sera ignorada.
        if (y > 100) {
            
            // Verifica se a variavel "parede_bloqueio"
            // ja existe nesta porta.
            if (!variable_instance_exists(id, "parede_bloqueio")) {
                
                // Cria a variavel e define que ela nao esta
                // apontando para nenhuma parede ainda.
                parede_bloqueio = noone;
            }
            
            // Verifica se o demonio ainda existe na sala.
            if (instance_exists(obj_demonio)) {
                
                // Se ainda nao existe uma parede criada...
                if (parede_bloqueio == noone) {
                    
                    // Cria uma parede invisivel exatamente na
                    // posicao da porta.
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
            
            // Se nao existe mais demonio...
            else {
                
                // Verifica se existe uma parede bloqueando a porta.
                if (parede_bloqueio != noone) {
                    
                    // Remove a parede invisivel.
                    instance_destroy(parede_bloqueio);
                    
                    // Limpa a referencia da variavel.
                    parede_bloqueio = noone;
                }
            }
        }
    }
}


// ----------------------------------------------------
// -----------------------------
// COLISAO COM A LAVA
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

	// se estiver totalmente visivel
	if (image_alpha >= 1){

		// comeca a ficar invisivel
		alfa_hit = -0.05;

	// se estiver invisivel
	}else if (image_alpha < 0){

		// comeca a ficar visivel novamente
		alfa_hit = 0.05;
	}

	// altera a transparencia do sprite
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

// Se a vida chegar a 0
if (vida <= 0 && !morreu) {
    morreu = true;
    
    // Se existir arquivo save.ini, recarrega os dados salvos para que o respawn seja fiel ao ultimo save
    if (file_exists("save.ini")) {
        ini_open("save.ini");
        global.checkpoint_ativo = ini_read_real("Checkpoint", "ativo", false);
        global.checkpoint_sala = ini_read_real("Checkpoint", "sala", room);
        global.checkpoint_x = ini_read_real("Checkpoint", "x", 0);
        global.checkpoint_y = ini_read_real("Checkpoint", "y", 0);
        global.vida_save = ini_read_real("Player", "vida", 5);
        global.faca_save = ini_read_real("Player", "faca", 0);
        global.faca_cargas_save = ini_read_real("Player", "faca_cargas", 0);
        global.frutas_save = ini_read_real("Player", "frutas", 0);
        ini_close();
    }
    
    vida = global.vida_save;
    faca = global.faca_save;
    faca_cargas = global.faca_cargas_save;
    frutas = global.frutas_save;
    room_goto(rm_gameover);
}

// -----------------------------------------------------------------------------
// SISTEMA DE INVENCIBILIDADE E PISCAR
// -----------------------------------------------------------------------------
if (invencivel) {
    timer_invencibilidade--;
    
    // Faz o personagem piscar alternando a transparencia a cada 4 frames
    if ((timer_invencibilidade div 4) % 2 == 0) {
        image_alpha = 1;    // Visivel
    } else {
        image_alpha = 0.2;  // Quase invisivel (piscando)
    }
    
    // Quando o tempo acabar
    if (timer_invencibilidade <= 0) {
        invencivel = false;
        image_alpha = 1;    // Garante que o personagem volte a ficar 100% visivel
    }
}
if (keyboard_check_pressed(vk_enter)) {
    atacando = true; // O personagem entra no modo de ataque
    
    // O ataque vai durar um tempo curtinho (ex: 20 frames) e depois desliga
    alarm[1] = 5; 
}
