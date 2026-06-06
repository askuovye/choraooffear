global.res_w = 1280;
global.res_h = 720;

window_set_size(global.res_w, global.res_h);
surface_resize(application_surface, global.res_w, global.res_h);

// vibes pinterest
global.fog_colour = merge_color(c_black, c_blue, 0.1);
gpu_set_fog(true, global.fog_colour, 50, 500); // affs muito vibes essa neblina vey

// requebrando ate o chao
layer_force_draw_depth(true, 0); 

gpu_set_ztestenable(true);
gpu_set_alphatestenable(true);


function draw_in_3d(_xoff, _yoff, _zoff, _xrot, _yrot, _zrot, _image_xscale, _image_yscale) {
    var _matrix = matrix_build(x + _xoff, y + _yoff, _zoff, _xrot, _yrot, _zrot, 1, 1, 1);
    matrix_set(matrix_world, _matrix);
    draw_sprite_ext(sprite_index, image_index, 0, 0, _image_xscale, _image_yscale, image_angle, image_blend, image_alpha);
    matrix_set(matrix_world, matrix_build_identity());
}