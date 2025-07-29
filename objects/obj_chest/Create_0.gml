event_inherited();
open = false;
maxDropSpd = 4;
maxDropJumpSpd = 5;

//FIND VALUES FOR THE CHEST BASED ON INDEXES
var file_content = "";
var file_buffer = buffer_load("LootTables/chest_table.txt");
if( file_buffer != -1){
	file_content = buffer_read(file_buffer, buffer_string);
	buffer_delete(file_buffer);
}
var loot_table		= json_parse(file_content);
var loot_table_map	= struct_to_dsmap(loot_table);
var values = loot_table_map[? idLoot];

type = values[? "type"];
drop = noone;
switch(type){
	#region chest of COINS
	case "coins":
		var smallCoins	= 0;
		var mediumCoins = 0;
		var bigCoins	= 0;
		
		if(ds_map_exists(values, "wallet")){
			var walletAux = values[? "wallet"]; 
			
			if(ds_map_exists(walletAux, "small")){
				smallCoins = walletAux[? "small"];
			}
			if(ds_map_exists(walletAux, "medium")){
				mediumCoins = walletAux[? "medium"];
			}
			if(ds_map_exists(walletAux, "big")){
				bigCoins = walletAux[? "big"];
			}
		}
		drop = new Wallet(smallCoins, mediumCoins, bigCoins);
	break;
	#endregion
	
}
//
