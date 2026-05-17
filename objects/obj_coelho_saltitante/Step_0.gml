// 1. CHECANDO A MORTE COM EXPLOSÃO NATIVA:
// 1. CHECANDO A MORTE:
if (vida <= 0) {
    
    if (alarm[1] <= 0) {
        
        // Ativa o alarm[1] com 20 frames
        // Esse tempo pode ser usado para um efeito visual (ex: flash branco)
        alarm[1] = 20; 
    }
	
	image_speed = 3;
    
    // (normalmente usado para lidar com a morte, como virar fumaça ou destruir)
    event_inherited(); 
    
    exit;
}

// 2. VIDA NORMAL
event_inherited(); 
// Geralmente cuida de coisas como vida, dano, hit, etc.

// --- GRAVIDADE ---
vveloc += gravidade;

// --- DETECTA O CHÃO ---
if (place_meeting(x, y + 1, obj_parede)) {

    no_chao = true;

    if (vveloc > 0) vveloc = 0; 

} else {
    no_chao = false;
}

// --- PULA DE TEMPOS EM TEMPOS ---
if (no_chao) {

    timer_pulo++;

    if (timer_pulo >= intervalo_pulo) {

        vveloc = forca_pulo;

        timer_pulo = 0;
    }
}

// --- MOVIMENTO VERTICAL PIXEL A PIXEL (não atravessa chão) ---
var _steps = abs(vveloc);

var _dir = sign(vveloc);
//  1  → descendo
// -1 → subindo
//  0 → parado

repeat (_steps) {

    if (!place_meeting(x, y + _dir, obj_parede)) {
    // sem colidir com uma parede.

        y += _dir;

    } else {
        vveloc = 0;
        // Se colidir, para a velocidade vertical.

        break;
    }
}
