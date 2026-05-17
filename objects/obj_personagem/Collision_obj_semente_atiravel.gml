if alarm[0] <= 0 {
	 vida -= 1;
	 // Ativa o tempo de invencibilidade (define um valor para o alarm[0])
    // Durante esse tempo, o personagem não poderá levar dano novamente
	alarm[0] = inv_tempo;
}

with (other){
	// Destrói o outro objeto (faz a semente desaparecer da tela)
	instance_destroy()
}
