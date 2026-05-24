if (instance_exists(obj_personagem)){
	 // Verifica se o jogador está em cima da plataforma
	 var _jogador_em_cima = place_meeting(x, y -4, obj_personagem);
	 
	  // Se a plataforma ainda NÃO começou a descer
	  if (!descendo) {
		  
		   // Se o jogador estiver em cima
		   if (_jogador_em_cima){
			   
			    // Aumenta o cronômetro
				timer_jogador++;
				
				// Se atingiu o tempo necessário
				if (timer_jogador >= tempo_para_descer){
					
					 // Começa a descida
					 descendo = true;
				}
		   } else {
			  
			  //se o jogador pular
			  timer_jogador = 0;
		   }
	  } else{
		  
		  // Guarda a velocidade de descida ( no caso 5 )
		   var _move_y = velocidade_descida;
		   
		    // Move o jogador junto com a plataforma
			 // somente se ele estiver em cima
			// e não estiver pulando
			if (_jogador_em_cima && obj_personagem.vveloc >= 0){
				
				// Entra no objeto jogador
				with (obj_personagem){
					 // Se não houver parede abaixo
					 if (!place_meeting(x, y + _move_y, obj_parede)){
						 
						  // Move o jogador para baixo
						  y += _move_y;
					 }
					
				}
				
			}
			
			  // Se não houver parede abaixo da plataforma
        if (!place_meeting(x, y + _move_y, obj_parede)) {

            // Move a plataforma para baixo
            y += _move_y;
        }
        
		   // Verifica se chegou ao limite máximo
		   if (y >= yorigem + limite_descida){
			   
			    // Trava a posição exatamente no limite
				y = yorigem + limite_descida;
					
				
		   }
	  }
}