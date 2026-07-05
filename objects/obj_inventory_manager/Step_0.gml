/// @description Insert description here
// You can write your code in this editor

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var grid_x = floor((mx - inv_draw_x) / cell_size);
var grid_y = floor((my - inv_draw_y) / cell_size);

var inside_grid = grid_x >= 0 && grid_x < inv.cols && grid_y >= 0 && grid_y < inv.rows;

if (keyboard_check_pressed(vk_tab)) {
    inventory_open = !inventory_open;
        global.game_paused = inventory_open;
    window_mouse_set_locked(!inventory_open);
}

if (mouse_check_button_pressed(mb_left) && inside_grid) {
    selected_item = inv.item_at_cell(grid_x, grid_y);

    if (selected_item >= 0) {
        dragging = true;
    }
}

if (dragging && selected_item >= 0) {
    if (keyboard_check_pressed(ord("R"))) {
        inv.inventory_rotate_item(selected_item);
    }
}

if (mouse_check_button_released(mb_left) && dragging) {
    if (inside_grid) {
        inv.inventory_move_item(selected_item, grid_x, grid_y);
    }

    dragging = false;
    selected_item = -1;
}




