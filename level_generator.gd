extends Node2D

const Room = preload("res://Rooms/room.tscn")
const Player = preload("res://Players/frog_1.tscn")
const Camera = preload("res://Core/camera_2d.tscn")
const ROOM_WIDTH = 1920
const ROOM_HEIGHT = 1080
const GRID_SIZE = 5

var player_ref: CharacterBody2D
var grid = {}  
var start_pos = Vector2i(2, 4) 
var room_count = randi_range(5,6)
var current_room_pos = start_pos

func _ready():
	var cam = Camera.instantiate()
	add_child(cam)
	generate()
	var start_world_pos = Vector2(start_pos.x * ROOM_WIDTH + ROOM_WIDTH/2,
	start_pos.y * ROOM_HEIGHT + ROOM_HEIGHT / 2)
	spawn_player(start_world_pos)
	cam.global_position = start_world_pos
	cam.target_position = start_world_pos
	UI_Manager.show_Level_Ui()
	
func _process(_delta):
	if player_ref == null:
		return
	var room_origin = Vector2(current_room_pos.x * ROOM_WIDTH, 
	current_room_pos.y * ROOM_HEIGHT
	)
	var local_pos = player_ref.global_position - room_origin
	
	if local_pos.x > ROOM_WIDTH:
		change_room(Vector2i(1,0))
	elif local_pos.x < 0:
		change_room(Vector2i(-1, 0))
	elif local_pos.y > ROOM_HEIGHT:
		change_room(Vector2i(0, 1))
	elif local_pos.y < 0:
		change_room(Vector2i(0, -1))
		
func generate():
	grid.clear()
	
	var current = start_pos
	grid[current] = null  
	
	
	
	for i in range(room_count):
		var neighbors = [
			current + Vector2i(1, 0),
			current + Vector2i(-1, 0),
			current + Vector2i(0, 1),
			current + Vector2i(0, -1),
			current + Vector2i(0, -1),
		]
	
		neighbors = neighbors.filter(func(n): 
			return n.x >= 0 and n.x < GRID_SIZE and n.y >= 0 and n.y < GRID_SIZE
		)
		current = neighbors[randi() % neighbors.size()]
		grid[current] = null
	
	spawn_rooms()
	setup_doors()
	
func setup_doors():
	for grid_pos in grid.keys():
		var room = grid[grid_pos]
		room.set_doors(
			grid.has(grid_pos + Vector2i(0, -1)),  # north
			grid.has(grid_pos + Vector2i(0, 1)),   # south
			grid.has(grid_pos + Vector2i(1, 0)),   # east
			grid.has(grid_pos + Vector2i(-1, 0))   # west
			)
		

func spawn_player(pos: Vector2):
	var player = Player.instantiate()
	player.position = pos
	add_child(player)
	player_ref = player
	
func spawn_rooms():
	for grid_pos in grid.keys():
		var room = Room.instantiate()
		room.position = Vector2(grid_pos.x * ROOM_WIDTH, grid_pos.y * ROOM_HEIGHT)
		add_child(room)
		grid[grid_pos] = room
		
func change_room(direction: Vector2i):
	var new_pos = current_room_pos + direction
	if grid.has(new_pos):
		current_room_pos = new_pos
		$Camera2D.global_position = Vector2(
			new_pos.x * ROOM_WIDTH + ROOM_WIDTH / 2, 
			new_pos.y * ROOM_HEIGHT + ROOM_HEIGHT / 2
		)
	
	
