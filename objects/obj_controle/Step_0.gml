/// @description Insert description here
// Primeiro, checamos se estamos na fase 3
if (room == rm_fase3){
	 // Se o tempo for maior que 0, vamos reduzindo ele
	 if(tempo_fase > 0 ){
		 // delta_time / 1000000 reduz o tempo perfeitamente em 1 segundo por tempo real
		 tempo_fase -= delta_time / 1000000;
	 }else {
		 // Quando o tempo zera, garantimos que ele trave no 0
		 tempo_espera = 0;
		 
		  // AQUI ESTÁ A PUNIÇÃO POR ACABAR O TEMPO:
        // Nesse exemplo, matamos o jogador fazendo a vida dele ir a zero.
		if (instance_exists(obj_personagem)){
			obj_personagem.vida = 0;
		}
	 }
}else {
	// Se não for a fase 3, nós garantimos que o tempo resete para 60
	tempo_fase = 60;
}
