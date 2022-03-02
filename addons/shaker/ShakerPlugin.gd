tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("Shaker", "Node", preload("Shaker.gd"), preload("Shaker.svg"))


func _exit_tree():
	remove_custom_type("Shaker")


