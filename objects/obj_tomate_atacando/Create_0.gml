// Esse alarme define qual momento do frame pegar
alarm[0] = 50;

// Permite que o objeto herde comportamentos já definidos no parente, como movimentação ou lógica de colisão
event_inherited();

// Assim, cada inimigo pode ter sua própria animação de morte, mesmo usando o mesmo código de destruição
sprite_morrendo = spr_tomate_morrendo;

item_drop = noone;