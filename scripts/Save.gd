extends Node

const SAVE_PATH = "res://save.json"

func _ready():
	pass

func save_game():
	var save_dict = {}
	var nodes_to_save = get_tree().get_nodes_in_group('persistent')
	for node in nodes_to_save:
		save_dict[node.get_path()] = node.save()
	
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	
	save_file.store_line(to_json(save_dict))
	
	save_file.close()
	pass

func load_game():
	var save_file = File.new()
	
	if not save_file.file_exists(SAVE_PATH):
		return
	
	save_file.open(SAVE_PATH, File.READ)
	
	var data = {}
	data = parse_json(save_file.get_as_text())
	
	for node_path in data.keys():
		var node = get_node(node_path)
		for attribute in data[node_path]:
			if attribute == "pos":
				#node.set_position(Vector2(data[node_path]['pos']['x'], data[node_path]['pos']['y'])) 
				Global.Position = Vector2(data[node_path]['pos']['x'], data[node_path]['pos']['y'])
			elif attribute == "max_health":
				Global.Max_Health = data[node_path]['max_health']
			elif attribute == "health":
				Global.Health = data[node_path]['health']
			elif attribute == "dash":
				Global.Dash = data[node_path]['dash']
			elif attribute == "double_jump":
				Global.Double_Jump = data[node_path]['double_jump']
		
	pass
