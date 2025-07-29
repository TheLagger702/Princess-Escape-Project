/// struct_to_dsmap(struct)
/// Converts a struct into a ds_map (deep copy, converts nested structs and arrays)
function struct_to_dsmap(struct) {
    var map = ds_map_create();
    
    // Iterate all keys in struct using variable_struct_get & variable_struct_get_names
    var keys = variable_struct_get_names(struct);
    
    for (var i = 0; i < array_length(keys); i++) {
        var key = keys[i];
        var val = variable_struct_get(struct, key);
        
        // Recursively convert if val is a struct
        if (is_struct(val)) {
            val = struct_to_dsmap(val);
        }
        // Recursively convert arrays (to ds_lists optionally)
        else if (is_array(val)) {
            val = array_to_dslist(val);
        }
        
        ds_map_add(map, key, val);
    }
    
    return map;
}

/// Helper func: convert array to ds_list (for consistency)
function array_to_dslist(arr) {
    var list = ds_list_create();
    var len = array_length(arr);
    for (var i = 0; i < len; i++) {
        var v = arr[i];
        if (is_struct(v)) v = struct_to_dsmap(v);
        else if (is_array(v)) v = array_to_dslist(v);
        
        ds_list_add(list, v);
    }
    return list;
}