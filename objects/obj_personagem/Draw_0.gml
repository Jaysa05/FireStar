// Desenha o personagem na tela
draw_self();

if (faca == true) {

// (x, y - 8) é o ponto de origem (um pouco acima do personagem, como se fosse a mão)
// (mouse_x, mouse_y) é onde o mouse está
	var dir = point_direction(x, y -8, mouse_x, mouse_y);
	
// 13 = distância da mão até a faca
// dir = direção que foi calculada acima
	var xx = lengthdir_x(13, dir);
	
// Usa a mesma distância e direção só que negativo
	var yy = lengthdir_y(13, dir);

    // 3. Define a escala Y para a faca não ficar de cabeça para baixo ao olhar para a esquerda
    var _yscale = 1;
    if (dir > 90 && dir < 270) {
        _yscale = -1;
    }

    // 4. Desenha a faca na mão do personagem
    draw_sprite_ext(spr_faca, 0, x + xx, y - 8 + yy, 1, _yscale, dir, c_white, 1);

    // 5. Se o botão esquerdo do mouse foi pressionado, dispara a faca
    if (mouse_check_button_pressed(mb_left)) {

        // Cria a faca como objeto no jogo
        var inst = instance_create_layer(x + xx, y - 8 + yy, "Instances_2", obj_faca);

        inst.melhoria = false;
        inst.direction = dir;
        inst.image_angle = dir;
        inst.image_yscale = _yscale;
        inst.speed = 8;

        faca_cargas -= 1;
    }

    // 6. Se acabarem as cargas, desativa o sistema de facas
    if (faca_cargas <= 0) {
        faca = false;
    }
}