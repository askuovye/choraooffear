function z_ranges_overlap(_a_bottom, _a_top, _b_bottom, _b_top) {
    return (_a_bottom < _b_top) && (_a_top > _b_bottom);
}

function rects_overlap(_l1, _t1, _r1, _b1, _l2, _t2, _r2, _b2) {
    return (_l1 < _r2) && (_r1 > _l2) && (_t1 < _b2) && (_b1 > _t2);
}

function player_over_platform_xy(_player, _px, _py, _plat) {
    var _pl = _px - _player.player_radius;
    var _pr = _px + _player.player_radius;
    var _pt = _py - _player.player_radius;
    var _pb = _py + _player.player_radius;

    return rects_overlap(
        _pl, _pt, _pr, _pb,
        _plat.bbox_left,
        _plat.bbox_top,
        _plat.bbox_right,
        _plat.bbox_bottom
    );
}

function get_3d_ground_z(_player, _px, _py, _prev_foot_z, _foot_z) {
    var _ground = 0;

    with (obj_platform) {
        if (player_over_platform_xy(_player, _px, _py, id)) {
            var _plat_top = z + z_size;

            if (_player.zspd <= 0 && _prev_foot_z >= _plat_top && _foot_z <= _plat_top) {
                if (_plat_top > _ground) {
                    _ground = _plat_top;
                }
            }
        }
    }

    return _ground;
}

function player_rect_hits_instance(_player, _px, _py, _obj) {
    var _l = _px - _player.player_radius;
    var _r = _px + _player.player_radius;
    var _t = _py - _player.player_radius;
    var _b = _py + _player.player_radius;

    return collision_rectangle(_l, _t, _r, _b, _obj, false, true) != noone;
}

function xy_blocks_player(_player, _px, _py) {
    // 1. Colisão com paredes normais 2D
    if (player_rect_hits_instance(_player, _px, _py, obj_solid)) {
        return true;
    }

    // 2. Colisão lateral com plataformas 3D
    var _player_bottom = _player.z - _player.camera_height;
    var _player_top = _player_bottom + _player.camera_height;

    var _l = _px - _player.player_radius;
    var _r = _px + _player.player_radius;
    var _t = _py - _player.player_radius;
    var _b = _py + _player.player_radius;

    var _list = ds_list_create();

    var _count = collision_rectangle_list(
        _l, _t, _r, _b,
        obj_platform,
        false,
        true,
        _list,
        false
    );

    for (var i = 0; i < _count; i++) {
        var _plat = _list[| i];

        var _plat_bottom = _plat.z;
        var _plat_top = _plat.z + _plat.z_size;

        var _epsilon = 0.5;

        // Se o pé do player está no topo ou acima,
        // essa plataforma não é uma parede lateral.
        if (_player_bottom >= _plat_top - _epsilon) {
            continue;
        }

        if (z_ranges_overlap(_player_bottom, _player_top, _plat_bottom, _plat_top)) {
            ds_list_destroy(_list);
            return true;
        }
    }

    ds_list_destroy(_list);

    return false;
}

function move_player_3d(_player, _dx, _dy) {
    var _steps = ceil(max(abs(_dx), abs(_dy)));

    if (_steps < 1) {
        _steps = 1;
    }

    var _sx = _dx / _steps;
    var _sy = _dy / _steps;

    repeat (_steps) {
        // X separado
        if (!xy_blocks_player(_player, _player.x + _sx, _player.y)) {
            _player.x += _sx;
        } else {
            // zera só o eixo X, não trava o Y
            _player.move_x = 0;
        }

        // Y separado
        if (!xy_blocks_player(_player, _player.x, _player.y + _sy)) {
            _player.y += _sy;
        } else {
            // zera só o eixo Y, não trava o X
            _player.move_y = 0;
        }
    }
}