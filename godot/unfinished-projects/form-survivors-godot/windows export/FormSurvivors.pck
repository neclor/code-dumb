GDPC                                                                                        #   `   res://.godot/exported/133200997/export-31589d5f9806bc2986bfe9638277b2c5-background_tile_set.res PQ      /H      lrTL�R����\Qf0    T   res://.godot/exported/133200997/export-58931b9e92906aa2320ce93db677ddfa-arena.scn          �      F��A�j��A����    \   res://.godot/exported/133200997/export-5fdce28b2025df3d853251c40a0711cf-health_component.scn�'      �      ���uTIW�Q���ѿ    X   res://.godot/exported/133200997/export-61fb7fc5b7a55c61eeb6f8db1465f77d-base_entity.scn �      �      ���Cs�e�g�F�	    \   res://.godot/exported/133200997/export-7b0be4150891a4ed04933ec28014b0f4-enemy_spawner.scn   p      U      �,�B葘�a�9���    T   res://.godot/exported/133200997/export-830bf86f4afb9a173baa051efc06cd7c-enemy.scn   `<            �4�� �����ӻ��    \   res://.godot/exported/133200997/export-c9d39ff9595f45da5ea18bd35a51363f-circle_component.scn�       �      z�X�i��MZ���4R�    `   res://.godot/exported/133200997/export-ce23a4a94a80352cdeb7ba9cfe76344e-polygon_component.scn   �.      =      .���B	�l>��x���    T   res://.godot/exported/133200997/export-ff1633955aab3abd1fa22a039261d084-player.scn  @F      P      h��6er���J^ٷF[    ,   res://.godot/global_script_class_cache.cfg  p�      <      g3^�~�o$O �+�
    L   res://.godot/imported/flat_tailset.png-1e80694cd88b50c73ae7fe6a9ea0ce69.ctex        N      �"	��Ќ7�� ��       res://.godot/uid_cache.bin  ��      �      	��8�YV�L��l{D*Z    ,   res://assets/sprites/flat_tailset.png.importP      �       �K���6b ���ڒ1?       res://core/global.gd       f       Fx��}Hܖ7ާ|p��       res://game/arena/arena.gd   `      �      �ɪ3��N�P��K[    $   res://game/arena/arena.tscn.remap   �      b       \ �#�aB�y���(���    0   res://game/arena/enemy_spawner/enemy_spawner.gd �      �      ��C������f��    8   res://game/arena/enemy_spawner/enemy_spawner.tscn.remap ��      j       �Г�+��=q�O���!    0   res://game/arena/enemy_spawner/spawning_enemy.gd�
      �      ����4�L�e~X�,Bx    0   res://game/entities/base_entity/base_entity.gd  �      �      @��T:$}��rf���    8   res://game/entities/base_entity/base_entity.tscn.remap  `�      h       ��)������~�v��L�    D   res://game/entities/components/circle_component/circle_component.gd �            }�#��OD=��    L   res://game/entities/components/circle_component/circle_component.tscn.remap К      m       &�� �>`�|�,U�    D   res://game/entities/components/health_component/health_component.gd @#      �      �;��A#⮢W$�fj�    L   res://game/entities/components/health_component/health_component.tscn.remap @�      m       6^r��[�jl�U�u�    H   res://game/entities/components/polygon_component/polygon_component.gd   �+      �      %����G�.Va/�    P   res://game/entities/components/polygon_component/polygon_component.tscn.remap   ��      n       ���%8�+�D�Hș�    $   res://game/entities/enemy/enemy.gd  �1      �
      /_:mˆ\������    ,   res://game/entities/enemy/enemy.tscn.remap   �      b       �~G����F�I��    $   res://game/entities/player/camera.gdpA      E      d~^5��\���z���    $   res://game/entities/player/player.gd�B      q      j�v¿����N2�,LE    ,   res://game/entities/player/player.tscn.remap��      c       �ڤ��z��Ae��n�I       res://project.binary��      P"      9��p6:S%� ��t��    $   res://resources/arena_tile_set.res  �L      �      M.|0'm\�3pU>]�    0   res://resources/background_tile_set.tres.remap   �      p       �Mϳ(M��Q,/'.�        GST2   �   `      ����               � `          RIFF  WEBPVP8L  /��!�����̓��)C)e(C(��K�t�=N�������m�H���dw��@�a S�8x��0��8	��׷X�]5
����5
 Є��L5S��28<�n
������Z��.b�"�{�jW�;���IN�M�7��R(4p���'�lK������A&��`Pf��^XD�%*�Q��(��C׻J��h��ۛؽ"g�����h�ox�P]��{S ���U)�����*�8�:���R֐��+K���    [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dc8eioweekg30"
path="res://.godot/imported/flat_tailset.png-1e80694cd88b50c73ae7fe6a9ea0ce69.ctex"
metadata={
"vram_texture": false
}
        extends Node

var rng := RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	seed(rng.seed)
          extends Node2D


@onready var arena = get_parent()
@onready var available_arena_radius = arena.ARENA_RADIUS - 1
@onready var cell_size = arena.CELL_SIZE
@onready var player = get_parent().get_node_or_null("Player")


var current_enemy_level := 3
var enemy_counter := 3


func _on_enemy_spawner_timer_timeout():
	spawn_new_enemy()


func spawn_new_enemy():
	var new_spawning_enemy = SpawningEnemy.new(get_enemy_level())
	new_spawning_enemy.position = choose_position()
	arena.add_child(new_spawning_enemy)


func get_enemy_level():
	if enemy_counter == 0:
		current_enemy_level += 1
		enemy_counter = current_enemy_level
	enemy_counter -= 1
	return current_enemy_level


func choose_position():
	var new_enemy_position = player.position
	var player_direction_vector = player.move_direction_vector

	if randi_range(0, 1) == 0 or player_direction_vector == Vector2.ZERO:
		new_enemy_position += Vector2.from_angle(randf_range(0.0, 2 * PI)).normalized() * 2 * cell_size
	else:
		new_enemy_position += player.move_direction_vector.normalized() * 2 * cell_size

	if abs(new_enemy_position.x) >= available_arena_radius * cell_size or abs(new_enemy_position.y) >= available_arena_radius * cell_size:
		return choose_position()
	return new_enemy_position
  RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script 0   res://game/arena/enemy_spawner/enemy_spawner.gd ��������      local://PackedScene_ri1oi '         PackedScene          	         names "   	      EnemySpawner    script    Node2D    EnemySpawnerTimer 
   wait_time 
   autostart    Timer     _on_enemy_spawner_timer_timeout    timeout    	   variants                       @            node_count             nodes        ��������       ����                            ����                         conn_count             conns                                      node_paths              editable_instances              version             RSRC           class_name SpawningEnemy
extends Node2D


const ENEMY = preload("res://game/entities/enemy/enemy.tscn")
const DEFAULT_SPAWN_CIRCLE_RADIUS = 32
const SPAWN_TIME = 1
const SPAWN_CIRCLE_COLOR = Color("#ff000080")

var enemy_level : int
var spawn_circle_radius : float
var elapsed_time := 0.0


func _init(init_enemy_level : int):
	enemy_level = init_enemy_level


func _physics_process(delta):
	elapsed_time += delta

	if elapsed_time >= SPAWN_TIME:
		spawn_enemy()
		queue_free()

	spawn_circle_radius = Tween.interpolate_value(DEFAULT_SPAWN_CIRCLE_RADIUS, -DEFAULT_SPAWN_CIRCLE_RADIUS, elapsed_time, SPAWN_TIME, Tween.TRANS_LINEAR, Tween.EASE_IN)
	queue_redraw()


func _draw():
	draw_circle(Vector2.ZERO, spawn_circle_radius, SPAWN_CIRCLE_COLOR)


func spawn_enemy():
	var new_enemy = ENEMY.instantiate()
	new_enemy.init(enemy_level)
	new_enemy.position = self.position
	get_parent().add_child(new_enemy)
       extends Node2D


@onready var arena_tile_map = $ArenaTileMap


const ARENA_RADIUS = 17
const CELL_SIZE = 64


func _ready():
	create_arena()


func create_arena():
	arena_tile_map.set_cells_terrain_connect(0, create_cells_array(), 0, 0)


func create_cells_array():
	var cells_array := []
	for i in range(-ARENA_RADIUS, ARENA_RADIUS):
		for j in range(-ARENA_RADIUS, ARENA_RADIUS):
			cells_array.append(Vector2i(i, j))
	return cells_array
        RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://game/arena/arena.gd ��������   TileSet #   res://resources/arena_tile_set.res ��;�9.�M   PackedScene 2   res://game/arena/enemy_spawner/enemy_spawner.tscn fU�Ǵh1V   PackedScene '   res://game/entities/player/player.tscn k��:��*3      local://PackedScene_qef8c �         PackedScene          	         names "         Arena    script    Node2D    ArenaTileMap    texture_filter    scale 	   tile_set    format    TileMap    EnemySpawner    Player 	   position    	   variants                       
      @   @                                 
    ��C ��C      node_count             nodes     (   ��������       ����                            ����                                       ���	                      ���
                         conn_count              conns               node_paths              editable_instances              version             RSRC             class_name Entity
extends CharacterBody2D


@onready var die_particles = $DieParticles
@onready var health_component = $HealthComponent
@onready var collision : Node
@onready var figure : Node


const BORDER_RADIUS = 16.0
const BODY_RADIUS = 14.0
const BORDER_COLOR = Color.BLACK


var speed : int
var move_direction_vector : Vector2 = Vector2.ZERO


var attack_power : int


func _physics_process(_delta):
	move()


func move():
	pass


func move_step():
	velocity = move_direction_vector * speed
	move_and_slide()


func start_dying():
	collision.disabled = true
	figure.visible = false
	die_particles.restart()


func _on_die_particles_finished():
	die()


func die():
	queue_free()


func redraw_hp(hp_ratio : float):
	figure.redraw_hp(BODY_RADIUS * hp_ratio)
    RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script /   res://game/entities/base_entity/base_entity.gd ��������   PackedScene F   res://game/entities/components/health_component/health_component.tscn ��߲�f|"      local://PackedScene_hfeig �         PackedScene          	         names "         BaseEntity    collision_layer    script    entity    CharacterBody2D    DieParticles 	   emitting    amount 	   lifetime 	   one_shot    explosiveness    randomness    spread    gravity    initial_velocity_min    initial_velocity_max    angular_velocity_min    angular_velocity_max    scale_amount_min    scale_amount_max    CPUParticles2D    HealthComponent    _on_die_particles_finished 	   finished    	   variants                                           @           �?     4C
                 A     zD     4�     4D     �@      A               node_count             nodes     6   ��������       ����                                    ����                     	      
                           	      
                                       ���                    conn_count             conns                                      node_paths              editable_instances              version             RSRC            extends Node2D


var border_radius : float
var body_radius : float
var hp_radius : float
var border_color : Color
var body_color : Color
var hp_color : Color


func set_figure_parameters(input_border_radius : float, input_body_radius : float, input_border_color : Color, input_body_color : Color, input_hp_color : Color):
	border_radius = input_border_radius
	body_radius = input_body_radius
	hp_radius = body_radius
	border_color = input_border_color
	body_color = input_body_color
	hp_color = input_hp_color
	queue_redraw()


func _draw():
	draw_circle(Vector2.ZERO, border_radius, border_color)
	draw_circle(Vector2.ZERO, body_radius, body_color)
	draw_circle(Vector2.ZERO, hp_radius, hp_color)


func redraw_hp(new_hp_radius : float):
	hp_radius = new_hp_radius
	queue_redraw()
  RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script D   res://game/entities/components/circle_component/circle_component.gd ��������      local://PackedScene_ofiiv ;         PackedScene          	         names "         CircleComponent    script    Node2D    	   variants                       node_count             nodes     	   ��������       ����                    conn_count              conns               node_paths              editable_instances              version             RSRC        extends Node2D


@onready var parent = get_parent()
@onready var hp_regen_cooldown_timer = $HpRegenCooldownTimer


const DEFAULT_HP_REGEN_COOLDOWN = 5


var max_hp : int
var hp : int
var hp_regen_per_sec : int
var hp_regen_cooldown : int
var hp_regen_ready := true


func set_values(new_max_hp : int, new_hp_regen_per_sec : int, new_hp_regen_cooldown : int = DEFAULT_HP_REGEN_COOLDOWN):
	max_hp = new_max_hp
	hp = max_hp
	hp_regen_per_sec = new_hp_regen_per_sec
	hp_regen_cooldown = new_hp_regen_cooldown


func redraw_hp():
	parent.redraw_hp(1.0 * hp / max_hp)


func take_damage(input_damage : int):
	if input_damage == 0:
		return
	hp -= input_damage
	if hp <= 0:
		die()
		return
	start_hp_cooldown()
	redraw_hp()


func die():
	parent.start_dying()


func _on_hp_regen_timer_timeout():
	regen_hp()


func heal_hp(input_heal: int):
	hp += input_heal
	if hp > max_hp:
		hp = max_hp
	redraw_hp()


func regen_hp():
	if hp < max_hp and hp_regen_ready:
		heal_hp(hp_regen_per_sec)


func start_hp_cooldown():
	hp_regen_ready = false
	hp_regen_cooldown_timer.wait_time = hp_regen_cooldown
	hp_regen_cooldown_timer.start()


func _on_hp_regen_cooldown_timer_timeout():
	hp_regen_ready = true
          RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script D   res://game/entities/components/health_component/health_component.gd ��������      local://PackedScene_t01mo ;         PackedScene          	         names "         HealthComponent    script    Node2D    HpRegenTimer 
   autostart    Timer    HpRegenCooldownTimer 	   one_shot    _on_hp_regen_timer_timeout    timeout $   _on_hp_regen_cooldown_timer_timeout    	   variants                             node_count             nodes        ��������       ����                            ����                           ����                   conn_count             conns               	                        	   
                    node_paths              editable_instances              version             RSRC              extends Node2D


@onready var border_polygon = $BorderPolygon
@onready var body_polygon = $BodyPolygon
@onready var hp_polygon = $HpPolygon


func set_figure_parameters(input_border_polygon : PackedVector2Array, input_body_polygon : PackedVector2Array, input_border_color : Color, input_body_color : Color, input_hp_color : Color):
	border_polygon.polygon = input_border_polygon
	body_polygon.polygon = input_body_polygon
	hp_polygon.polygon = input_body_polygon

	border_polygon.color = input_border_color
	body_polygon.color = input_body_color
	hp_polygon.color = input_hp_color


func redraw_hp(input_hp_polygon : PackedVector2Array):
	hp_polygon.polygon = input_hp_polygon
	queue_redraw()
           RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script F   res://game/entities/components/polygon_component/polygon_component.gd ��������      local://PackedScene_qn8mh =         PackedScene          	         names "         PolygonComponent    script    Node2D    BorderPolygon 
   Polygon2D    BodyPolygon 
   HpPolygon    	   variants                       node_count             nodes        ��������       ����                            ����                      ����                      ����              conn_count              conns               node_paths              editable_instances              version             RSRC   class_name Enemy
extends Entity


@onready var collision_polygon = $CollisionPolygon
@onready var polygon_component = $PolygonComponent
@onready var hit_box = $HitBox
@onready var hit_box_collision_polygon = $HitBox/HitBoxCollisionPolygon
@onready var player = get_parent().get_node_or_null("Player")


const MIN_VERTICES_NUMBER = 3
var vertices_number : int 


var normalized_polygon : PackedVector2Array


func init(new_vertices_number : int = MIN_VERTICES_NUMBER):
	new_vertices_number = MIN_VERTICES_NUMBER if new_vertices_number < MIN_VERTICES_NUMBER else new_vertices_number
	vertices_number = new_vertices_number

	speed = vertices_number * 20
	attack_power = vertices_number


func _ready():
	health_component.set_values(vertices_number, 0)

	collision = collision_polygon
	figure = polygon_component

	set_polygons()

	self.rotation = randf_range(0.0, 2 * PI)


func set_polygons():
	var hp_color = choose_color()
	var body_color = hp_color / 2
	body_color.a = 1.0

	set_normalized_polygon()

	var border_polygon = create_polygon(BORDER_RADIUS)
	collision.polygon = border_polygon
	hit_box_collision_polygon.polygon = border_polygon

	figure.set_figure_parameters(border_polygon, create_polygon(BODY_RADIUS), BORDER_COLOR, body_color, hp_color)

	die_particles.color = hp_color


func choose_color():
	var color_components = [randf(), randf(), 0.0]
	var lower_limit = 1.0 - (color_components[0] + color_components[1])

	lower_limit = 0.0 if lower_limit < 0 else lower_limit

	color_components[2] = randf_range(lower_limit, 1.0)

	color_components.shuffle()
	return Color(color_components[0], color_components[1], color_components[2])


func create_polygon(factor : float):
	var polygon = normalized_polygon.duplicate()
	for i in polygon.size():
		polygon[i] *= factor
	return polygon


func set_normalized_polygon():
	var angle_between_points := 2 * PI / vertices_number
	var current_angle := 0.0
	normalized_polygon = []
	for i in vertices_number:
		var next_normalized_point = Vector2.from_angle(current_angle).normalized()
		normalized_polygon.append(next_normalized_point)
		current_angle += angle_between_points


func move():
	if player:
		move_direction_vector = global_position.direction_to(player.global_position).normalized()
		move_step()
	else:
		player = get_parent().get_node_or_null("Player")


func _on_hit_box_body_entered(body):
	if body.is_in_group("player"):
		body.health_component.take_damage(attack_power)
	start_dying()


func start_dying():
	collision.set_deferred("disabled", true)
	figure.visible = false
	hit_box.set_deferred("monitoring", false)
	die_particles.restart()


func redraw_hp(hp_ratio : float):
	figure.redraw_hp(create_polygon(BODY_RADIUS * hp_ratio))
 RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       PackedScene 1   res://game/entities/base_entity/base_entity.tscn H���s   Script #   res://game/entities/enemy/enemy.gd ��������   PackedScene H   res://game/entities/components/polygon_component/polygon_component.tscn (Jҽl�o      local://PackedScene_jux47 �         PackedScene          
         names "         Enemy    collision_layer    script    enemy    DieParticles    HealthComponent    CollisionPolygon    CollisionPolygon2D    PolygonComponent    HitBox    collision_mask    Area2D    HitBoxCollisionPolygon    _on_hit_box_body_entered    body_entered    	   variants                                                            node_count             nodes     ,   �����������    ����                                  ����                ���                        	  ����         
                      ����              conn_count             conns                                      node_paths              editable_instances              base_scene              version             RSRC    extends Camera2D


const MIN_ZOOM = Vector2(0.25, 0.25)
const MAX_ZOOM = Vector2(2, 2)


func _input(_event):
	if Input.is_action_pressed("zoom_in"):
		zoom_in()
	elif Input.is_action_pressed("zoom_out"):
		zoom_out()


func zoom_in():
	if zoom < MAX_ZOOM:
		zoom *= 1.1


func zoom_out():
	if zoom > MIN_ZOOM:
		zoom /= 1.1
           class_name Player
extends Entity


@onready var collision_shape = $CollisionShape
@onready var circle_component = $CircleComponent


const DEFAULT_SPEED = 150
const DEFAULT_ATTACK_POWER = 1
const DEFAULT_HP = 100
const HP_COLOR = Color.RED
const BODY_COLOR = Color("#800000")


var level := 0
var xp := 0


func _init():
	speed = DEFAULT_SPEED
	attack_power = DEFAULT_ATTACK_POWER


func _ready():
	health_component.set_values(DEFAULT_HP, 10)

	collision = collision_shape
	figure = circle_component

	figure.set_figure_parameters(BORDER_RADIUS, BODY_RADIUS, BORDER_COLOR, BODY_COLOR, HP_COLOR)

	die_particles.color = HP_COLOR


func move():
		var input_move_direction_vector = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
		move_direction_vector = input_move_direction_vector.normalized()
		move_step()


func die():
	print("mertv")
               RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    radius    script 	   _bundled       PackedScene 1   res://game/entities/base_entity/base_entity.tscn H���s   Script %   res://game/entities/player/player.gd ��������   PackedScene F   res://game/entities/components/circle_component/circle_component.tscn �=�&��v   Script %   res://game/entities/player/camera.gd ��������      local://CircleShape2D_0o61a Q         local://PackedScene_lpc62 {         CircleShape2D            �A         PackedScene          
         names "         Player    collision_layer    script    player    DieParticles    HealthComponent    CollisionShape    shape    CollisionShape2D    CircleComponent    Camera    position_smoothing_enabled    drag_horizontal_enabled    drag_vertical_enabled    drag_left_margin    drag_top_margin    drag_right_margin    drag_bottom_margin    editor_draw_drag_margin 	   Camera2D    	   variants                                                            ���=               node_count             nodes     5   �����������    ����                                  ����                     ���	                        
  ����	                                                                   conn_count              conns               node_paths              editable_instances              base_scene              version             RSRCRSCC      �  k  6  (�/�`  6cl:@����8��2<��X:p�֤6�{���H�$6��@�=6�glrs��
�Fv~5���D�Y Y ` q;!x��J���cϳ��2fC0V��Q�=�+.��?���%b�d{/���uX_k[�k�N�<���������N�x��6F����)�mi��KM�����ʲM��0VJ)�������m�E���W���(�X܅��܎=�u�ڃ����f4�u��F�F�);�#��^V�V߃�p|�wI�&�^��3k�9�!@Ț�gv���-�w��y�j_�LX������TJ)�̐���H���TJ)�*JU���	�5
H��P(���fX/��������+�������F]n�J,����c����R����?�%C�@D�!Ez���ګYo�9q/�J��7$�������6������I�ڨ�U3"#�$)I2����٦��$�aD`!�B� ���F*� �A�	��/ώ�БB��L��g�k��!��+�a|�d�/�o���u#vR}�ʖe��5����{���s���a��&���y���+�S3	�AJ�e� o槥3qg�<U8}
nF��M)����o��o��|����o����s��B�D�����;>Y���V�<�����'"�4���%�Q�lx$��U�ĠeIv�c'fe��ή˥3�Ul���N��񻞖y��Tv��Q�X+x&ȃ�X�kԖ����yKĪ3���@:�1$Dn�J�;�k�n/誐",$L����ȱ��?]���&���>�����6hv!�~���>��$�Pc�������?G�ch�Q~wJ�QSܤ�ScP��u���,�J$��_(���(�/�`�e	 $
  ��A              
       %    !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abc   TileSetgijkl   Arena m  �?�?nRSRCq�@�$�`�H���AAp������	�`V��H5�y���Lz|���=^(i�4���dd"x78ԁa�8$*r�M�����}����ڀ�����C�7M"X�h�*8�!O��~���>�'t����RSCC   RSRC                    TileSet            ��������                                            �     resource_local_to_scene    resource_name    texture    margins    separation    texture_region_size    use_texture_padding    2:0/next_alternative_id    2:0/0    2:0/0/terrain_set .   2:0/0/terrains_peering_bit/bottom_left_corner    2:0/0/script    2:0/1    2:0/1/modulate    2:0/1/terrain_set .   2:0/1/terrains_peering_bit/bottom_left_corner    2:0/1/script    2:0/2    2:0/2/modulate    2:0/2/terrain_set .   2:0/2/terrains_peering_bit/bottom_left_corner    2:0/2/script    2:0/3    2:0/3/modulate    2:0/3/terrain_set .   2:0/3/terrains_peering_bit/bottom_left_corner    2:0/3/script    2:0/4    2:0/4/modulate    2:0/4/terrain_set .   2:0/4/terrains_peering_bit/bottom_left_corner    2:0/4/script    2:0/5    2:0/5/modulate    2:0/5/terrain_set .   2:0/5/terrains_peering_bit/bottom_left_corner    2:0/5/script    2:0/6    2:0/6/modulate    2:0/6/terrain_set .   2:0/6/terrains_peering_bit/bottom_left_corner    2:0/6/script    1:1/next_alternative_id    1:1/0    1:1/0/terrain_set &   1:1/0/terrains_peering_bit/right_side /   1:1/0/terrains_peering_bit/bottom_right_corner '   1:1/0/terrains_peering_bit/bottom_side .   1:1/0/terrains_peering_bit/bottom_left_corner %   1:1/0/terrains_peering_bit/left_side +   1:1/0/terrains_peering_bit/top_left_corner $   1:1/0/terrains_peering_bit/top_side ,   1:1/0/terrains_peering_bit/top_right_corner    1:1/0/script    1:1/1    1:1/1/modulate    1:1/1/terrain_set &   1:1/1/terrains_peering_bit/right_side /   1:1/1/terrains_peering_bit/bottom_right_corner '   1:1/1/terrains_peering_bit/bottom_side .   1:1/1/terrains_peering_bit/bottom_left_corner %   1:1/1/terrains_peering_bit/left_side +   1:1/1/terrains_peering_bit/top_left_corner $   1:1/1/terrains_peering_bit/top_side ,   1:1/1/terrains_peering_bit/top_right_corner    1:1/1/script    1:1/2    1:1/2/modulate    1:1/2/terrain_set &   1:1/2/terrains_peering_bit/right_side /   1:1/2/terrains_peering_bit/bottom_right_corner '   1:1/2/terrains_peering_bit/bottom_side .   1:1/2/terrains_peering_bit/bottom_left_corner %   1:1/2/terrains_peering_bit/left_side +   1:1/2/terrains_peering_bit/top_left_corner $   1:1/2/terrains_peering_bit/top_side ,   1:1/2/terrains_peering_bit/top_right_corner    1:1/2/script    1:1/3    1:1/3/modulate    1:1/3/terrain_set &   1:1/3/terrains_peering_bit/right_side /   1:1/3/terrains_peering_bit/bottom_right_corner '   1:1/3/terrains_peering_bit/bottom_side .   1:1/3/terrains_peering_bit/bottom_left_corner %   1:1/3/terrains_peering_bit/left_side +   1:1/3/terrains_peering_bit/top_left_corner $   1:1/3/terrains_peering_bit/top_side ,   1:1/3/terrains_peering_bit/top_right_corner    1:1/3/script    1:1/4    1:1/4/modulate    1:1/4/terrain_set &   1:1/4/terrains_peering_bit/right_side /   1:1/4/terrains_peering_bit/bottom_right_corner '   1:1/4/terrains_peering_bit/bottom_side .   1:1/4/terrains_peering_bit/bottom_left_corner %   1:1/4/terrains_peering_bit/left_side +   1:1/4/terrains_peering_bit/top_left_corner $   1:1/4/terrains_peering_bit/top_side ,   1:1/4/terrains_peering_bit/top_right_corner    1:1/4/script    1:1/5    1:1/5/modulate    1:1/5/terrain_set &   1:1/5/terrains_peering_bit/right_side /   1:1/5/terrains_peering_bit/bottom_right_corner '   1:1/5/terrains_peering_bit/bottom_side .   1:1/5/terrains_peering_bit/bottom_left_corner %   1:1/5/terrains_peering_bit/left_side +   1:1/5/terrains_peering_bit/top_left_corner $   1:1/5/terrains_peering_bit/top_side ,   1:1/5/terrains_peering_bit/top_right_corner    1:1/5/script    1:1/6    1:1/6/modulate    1:1/6/terrain_set &   1:1/6/terrains_peering_bit/right_side /   1:1/6/terrains_peering_bit/bottom_right_corner '   1:1/6/terrains_peering_bit/bottom_side .   1:1/6/terrains_peering_bit/bottom_left_corner %   1:1/6/terrains_peering_bit/left_side +   1:1/6/terrains_peering_bit/top_left_corner $   1:1/6/terrains_peering_bit/top_side ,   1:1/6/terrains_peering_bit/top_right_corner    1:1/6/script    2:1/next_alternative_id    2:1/0    2:1/0/terrain_set .   2:1/0/terrains_peering_bit/bottom_left_corner %   2:1/0/terrains_peering_bit/left_side +   2:1/0/terrains_peering_bit/top_left_corner    2:1/0/script    2:1/1    2:1/1/modulate    2:1/1/terrain_set .   2:1/1/terrains_peering_bit/bottom_left_corner %   2:1/1/terrains_peering_bit/left_side +   2:1/1/terrains_peering_bit/top_left_corner    2:1/1/script    2:1/2    2:1/2/modulate    2:1/2/terrain_set .   2:1/2/terrains_peering_bit/bottom_left_corner %   2:1/2/terrains_peering_bit/left_side +   2:1/2/terrains_peering_bit/top_left_corner    2:1/2/script    2:1/3    2:1/3/modulate    2:1/3/terrain_set .   2:1/3/terrains_peering_bit/bottom_left_corner %   2:1/3/terrains_peering_bit/left_side +   2:1/3/terrains_peering_bit/top_left_corner    2:1/3/script    2:1/4    2:1/4/modulate    2:1/4/terrain_set .   2:1/4/terrains_peering_bit/bottom_left_corner %   2:1/4/terrains_peering_bit/left_side +   2:1/4/terrains_peering_bit/top_left_corner    2:1/4/script    2:1/5    2:1/5/modulate    2:1/5/terrain_set .   2:1/5/terrains_peering_bit/bottom_left_corner %   2:1/5/terrains_peering_bit/left_side +   2:1/5/terrains_peering_bit/top_left_corner    2:1/5/script    2:1/6    2:1/6/modulate    2:1/6/terrain_set .   2:1/6/terrains_peering_bit/bottom_left_corner %   2:1/6/terrains_peering_bit/left_side +   2:1/6/terrains_peering_bit/top_left_corner    2:1/6/script    0:2/next_alternative_id    0:2/0    0:2/0/terrain_set ,   0:2/0/terrains_peering_bit/top_right_corner    0:2/0/script    0:2/1    0:2/1/modulate    0:2/1/terrain_set ,   0:2/1/terrains_peering_bit/top_right_corner    0:2/1/script    0:2/2    0:2/2/modulate    0:2/2/terrain_set ,   0:2/2/terrains_peering_bit/top_right_corner    0:2/2/script    0:2/3    0:2/3/modulate    0:2/3/terrain_set ,   0:2/3/terrains_peering_bit/top_right_corner    0:2/3/script    0:2/4    0:2/4/modulate    0:2/4/terrain_set ,   0:2/4/terrains_peering_bit/top_right_corner    0:2/4/script    0:2/5    0:2/5/modulate    0:2/5/terrain_set ,   0:2/5/terrains_peering_bit/top_right_corner    0:2/5/script    0:2/6    0:2/6/modulate    0:2/6/terrain_set ,   0:2/6/terrains_peering_bit/top_right_corner    0:2/6/script    1:2/next_alternative_id    1:2/0    1:2/0/terrain_set +   1:2/0/terrains_peering_bit/top_left_corner $   1:2/0/terrains_peering_bit/top_side ,   1:2/0/terrains_peering_bit/top_right_corner    1:2/0/script    1:2/1    1:2/1/modulate    1:2/1/terrain_set +   1:2/1/terrains_peering_bit/top_left_corner $   1:2/1/terrains_peering_bit/top_side ,   1:2/1/terrains_peering_bit/top_right_corner    1:2/1/script    1:2/2    1:2/2/modulate    1:2/2/terrain_set +   1:2/2/terrains_peering_bit/top_left_corner $   1:2/2/terrains_peering_bit/top_side ,   1:2/2/terrains_peering_bit/top_right_corner    1:2/2/script    1:2/3    1:2/3/modulate    1:2/3/terrain_set +   1:2/3/terrains_peering_bit/top_left_corner $   1:2/3/terrains_peering_bit/top_side ,   1:2/3/terrains_peering_bit/top_right_corner    1:2/3/script    1:2/4    1:2/4/modulate    1:2/4/terrain_set +   1:2/4/terrains_peering_bit/top_left_corner $   1:2/4/terrains_peering_bit/top_side ,   1:2/4/terrains_peering_bit/top_right_corner    1:2/4/script    1:2/5    1:2/5/modulate    1:2/5/terrain_set +   1:2/5/terrains_peering_bit/top_left_corner $   1:2/5/terrains_peering_bit/top_side ,   1:2/5/terrains_peering_bit/top_right_corner    1:2/5/script    1:2/6    1:2/6/modulate    1:2/6/terrain_set +   1:2/6/terrains_peering_bit/top_left_corner $   1:2/6/terrains_peering_bit/top_side ,   1:2/6/terrains_peering_bit/top_right_corner    1:2/6/script    2:2/next_alternative_id    2:2/0    2:2/0/terrain_set +   2:2/0/terrains_peering_bit/top_left_corner    2:2/0/script    2:2/1    2:2/1/modulate    2:2/1/terrain_set +   2:2/1/terrains_peering_bit/top_left_corner    2:2/1/script    2:2/2    2:2/2/modulate    2:2/2/terrain_set +   2:2/2/terrains_peering_bit/top_left_corner    2:2/2/script    2:2/3    2:2/3/modulate    2:2/3/terrain_set +   2:2/3/terrains_peering_bit/top_left_corner    2:2/3/script    2:2/4    2:2/4/modulate    2:2/4/terrain_set +   2:2/4/terrains_peering_bit/top_left_corner    2:2/4/script    2:2/5    2:2/5/modulate    2:2/5/terrain_set +   2:2/5/terrains_peering_bit/top_left_corner    2:2/5/script    2:2/6    2:2/6/modulate    2:2/6/terrain_set +   2:2/6/terrains_peering_bit/top_left_corner    2:2/6/script    1:0/next_alternative_id    1:0/0    1:0/0/terrain_set /   1:0/0/terrains_peering_bit/bottom_right_corner '   1:0/0/terrains_peering_bit/bottom_side .   1:0/0/terrains_peering_bit/bottom_left_corner    1:0/0/script    1:0/1    1:0/1/modulate    1:0/1/terrain_set /   1:0/1/terrains_peering_bit/bottom_right_corner '   1:0/1/terrains_peering_bit/bottom_side .   1:0/1/terrains_peering_bit/bottom_left_corner    1:0/1/script    1:0/2    1:0/2/modulate    1:0/2/terrain_set /   1:0/2/terrains_peering_bit/bottom_right_corner '   1:0/2/terrains_peering_bit/bottom_side .   1:0/2/terrains_peering_bit/bottom_left_corner    1:0/2/script    1:0/3    1:0/3/modulate    1:0/3/terrain_set /   1:0/3/terrains_peering_bit/bottom_right_corner '   1:0/3/terrains_peering_bit/bottom_side .   1:0/3/terrains_peering_bit/bottom_left_corner    1:0/3/script    1:0/4    1:0/4/modulate    1:0/4/terrain_set /   1:0/4/terrains_peering_bit/bottom_right_corner '   1:0/4/terrains_peering_bit/bottom_side .   1:0/4/terrains_peering_bit/bottom_left_corner    1:0/4/script    1:0/5    1:0/5/modulate    1:0/5/terrain_set /   1:0/5/terrains_peering_bit/bottom_right_corner '   1:0/5/terrains_peering_bit/bottom_side .   1:0/5/terrains_peering_bit/bottom_left_corner    1:0/5/script    1:0/6    1:0/6/modulate    1:0/6/terrain_set /   1:0/6/terrains_peering_bit/bottom_right_corner '   1:0/6/terrains_peering_bit/bottom_side .   1:0/6/terrains_peering_bit/bottom_left_corner    1:0/6/script    0:0/next_alternative_id    0:0/0    0:0/0/terrain_set /   0:0/0/terrains_peering_bit/bottom_right_corner    0:0/0/script    0:0/1    0:0/1/modulate    0:0/1/terrain_set /   0:0/1/terrains_peering_bit/bottom_right_corner    0:0/1/script    0:0/2    0:0/2/modulate    0:0/2/terrain_set /   0:0/2/terrains_peering_bit/bottom_right_corner    0:0/2/script    0:0/3    0:0/3/modulate    0:0/3/terrain_set /   0:0/3/terrains_peering_bit/bottom_right_corner    0:0/3/script    0:0/4    0:0/4/modulate    0:0/4/terrain_set /   0:0/4/terrains_peering_bit/bottom_right_corner    0:0/4/script    0:0/5    0:0/5/modulate    0:0/5/terrain_set /   0:0/5/terrains_peering_bit/bottom_right_corner    0:0/5/script    0:0/6    0:0/6/modulate    0:0/6/terrain_set /   0:0/6/terrains_peering_bit/bottom_right_corner    0:0/6/script    0:1/next_alternative_id    0:1/0    0:1/0/terrain_set &   0:1/0/terrains_peering_bit/right_side /   0:1/0/terrains_peering_bit/bottom_right_corner ,   0:1/0/terrains_peering_bit/top_right_corner    0:1/0/script    0:1/1    0:1/1/modulate    0:1/1/terrain_set &   0:1/1/terrains_peering_bit/right_side /   0:1/1/terrains_peering_bit/bottom_right_corner ,   0:1/1/terrains_peering_bit/top_right_corner    0:1/1/script    0:1/2    0:1/2/modulate    0:1/2/terrain_set &   0:1/2/terrains_peering_bit/right_side /   0:1/2/terrains_peering_bit/bottom_right_corner ,   0:1/2/terrains_peering_bit/top_right_corner    0:1/2/script    0:1/3    0:1/3/modulate    0:1/3/terrain_set &   0:1/3/terrains_peering_bit/right_side /   0:1/3/terrains_peering_bit/bottom_right_corner ,   0:1/3/terrains_peering_bit/top_right_corner    0:1/3/script    0:1/4    0:1/4/modulate    0:1/4/terrain_set &   0:1/4/terrains_peering_bit/right_side /   0:1/4/terrains_peering_bit/bottom_right_corner ,   0:1/4/terrains_peering_bit/top_right_corner    0:1/4/script    0:1/5    0:1/5/modulate    0:1/5/terrain_set &   0:1/5/terrains_peering_bit/right_side /   0:1/5/terrains_peering_bit/bottom_right_corner ,   0:1/5/terrains_peering_bit/top_right_corner    0:1/5/script    0:1/6    0:1/6/modulate    0:1/6/terrain_set &   0:1/6/terrains_peering_bit/right_side /   0:1/6/terrains_peering_bit/bottom_right_corner ,   0:1/6/terrains_peering_bit/top_right_corner    0:1/6/script    script    tile_shape    tile_layout    tile_offset_axis 
   tile_size    uv_clipping    terrain_set_0/mode    terrain_set_0/terrain_0/name    terrain_set_0/terrain_0/color 
   sources/0    tile_proxies/source_level    tile_proxies/coords_level    tile_proxies/alternative_level    
   Texture2D &   res://assets/sprites/flat_tailset.png yWV�y@f   !   local://TileSetAtlasSource_x6skc 92         local://TileSet_3466f �G         TileSetAtlasSource �                  -                              	          
                                 �?          �?                                               �?      �?                                                   �?  �?                                           �?  �?      �?                                    !        �?      �?  �?"          #          $      %         &            �?  �?  �?'          (          )      *         +          ,          -          .          /          0          1          2          3          4          5      6         7        �?          �?8          9          :          ;          <          =          >          ?          @          A      B         C            �?      �?D          E          F          G          H          I          J          K          L          M      N         O                �?  �?P          Q          R          S          T          U          V          W          X          Y      Z         [        �?  �?      �?\          ]          ^          _          `          a          b          c          d          e      f         g        �?      �?  �?h          i          j          k          l          m          n          o          p          q      r         s            �?  �?  �?t          u          v          w          x          y          z          {          |          }      ~                   �          �          �          �          �      �         �        �?          �?�          �          �          �          �      �         �            �?      �?�          �          �          �          �      �         �                �?  �?�          �          �          �          �      �         �        �?  �?      �?�          �          �          �          �      �         �        �?      �?  �?�          �          �          �          �      �         �            �?  �?  �?�          �          �          �          �      �         �          �          �          �      �         �        �?          �?�          �          �      �         �            �?      �?�          �          �      �         �                �?  �?�          �          �      �         �        �?  �?      �?�          �          �      �         �        �?      �?  �?�          �          �      �         �            �?  �?  �?�          �          �      �         �          �          �          �          �          �      �         �        �?          �?�          �          �          �          �      �         �            �?      �?�          �          �          �          �      �         �                �?  �?�          �          �          �          �      �         �        �?  �?      �?�          �          �          �          �      �         �        �?      �?  �?�          �          �          �          �      �         �            �?  �?  �?�          �                                                                                  	       �?          �?
                                          �?      �?                                              �?  �?                                      �?  �?      �?                                      �?      �?  �?                        !        "           �?  �?  �?#         $         %     &        '         (         )         *         +         ,     -        .       �?          �?/         0         1         2         3     4        5           �?      �?6         7         8         9         :     ;        <               �?  �?=         >         ?         @         A     B        C       �?  �?      �?D         E         F         G         H     I        J       �?      �?  �?K         L         M         N         O     P        Q           �?  �?  �?R         S         T         U         V     W        X         Y         Z         [     \        ]       �?          �?^         _         `     a        b           �?      �?c         d         e     f        g               �?  �?h         i         j     k        l       �?  �?      �?m         n         o     p        q       �?      �?  �?r         s         t     u        v           �?  �?  �?w         x         y     z        {         |         }         ~                  �     �        �       �?          �?�         �         �         �         �     �        �           �?      �?�         �         �         �         �     �        �               �?  �?�         �         �         �         �     �        �       �?  �?      �?�         �         �         �         �     �        �       �?      �?  �?�         �         �         �         �     �        �           �?  �?  �?�         �         �         �         �     �        TileSet    �  -           �         �        Background �       �?          �?�            �     RSRC [remap]

path="res://.godot/exported/133200997/export-7b0be4150891a4ed04933ec28014b0f4-enemy_spawner.scn"
      [remap]

path="res://.godot/exported/133200997/export-58931b9e92906aa2320ce93db677ddfa-arena.scn"
              [remap]

path="res://.godot/exported/133200997/export-61fb7fc5b7a55c61eeb6f8db1465f77d-base_entity.scn"
        [remap]

path="res://.godot/exported/133200997/export-c9d39ff9595f45da5ea18bd35a51363f-circle_component.scn"
   [remap]

path="res://.godot/exported/133200997/export-5fdce28b2025df3d853251c40a0711cf-health_component.scn"
   [remap]

path="res://.godot/exported/133200997/export-ce23a4a94a80352cdeb7ba9cfe76344e-polygon_component.scn"
  [remap]

path="res://.godot/exported/133200997/export-830bf86f4afb9a173baa051efc06cd7c-enemy.scn"
              [remap]

path="res://.godot/exported/133200997/export-ff1633955aab3abd1fa22a039261d084-player.scn"
             [remap]

path="res://.godot/exported/133200997/export-31589d5f9806bc2986bfe9638277b2c5-background_tile_set.res"
list=Array[Dictionary]([{
"base": &"Entity",
"class": &"Enemy",
"icon": "",
"language": &"GDScript",
"path": "res://game/entities/enemy/enemy.gd"
}, {
"base": &"CharacterBody2D",
"class": &"Entity",
"icon": "",
"language": &"GDScript",
"path": "res://game/entities/base_entity/base_entity.gd"
}, {
"base": &"Entity",
"class": &"Player",
"icon": "",
"language": &"GDScript",
"path": "res://game/entities/player/player.gd"
}, {
"base": &"Node2D",
"class": &"SpawningEnemy",
"icon": "",
"language": &"GDScript",
"path": "res://game/arena/enemy_spawner/spawning_enemy.gd"
}])
       yWV�y@f%   res://assets/sprites/flat_tailset.pngp'�Z/d�4   res://game/arena/arena.tscnH���s0   res://game/entities/base_entity/base_entity.tscn�=�&��vE   res://game/entities/components/circle_component/circle_component.tscn��߲�f|"E   res://game/entities/components/health_component/health_component.tscn(Jҽl�oG   res://game/entities/components/polygon_component/polygon_component.tscn��
�}�+$   res://game/entities/enemy/enemy.tscnk��:��*3&   res://game/entities/player/player.tscn��;�9.�M"   res://resources/arena_tile_set.resnR��S�jb(   res://resources/background_tile_set.tresfU�Ǵh1V#   res://game/arena/enemy_spawner.tscnfU�Ǵh1V1   res://game/arena/enemy_spawner/enemy_spawner.tscn�_�֗^�2   res://game/arena/enemy_spawner/spawning_enemy.tscn     ECFG      application/config/name         Form Survivors     application/run/main_scene$         res://game/arena/arena.tscn    application/config/features$   "         4.3    Forward Plus       application/run/max_fps      <       application/boot_splash/bg_color                    �?"   application/boot_splash/show_image             autoload/Global          *res://core/global.gd      display/window/stretch/mode         canvas_items    file_customization/folder_colors�     
         res://assets/         yellow        res://core/       gray      res://game/       blue      res://game/arena/         pink      res://game/entities/      purple        res://game/entities/enemy/        red       res://game/entities/player/       blue      res://menu/       green         res://resources/      gray      res://game/arena/enemy_spawner/       orange     input/zoom_in�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask          position     QC  B   global_position      WC  �B   factor       �?   button_index         canceled          pressed          double_click          script         input/zoom_out�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask          position     _C  �A   global_position      eC  �B   factor       �?   button_index         canceled          pressed          double_click          script         input/move_right(              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode    D      physical_keycode       	   key_label             unicode    d      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode       	   key_label      D      unicode    d      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode       	   key_label           unicode    2     echo          script         input/move_left(              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode    A      physical_keycode       	   key_label             unicode    D     echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    D     echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode       	   key_label      A      unicode    a      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode       	   key_label      $     unicode    D     echo          script         input/move_up(              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode    W      physical_keycode       	   key_label             unicode    w      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode       	   key_label      W      unicode    w      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode       	   key_label      &     unicode    F     echo          script         input/move_down(              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode    S      physical_keycode       	   key_label             unicode    s      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode       	   key_label      S      unicode    s      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode       	   key_label      +     unicode    K     echo          script      /   input_devices/pointing/emulate_touch_from_mouse            layer_names/2d_physics/layer_1         border     layer_names/2d_physics/layer_3         entity     layer_names/2d_physics/layer_4         player     layer_names/2d_physics/layer_5         enemy      layer_names/2d_physics/layer_7      
   projectile  2   rendering/environment/defaults/default_clear_color                    �?