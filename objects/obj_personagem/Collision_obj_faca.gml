// Se pegou uma melhoria
if obj_faca.melhoria == true {

    // Ativa o uso da faca
    faca = true;

    faca_cargas = 5;

    with (other) {

        // Destroi o item após ser coletado
        instance_destroy();
    }
}

