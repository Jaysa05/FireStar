if (vire == true) {
    switch (estado) {
        case -1: // AGUARDANDO ATRASO INICIAL
            timer++;
            if (timer >= atraso_inicial) {
                timer = 0;
                estado = 0; // Depois do atraso, entra no ciclo normal
            }
            break;

        case 0: // Parada horizontal
            timer++;
            if (timer >= tempo_espera) { timer = 0; estado = 1; }
            break;

        case 1: // Girando para 90
            image_angle += velocidade;
            if (image_angle >= 90) { image_angle = 90; estado = 2; }
            break;

        case 2: // Parada vertical
            timer++;
            if (timer >= tempo_espera) { timer = 0; estado = 3; }
            break;

        case 3: // Voltando para 0
            image_angle -= velocidade;
            if (image_angle <= 0) { image_angle = 0; estado = 0; }
            break;
    }
} else {
    image_angle = 0;
}
