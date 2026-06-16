extends CanvasLayer
@onready var hearts_container = $Hearts
var hearttexture = preload("res://Assets/HeartTexture.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = get_tree().get_first_node_in_group("player")
	player.health_changed.connect(update_hearts)
	create_hearts(3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_hearts(current_health):
	create_hearts(current_health)
	
func create_hearts(current_health):
	for child in hearts_container.get_children():
		child.queue_free()
		
	for i in range(current_health):
		var heart = hearttexture.instantiate()
		hearts_container.add_child(heart)
	
	
