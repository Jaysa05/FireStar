// Se o timer ainda não chegou a zero
if (timer_tiro > 0) {
	
	// Diminui o timer a cada frame
	timer_tiro--;
}
else{
	
	if (instance_exists(obj_personagem)){
	 // Verifica se o jogador está
     // dentro do alcance do inimigo
	 if (distance_to_object(obj_personagem) < 450) {
		 
		 var _fogo = instance_create_layer( x,y,layer, obj_fogo);
		 // Calcula direção exata até o jogador
		 var _dir_perfeita = point_direction( x, y, obj_personagem.x, obj_personagem.y);
		 
		  // Adiciona erro aleatório na mira
          // entre -15 e +15 graus
		  var _dir_com_desvio = _dir_perfeita + random_range(-15, 15);
		  
		   // Define direção da bola de fogo
		   _fogo.direction = _dir_com_desvio;
		   
		    // Define velocidade do disparo
			_fogo.speed = 3.5;
			
			 // Faz a imagem acompanhar direção
			 _fogo.image_angle = _dir_com_desvio;
			 
			  // Reinicia timer para próximo tiro
			  timer_tiro = tempo_tiro_max;
		}
	 }
}

