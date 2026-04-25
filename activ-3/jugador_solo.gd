extends CharacterBody2D

@export var velocidad_move = 300
@export var Salto_VELOCITY= -100
var espejo:bool = true
const Dasheo = 900
var AccionDash: bool= false
var podemoDashear: bool= true


func _physics_process(delta):
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	
	
	if Input.is_action_just_pressed("Salto") and is_on_floor():
		velocity.y = Salto_VELOCITY	
	
	var inputaxis = Input.get_axis("Izquierda","Derecha")
	if inputaxis:
		if AccionDash:
			velocity.x = inputaxis * Dasheo	
		else:
			velocity.x = inputaxis * velocidad_move
	else:
		velocity.x = move_toward(velocity.x, 0, velocidad_move)


	if Input.is_action_just_pressed("DASH") and podemoDashear:
		AccionDash = true
		podemoDashear = false
		$dasheo.start()
		$CargadorDash.start()
	

	if (espejo and velocity.x <0) or (not espejo and velocity.x >0):
		scale.x *= -1
		espejo = not espejo
		

	
		
	

func _on_dasheo_timeout() -> void:
	AccionDash = false


func _on_cargador_dash_timeout() -> void:
	podemoDashear = true 
