/// @description Insert description here

if melhoria == true {
	// Movimento senoidal (efeito de "flutuar")
	y = pontoy + sin(tempo * frequencia) * amplitude;

	// Avança o tempo a cada frame
	tempo++;
}

