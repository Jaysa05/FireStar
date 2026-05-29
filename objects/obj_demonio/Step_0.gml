// Se o timer ainda não chegou a zero
event_inherited();

// Só permite que ele ataque e faça as lógicas normais SE ESTIVER VIVO
if (vida > 0) {
    if (timer_tiro > 0) {
        // Diminui o timer a cada frame
        timer_tiro--;
    }
    else {
        if (instance_exists(obj_personagem)){
            // Verifica se o jogador está dentro do alcance do inimigo
            if (distance_to_object(obj_personagem) < 450) {
                 
               // Cria uma bola de fogo na posição configurada pela boca
				var _fogo = instance_create_depth(x + offset_x_tiro, y + offset_y_tiro, depth - 10, obj_fogo);
				
				// Calcula a direção EXATA do jogador a partir da boca
				var _dir_perfeita = point_direction(x + offset_x_tiro, y + offset_y_tiro, obj_personagem.x, obj_personagem.y);
				
				// Adiciona erro aleatório na mira
				// Isso evita que o inimigo acerte sempre
				// random_range sorteia um valor entre:
				// -margem_erro_tiro e +margem_erro_tiro
				var _dir_com_desvio = _dir_perfeita + random_range(
				-margem_erro_tiro, 
				 margem_erro_tiro
					);
					
					// WITH = mexe no objeto criado (_fogo)
					with(_fogo) {
						
						 // Gira a imagem do fogo
						 // para olhar para a direção do tiro
						 image_angle = _dir_com_desvio;
						 
						 // Define para onde o fogo vai andar
						 direction = _dir_com_desvio;
						 
						// Velocidade do fogo
					    // Quanto maior o número:
					    // mais rápido o tiro 
						speed = 5;					
                }
                 
                // Reinicia timer para próximo tiro (ajustado para 1 segundo e meio = 90 frames)
                timer_tiro = 90;
            }
        }
    }
}

// Verifica se a variável "vida" chegou a 0 ou menos (Inimigo morreu)
if (vida <= 0) {
    // Verifica se o sprite atual NÃO é o sprite de morte
    if (sprite_index != spr_demonio_morrendo){
        
        // Troca o sprite atual pelo sprite de morte
        sprite_index = spr_demonio_morrendo;
         
        // Faz a animação começar do frame 0 (primeiro frame)
        image_index = 0;
         
        // Define a velocidade básica do objeto como 0
        speed = 0;
        hveloc = 0;
        vveloc = 0;
    }
}
