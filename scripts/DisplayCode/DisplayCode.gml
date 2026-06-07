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

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_colour();
global.line_vf = vertex_format_end();

function create_3d_line_buffer(_x1, _y1, _z1, _x2, _y2, _z2, _col, _alpha) {
    var _vbuff = vertex_create_buffer();

    vertex_begin(_vbuff, global.line_vf);

    vertex_position_3d(_vbuff, _x1, _y1, _z1);
    vertex_colour(_vbuff, _col, _alpha);

    vertex_position_3d(_vbuff, _x2, _y2, _z2);
    vertex_colour(_vbuff, _col, _alpha);

    vertex_end(_vbuff);

    return _vbuff;
}

function draw_line_3d(_x1, _y1, _z1, _x2, _y2, _z2, _col, _alpha) {
    var _line = create_3d_line_buffer(
        _x1, _y1, _z1,
        _x2, _y2, _z2,
        _col,
        _alpha
    );

    vertex_submit(_line, pr_linelist, -1);
    vertex_delete_buffer(_line);
}