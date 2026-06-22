/// @description Insert description here
// You can write your code in this editor

render_model = "models/9mm.vbm";
collision_model = "models/9mm_collision.vbm";

render_vbm = VBM_Model_Create();
collision_vbm = VBM_Model_Create();

world = matrix_build(x, y, 0, -90, 0, 0, 10, 10, 10);

var render_ok = VBM_Model_Open(render_vbm, render_model);
if (!render_ok) {
    show_debug_message("Falha ao Carregar Modelo");
}

var collision_ok = VBM_Model_Open(collision_vbm, collision_model);
if (!collision_ok) {
    show_debug_message("Falha ao Carregar Colisao");
}


