/// @description Insert description here
// ==============================
// SISTEMA DE MORTE DO INIMIGO
// ==============================

// 1. Verifica se o inimigo morreu (vida chegou a 0 ou menos)
if (vida <= 0){
	// 2. Aumenta a velocidade da animação (ex: animação de morte)
	image_speed = 3;
	
	 // 3. Executa também o código do objeto pai (herança)
	 event_inherited();
	 
	 // 4. Para o resto do código daqui pra frente (evita bugs depois da morte)
	 exit;
}

// 2. CONTINUA O RESTO (Só se estiver viva):
event_inherited();


// Se estiver no frame 4 da animação E ainda não tiver atirado
if (floor(image_index) == 4 && !atirou) {
	// Cria a semente um pouco à frente (direita) e um pouco acima do objeto
	var _semente = instance_create_layer(x + 30, y - 15, "colisao_2", obj_semente_atiravel);
	// Define a velocidade horizontal da semente (vai para a direita)
	_semente.hspeed = 2;
	// Marca que já atirou, para não repetir no mesmo frame
	atirou = true;
}

// Se NÃO estiver no frame 4
if (floor(image_index) != 4) {
	// Reseta a variável para permitir atirar novamente
	atirou = false;
}