extends Node


export(int) var minDistance = 0
export(int) var maxDistance = 0
export(bool) var useX = true
export(bool) var useY = true
export(float, 0, 1) var multiplierX = 1
export(float, 0, 1) var multiplierY = 1
export(int, 1, 60) var shakesPerSecond = 1
export(NodePath) var targetNode = null

var originalPosition


func _ready():
	if targetNode == null:
		targetNode = get_child(1)
	else:
		targetNode = get_node(targetNode)
		
	if minDistance > maxDistance:
		minDistance = 0
	
	originalPosition = targetNode.position
	
	$Timer.wait_time = 1 / shakesPerSecond
	var _err = $Timer.connect("timeout", self, "shake")
	
	
func start():
	$Timer.start()
	emit_signal("startedShaking")
	
	
func stop():
	$Timer.stop()
	targetNode.position = originalPosition


func shake():
	if useX:
		if round(rand_range(0, 1)):
			targetNode.position.x = originalPosition.x + rand_range(minDistance, maxDistance) * multiplierX
		else:
			targetNode.position.x = originalPosition.x + rand_range(-minDistance, -maxDistance) * multiplierX
		
	randomize()
	
	if useY:
		if round(rand_range(0, 1)):
			targetNode.position.y = originalPosition.y + rand_range(minDistance, maxDistance) * multiplierX
		else:
			targetNode.position.y = originalPosition.y + rand_range(-minDistance, -maxDistance) * multiplierY
	
	emit_signal("onShake")
	
	
func setShakesPerSecond(sps):
	$Timer.wait_time = float(1.0 / float(sps))
	print(float(1.0 / float(sps)))
	
	
signal onShake
signal startedShaking
