/// @description Desenha o Minotauro corrigindo o flip de origem
if (sprite_exists(sprite_index)) {
    var _draw_xscale = 1;
    var _draw_x = x;
    var _width = sprite_get_width(sprite_index);
    
    // CORREÇÃO:
    // spr_minotauro_andando_esquerda e spr_investida_cortante_minotauro já são virados para a ESQUERDA por padrão.
    // spr_minotauro e spr_minotauro_andando_direita são virados para a DIREITA por padrão.
    var _sprite_nativo_esquerda = (sprite_index == spr_minotauro_andando_esquerda || sprite_index == spr_investida_cortante_minotauro);
    
    if (_sprite_nativo_esquerda) {
        // Se o sprite é nativo de ESQUERDA, nós o flipamos quando estiver olhando para a DIREITA (direct == 1)
        if (direct == 1) {
            _draw_xscale = -1;
            _draw_x = x + _width; // Desloca para desenhar exatamente dentro do retângulo estável de colisão
        }
    } else {
        // Se o sprite é nativo de DIREITA, nós o flipamos quando estiver olhando para a ESQUERDA (direct == -1)
        if (direct == -1) {
            _draw_xscale = -1;
            _draw_x = x + _width; // Desloca para desenhar exatamente dentro do retângulo estável de colisão
        }
    }
    
    // Efeito de piscar em branco ao tomar dano (fog) herdado do pai
    if (alarm[1] > 0) {
        gpu_set_fog(true, c_white, 0, 0);
        draw_sprite_ext(sprite_index, image_index, _draw_x, y, _draw_xscale, image_yscale, image_angle, image_blend, image_alpha);
        gpu_set_fog(false, c_white, 0, 0);
    } else {
        draw_sprite_ext(sprite_index, image_index, _draw_x, y, _draw_xscale, image_yscale, image_angle, image_blend, image_alpha);
    }
}
