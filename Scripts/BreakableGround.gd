extends StaticBody2D

var mirror_prefab = "res://Scenes/BreakableGroundMirror.tscn"

func destroy():
	var platforms: Node2D = get_parent()
	platforms.change_child_property(self.name + "/Cobblestone","visible",false)
	platforms.change_child_property(self.name + "/CollisionShape2D","disabled",true)
	platforms.change_child_property(self.name + "/GPUParticles2D","emitting",true)
