// ==============================
// SISTEMA DE MORTE DO INIMIGO
// ==============================

// 1. Verifica se o inimigo morreu (vida chegou a 0 ou menos)
if (vida <= 0){
	
	// 2. Só executa essa parte se o alarm[1] NÃO estiver ativo ainda
    // (isso evita criar frutas várias vezes)
	if (alarm[1] <= 0) {
		
		// 3. Ativa um pequeno tempo (20 frames ≈ 0,3 segundos)
        // Serve como um "bloqueio" para não repetir o drop
		alarm[1] = 20;
		
		// ==============================
        // 4. SISTEMA DE DROP (FRUTAS)
        // ==============================
		
		for( var i = 0; i < 10; i++){
			
			 // Cria uma posição X aleatória perto do inimigo
			 var _x_fruta = x + random_range(-25, 25);
			 
			 // Cria uma posição Y aleatória (um pouco acima do inimigo)
			 var _y_fruta = y + random_range(-25, 0);
			 
             // SISTEMA DE SEGURANÇA CONTRA PAREDES:
             // puxamos a fruta de volta para o centro do inimigo!
             if (position_meeting(_x_fruta, _y_fruta, obj_parede)) {
                 _x_fruta = x + random_range(-5, 5);
                 _y_fruta = y - 15;
             }
             
			 // Cria a fruta na tela nessa posição
			 instance_create_layer(_x_fruta, _y_fruta, layer, obj_fruta);
		}
		
		// ==============================
	}
	// 5. Aumenta a velocidade da animação (ex: animação de morte)
	image_speed = 3;
	
	 // 6. Executa também o código do objeto pai (herança)
	 event_inherited();
	 
	 // 7. Para o resto do código daqui pra frente
    // (evita bugs depois da morte)
	exit;
}

// 2. CONTINUA O RESTO (Só se estiver viva):
event_inherited();

if (floor(image_index) == 4 && !atirou) {
	// Cria a semente um pouco à frente (direita) e um pouco acima do objeto
	var _semente = instance_create_layer(x + 30, y - 15, "colisao_2", obj_semente_atiravel);
	_semente.hspeed = 2;
	atirou = true;
}

if (floor(image_index) != 4) {
	atirou = false;
}