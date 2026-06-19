/// @description Insert description here
// You can write your code in this editor

model = VBM_Model_Create();

var ok = VBM_Model_Open(model, "models/Naoya.vbm");
if (!ok) {
    show_debug_message("Falha ao carregar modelo");
}




