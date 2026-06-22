/// @description Insert description here
// You can write your code in this editor

if (variable_instance_exists(id, "render_vbm") && is_struct(render_vbm)) {
	VBM_Model_Free(render_vbm);
	delete render_vbm;
}

if (variable_instance_exists(id, "collision_vbm") && is_struct(collision_vbm)) {
	VBM_Model_Free(collision_vbm);
	delete collision_vbm;
}

if (variable_instance_exists(id, "vbm") && is_struct(vbm)) {
	VBM_Model_Free(vbm);
	delete vbm;
}




