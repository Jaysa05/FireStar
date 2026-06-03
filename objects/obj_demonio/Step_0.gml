// Executa primeiro o código do objeto pai (vida, dano, animações, etc.)
event_inherited();

// Só executa os ataques e movimentações se o chefe estiver vivo
if (vida > 0 ) {
	
	// Máquina de estados responsável por controlar o comportamento do chefe
	switch (estado_voo) {
		
		 // ====================================================
        // ESTADO: CHÃO
        // ====================================================
		case "CHAO":
		
		 // ------------------------------
            // SISTEMA DE TIRO NO CHÃO
            // ------------------------------
			
			 // Se o tempo de recarga ainda não terminou
			 if (timer_tiro > 0) {
				 
				 // Diminui o contador a cada frame
				 timer_tiro--;
				 
			 }
				else {
					
					// Verifica se o jogador existe
					if (instance_exists(obj_personagem)){
						
						 // Só atira se o jogador estiver dentro do alcance
						 if (distance_to_object(obj_personagem) < 450 ){
							 
							  // Cria a bola de fogo próxima à boca do demônio
							  var _fogo = instance_create_depth(
							  x + offset_x_tiro
							  , y + offset_y_tiro,
							  depth -10,
							  obj_fogo);
								
								// Descobre a direção exata até o jogador
								var _dir_perfeita = point_direction(
								x+ offset_x_tiro,
								y + offset_y_tiro,
								obj_personagem.x,
								obj_personagem.y);
								
								// Adiciona um pequeno erro aleatório na mira
								var _dir_com_desvio = _dir_perfeita + irandom_range(-margem_erro_tiro, margem_erro_tiro);
								
								// Configura o projétil recém-criado
								with(_fogo) {
									
									 // Faz o sprite olhar para a direção do disparo
									 image_angle = _dir_com_desvio;
									 
									 // Define a direção de movimento
									 direction = _dir_com_desvio;
									 
									  // Define a velocidade da bola de fogo
									  speed = 5;
								}
									  
									   // Reinicia o tempo de recarga do próximo tiro
									 // 90 frames ≈ 1,5 segundos
									 timer_tiro = 90;
						
								}
							 
						 }
					
					}
					
					 // ------------------------------
				// CONTROLE DE VOO
				// ------------------------------
				
				 // Conta o tempo que o chefe fica no chão
				 timer_voo--;
				 
				  // Quando o tempo acabar, começa a subir
				  if (timer_voo <= 0) {
					  estado_voo = "SUBINDO";
				  }
				  break;
				  
				  
				   // ====================================================
        // ESTADO: SUBINDO
        // ====================================================
		case "SUBINDO":
		
		// Move o chefe para cima
		y -=velocidade_voo;
		
		 // Quando atingir a altura máxima
		 if (y <= y_alto){
			 
			  // Corrige a posição exata
			  y = y_alto;
			  
			  // Muda para o estado de voo
			  estado_voo = "NO_AR";
			  
			  // Permanece 3 segundos no alto
			  timer_voo = 180;
		 }
			break;
        
			// ====================================================
			// ESTADO: NO AR
			// ====================================================	
			
			case "NO_AR":
			
				 // ------------------------------
				// SISTEMA DE TIRO NO AR
				// ------------------------------
				
				// Aguarda o tempo de recarga
				if (timer_tiro > 0) {
					timer_tiro--;
				}
				else {
					
					 // Verifica se o jogador existe
					 if (instance_exists(obj_personagem)){
						 
						 // Alcance aumentado enquanto está voando
						 if ( distance_to_object(obj_personagem) < 600){
							 
							 // Cria a bola de fogo
							 var _fogo = instance_create_depth(
							 x + offset_x_tiro,
							 y + offset_y_tiro,
							 depth -10,
							 obj_fogo);
							 
							 // Calcula a direção exata do jogador
        				var _dir_perfeita = point_direction(
                            x + offset_x_tiro,
                            y + offset_y_tiro,
                            obj_personagem.x,
                            obj_personagem.y
                        );
        				
        				// Adiciona erro aleatório à mira
        				var _dir_com_desvio = _dir_perfeita + random_range(
                            -margem_erro_tiro,
                             margem_erro_tiro
                        );
        					
    					// Configura o projétil
    					with(_fogo) {
                            
                            // Rotaciona o sprite
    						image_angle = _dir_com_desvio;
                            
                            // Define direção de movimento
    						direction = _dir_com_desvio;
                            
                            // Define velocidade
    						speed = 5;
                        }
                         
                        // Espera 1,5 segundos até o próximo disparo
                        timer_tiro = 90;
						 }
					 }
					
				}
			
				   // ------------------------------
            // TEMPO DE PERMANÊNCIA NO AR
            // ------------------------------
			
			 // Conta o tempo que ficará voando
			 timer_voo --;
			 
			 // Quando o tempo acabar, começa a descer
			 if (timer_voo <= 0) {
				estado_voo = "DESCENDO" 
			 }
            break;
			
			// ====================================================
			// ESTADO: DESCENDO
			// ====================================================
			case "DESCENDO":
			
				// Move o inimigo para baixo
				y +=velocidade_voo;
				
				// Quando atingir o chão
				if (y >= y_original){
					 // Corrige a posição exata
					 y = y_original;
					 
					 // Retorna ao estado inicial
					 estado_voo = "CHAO";
					 
					  // Permanece mais 3 segundos no chão
					  timer_voo = 180;
					 	 
				}
				break;
				  
	}
}
				
	
