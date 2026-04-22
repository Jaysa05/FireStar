/// @description Insert description here
// Controla o comportamento com base no estado atual
switch(estado) {
    
    // ============================
    // ESTADO: ESPERANDO NO TOPO
    // ============================
    
    case "esperando":          // Estado genérico de espera
    case "esperando_topo":     // Estado específico: parado no topo
        
        vveloc = 0; // Garante que o objeto não se move (fica parado)
        
        break; // Sai do switch
    
    
    // ============================
    // ESTADO: CAINDO
    // ============================
    
    case "caindo":
        
        // Aplica gravidade (aumenta a velocidade de queda)
        vveloc += gravidade;
        
        // Verifica se:
        // 1. Está caindo (vveloc > 0)
        // 2. Vai colidir com o chão no próximo movimento
        // 3. Ainda não está colidindo agora (evita bugs com teto/embutido)
        if (vveloc > 0 && place_meeting(x, y + vveloc, obj_parede) && !place_meeting(x, y + 1, obj_parede)) {
            
            // Move o objeto pixel por pixel até encostar exatamente no chão
            while (!place_meeting(x, y + sign(vveloc), obj_parede)) {
                y += sign(vveloc); // Move 1 pixel para baixo
            }
            
            vveloc = 0; // Para o movimento vertical (parou no chão)
            
            estado = "esperando_chao"; // Muda para estado de espera no chão
            
            alarm[0] = 60; // Define um tempo de espera (60 frames ≈ 1 segundo)
        }
        
        // Aplica o movimento vertical (faz o objeto cair)
        y += vveloc;
        
        break; // Sai do switch
    
    
    // ============================
    // ESTADO: VOLTANDO (SUBINDO)
    // ============================
    
    case "voltando":
        
        // Move o objeto para cima (1 pixel por frame)
        y -= 1;
        
        // Verifica se chegou na posição inicial (topo)
        if (y <= y_inicial) {
            
            y = y_inicial; // Corrige posição para não passar do topo
            
            estado = "esperando_topo"; // Volta para o estado de espera no topo
            
            alarm[1] = 90; // Tempo de espera no topo (90 frames ≈ 1,5 segundos)
        }
        
        break; // Sai do switch
}