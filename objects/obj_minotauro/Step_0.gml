/// @description Comportamento do Minotauro

event_inherited();
// Executa primeiro o código do objeto pai


// ====================================================
// MORTE
// ====================================================

// Se a vida chegou a 0 ou menos, para tudo
if (vida <= 0)
{
    image_blend = c_white;
    // Remove a cor verde/lima ao morrer

    visible = true;
    // Garante que ele fique visível para tocar a animação de morte

    exit;
    // Para a execução deste Step
}


// ====================================================
// SISTEMA DE VULNERABILIDADE
// ====================================================
//
// REGRA:
//
// Estado "exhausted"
//      ↓
// Vulnerável por 180 frames
//      ↓
// Invulnerável por 300 frames
//
// Fora de "exhausted"
//      ↓
// Invulnerável
//
// ====================================================


/// ====================================================
// SISTEMA DE VULNERABILIDADE
// ====================================================
// O Minotauro fica VULNERÁVEL (vulneravel = true) APENAS quando está cansado ("exhausted").
// Enquanto estiver perseguindo ou executando ataques, ele fica INVULNERÁVEL (vulneravel = false).
if (estado == "exhausted")
{
    vulneravel = true;
}
else
{
    vulneravel = false;
}


    // Se ele está vulnerável
    if (vulneravel)
    {
        timer_vulnerabilidade -= 1;


        // Quando terminar o período vulnerável
        if (timer_vulnerabilidade <= 0)
        {
            vulneravel = false;

            timer_vulnerabilidade = 300;
            // 300 frames = 5 segundos invulnerável
        }
    }



// ----------------------------------------------------
// SE NÃO ESTÁ CANSADO
// ----------------------------------------------------

else
{
    // Fora do estado exhausted,
    // o Minotauro não pode receber dano.

    vulneravel = false;
}


// ====================================================
// VERIFICA SE O MINOTAURO ESTÁ PRESO
// ====================================================

var _chao_atual =
    place_meeting(x, y, obj_parede) ||
    place_meeting(x, y, obj_plataforma_fase2) ||
    place_meeting(x, y, obj_plataforma) ||
    place_meeting(x, y, obj_plataforma2);


// ----------------------------------------------------
// SE ESTIVER PRESO
// ----------------------------------------------------

if (_chao_atual)
{
    // Procura um espaço livre até 32 pixels acima

    for (var i = 1; i <= 32; i++)
    {
        // Se encontrou uma posição sem colisão

        if (!place_meeting(x, y - i, obj_parede) &&
            !place_meeting(x, y - i, obj_plataforma_fase2) &&
            !place_meeting(x, y - i, obj_plataforma) &&
            !place_meeting(x, y - i, obj_plataforma2))
        {
            // Move o Minotauro para cima

            y -= i;

            // Para de procurar

            break;
        }
    }
}


// ====================================================
// GRAVIDADE
// ====================================================

// Aplica a gravidade aumentando a velocidade vertical

vveloc += gravidade;


// ====================================================
// IA DO MINOTAURO
// ====================================================

// Só executa a IA se o jogador existir

if (instance_exists(obj_personagem))
{
    // Calcula o centro horizontal do Minotauro

    var _minotauro_centro = (bbox_left + bbox_right) / 2;


    // Distância horizontal até o jogador

    var _dif_x = obj_personagem.x - _minotauro_centro;


    // Distância sem sinal
    // Sempre positiva

    var _dist_h = abs(_dif_x);


    // ====================================================
    // COOLDOWN DA INVESTIDA
    // ====================================================

    if (cooldown_investida > 0)
    {
        // Diminui o tempo restante

        cooldown_investida -= 1;
    }


    // ====================================================
    // ESTADOS DO MINOTAURO
    // ====================================================

    switch (estado)
    {
        // ==================================================
        // ESTADO: PERSEGUIÇÃO
        // ==================================================

        case "chase":

            // Mantém o sprite na escala normal

            image_xscale = 1;


            // Se o jogador estiver a mais de 60 pixels

            if (_dist_h > 60)
            {
                // Descobre se o jogador está
                // à esquerda ou à direita

                direct = sign(_dif_x);


                // Move o Minotauro na direção do jogador

                hveloc = direct * veloc_chase;


                // Escolhe a animação correta

                if (direct == 1)
                {
                    sprite_index = sprite_andando_dir;
                }
                else
                {
                    sprite_index = sprite_andando_esq;
                }
            }

            else
            {
                // Se estiver perto do jogador,
                // para de andar

                hveloc = 0;


                // Usa a animação parado

                sprite_index = sprite_idle;
            }


            // ==================================================
            // PREPARAÇÃO DA INVESTIDA
            // ==================================================

            if (cooldown_investida <= 0 &&
                _dist_h <= 200 &&
                _dist_h > 40)
            {
                // Troca para o estado de preparação

                estado = "prepara_investida";


                // Tempo de preparação
                // 80 frames ≈ 1,33 segundos

                timer_estado = 80;


                // Para de andar

                hveloc = 0;
            }


            break;


        // ==================================================
        // ESTADO: PREPARAÇÃO DA INVESTIDA
        // ==================================================

        case "prepara_investida":

            image_xscale = 1;


            // Diminui o cronômetro

            timer_estado -= 1;


            // Continua parado

            hveloc = 0;


            // Continua olhando para o jogador

            direct = sign(_dif_x);


            // Se não existir direção,
            // assume direita

            if (direct == 0)
            {
                direct = 1;
            }


            // Usa animação parada

            sprite_index = sprite_idle;


            // ==================================================
            // ESCOLHA DO ATAQUE
            // ==================================================

            if (timer_estado <= 0)
            {
                // 0 = investida
                // 1 = girador
                // 2 = machadada

                if (proximo_ataque == 0)
                {
                    // ==========================================
                    // ATAQUE 0: INVESTIDA
                    // ==========================================

                    estado = "investida";

                    sprite_index = sprite_investida;

                    image_index = 0;

                    mask_index = sprite_investida;

                    timer_estado = 60;

                    proximo_ataque = 1;
                }


                else if (proximo_ataque == 1)
                {
                    // ==========================================
                    // ATAQUE 1: GOLPE GIRADOR
                    // ==========================================

                    estado = "girador";

                    sprite_index = sprite_idle;

                    image_index = 0;

                    visible = false;

                    timer_estado = 45;


                    // ==========================================
                    // CRIA O OBJETO DO ATAQUE GIRATÓRIO
                    // ==========================================

                    var _spawn_x = x;


                    // Se estiver olhando para esquerda

                    if (direct == -1)
                    {
                        _spawn_x = x + sprite_get_width(sprite_index);
                    }


                    // Cria o objeto do golpe

                    var _girador = instance_create_depth(
                        _spawn_x,
                        y,
                        depth - 1,
                        obj_golpe_girador
                    );


                    // Se o objeto foi criado corretamente

                    if (_girador != noone)
                    {
                        _girador.image_xscale = direct;
                    }


                    // Próximo ataque será machadada

                    proximo_ataque = 2;
                }


                else
                {
                    // ==========================================
                    // ATAQUE 2: MACHADADA
                    // ==========================================

                    estado = "machadada";

                    sprite_index = spr_machadada;

                    mask_index = spr_minotauro;

                    image_index = 0;

                    visible = true;

                    timer_estado = 45;


                    // ==========================================
                    // HITBOX DA MACHADADA
                    // ==========================================

                    var _spawn_x = x;

                    var _hitbox_xscale = 1;


                    // Se estiver olhando para direita

                    if (direct == 1)
                    {
                        _spawn_x = x + sprite_get_width(sprite_index);

                        _hitbox_xscale = -1;
                    }


                    // Cria a hitbox

                    var _machadada = instance_create_depth(
                        _spawn_x,
                        y,
                        depth - 1,
                        obj_machadada
                    );


                    if (_machadada != noone)
                    {
                        _machadada.image_xscale = _hitbox_xscale;
                    }


                    // Volta o ciclo para a investida

                    proximo_ataque = 0;
                }
            }


            break;


        // ==================================================
        // ESTADO: INVESTIDA
        // ==================================================

        case "investida":

            image_xscale = 1;


            // Diminui o cronômetro

            timer_estado -= 1;


            // Durante o ataque fica parado

            hveloc = 0;


            // Usa animação da investida

            sprite_index = sprite_investida;


            // Quando terminar

            if (timer_estado <= 0)
            {
                // Entra no estado de cansaço

                estado = "exhausted";


                // Reseta a máscara

                mask_index = spr_minotauro;


                // 120 frames ≈ 2 segundos

                timer_estado = 120;


                hveloc = 0;


                // IMPORTANTE:
                // A vulnerabilidade será iniciada
                // pelo sistema de vulnerabilidade acima.
            }


            break;


        // ==================================================
        // ESTADO: GOLPE GIRADOR
        // ==================================================

        case "girador":

            hveloc = 0;

            image_xscale = 1;


            // Diminui o tempo

            timer_estado -= 1;


            // Quando terminar

            if (timer_estado <= 0)
            {
                estado = "exhausted";

                visible = true;

                timer_estado = 90;

                hveloc = 0;
            }


            break;


        // ==================================================
        // ESTADO: MACHADADA
        // ==================================================

        case "machadada":

            // Não anda durante a machadada

            hveloc = 0;


            // Escala normal

            image_xscale = 1;


            // Verifica se a animação terminou

            if (scr_fim_da_animacao())
            {
                // Entra em cansaço

                estado = "exhausted";


                // Volta para o sprite parado

                sprite_index = sprite_idle;


                // Volta a máscara normal

                mask_index = spr_minotauro;


                // Continua visível

                visible = true;


                // 90 frames ≈ 1,5 segundos

                timer_estado = 90;


                hveloc = 0;
            }


            break;


        // ==================================================
        // ESTADO: EXHAUSTED / CANSAÇO
        // ==================================================

        case "exhausted":

            image_xscale = 1;


            // Diminui o cronômetro do estado

            timer_estado -= 1;


            // Mantém parado

            hveloc = 0;


            // Usa animação parada

            sprite_index = sprite_idle;


            // Quando terminar o cansaço

            if (timer_estado <= 0)
            {
                // Volta para perseguição

                estado = "chase";


                // Cooldown de 3 segundos

                cooldown_investida = 180;
            }


            break;
    }
}


// ====================================================
// SE O JOGADOR NÃO EXISTIR
// ====================================================

else
{
    // Não se move

    sprite_index = sprite_idle;


    // Escala normal

    image_xscale = 1;
}


// ====================================================
// DETECÇÃO DE COLISÕES
// ====================================================


// ====================================================
// COLISÃO HORIZONTAL
// ====================================================

// Verifica se vai bater em parede ou cerca

var _colidiu_h =
    place_meeting(x + hveloc, y, obj_parede) ||
    place_meeting(x + hveloc, y, obj_parede_inimigo);


// ----------------------------------------------------
// SE COLIDIU HORIZONTALMENTE
// ----------------------------------------------------

if (_colidiu_h)
{
    // Descobre qual objeto causou a colisão

    var _obj_colisao =
        place_meeting(x + hveloc, y, obj_parede)
        ? obj_parede
        : obj_parede_inimigo;


    // Move 1 pixel por vez
    // até encostar

    while (!place_meeting(
        x + sign(hveloc),
        y,
        _obj_colisao))
    {
        x += sign(hveloc);
    }


    // Para o movimento

    hveloc = 0;
}


// ====================================================
// MOVIMENTO HORIZONTAL
// ====================================================

x += hveloc;


// ====================================================
// COLISÃO VERTICAL COM PAREDES
// ====================================================

if (place_meeting(x, y + vveloc, obj_parede))
{
    // Aproxima 1 pixel por vez

    while (!place_meeting(
        x,
        y + sign(vveloc),
        obj_parede))
    {
        y += sign(vveloc);
    }


    // Para o movimento vertical

    vveloc = 0;
}


// ====================================================
// PLATAFORMAS UNIDIRECIONAIS
// ====================================================

// Procura a primeira plataforma

var _plat =
    instance_place(
        x,
        y + vveloc,
        obj_plataforma_fase2
    );


// Se não encontrou

if (_plat == noone)
{
    _plat =
        instance_place(
            x,
            y + vveloc,
            obj_plataforma
        );
}


// Se ainda não encontrou

if (_plat == noone)
{
    _plat =
        instance_place(
            x,
            y + vveloc,
            obj_plataforma2
        );
}


// ====================================================
// COLISÃO COM A PLATAFORMA
// ====================================================

if (_plat != noone)
{
    // Só colide se estiver caindo

    if (vveloc > 0 &&
        bbox_bottom <= _plat.bbox_top + 4)
    {
        // Move até encostar

        while (!place_meeting(
            x,
            y + sign(vveloc),
            _plat))
        {
            y += sign(vveloc);
        }


        // Para a queda

        vveloc = 0;
    }
}


// ====================================================
// MOVIMENTO VERTICAL
// ====================================================

y += vveloc;


// ====================================================
// CONTROLE DE COR
// ====================================================

if (vulneravel)
{
    // Verde/lima = pode receber dano

    image_blend = c_lime;
}

else
{
    // Se estiver preparando a investida

    if (estado == "prepara_investida")
    {
        // Vermelho = aviso de ataque

        image_blend = c_red;
    }

    else
    {
        // Branco = aparência normal

        image_blend = c_white;
    }
}