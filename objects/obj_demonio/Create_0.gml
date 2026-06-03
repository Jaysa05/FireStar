/// @description Insert description here
// Tempo total de espera entre um tiro e outro (180 frames = 3 segundos a 60 FPS)
event_inherited();
tempo_tiro_max = 180; 

// Timer que vai contar o tempo no Step
timer_tiro = tempo_tiro_max;

// Profundidade ajustada para -10 (Valores muito baixos como -99999 quebram o Fog no GameMaker!)
depth = -10;

vida = 8;

// Margem de erro (desvio) do tiro em graus. 
// 15 significa que o tiro pode sair até 15 graus para cima ou para baixo do jogador
margem_erro_tiro = 15;

// === POSIÇÃO DA BOCA PARA O TIRO ===
// Ajuste esses valores para que a bola de fogo saia exatamente da boca
offset_x_tiro = -25;  // Coloquei negativo para a bola nascer mais para a esquerda (boca)
offset_y_tiro = -25; // Coloquei -25 (em vez de -50) para a bola nascer mais para baixo (boca)

tomou_dano = false;

// Define a animação de morte específica do demônio para o objeto Pai usar!
sprite_morrendo = spr_demonio_morrendo;

// --- VARIÁVEIS DE VOO ---
estado_voo = "CHAO"; // Estados: "CHAO", "SUBINDO", "NO_AR", "DESCENDO"
timer_voo = 180; // Timer de 3 segundos (60 FPS * 3 = 180)
y_original = y;  // Guarda a posição Y do chão para saber pra onde voltar
y_alto = y - 100; // Ponto alto que ele vai voar (100 pixels para cima, no topo da tela)
velocidade_voo = 5; // Velocidade que ele sobe e desce

// O demônio não dropa nenhum item quando morre!
item_drop = noone;

// Verifica se já existe uma barra de vida do chefe na sala.
// O símbolo "!" significa NÃO.
// Então a condição é:
// "Se NÃO existir uma barra de vida do chefe..."
if (!instance_exists(obj_chefe_hud_vida)){
	 // Cria a barra de vida do chefe.
    // x, y = posição atual do chefe.
    // depth - 1 = desenha a barra na frente do chefe.
    // obj_chefe_hud_vida = objeto da barra de vida.
	instance_create_depth(x, y, depth -10 , obj_chefe_hud_vida);
}
