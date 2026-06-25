/// @description Comportamento do Minotauro
event_inherited(); // Executa primeiro o código do objeto pai
// Se a vida chegou a 0 ou menos, para tudo
if (vida <= 0){
	image_blend = c_white; // Remove a cor verde/lima ao morrer
	visible = true; // Garante que ele fique visível para tocar a animação de morte!
	exit;
}

// ====================================================
// NOVO: SISTEMA DE VULNERABILIDADE CÍCLICA
// ====================================================

// Se ainda existe tempo no cronômetro
if (timer_vulnerabilidade > 0){
	
	 // Diminui 1 frame do tempo restante
	 timer_vulnerabilidade -=1;
}
else {
	
	 // Quando o cronômetro chega a 0
	 if (vulneravel){
		 
		  // Se ele podia levar dano,
        // agora fica invencível
		vulneravel = false;
		
		// Fica invencível por 300 frames
        // (5 segundos em 60 FPS)
		timer_vulnerabilidade = 300;
	 }
	 
	 else{
		 
		  // Se ele estava invencível,
        // agora pode levar dano
		vulneravel = true;
		
		 // Fica vulnerável por 180 frames
        // (3 segundos em 60 FPS)
		timer_vulnerabilidade = 180;
		 
	 }
	
}

// Verifica se o minotauro está preso em alguma parede ou plataforma
var _chao_atual = place_meeting(x, y, obj_parede) || 
                  place_meeting(x, y, obj_plataforma_fase2) || 
                  place_meeting(x, y, obj_plataforma) || 
                  place_meeting(x, y, obj_plataforma2);

// Se estiver preso
if (_chao_atual){
	
	 // Procura um espaço livre até 32 pixels acima
	 for (var i = 1; i <= 32; i++){
		 
		 // Se encontrou uma posição sem colisão
        if (!place_meeting(x, y - i, obj_parede) && 
            !place_meeting(x, y - i, obj_plataforma_fase2) && 
            !place_meeting(x, y - i, obj_plataforma) && 
            !place_meeting(x, y - i, obj_plataforma2)) {
				
			 // Move o minotauro para cima
			 y -= i;
			  // Para de procurar
			  break;
			 
			}
		 
	 }
}

// Aplica a gravidade aumentando a velocidade vertical
vveloc += gravidade;

// Só executa a IA se o jogador existir
if (instance_exists(obj_personagem)){
	
	// Calcula o centro horizontal do minotauro
	var _minotauro_centro = (bbox_left + bbox_right) / 2;
	
	// Distância horizontal até o jogador
	var _dif_x = obj_personagem.x - _minotauro_centro;
	
	// Distância sem sinal (sempre positiva)
	var _dist_h = abs(_dif_x);
	
	 // Se a investida estiver recarregando
	 if (cooldown_investida > 0){
		 
		  // Diminui o tempo restante do cooldown
		  cooldown_investida -=1;
		 
	 }
    
    // Estados do minotauro
    switch (estado) {
        // ==========================================
        // ESTADO: PERSEGUIÇÃO
        // ==========================================
        
		// Executa este bloco quando o minotauro está perseguindo o jogador
		case "chase":
		
		 // Mantém o sprite na escala normal
		 image_xscale = 1;
		 
		 // Se o jogador estiver a mais de 60 pixels
		 if (_dist_h > 60) {
			 
			 // Descobre se o jogador está à esquerda ou à direita
			 direct = sign(_dif_x);
			 
			 // Move o minotauro na direção do jogador
			 hveloc = direct * veloc_chase;
			 
			  // Escolhe a animação correta
			  if (direct == 1){
				  sprite_index = sprite_andando_dir;
				  
			  }
			 else {
				 sprite_index = sprite_andando_esq;
			 }
		 }
		 else {
			 
			 // Se estiver perto do jogador, para de andar
			 hveloc = 0;
			 
			  // Usa a animação parado
			  sprite_index = sprite_idle; 
		 }
		 
		  // Verifica se pode iniciar a preparação da investida
		  if (cooldown_investida <= 0 && _dist_h <= 200 && _dist_h > 40 ) {
			  
			   // Troca para o estado de preparação
			   estado = "prepara_investida";
			   
			    // Tempo de preparação (Aumentado para 80 frames / 1.33s para ser mais justo)
				timer_estado = 80;
				
				 // Para de andar
				 hveloc = 0;
		  }
		  
		  break;

        // ==========================================
        // ESTADO: PREPARAÇÃO DA INVESTIDA
        // ==========================================
       
	    // Estado em que o minotauro está carregando o ataque
		case "prepara_investida":
		
			// Mantém a escala normal do sprite
			image_xscale = 1;
			
			// Diminui o cronômetro em 1 frame
			timer_estado -= 1;
			
			 // Continua parado
			 hveloc = 0;
			 
			 // Continua olhando para o jogador
			 direct = sign(_dif_x);
			 
			  // Se não existir direção, assume direita
			  if (direct == 0)
				direct = 1;
				
			 // Usa animação parado
			 sprite_index = sprite_idle;
			 
			 // Quando o cronômetro terminar
			 if (timer_estado <= 0){
				 
				// Verifica qual será o próximo ataque do inimigo.
				// 0 = investida
				// 1 = girador
				// 2 = machadada (último golpe)
				if (proximo_ataque == 0) {
					
					// ----------------------------------------------------
					// ATAQUE 0: INVESTIDA
					// ----------------------------------------------------
					
					// Muda o estado do inimigo para "investida".
					// Isso faz o inimigo executar o comportamento desse ataque.
					estado = "investida";
					
					// Troca o sprite para a animação da investida
					sprite_index = sprite_investida;
					
					// Reinicia a animação começando pelo primeiro frame.
					image_index = 0;
					
					// Troca a máscara de colisão.
					// Usa a área do sprite da investida para que o golpe
					// consiga alcançar o jogador.
					mask_index = sprite_investida;
					
					// Define quanto tempo a investida vai durar.
					// O valor representa quantidade de frames.
					timer_estado = 60;
					
					// Depois da investida, o próximo ataque será o girador.
					proximo_ataque = 1;
				}
				
				else if (proximo_ataque == 1) {
					
					// ----------------------------------------------------
					// ATAQUE 1: GOLPE GIRADOR
					// ----------------------------------------------------
					
					// Muda o estado do inimigo para o ataque girador
					estado = "girador";
					
					// Usa o sprite parado porque o ataque girador
					// será criado por outro objeto separado.
					sprite_index = sprite_idle;
					
					// Reinicia a animação.
					image_index = 0;
					
					// Esconde o corpo do Minotauro durante o giro.
					// Assim aparece somente o objeto do golpe girador.
					visible = false;
					
					// Define a duração do ataque girador
					timer_estado = 45;
					
					// ----------------------------------------------------
					// CRIA O OBJETO DO ATAQUE GIRATÓRIO
					// ----------------------------------------------------
					
					// Guarda a posição X atual do Minotauro.
					// Esse será o ponto inicial onde o ataque nascerá.
					var _spawn_x = x;
					
					// Verifica se o Minotauro está olhando para esquerda.
					// direct == -1 significa esquerda.
					if (direct == -1) {
						
						// Ajusta a posição do golpe para aparecer
						// no lado correto do personagem.
						_spawn_x = x + sprite_get_width(sprite_index);
					}
					
					// Cria uma instância do objeto responsável pelo golpe giratório.
					//
					// _spawn_x → posição horizontal
					// y → mesma altura do Minotauro
					// depth - 1 → fica desenhado atrás dele
					// obj_golpe_girador → objeto criado
					var _girador = instance_create_depth(
									_spawn_x,
									y,
									depth - 1,
									obj_golpe_girador);
									
					// Verifica se o objeto foi criado corretamente.
					if (_girador != noone){
						
						// Faz o golpe giratório seguir a mesma direção
						// que o Minotauro está olhando.
						//
						// 1 = direita
						// -1 = esquerda
						_girador.image_xscale = direct;
					}
					
					// Depois do golpe girador, o próximo ataque será o da machadada.
					proximo_ataque = 2;
				}
				
				else {
					
					// ----------------------------------------------------
					// ATAQUE 2: GOLPE DA MACHADADA (ÚLTIMO GOLPE)
					// ----------------------------------------------------
					
					// Muda o estado do inimigo para a machadada
					estado = "machadada";
					
					// Usa o sprite da machadada diretamente no Minotauro
					sprite_index = spr_machadada;
					
					// Trava a máscara de colisão física no corpo normal para evitar que ele mude de tamanho e pule!
					mask_index = spr_minotauro;
					
					// Reinicia a animação.
					image_index = 0;
					
					// Garante que o Minotauro continue visível
					visible = true;
					
					// Define a duração da machadada
					timer_estado = 45;
					
					// ----------------------------------------------------
					// CRIA A HITBOX INVISÍVEL DA MACHADADA
					// ----------------------------------------------------
					var _spawn_x = x;
					var _hitbox_xscale = 1;
					
					// Se o Minotauro está olhando para a direita, ajusta a posição e espelha a hitbox
					if (direct == 1) {
						_spawn_x = x + sprite_get_width(sprite_index);
						_hitbox_xscale = -1;
					}
					
					// Cria a hitbox invisível
					var _machadada = instance_create_depth(
									_spawn_x,
									y,
									depth - 1,
									obj_machadada);
									
					if (_machadada != noone){
						_machadada.image_xscale = _hitbox_xscale;
					}
					
					// Reseta o ciclo de ataques voltando para a investida.
					proximo_ataque = 0;
				}
			 }
			 
			 break;
			 
		// ==========================================
		// ESTADO: INVESTIDA CORTANTE
		// ==========================================
		case "investida":

		 // Mantém o sprite com escala normal
			// evitando problemas visuais e de colisão
			image_xscale = 1;
			
			 // Diminui o cronômetro da investida
			 timer_estado -= 1;
			 
			 // Durante o ataque o minotauro fica parado
			 hveloc = 0;
			 
			 // Usa a animação de investida
			 sprite_index = sprite_investida;
			 
			  // Quando o tempo da investida acabar
			  if (timer_estado <= 0) {
				  
				  // Entra no estado de cansaço
				   estado = "exhausted";
				   mask_index = spr_minotauro; // Reseta a caixa de colisão para a do corpo normal
				   
				    // Fica cansado por 120 frames
					 // (aproximadamente 2 segundos)
					 timer_estado = 120;
					 
					 // Continua parado ao entrar no cansaço
					 hveloc = 0;
			  }
			  
			  break;

            
        
        // ==========================================
        // ESTADO: ATAQUE 1 (GOLPE GIRADOR)
        // ==========================================
        case "girador":
            hveloc = 0;
            image_xscale = 1;
			
			// Decrementa o tempo do estado
			timer_estado -= 1;
			
			// Se o tempo de ataque acabou, entra em cansaço
			if (timer_estado <= 0) {
				estado = "exhausted";
				visible = true; // Torna o Minotauro visível novamente ao fim do ataque
				timer_estado = 90; // Cansaço um pouco menor (1.5 segundos)
				hveloc = 0;
			}
            break;
            
       // ==========================================
		// ESTADO: GOLPE DA MACHADADA (ÚLTIMO GOLPE)
		// ==========================================
		
		case "machadada":
		
		// Enquanto o Minotauro está dando a machadada,
		// ele não pode andar. Zera a velocidade horizontal.
		hveloc = 0;
		
		// Define que o sprite não está invertido.
		// 1 = direção normal
		// -1 = sprite espelhado para o outro lado
		image_xscale = 1;
		
		// Verifica se a animação da machadada terminou.
		// Essa função provavelmente retorna TRUE quando
		// chega no último frame do sprite.
		if (scr_fim_da_animacao()) {
			
			// Troca o estado do personagem.
			// Sai do ataque e entra no estado de cansaço.
			estado = "exhausted";
			
			 // Troca a animação para o sprite parado.
			// O Minotauro deixa de fazer a machadada.
			sprite_index = sprite_idle;
			
			 // Volta a máscara de colisão para o tamanho normal do corpo.
			// Durante o ataque ela pode ser diferente.
			mask_index = spr_minotauro;
			
			 // Garante que o personagem continue aparecendo na tela.
			 visible = true;
			 
			  // Define quanto tempo ele ficará cansado.
			// 90 frames = aproximadamente 1,5 segundos
			// em um jogo rodando a 60 FPS.
			timer_estado = 90;
			
			// Garante novamente que ele não está se movendo.
			hveloc = 0;
		}
		
		// Encerra esse estado.
		// Impede que o código continue executando outros estados.
		
		break;
       
		// ==========================================
		// ESTADO: EXHAUSTED / CANSAÇO
		// ==========================================
		case "exhausted":

		 // Mantém o sprite na escala normal
		 image_xscale = 1;
		 
		 // Diminui o cronômetro do estado de cansaço
		 timer_estado -= 1;
		 
		 // Mantém o minotauro parado
		 hveloc = 0;
		 
		  // Usa a animação de parado/descanso
		  sprite_index = sprite_idle;
		  
		   // Quando o tempo de cansaço terminar
		   if (timer_estado <= 0){
			   
				// Volta ao estado de perseguição
				estado = "chase";
				
				  // Define um cooldown de 3 segundos
				// antes de poder usar outra investida
				cooldown_investida = 180;
		   }
		   
		   break;
	}
	
}
else {
	
	 // Caso não exista jogador na sala
	  // Não se move
	  // Usa a animação parado
    sprite_index = sprite_idle;

    // Mantém a escala normal do sprite
    image_xscale = 1;
	  

}

// ====================================================
// DETECÇÃO DE COLISÕES
// ====================================================


// ====================================================
// COLISÃO HORIZONTAL (ESQUERDA / DIREITA)
// ====================================================

// Verifica se o objeto vai bater em uma parede ou cerca inimiga
// antes de mover.
// x + hveloc = posição que ele tentaria ir.
var _colidiu_h = place_meeting(x + hveloc, y, obj_parede) || 
                 place_meeting(x + hveloc, y, obj_parede_inimigo);


if (_colidiu_h) {

    // Descobre qual objeto causou a colisão.
    // O operador ? funciona como:
    // "se for parede, usa parede; senão usa cerca inimiga"
    var _obj_colisao = place_meeting(x + hveloc, y, obj_parede) 
                       ? obj_parede 
                       : obj_parede_inimigo;


    // Move o objeto 1 pixel por vez até ficar encostado
    // na parede.
    // Isso evita atravessar a parede quando a velocidade
    // é muito alta.
    while (!place_meeting(x + sign(hveloc), y, _obj_colisao)) {

        // Anda na direção horizontal:
        // direita = +1
        // esquerda = -1
        x += sign(hveloc);
    }


    // Para o movimento horizontal
    // porque encontrou uma parede.
    hveloc = 0;
}


// Aplica o movimento horizontal normalmente
x += hveloc;





// ====================================================
// COLISÃO VERTICAL COM PAREDES SÓLIDAS
// ====================================================


// Verifica se vai bater em uma parede ao cair ou subir.
if (place_meeting(x, y + vveloc, obj_parede)) {


    // Aproxima o objeto da parede vertical
    // pixel por pixel até encostar.
    while (!place_meeting(x, y + sign(vveloc), obj_parede)) {


        // Move para cima ou para baixo:
        //
        // vveloc positivo = descendo
        // vveloc negativo = subindo
        y += sign(vveloc); 
    }


    // Cancela a velocidade vertical.
    // Impede continuar atravessando a parede.
    vveloc = 0;
}





// ====================================================
// COLISÃO COM PLATAFORMAS UNIDIRECIONAIS
// ====================================================


// Procura uma plataforma exatamente na posição
// onde o objeto vai cair.
var _plat = instance_place(x, y + vveloc, obj_plataforma_fase2);


// Se não encontrou a primeira plataforma,
// procura na próxima.
if (_plat == noone) 
    _plat = instance_place(x, y + vveloc, obj_plataforma);


// Se ainda não encontrou,
// procura na terceira.
if (_plat == noone) 
    _plat = instance_place(x, y + vveloc, obj_plataforma2);





// Se encontrou alguma plataforma
if (_plat != noone) {


    // Só deixa colidir se:
    //
    // 1 - O objeto estiver caindo
    // vveloc > 0
    //
    // 2 - Os pés do objeto estiverem próximos
    // do topo da plataforma.
    //
    // Isso faz a plataforma ser "atravessável por baixo".
    if (vveloc > 0 && bbox_bottom <= _plat.bbox_top + 4) {



        // Move o objeto até encostar na plataforma
        // sem atravessar.
        while (!place_meeting(x, y + sign(vveloc), _plat)) {


            // Desce ou sobe 1 pixel por vez.
            y += sign(vveloc);
        }


        // Para a queda.
        // O personagem ficou em cima da plataforma.
        vveloc = 0;
    }
}

// Aplica finalmente o movimento vertical
y += vveloc;

// ====================================================
// NOVO: CONTROLE DE COR E FEEDBACK VISUAL
// ====================================================
if (vulneravel) {
    image_blend = c_lime; // Pintado de verde/lima para mostrar que está vulnerável a ataques!
} else {
    if (estado == "prepara_investida") {
        image_blend = c_red; // Pisca em vermelho para alertar a preparação do ataque!
    } else {
        image_blend = c_white; // Cor branca normal (quando está invulnerável)
    }
}
