
event_inherited();

if vida > 0 {

    // -----------------------------
    // Movimentação para a direita
    // -----------------------------
    if direct == 0 {

        if place_meeting(x + veloc, y, obj_parede_inimigo){
            direct = 1;
        } else {
            x += veloc;
        }

        sprite_index = spr_cebola_andando_direita;
    }

    // -----------------------------
    // Movimentação para a esquerda
    // -----------------------------
    else if direct == 1 {

        if place_meeting(x - veloc, y, obj_parede_inimigo){
            direct = 0;
        } else {
            x -= veloc;
        }

        sprite_index = spr_cebola_andando_esquerda;
    }

    // -----------------------------
    // -----------------------------
    if vida <= 0 {
        instance_destroy();
    }
}