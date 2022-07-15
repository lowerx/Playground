extends Node

signal update

var start = true
var _game_scene = false


func _ready():
	randomize()


func _process(delta):
	pass


func game_scene():
	_game_scene = true


func not_game_scene():
	_game_scene = false


func reset_values():
	not_game_scene()
