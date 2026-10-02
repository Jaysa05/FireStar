/// @description Desenho do personagem com piscar de invencibilidade bem lento

// SE O PLAYER ESTIVER INVENCÍVEL (alarm[0] > 0)
if (alarm[0] > 0) {
    // Alterna a cada 20 frames (aprox 0,33s branco, 0,33s sprite normal)
    if ((alarm[0] div 20) % 2 == 0) {
        gpu_set_fog(true, c_white, 0, 0); // Fica branco
        draw_self();
        gpu_set_fog(false, c_white, 0, 0);
    } else {
        draw_self(); // Sprite normal
    }
} else {
    // Quando não está invencível, desenha o sprite normal 100% das vezes
    draw_self();
}

if (faca == true) {

    // Calcula a direção (ângulo) do personagem até o mouse
    var dir = point_direction(x, y - 8, mouse_x, mouse_y);
    
    // Calcula a posição da faca na mão do personagem
    var xx = lengthdir_x(13, dir);
    var yy = lengthdir_y(13, dir);

    // Define a escala Y para a faca não ficar de cabeça para baixo
    var _yscale = 1;
    if (dir > 90 && dir < 270) {
        _yscale = -1;
    }

    // Desenha a faca na mão do personagem
    draw_sprite_ext(spr_faca, 0, x + xx, y - 8 + yy, 1, _yscale, dir, c_white, 1);

    // Dispara a faca ao clicar com o botão esquerdo do mouse
    if (mouse_check_button_pressed(mb_left)) {

        var inst = instance_create_layer(x + xx, y - 8 + yy, "Instances_2", obj_faca);

        inst.melhoria = false;
        inst.direction = dir;
        inst.image_angle = dir;
        inst.image_yscale = _yscale;
        inst.speed = 8;

        faca_cargas -= 1;
    }

    if (faca_cargas <= 0) {
        faca = false;
    }
}
