// Controla o comportamento com base no estado atual
switch(estado) {
    
    // ============================
    // ESTADO: ESPERANDO NO TOPO
    // ============================
    
    case "esperando":
    case "esperando_topo":
        
        vveloc = 0;
        
        break;
    
    
    // ============================
    // ESTADO: CAINDO
    // ============================
    
    case "caindo":
        
        vveloc += gravidade;
        
        // 1. Está caindo (vveloc > 0)
        // 2. Vai colidir com o chão no próximo movimento
        // 3. Ainda não está colidindo agora (evita bugs com teto/embutido)
        if (vveloc > 0 && place_meeting(x, y + vveloc, obj_parede) && !place_meeting(x, y + 1, obj_parede)) {
            
            while (!place_meeting(x, y + sign(vveloc), obj_parede)) {
                y += sign(vveloc);
            }
            
            vveloc = 0;
            
            estado = "esperando_chao";
            
            alarm[0] = 60;
        }
        
        y += vveloc;
        
        break;
    
    
    // ============================
    // ESTADO: VOLTANDO (SUBINDO)
    // ============================
    
    case "voltando":
        
        y -= 1;
        
        if (y <= y_inicial) {
            
            y = y_inicial;
            
            estado = "esperando_topo";
            
            alarm[1] = 90;
        }
        
        break;
}