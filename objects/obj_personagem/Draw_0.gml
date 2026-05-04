/// @description Insert description here
// Desenha o personagem na tela
draw_self();

// Se a faca estiver ativa
if (faca == true) {

   // Calcula a direção (ângulo) do personagem até o mouse
// (x, y - 8) é o ponto de origem (um pouco acima do personagem, como se fosse a mão)
// (mouse_x, mouse_y) é onde o mouse está
	var dir = point_direction(x, y -8, mouse_x, mouse_y);
	
	// Calcula quanto a faca deve se mover no eixo X (horizontal)
// 13 = distância da mão até a faca
// dir = direção que foi calculada acima
	var xx = lengthdir_x(13, dir);
	
	// Calcula quanto a faca deve se mover no eixo Y (vertical)
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

        // Define propriedades da faca disparada
        inst.melhoria = false;
        inst.direction = dir;
        inst.image_angle = dir;
        inst.image_yscale = _yscale; // Mantém a orientação correta no ar
        inst.speed = 8;

        // Diminui uma carga de faca
        faca_cargas -= 1;
    }

    // 6. Se acabarem as cargas, desativa o sistema de facas
    if (faca_cargas <= 0) {
        faca = false;
    }
}