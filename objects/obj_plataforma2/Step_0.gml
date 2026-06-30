//=========================================================
// Esta plataforma funciona apenas na fase 5.
// Se estiver em qualquer outra fase, o código é encerrado.
//=========================================================
if (room != rm_fase5) exit;


//=========================================================
// Verifica se o jogador existe no jogo.
// Isso evita erros caso ele ainda não tenha sido criado.
//=========================================================
if (instance_exists(obj_personagem))
{
    //-----------------------------------------------------
    // Descobre se o jogador está realmente em cima
    // da plataforma.
    //-----------------------------------------------------

    // Assume inicialmente que o jogador NÃO está em cima.
    var _jogador_em_cima = false;

    // Verifica se existe um jogador logo acima da plataforma.
    if (place_meeting(x, y - 4, obj_personagem))
    {
        // Confirma se:
        // • Os pés do jogador estão próximos ao topo da plataforma.
        // • O jogador está parado ou caindo.
        // Essas verificações evitam que a plataforma
        // considere o jogador em cima enquanto ele está subindo.
        if (obj_personagem.bbox_bottom <= bbox_top + 5 &&
            obj_personagem.vveloc >= 0)
        {
            _jogador_em_cima = true;
        }
    }


    //-----------------------------------------------------
    // Máquina de estados da plataforma.
    // Cada estado representa um comportamento diferente.
    //
    // Estado 0 = Parada em cima.
    // Estado 1 = Descendo.
    // Estado 2 = Esperando embaixo.
    // Estado 3 = Subindo.
    //-----------------------------------------------------
    switch (estado_movimento)
    {

        //=================================================
        // ESTADO 0
        // Plataforma parada aguardando o jogador.
        //=================================================
        case 0:

            // Se o jogador estiver sobre a plataforma...
            if (_jogador_em_cima)
            {
                // Conta quanto tempo ele permanece em cima.
                timer_jogador++;

                // Quando o tempo configurado for atingido...
                if (timer_jogador >= tempo_para_descer)
                {
                    // Reinicia o cronômetro.
                    timer_jogador = 0;

                    // Troca para o estado "Descendo".
                    estado_movimento = 1;

                    // Marca que a plataforma iniciou a descida.
                    descendo = true;
                }
            }
            else
            {
                // O jogador saiu antes do tempo necessário.
                // O cronômetro volta para zero.
                timer_jogador = 0;
            }

            break;



        //=================================================
        // ESTADO 1
        // Plataforma descendo.
        //=================================================
        case 1:

            // Define quantos pixels a plataforma tentará
            // descer neste frame.
            var _move_y = velocidade_descida;


            //-------------------------------------------------
            // Procura uma parede logo abaixo da plataforma.
            // Isso impede que ela atravesse o chão.
            //-------------------------------------------------
            var _parede_abaixo =
                collision_rectangle(
                    x + 4,
                    y + 8,
                    x + 20,
                    y + 8 + _move_y,
                    obj_parede,
                    false,
                    true
                );


            // Se encontrou uma parede...
            if (_parede_abaixo != noone)
            {
                // Calcula a distância até o topo da parede.
                var _deslocamento =
                    _parede_abaixo.bbox_top - (y + 7);

                // Se essa distância for menor que o movimento
                // planejado, reduz o movimento para parar
                // exatamente na parede.
                if (_deslocamento < _move_y)
                {
                    _move_y = max(0, _deslocamento);
                }
            }


            //-------------------------------------------------
            // Verifica se a plataforma ultrapassaria
            // o limite máximo de descida.
            //-------------------------------------------------
            if (y + _move_y > yorigem + limite_descida)
            {
                // Ajusta o movimento para parar exatamente
                // no limite configurado.
                _move_y =
                    (yorigem + limite_descida) - y;
            }


            //-------------------------------------------------
            // Se ainda existe espaço para descer...
            //-------------------------------------------------
            if (_move_y > 0)
            {
                // Se o jogador estiver sobre a plataforma...
                if (_jogador_em_cima &&
                    obj_personagem.vveloc >= 0)
                {
                    // Executa este código dentro do jogador.
                    with (obj_personagem)
                    {
                        // Verifica se o jogador pode ser movido
                        // sem entrar em uma parede.
                        if (!place_meeting(
                                x,
                                y + _move_y,
                                obj_parede))
                        {
                            // Move o jogador junto com a plataforma.
                            y += _move_y;
                        }
                    }
                }

                // Move a plataforma para baixo.
                y += _move_y;
            }
            else
            {
                // A plataforma chegou ao chão
                // ou ao limite máximo de descida.

                // Troca para o estado "Esperando embaixo".
                estado_movimento = 2;

                // Reinicia o cronômetro de espera.
                timer_espera = 0;
            }

            break;



        //=================================================
        // ESTADO 2
        // Plataforma parada embaixo.
        //=================================================
        case 2:

            // Conta quanto tempo a plataforma permanece
            // parada embaixo.
            timer_espera++;

            // Quando o tempo configurado terminar...
            if (timer_espera >= tempo_espera_embaixo)
            {
                // Reinicia o cronômetro.
                timer_espera = 0;

                // Troca para o estado "Subindo".
                estado_movimento = 3;
            }

            break;



        //=================================================
        // ESTADO 3
        // Plataforma voltando para cima.
        //=================================================
        case 3:

            // Define o movimento de subida.
            // Como o valor é negativo,
            // a plataforma sobe.
            var _move_y = -velocidade_descida;


            //-------------------------------------------------
            // Impede que a plataforma passe da posição
            // onde ela começou.
            //-------------------------------------------------
            if (y + _move_y < yorigem)
            {
                // Ajusta o movimento para parar exatamente
                // na posição inicial.
                _move_y = yorigem - y;
            }


            // Move a plataforma para cima.
            y += _move_y;


            //-------------------------------------------------
            // Verifica se a plataforma chegou novamente
            // à posição original.
            //-------------------------------------------------
            if (y == yorigem)
            {
                // Volta ao estado inicial.
                estado_movimento = 0;

                // Informa que ela não está mais descendo.
                descendo = false;
            }

            break;
    }
}