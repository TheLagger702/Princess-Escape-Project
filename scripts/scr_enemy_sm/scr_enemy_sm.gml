function EnemyState(_name, _on_enter, _on_update, _on_exit, _transition) constructor{
	__name		 = _name;
	__on_enter	 = _on_enter;
	__on_update  = _on_update;
	__on_exit	 = _on_exit;
	__transition = _transition;
}


#region StateMachine class
function StateMachine() constructor {
    state = undefined;
    states = {};
    
    static addState = function(_state) {
		#region addState parameter validation
			if(!is_struct(_state)){
				show_error("The provided parameter is not a valid EnemyState struct.", true);
			}
			
		    if (
			    !variable_struct_exists(_state, "__name")
			) {
			    show_error("Invalid or missing '__name' property in EnemyState. Must be an enum.", true);
			}
		    if (
				!variable_struct_exists(_state, "__on_enter") || 
				(!is_method(_state.__on_enter) && !is_undefined(_state.__on_enter))
			) {
		        show_error("Invalid or missing '__on_enter' property in EnemyState.", true);
		    }

		    if (
				!variable_struct_exists(_state, "__on_update") || 
				(!is_method(_state.__on_update) && !is_undefined(_state.__on_update))
			) {
		        show_error("Invalid or missing '__on_update' property in EnemyState.", true);
		    }

		    if (
				!variable_struct_exists(_state, "__on_exit") || 
				(!is_method(_state.__on_exit) && !is_undefined(_state.__on_exit))
			) {
		        show_error("Invalid or missing '__on_exit' property in EnemyState.", true);
		    }
			
			if (
				!variable_struct_exists(_state, "__transition") || 
				(!(ds_exists(_state.__transition, ds_type_map)) && !is_undefined(_state.__transition))
			) {
		        show_error("Invalid or missing '__transition' property in EnemyState.", true);
		    } else {
				var key  = ds_map_keys_to_array(_state.__transition);
				var size = array_length(key);
				for (var i = 0; i < size; i += 1){	
					#region Transition class parameter validation
						var transition = _state.__transition[? key[i]];
					
						if (
							!is_method(transition) && !is_undefined(transition)
						) {
					        show_error(
								"Invalid or missing '[" + string(i) + "]' property in EnemyStateTransition.", 
								true
							);
					    } else {
							var test_result = transition(undefined);
							if (!is_bool(test_result)) {
							    show_error("Transition function for [" + string(i) +"] must return boolean value.", true);
							}
						}
					#endregion
				}	
			}
		#endregion
		
        states[$ _state.__name] = {
            onEnter:		 _state.__on_enter,
            onUpdate:		 _state.__on_update,
            onExit:			 _state.__on_exit,
            onTransition:	 _state.__transition
        }; 
    }
	
	static setInitialState = function(_name) {
		if(states[$ _name] != undefined){
			state = _name;
		}
	}
    
    static setState = function (_new_state, _exit_params = undefined, _enter_params = undefined) {
		if(state != _new_state){
			if (state != undefined && states[$ state].onExit != undefined) {
				states[$ state].onExit(_exit_params);
			}
			state = _new_state;
			if (states[$ state].onEnter != undefined) {
	            states[$ state].onEnter(_enter_params);
	        }
		}
    }
	
    static getState = function() {
        return state;
    }
    
    static update = function (_parameters, _conditions) {
        if (state == undefined) return;
	
        var _current = states[$ state];
        if (_current.onUpdate != undefined) {
            _current.onUpdate(_parameters);
        }
		var arrLength = array_length(_conditions);
		for (var i = 0; i < arrLength; i += 1){
			var condition = _conditions[i];
			var transition = _current.onTransition[? condition._next_state];
			if(!is_undefined(transition) && transition(condition._conditions)){
				setState(condition._next_state, condition._exit_params, condition._enter_params);
				break;
			}
		}
    }
}
#endregion