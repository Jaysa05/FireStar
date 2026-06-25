/// @description Insert description here
// Verifica se o inimigo está vivo
if (other.vida > 0) {
    
    // IGNORA DANO POR CONTATO DIRETO COM O MONSTRO DE GELO
    // O jogador só toma dano pelos ataques telegrafados do próprio boss (gerenciados no Step dele)
    if (other.object_index == obj_mostro_gelo || object_is_ancestor(other.object_index, obj_mostro_gelo)) {
        exit;
    }
    
   // Verifica se quem causou o dano é o Minotauro
	// ou algum objeto que herda dele
	if (other.object_index == obj_minotauro || object_is_ancestor(other.object_index, obj_minotauro)){
		
		  // Verifica se o Minotauro está fazendo uma investida válida.
		// Para causar dano:
		// - O estado precisa ser "investida"
		// - A animação precisa estar entre os frames 4 e 12
		var _em_investida_valida = (other.estado == "investida" && other.image_index >= 4 && other.image_index<= 12);
		
		// Verifica se o Minotauro está fazendo uma machadada válida.
		// Para causar dano:
		// - O estado precisa ser "machadada"
		// - A animação precisa estar entre os frames 3 e 12
		var _em_machadada_valida = (other.estado == "machadada" && other.image_index >= 3 && other.image_index <= 12);
		
		 // Se NÃO estiver em uma investida válida
		// E também NÃO estiver em uma machadada válida
		// significa que o Minotauro não está realmente atacando.
		if (!_em_investida_valida && !_em_machadada_valida) {
			
			// Cancela o dano.
        // Ignora a colisão porque o ataque não está no momento certo.
		exit;
		}
	}
	
// ==========================================
// REGRA PARA A HITBOX DA MACHADADA DO MINOTAURO
// ==========================================

// Verifica se o dano veio especificamente da hitbox do machado
if ( other.object_index == obj_machadada) {
	
	// Procura o Minotauro que está na sala.
    // O número 0 pega a primeira instância encontrada.
	var _boss = instance_find(obj_minotauro, 0);
	
	 // Verifica se o Minotauro existe.
	 if (_boss != noone ) {
		 
		 // Confirma se a machadada está no momento correto.
        // Apenas os frames 3 até 12 da animação causam dano.
		var _frame_valido = (_boss.estado == "machadada" && _boss.image_index >= 3 && _boss.image_index <= 12);
		
		// Se a animação não está no momento do impacto,
        // ignora o dano.
		if (!_frame_valido) {
			
			exit;
		}
		
		 // Calcula o centro horizontal do corpo do Minotauro.
        // Usa a borda esquerda e direita da caixa de colisão.
		var _boss_center_x = (_boss.bbox_left + _boss.bbox_right) / 2;
		
		 // Calcula a distância entre o jogador e o centro do Minotauro.
		 var _dist_x = abs(x - _boss_center_x);
		 
		  // Verifica se o jogador está na frente do Minotauro.
        // Impede tomar dano estando atrás dele.
		var _in_front = (sign(x - _boss_center_x) == _boss.direct);
		
		 // Só permite dano se:
        // - O jogador estiver na frente
        // - A distância for menor ou igual a 90 pixels
        //
        // Se estiver atrás ou longe demais, cancela o dano.
		if (!_in_front || _dist_x >100){
			exit;
			
		}
	 }
}

	
// ==========================================
// REGRA PARA A HITBOX DA MACHADADA DO MINOTAURO
// ==========================================

// Verifica se o dano veio especificamente da hitbox do machado
if ( other.object_index == obj_machadada) {
	
	// Procura o Minotauro que está na sala.
    // O número 0 pega a primeira instância encontrada.
	var _boss = instance_find(obj_minotauro, 0);
	
	 // Verifica se o Minotauro existe.
	 if (_boss != noone ) {
		 
		 // Confirma se a machadada está no momento correto.
        // Apenas os frames 3 até 12 da animação causam dano.
		var _frame_valido = (_boss.estado == "machadada" && _boss.image_index >= 3 && _boss.image_index <= 12);
		
		// Se a animação não está no momento do impacto,
        // ignora o dano.
		if (!_frame_valido) {
			
			exit;
		}
		
		 // Calcula o centro horizontal do corpo do Minotauro.
        // Usa a borda esquerda e direita da caixa de colisão.
		var _boss_center_x = (_boss.bbox_left + _boss.bbox_right) / 2;
		
		 // Calcula a distância entre o jogador e o centro do Minotauro.
		 var _dist_x = abs(x - _boss_center_x);
		 
		  // Verifica se o jogador está na frente do Minotauro.
        // Impede tomar dano estando atrás dele.
		var _in_front = (sign(x - _boss_center_x) == _boss.direct);
		
		 // Só permite dano se:
        // - O jogador estiver na frente
        // - A distância for menor ou igual a 90 pixels
        //
        // Se estiver atrás ou longe demais, cancela o dano.
		if (!_in_front || _dist_x > 90){
			exit;
			
		}
	 }
}
    
    // VERIFICA SE ESTÁ PULANDO EM CIMA DO COELHO SALTITANTE
    if (other.object_index == obj_coelho_saltitante && vveloc > 0 && y < other.y) {
        
        other.vida = 0; // Mata o coelho
        vveloc = -forca_pulo; // Faz o personagem quicar para cima
        
        // Define o drop para ser 10 frutas na hora de morrer
        other.item_drop = obj_fruta;
        other.item_drop_quantidade = 10;
        
        exit; // Sai do código para que o personagem não tome dano!
    }

    // SISTEMA NORMAL DE TOMAR DANO
    if (alarm[0] <= 0) { //se o alarme estiver em 0 ou menor pode sofrer dano
        vida -= 1; //perde 1 vida
        alarm[0] = inv_tempo; // tempo sem poder sofrer dano
    }
}