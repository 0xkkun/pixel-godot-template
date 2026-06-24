extends Node

var _runner: Node


func _set_runner(runner: Node) -> void:
	_runner = runner


func before_each() -> void:
	PoolManager.clear_all()
	GameManager.reset_session()


func after_each() -> void:
	PoolManager.clear_all()
	GameManager.reset_session()


func test_session_interaction_and_summary() -> void:
	var packed := load("res://scenes/session/session_root.tscn") as PackedScene
	var session := packed.instantiate()
	add_child(session)

	var dispatched: int = session.trigger_sample_interaction()
	_runner.assert_eq(dispatched, 1, "one interactable receives interaction check")
	_runner.assert_eq(session.completed_interactions, 1, "interaction updates session count")
	_runner.assert_eq(PoolManager.get_active_count(&"sample_marker"), 1, "interaction spawns pooled marker")

	var result: Dictionary = session.finish_session()
	_runner.assert_eq(result["interactions"], 1)
	_runner.assert_false(GameManager.is_session_active(), "session is no longer active")

	session.queue_free()


func test_session_root_preserves_existing_config() -> void:
	GameManager.start_session({"source": "preconfigured"})

	var packed := load("res://scenes/session/session_root.tscn") as PackedScene
	var session := packed.instantiate()
	add_child(session)

	_runner.assert_eq(GameManager.get_active_config()["source"], "preconfigured")

	session.queue_free()
