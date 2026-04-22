/// @description Insert description here
// 1. Anda para a esquerda
x -= velocidade;

// 2. Se sair totalmente da tela pela esquerda
if (x < -100) {
	 // 3. Teletransporta CADA fantasma de volta para o *seu* ponto de início!
	 x = posicao_inicial_x;
}
