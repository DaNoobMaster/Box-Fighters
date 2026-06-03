extends Area2D
var speed = 500
const damage = 10
func _physics_process(delta):
	position.x += speed * delta




func _on_Area2D_body_entered(body):
	if body.name == "Player2":
		body.storage["health"] -= 10
		self.queue_free()
