gpu_push_state();
gpu_set_fog(false, 0, 0, 0);
gpu_set_ztestenable(false);
gpu_set_alphatestenable(false);
gpu_set_blendenable(true);

var g_width = display_get_gui_width();
var g_height = display_get_gui_height();

if (inventory_open) {
    if (surface_exists(application_surface)) {
        var _blur_w = max(1, floor(g_width * blur_scale));
        var _blur_h = max(1, floor(g_height * blur_scale));

        if (!surface_exists(blur_surface) || surface_get_width(blur_surface) != _blur_w || surface_get_height(blur_surface) != _blur_h) {
            if (surface_exists(blur_surface)) {
                surface_free(blur_surface);
            }

            blur_surface = surface_create(_blur_w, _blur_h);
        }

        surface_set_target(blur_surface);
        draw_clear_alpha(c_black, 1);
        draw_surface_stretched(application_surface, 0, 0, _blur_w, _blur_h);
        surface_reset_target();

        gpu_set_tex_filter(true);
        draw_surface_stretched(blur_surface, 0, 0, g_width, g_height);
        gpu_set_tex_filter(false);
    }

    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(g_width, g_height, 0, 0, false);

    draw_sprite_ext(spr_inventory, image_index, g_width/2, g_height/2, 2, 2, 0, c_white, 0.5);

    draw_set_alpha(1);
    draw_set_color(c_white);

    draw_set_alpha(0.2);

    for (var row = 0; row < inv.rows; row++) {
        var pos_y = inv_draw_y + (row * cell_size);

        for (var column = 0; column < inv.cols; column++) {
            var pos_x = inv_draw_x + (column * cell_size);
            var box_size = cell_size - (cell_padding * 2);

            draw_sprite_stretched(spr_inventory_box, 0, pos_x + cell_padding, pos_y + cell_padding, box_size, box_size);
        }
    }

    draw_set_alpha(1);

    var _items = inv.inventory_get_items();

    for (var i = 0; i < array_length(_items); i++) {
        var _item = _items[i];

        if (dragging && i == selected_item) {
            continue;
        }

        var _x = inv_draw_x + _item.grid_x * cell_size;
        var _y = inv_draw_y + _item.grid_y * cell_size;

        var _w = _item.w * cell_size;
        var _h = _item.h * cell_size;

        var _spr_w = sprite_get_width(_item.sprite);
        var _spr_h = sprite_get_height(_item.sprite);

        var _draw_w = _w - 2;
        var _draw_h = _h - 2;

        draw_set_color(c_white);

        if (_item.rotated) {
            draw_sprite_stretched(spr_item_box, 0, _x + 4, _y + 4, _w - 8, _h - 8);
            draw_sprite_ext(
                _item.sprite,
                0,
                _x + _draw_w,
                _y,
                _draw_h / _spr_w,
                _draw_w / _spr_h,
                270,
                c_white,
                1
            );
        } else {
            draw_sprite_stretched(spr_item_box, 0, _x + 4, _y + 4, _w - 8, _h - 8);
            draw_sprite_stretched(_item.sprite, 0, _x + 4, _y + 4, _w - 8, _h - 8);
        }

        if (_item.amount > 1) {
            draw_set_font(fnt_arial);
            draw_set_color(c_aqua);
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            draw_text(_x + _w - 20, _y + _h - 24, string(_item.amount));
            draw_set_color(c_white);
        }
    }

    if (dragging && selected_item >= 0 && selected_item < array_length(_items)) {
        var _drag_item = _items[selected_item];

        var _mx = device_mouse_x_to_gui(0);
        var _my = device_mouse_y_to_gui(0);

        var _grid_x = floor((_mx - inv_draw_x) / cell_size);
        var _grid_y = floor((_my - inv_draw_y) / cell_size);
        var _inside_grid = _grid_x >= 0 && _grid_x < inv.cols && _grid_y >= 0 && _grid_y < inv.rows;

        var _drag_w = _drag_item.w * cell_size;
        var _drag_h = _drag_item.h * cell_size;

        var _spr_w = sprite_get_width(_drag_item.sprite);
        var _spr_h = sprite_get_height(_drag_item.sprite);

        if (_inside_grid) {
            var _preview_x = inv_draw_x + _grid_x * cell_size;
            var _preview_y = inv_draw_y + _grid_y * cell_size;
            var _can_place = inv.inventory_can_place(selected_item, _grid_x, _grid_y, _drag_item.w, _drag_item.h);
            var _preview_color = _can_place ? c_lime : c_red;

            draw_set_alpha(0.2);
            draw_set_color(_preview_color);
            draw_rectangle(_preview_x, _preview_y, _preview_x + _drag_w, _preview_y + _drag_h, false);
            draw_set_color(c_white);

            if (_drag_item.rotated) {
                draw_sprite_stretched_ext(spr_item_box, 0, _preview_x + 4, _preview_y + 4, _drag_w - 8, _drag_h - 8, c_white, 0.55);
                draw_sprite_ext(
                    _drag_item.sprite,
                    0,
                    _preview_x + _drag_w - 2,
                    _preview_y + 2,
                    (_drag_h - 2) / _spr_w,
                    (_drag_w - 2) / _spr_h,
                    270,
                    c_white,
                    0.55
                );
            } else {
                draw_sprite_stretched_ext(spr_item_box, 0, _preview_x + 4, _preview_y + 4, _drag_w - 8, _drag_h - 8, c_white, 0.55);
                draw_sprite_stretched_ext(_drag_item.sprite, 0, _preview_x + 4, _preview_y + 4, _drag_w - 8, _drag_h - 8, c_white, 0.55);
            }

            draw_set_alpha(1);
        }

        var _mouse_x = _mx;
        var _mouse_y = _my;

        draw_set_color(c_white);
        draw_set_alpha(0.9);

        if (_drag_item.rotated) {
            draw_sprite_stretched(spr_item_box, 0, _mouse_x + 4, _mouse_y + 4, _drag_w - 8, _drag_h - 8);
            draw_sprite_ext(
                _drag_item.sprite,
                0,
                _mouse_x + _drag_w - 2,
                _mouse_y + 2,
                (_drag_h - 2) / _spr_w,
                (_drag_w - 2) / _spr_h,
                270,
                c_white,
                1
            );
        } else {
            draw_sprite_stretched(spr_item_box, 0, _mouse_x + 4, _mouse_y + 4, _drag_w - 8, _drag_h - 8);
            draw_sprite_stretched(_drag_item.sprite, 0, _mouse_x + 4, _mouse_y + 4, _drag_w - 8, _drag_h - 8);
        }

        if (_drag_item.amount > 1) {
            draw_set_font(fnt_arial);
            draw_set_color(c_aqua);
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            draw_text(_mouse_x + _drag_w - 20, _mouse_y + _drag_h - 24, string(_drag_item.amount));
            draw_set_color(c_white);
        }

        draw_set_alpha(1);
    }
}

gpu_pop_state();
