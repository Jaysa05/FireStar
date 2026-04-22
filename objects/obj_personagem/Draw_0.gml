/// @description Insert description here
// Desenha o personagem na tela
draw_self();

// Se a faca estiver ativa
if (faca == true) {

    // Calcula a direção do personagem até o mouse
    var dir = point_direction(x, y, mouse_x, mouse_y);

    // Calcula um ponto 13 pixels à frente
    var xx = lengthdir_x(13, dir);
    var yy = lengthdir_y(13, dir);

    // Desenha a faca na mão do personagem, apontando para o mouse
    draw_sprite_ext(spr_faca, 0, x + xx, y - 8 + yy, 1, 1, dir, c_white, 1);

    // Se o botão esquerdo do mouse foi pressionado
    if (mouse_check_button_pressed(mb_left)) {

        // Cria a faca como objeto no jogo
        var inst = instance_create_layer(x + xx, y - 8 + yy, "Instances_2", obj_faca);

        // Define propriedades da faca criada
        inst.melhoria = false;     // sem melhoria
        inst.direction = dir;      // direção do movimento
        inst.image_angle = dir;    // rotação da sprite
        inst.speed = 8;            // velocidade

        // Diminui uma carga de faca
        faca_cargas -= 1;
    }

    // Se acabou as cargas
    if (faca_cargas <= 0) {

        // Desativa o uso da faca
        faca = false;
    }
}