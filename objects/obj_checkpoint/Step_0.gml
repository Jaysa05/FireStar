/// @description Sistema de ativacao do Checkpoint e Salvamento

if (!ativado) {
    if (place_meeting(x, y, obj_personagem)){
        ativado = true;
        
        // -------- SALVA DADOS DO CHECKPOINT NAS GLOBAIS --------
        global.checkpoint_ativo = true;
        global.checkpoint_sala = room;
        global.checkpoint_x = x;
        global.checkpoint_y = y;
           
        // -------- SALVA DADOS DO JOGADOR NAS GLOBAIS --------
        with (obj_personagem){
            global.vida_save = vida;
            global.faca_save = faca;
            global.faca_cargas_save = faca_cargas;
            global.frutas_save = frutas;
        }
        
        // -------- SALVA NO ARQUIVO FÍSICO SAVE.INI --------
        ini_open("save.ini");
        ini_write_real("Checkpoint", "ativo", true);
        ini_write_real("Checkpoint", "sala", global.checkpoint_sala);
        ini_write_real("Checkpoint", "x", global.checkpoint_x);
        ini_write_real("Checkpoint", "y", global.checkpoint_y);
        ini_write_real("Player", "vida", global.vida_save);
        ini_write_real("Player", "faca", global.faca_save);
        ini_write_real("Player", "faca_cargas", global.faca_cargas_save);
        ini_write_real("Player", "frutas", global.frutas_save);
        ini_close();
           
        sprite_index = -1;
        timer_texto = 60;
    }
}

if (timer_texto > 0){
    timer_texto--;
}
