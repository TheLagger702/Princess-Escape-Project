
function debug_print_ds_map(map) {    
    var key = undefined;
    var value = undefined;
    var iterator = ds_map_find_first(map);
    while (iterator != -1) {
        key = ds_map_find_key(map, iterator);
        value = ds_map_find_value(map, key);
        
        // If value itself is a ds_map or ds_list, you could recursively print it or just mention type
        if (ds_exists(value, ds_type_map)) {
            show_debug_message(key + ": [ds_map]");
        } else if (ds_exists(value, ds_type_list)) {
            show_debug_message(key + ": [ds_list]");
        } else {
            show_debug_message(key + ": " + string(value));
        }
        
        iterator = ds_map_find_next(map, iterator);
    }
}