extends Node

var _runner: Node


func _set_runner(runner: Node) -> void:
	_runner = runner


func before_each() -> void:
	PoolManager.clear_all()


func after_each() -> void:
	PoolManager.clear_all()


func test_acquire_release_reuses_instance() -> void:
	var scene := load("res://scenes/interactables/sample_pooled_marker.tscn") as PackedScene
	PoolManager.register_scene(&"sample_marker", scene, 0, self)

	var first := PoolManager.acquire(&"sample_marker", self)
	_runner.assert_not_null(first, "first acquire returns a node")
	_runner.assert_eq(PoolManager.get_active_count(&"sample_marker"), 1)

	PoolManager.release(first)
	_runner.assert_eq(PoolManager.get_active_count(&"sample_marker"), 0)
	_runner.assert_eq(PoolManager.get_available_count(&"sample_marker"), 1)

	var second := PoolManager.acquire(&"sample_marker", self)
	_runner.assert_true(first == second, "pool reuses released instance")
	_runner.assert_eq(second.get_meta("pool_id"), &"sample_marker")
