/// @description Insert description here
// You can write your code in this editor

model = 0;
vbm = VBM_Model_Create();

world = matrix_build(x, y, 0, 0, 0, 0, 1, 1, 1);

var ok = VBM_Model_Open(vbm, model);
if (!ok) {
    show_debug_message("Falha ao Carregar Modelo");
}


