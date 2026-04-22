/// @description Insert description here
// 1. CHECANDO A MORTE COM EXPLOSÃO NATIVA:
// 1. CHECANDO A MORTE:
// Verifica se a vida do inimigo chegou a 0 ou menos (morreu)
if (vida <= 0) {
    
    // Verifica se o alarm[1] ainda não está ativo (tempo <= 0)
    if (alarm[1] <= 0) {
        
        // Ativa o alarm[1] com 20 frames
        // Esse tempo pode ser usado para um efeito visual (ex: flash branco)
        alarm[1] = 20; 
    }
	
	image_speed = 3; // quanto maior, mais rápido
    
    // Executa o código do objeto pai
    // (normalmente usado para lidar com a morte, como virar fumaça ou destruir)
    event_inherited(); 
    
    // Interrompe o restante do código deste evento
    // Evita que outras ações sejam executadas após a morte
    exit;
}

// 2. VIDA NORMAL
event_inherited(); 
// Executa o código do objeto pai.
// Geralmente cuida de coisas como vida, dano, hit, etc.

// --- GRAVIDADE ---
vveloc += gravidade;
// Aumenta a velocidade vertical somando a gravidade.
// Isso faz o objeto cair cada vez mais rápido.

// --- DETECTA O CHÃO ---
if (place_meeting(x, y + 1, obj_parede)) {
// Verifica se existe uma colisão 1 pixel abaixo do objeto.
// Ou seja: checa se tem chão logo embaixo.

    no_chao = true;
    // Se tiver chão, marca que o objeto está no chão.

    if (vveloc > 0) vveloc = 0; 
    // Se estiver caindo (velocidade positiva),
    // zera a velocidade para parar no chão (não atravessar).

} else {
    no_chao = false;
    // Se não tiver chão, o objeto está no ar.
}

// --- PULA DE TEMPOS EM TEMPOS ---
if (no_chao) {
// Só executa se o objeto estiver no chão.

    timer_pulo++;
    // Aumenta o contador de tempo a cada frame.

    if (timer_pulo >= intervalo_pulo) {
    // Quando o tempo atingir o intervalo definido...

        vveloc = forca_pulo;
        // Aplica a força do pulo (valor negativo → sobe).

        timer_pulo = 0;
        // Reseta o contador para começar de novo.
    }
}

// --- MOVIMENTO VERTICAL PIXEL A PIXEL (não atravessa chão) ---
var _steps = abs(vveloc);
// Pega o valor absoluto da velocidade.
// Define quantos pixels o objeto vai se mover.

var _dir = sign(vveloc);
// Define a direção do movimento:
//  1  → descendo
// -1 → subindo
//  0 → parado

repeat (_steps) {
// Repete o movimento pixel por pixel.

    if (!place_meeting(x, y + _dir, obj_parede)) {
    // Verifica se pode andar 1 pixel nessa direção
    // sem colidir com uma parede.

        y += _dir;
        // Move 1 pixel na direção (cima ou baixo).

    } else {
        vveloc = 0;
        // Se colidir, para a velocidade vertical.

        break;
        // Interrompe o loop para não atravessar o objeto.
    }
}
