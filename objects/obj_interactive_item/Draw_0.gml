/// @description Insert description here
// You can write your code in this editor

var _draw_vbm = variable_instance_exists(id, "render_vbm") ? render_vbm : vbm;

if (is_struct(_draw_vbm) && _draw_vbm.vertex_buffer != -1) {
	VBM_Model_Submit(_draw_vbm, world);
}
matrix_set(matrix_world, matrix_build_identity());




