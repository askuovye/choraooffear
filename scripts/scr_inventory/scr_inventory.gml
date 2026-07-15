global.game_paused = false;

function inventory(_cols = 10, _rows = 6) constructor {

    cols = _cols;
    rows = _rows;

    _inventory_items = [];

    function item_create(_name, _sprite, _w, _h, _grid_x, _grid_y, _amount = 1, _stackable = false, _max_stack = 99) {
        return {
            name: _name,
            sprite: _sprite,

            w: _w,
            h: _h,

            grid_x: _grid_x,
            grid_y: _grid_y,

            amount: _amount,

            stackable: _stackable,
            max_stack: _max_stack,

            rotated: false
        };
    }

    function item_find(_name) {
        for (var i = 0; i < array_length(_inventory_items); i++) {
            if (_inventory_items[i].name == _name) {
                return i;
            }
        }

        return -1;
    }

    function item_find_stackable(_name) {
        for (var i = 0; i < array_length(_inventory_items); i++) {
            var _item = _inventory_items[i];

            if (_item.name == _name && _item.stackable && _item.amount < _item.max_stack) {
                return i;
            }
        }

        return -1;
    }

    function item_at_cell(_grid_x, _grid_y) {
        for (var i = array_length(_inventory_items) - 1; i >= 0; i--) {
            var _item = _inventory_items[i];

            var _left = _item.grid_x;
            var _right = _item.grid_x + _item.w;
            var _top = _item.grid_y;
            var _bottom = _item.grid_y + _item.h;

            if (_grid_x >= _left && _grid_x < _right && _grid_y >= _top && _grid_y < _bottom) {
                return i;
            }
        }

        return -1;
    }

    function inventory_can_place(_item_index, _grid_x, _grid_y, _w, _h) {
        if (_grid_x < 0) return false;
        if (_grid_y < 0) return false;

        if (_grid_x + _w > cols) return false;
        if (_grid_y + _h > rows) return false;

        for (var i = 0; i < array_length(_inventory_items); i++) {
            if (i == _item_index) continue;

            var _other = _inventory_items[i];

            var a_left = _grid_x;
            var a_right = _grid_x + _w;
            var a_top = _grid_y;
            var a_bottom = _grid_y + _h;

            var b_left = _other.grid_x;
            var b_right = _other.grid_x + _other.w;
            var b_top = _other.grid_y;
            var b_bottom = _other.grid_y + _other.h;

            var _overlap = a_left < b_right &&
                           a_right > b_left &&
                           a_top < b_bottom &&
                           a_bottom > b_top;

            if (_overlap) {
                return false;
            }
        }

        return true;
    }

    function inventory_find_free_space(_w, _h) {
        for (var yy = 0; yy < rows; yy++) {
            for (var xx = 0; xx < cols; xx++) {
                if (inventory_can_place(-1, xx, yy, _w, _h)) {
                    return {
                        found: true,
                        grid_x: xx,
                        grid_y: yy
                    };
                }
            }
        }

        return {
            found: false,
            grid_x: -1,
            grid_y: -1
        };
    }

    function inventory_push_item(_name, _sprite, _w, _h, _grid_x, _grid_y, _amount = 1, _stackable = false, _max_stack = 99) {
        if (!inventory_can_place(-1, _grid_x, _grid_y, _w, _h)) {
            return false;
        }

        var _item = item_create(_name, _sprite, _w, _h, _grid_x, _grid_y, _amount, _stackable, _max_stack);
        array_push(_inventory_items, _item);

        return true;
    }

    function inventory_add_item(_name, _sprite, _w, _h, _grid_x, _grid_y, _amount = 1, _stackable = false, _max_stack = 99) {
        if (_stackable) {
            var _stack_index = item_find_stackable(_name);

            if (_stack_index >= 0) {
                var _item = _inventory_items[_stack_index];

                var _space_left = _item.max_stack - _item.amount;
                var _add_amount = min(_amount, _space_left);

                _inventory_items[_stack_index].amount += _add_amount;
                _amount -= _add_amount;

                if (_amount <= 0) {
                    return true;
                }
            }
        }

        return inventory_push_item(_name, _sprite, _w, _h, _grid_x, _grid_y, _amount, _stackable, _max_stack);
    }

    function inventory_auto_add_item(_name, _sprite, _w, _h, _amount = 1, _stackable = false, _max_stack = 99) {
        if (_stackable) {
            var _stack_index = item_find_stackable(_name);

            if (_stack_index >= 0) {
                var _item = _inventory_items[_stack_index];

                var _space_left = _item.max_stack - _item.amount;
                var _add_amount = min(_amount, _space_left);

                _inventory_items[_stack_index].amount += _add_amount;
                _amount -= _add_amount;

                if (_amount <= 0) {
                    return true;
                }
            }
        }

        var _space = inventory_find_free_space(_w, _h);

        if (!_space.found) {
            return false;
        }

        return inventory_push_item(_name, _sprite, _w, _h, _space.grid_x, _space.grid_y, _amount, _stackable, _max_stack);
    }

    function inventory_move_item(_index, _grid_x, _grid_y) {
        if (_index < 0 || _index >= array_length(_inventory_items)) {
            return false;
        }

        var _item = _inventory_items[_index];

        if (!inventory_can_place(_index, _grid_x, _grid_y, _item.w, _item.h)) {
            return false;
        }

        _inventory_items[_index].grid_x = _grid_x;
        _inventory_items[_index].grid_y = _grid_y;

        return true;
    }

    function inventory_rotate_item(_index) {
        if (_index < 0 || _index >= array_length(_inventory_items)) {
            return false;
        }

        var _item = _inventory_items[_index];

        var _old_w = _item.w;
        var _old_h = _item.h;

        var _new_w = _old_h;
        var _new_h = _old_w;

        if (!inventory_can_place(_index, _item.grid_x, _item.grid_y, _new_w, _new_h)) {
            return false;
        }

        _inventory_items[_index].w = _new_w;
        _inventory_items[_index].h = _new_h;
        _inventory_items[_index].rotated = !_inventory_items[_index].rotated;

        return true;
    }

    function item_has(_name, _amount = 1) {
        var _total = 0;

        for (var i = 0; i < array_length(_inventory_items); i++) {
            if (_inventory_items[i].name == _name) {
                _total += _inventory_items[i].amount;
            }
        }

        return _total >= _amount;
    }

    function item_remove(_index) {
        if (_index < 0 || _index >= array_length(_inventory_items)) {
            return false;
        }

        array_delete(_inventory_items, _index, 1);
        return true;
    }

    function inventory_subtract_item(_name, _amount = 1) {
        for (var i = array_length(_inventory_items) - 1; i >= 0; i--) {
            if (_inventory_items[i].name == _name) {
                var _remove_amount = min(_amount, _inventory_items[i].amount);

                _inventory_items[i].amount -= _remove_amount;
                _amount -= _remove_amount;

                if (_inventory_items[i].amount <= 0) {
                    item_remove(i);
                }

                if (_amount <= 0) {
                    return true;
                }
            }
        }

        return false;
    }

    function inventory_get_amount(_name) {
        var _total = 0;

        for (var i = 0; i < array_length(_inventory_items); i++) {
            if (_inventory_items[i].name == _name) {
                _total += _inventory_items[i].amount;
            }
        }

        return _total;
    }

    function inventory_get_items() {
        return _inventory_items;
    }
}