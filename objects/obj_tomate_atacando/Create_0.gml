/// @description Insert description here
// Define o alarme 0 para 50 frames
// Esse alarme define qual momento do frame pegar
alarm[0] = 50;

// Chama o conteúdo do evento do objeto pai (parente_inimigo)
// Permite que o objeto herde comportamentos já definidos no parente, como movimentação ou lógica de colisão
event_inherited();

// Define o sprite de morte específico deste inimigo
// Assim, cada inimigo pode ter sua própria animação de morte, mesmo usando o mesmo código de destruição
sprite_morrendo = spr_tomate_morrendo; //sprite de quando o tomate morre

item_drop = noone; // Todos os tomates vão nascer sem dropar nada.