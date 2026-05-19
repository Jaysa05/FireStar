/// @description Insert description here
// Se o checkpoint ainda NÃO foi ativado
if (!ativado) {
	// Verifica se o jogador está encostando no checkpoint
	if (place_meeting(x, y, obj_personagem)){
		// Marca que o checkpoint já foi ativado (não ativa de novo)
		ativado = true;
		
		  // -------- SALVA DADOS DO CHECKPOINT --------
		 // Diz que existe um checkpoint ativo
		 global.checkpoint_ativo = true;
		 
		  // Salva em qual sala (fase) o checkpoint está
		  global.checkpoint_sala = room;
		  
		  // Salva a posição X do checkpoint
		  global.checkpoint_x = x;
		  
		   // Salva a posição Y do checkpoint
		   global.checkpoint_y = y;
		   
		   // -------- SALVA DADOS DO JOGADOR --------
		   
		   // Acessa o objeto do jogador
		   with (obj_personagem){
			   // Salva a vida atual do jogador
			   global.vida_save = vida;
			   
			   // Salva se o jogador tem faca
			   global.faca_save = faca;
			   
			   // Salva quantas cargas de faca ele tem
			   global.faca_cargas_save = faca_cargas;
			   
			   // Salva quantas frutas o jogador tem
			   global.frutas_save = frutas;
		   }
		   
		   // Remove o sprite do checkpoint (faz a bandeira sumir)
		   sprite_index = -1;
		   
		   // Inicia um contador de tempo (timer)
        // 120 frames = 3 segundos (se o jogo roda a 60 FPS)
		//É o tempo que o texto ficarána tela
		timer_texto = 60;
	}
}

		// -------- CONTADOR DO TEXTO --------
		// Se o tempo ainda não acabou
		if (timer_texto > 0){
			// Diminui o tempo a cada frame
			timer_texto--;
		}
