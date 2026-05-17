/// @description Executa estado e efeitos temporários
script_execute(estado);

// Efeito visual de piscar ao receber dano (invencibilidade ativa)
if (alarm[0] > 0) {
    if (image_alpha >= 1) {
        alfa_hit = -0.05;
    } else if (image_alpha < 0) {
        alfa_hit = 0.05;
    }
    image_alpha += alfa_hit;
} else {
    image_alpha = 1; // Restaura opacidade quando o alarme expira
}

// Depth sorting para efeito de perspectiva
depth = -bbox_bottom;

// Sistema de Derrota e Renascimento
if (vida <= 0 && !morreu) {
    morreu = true;
    
    // Se houver um checkpoint ativo, resetamos o progresso temporário
    if (variable_global_exists("checkpoint_ativo")) {
        global.vida_save = 5;
        global.faca_save = 0;
        global.faca_cargas_save = 0;
        global.frutas_save = 0;
        global.inv_save = 0;
    }
    
    vida = global.vida_save;
    faca = global.faca_save;
    faca_cargas = global.faca_cargas_save;
    frutas = global.frutas_save;
    room_goto(rm_gameover);
}