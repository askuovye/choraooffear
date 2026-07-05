/// @description Insert description here
// You can write your code in this editor

inv = new inventory(9, 5);

inventory_open = false;
blur_surface = -1;
blur_scale = 0.1;

selected_item = -1;
dragging = false;

cell_size = 64;
cell_padding = 3;
inv_draw_x = 345;
inv_draw_y = 245;


inv.inventory_auto_add_item("Cellphone", spr_cellphone, 2, 1, 1, false);
inv.inventory_auto_add_item("Knife", spr_knife, 2, 1, 1, false);
inv.inventory_auto_add_item("Pistol", spr_pistol, 3, 2, 1, false);
inv.inventory_auto_add_item("Handgun Ammo", spr_ammo, 1, 1, 10, true, 50);
