extends Control

# Resources
var ore   = 0
var stone = 0
var stick = 0
var vine  = 0
var wood  = 0
var brick = 0
var metal = 0

# Psudo Buildings
var forge = 0

# Food
var raw_meat    = 0
var cooked_meat = 0

# Tools
var axe        = 0
var axe_hth    = 8
var pick       = 0
var pick_hth   = 8
var dagger     = 0
var dagger_hth = 4
var spear      = 0
var spear_hth  = 6
var bow        = 0
var bow_hth    = 12
var arrow      = 0

# SKill Stuff
var lumb_skill = 0
var lumb_exp   = 10
var lumb_lvl   = 1
var fire_skill = 0
var fire_exp   = 10
var fire_lvl   = 1
var min_skill  = 0 
var min_exp    = 10
var min_lvl    = 1 
var hunt_skill = 0
var hunt_exp   = 10
var hunt_lvl   = 1

# MISC Features
var health      = 10
var max_health = 10
var energy     = 20
var max_energy = 20

# Various functions
func Update_Stick():
	$Inventory/Stick_INV.text = "Stick: " + str(stick)

func Update_Stone():
	$Inventory/Stone_INV.text = "Stone: " + str(stone)

func Update_Wood():
	$Inventory/Wood_INV.text = "Wood: " + str(wood)

func Update_Energy():
	$Main_Form/Energy.text = "Energy: " + str(energy) + "/" + str(max_energy)

func Update_Hunt_LVL():
	if hunt_skill == hunt_exp:
			hunt_lvl += 1
			hunt_exp *= 2
			hunt_skill = 0

func Update_Dagger_HTH():
	if dagger_hth == 0:
			dagger -= 1
			$Inventory/Dag_INV.text = "Dagger: 0"

func Update_Raw_Meat():
	$Inventory/Raw_INV.text = "Raw Meat: " + str(raw_meat)
	
func Update_Cook_Meat():
	$Inventory/Cook_INV.text = "Cooked Meat: " + str(cooked_meat)

func pass_out():
	energy += 5
	OS.alert("You passed out, you lost some resources")
	if stick >= 3:
		stick -= 3
		Update_Stick()
	elif stick < 3:
		stick -= stick
		Update_Stick()
	if stone >= 3:
		stone -= 3
		Update_Stone()
	elif stone < 3:
		stone -= stone
		Update_Stone()

func _on_stone_up_pressed() -> void:
	stone += 1
	Update_Stone()


func _on_stick_up_pressed() -> void:
	stick += 1
	Update_Stick()


func _on_axe_up_pressed() -> void:
	if axe == 1:
		OS.alert("You can only have one axe at a time")
	elif stick >= 3 and stone >= 2:
		axe += 1
		stick -= 3
		stone -= 2
		axe_hth = 8
		Update_Stone()
		Update_Stick()
		$Inventory/Axe_INV.text = "Axe: " + str(axe) + "                  " + str(axe_hth) + "/8"


func _on_wood_up_pressed() -> void:
	if axe == 1:
		if energy > 0:
			wood += lumb_lvl
			lumb_skill += 1
			energy -= 1
			if energy == 0:
				pass_out()
			Update_Energy()
			Update_Wood()
			if lumb_skill == lumb_exp:
				lumb_skill = 0
				lumb_exp *= 2
				lumb_lvl += 1
			$Skills/Lumber_Skill.text = "Lumberjacking Skill: " + str(lumb_skill) + "/" + str(lumb_exp)
			axe_hth -= 1
			if axe_hth == 0:
				axe -= 1
				$Inventory/Axe_INV.text = "Axe: "
			else:
				$Inventory/Axe_INV.text = "Axe: " + str(axe) + "                  " + str(axe_hth) + "/8"
		elif energy == 0:
			OS.alert("You don't have enough energy")
	else:
		OS.alert("You need an axe!")


func _on_ore_up_pressed() -> void:
	if pick == 1:
		if energy > 0:
			ore += min_lvl
			$Inventory/Ore_INV.text = "Ore: " + str(ore)
			min_skill += 1
			if min_skill == min_exp:
				min_exp *= 2
				min_skill = 0
				min_lvl += 1
			$Skills/Mining_Skill.text = "Mining Skill: " + str(min_skill) + "/" + str(min_exp)
			energy -= 1
			if energy == 0:
				pass_out()
			Update_Energy()
			pick_hth -= 1
			if pick_hth == 0:
				pick -= 1
				$Inventory/Pick_INV.text = "Pickaxe: "
			else: 
				$Inventory/Pick_INV.text = "Pickaxe: " + str(pick) + "           " + str(pick_hth) + "/8"
		elif energy < 0:
			OS.alert("You ran out of energy!")
	else:
		OS.alert("You need a pickaxe!")


func _on_pick_up_pressed() -> void:
	if pick == 1:
		OS.alert("You can only have one pickaxe at a time")
	elif stone >= 3 and stick >= 3:
		pick += 1
		stick -= 3
		stone -= 3
		pick_hth = 8
		Update_Stone()
		Update_Stick()
		$Inventory/Pick_INV.text = "Pickaxe: "  + str(pick) + "           " + str(pick_hth) + "/8"

# Hiding/Showing Various Tabs
func _on_show_skill_pressed() -> void:
	$Inventory.visible = false
	$Resources.visible = false
	$Skills.visible = true
	$Cooking.visible = false
	$Main_Form.visible = false
	$Recipes.visible = false


func _on_show_res_pressed() -> void:
	$Inventory.visible = false
	$Resources.visible = true
	$Skills.visible = false
	$Cooking.visible = false
	$Main_Form.visible = false
	$Recipes.visible = false


func _on_hide_skill_pressed() -> void:
	$Inventory.visible = false
	$Resources.visible = false
	$Skills.visible = false
	$Cooking.visible = false
	$Main_Form.visible = true


func _on_hide_res_pressed() -> void:
	$Inventory.visible = false
	$Resources.visible = false
	$Cooking.visible = false
	$Skills.visible = false
	$Main_Form.visible = true


func _on_hide_inv_pressed() -> void:
	$Inventory.visible = false
	$Resources.visible = false
	$Skills.visible = false
	$Cooking.visible = false
	$Main_Form.visible = true


func _on_show_inv_pressed() -> void:
	$Inventory.visible = true
	$Resources.visible = false
	$Skills.visible = false
	$Cooking.visible = false
	$Main_Form.visible = false
	$Recipes.visible = false


func _on_hide_cook_pressed() -> void:
	$Inventory.visible = false
	$Resources.visible = false
	$Skills.visible = false
	$Cooking.visible = false
	$Main_Form.visible = true


func _on_show_cooking_pressed() -> void:
	$Skills.visible = false
	$Resources.visible = false
	$Inventory.visible = false
	$Cooking.visible = true
	$Main_Form.visible = false
	$Recipes.visible = false
	
	
func _on_show_recipe_pressed() -> void:
	$Skills.visible = false
	$Resources.visible = false
	$Inventory.visible = false
	$Cooking.visible = false
	$Main_Form.visible = false
	$Recipes.visible = true


func _on_hide_rec_pressed() -> void:
	$Skills.visible = false
	$Resources.visible = false
	$Inventory.visible = false
	$Cooking.visible = false
	$Main_Form.visible = true
	$Recipes.visible = false


func _on_dag_up_pressed() -> void:
	if dagger == 1:
		OS.alert("You can only have one dagger at a time")
	elif stone >= 1 and stick >= 1:
		dagger = 1
		stick -= 1
		stone -= 1
		dagger_hth = 4
		$Inventory/Dag_INV.text = "Dagger: "  + str(dagger) + "           " + str(dagger_hth) + "/4"
		Update_Stone()
		Update_Stick()


func _on_raw_meat_up_pressed() -> void:
	if bow == 1 and arrow >= 1:
		raw_meat += 3 + hunt_lvl
		energy -= 2
		if energy <= 0:
			pass_out()
		arrow -= 1
		bow_hth -= 1
		if bow_hth == 0:
			bow -= 1
			$Inventory/Bow_INV.text = "Bow: 0"
		hunt_skill += 3
		if hunt_skill >= hunt_exp:
			hunt_exp *= 2
			hunt_skill = 0
			hunt_lvl += 1
	elif spear == 1:
		raw_meat += 2 + hunt_lvl
		hunt_skill += 2
		spear_hth -= 1
		energy -= 2
		if energy <= 0:
			pass_out()
		Update_Energy()
		$Inventory/Spear_INV.text = "Spear: 1" + "              " + str(spear_hth) + "/" + "6" 
		if spear_hth == 0:
			spear -= 1
			$Inventory/Spear_INV.text = "Spear: 0"
		Update_Hunt_LVL()
		$Skills/Hunt_Skill.text = "Hunting Skill " + str(hunt_skill) + "/" + str(hunt_exp)
		Update_Raw_Meat()
	elif dagger == 1:
		raw_meat += hunt_lvl
		hunt_skill += 1
		dagger_hth -= 1
		energy -= 4
		if energy <= 0:
			pass_out()
		Update_Energy()
		$Inventory/Dag_INV.text = "Dagger: 1" + "            " + str(dagger_hth) + "/" + "4" 
		if dagger_hth == 0:
			dagger -= 1
			$Inventory/Dag_INV.text = "Dagger: 0"
		Update_Dagger_HTH()
		Update_Hunt_LVL()
		$Skills/Hunt_Skill.text = "Hunting Skill " + str(hunt_skill) + "/" + str(hunt_exp)
		Update_Raw_Meat()
	elif dagger == 0 or spear == 0:
		OS.alert("You need a weapon to hunt!")
		


func _on_energy_up_pressed() -> void:
	if cooked_meat >= 1:
		cooked_meat -= 1
		Update_Cook_Meat()
		health += 3
		$Main_Form/Health.text = "Health: " + str(health) + "/" + str(max_health)
		energy += 6
		Update_Energy()
	elif raw_meat >= 1:
		raw_meat -= 1
		Update_Raw_Meat()
		health -= 3
		$Main_Form/Health.text = "Health: " + str(health) + "/" + str(max_health)
		energy += 3
		Update_Energy()
	else: 
		OS.alert("You don't have any food")


func _on_cook_up_pressed() -> void:
	if raw_meat >= 1 and wood >=1:
		cooked_meat += 1
		Update_Cook_Meat()
		raw_meat -= 1
		Update_Raw_Meat()
		energy -= 1
		Update_Energy()
	elif raw_meat >= 1 and stick >= 2:
		cooked_meat += 1
		Update_Cook_Meat()
		raw_meat -= 1
		Update_Raw_Meat()
		energy -= 1
		Update_Energy()
	elif raw_meat == 0:
		OS.alert("You don't have enough raw meat")
	elif wood == 0 and stick <= 1:
		OS.alert("You don't have enough wood or sticks")
	elif wood == 0:
		OS.alert("You don't have enough wood")
	elif stick <= 1:
		OS.alert("You don't have enough sticks")


func _on_spear_up_pressed() -> void:
	if spear == 1:
		OS.alert("You can only have one spear at a time!")
	elif wood >= 2 and stone >= 1:
		spear += 1
		wood -= 2
		stone -= 1
		$Inventory/Spear_INV.text = "Spear: " + str(spear)


func _on_vine_up_pressed() -> void:
	if dagger == 1:
		vine += 1
		$Inventory/Vine_INV.text = "Vine: " + str(vine)
		energy -= 1
		Update_Energy()
		dagger_hth -= 1
		if dagger_hth == 0:
			dagger -= 1
			$Inventory/Dag_INV.text = "Dagger: 0"
	else:
		OS.alert("You need a dagger for this")

func _on_brick_up_pressed() -> void:
	if stone >= 4:
		brick += 1
		stone -= 4
		Update_Stone()
		$Inventory/Brick_INV.text = "Brick: " + str(brick)
	else:
		OS.alert("You need atleast 4 stone to make this")


func _on_bow_up_pressed() -> void:
	if bow == 1:
		OS.alert("You can only have one bow at a time")
	elif stick >= 4 and vine >= 3:
		bow += 1
		Update_Stick()
		$Inventory/Vine_INV.text = "Vine: " + str(vine)
		$Inventory/Bow_INV.text = "Bow: " + str(bow)
		bow_hth = 12
	elif stick < 4 and vine < 3:
		OS.alert("You don't have enough sticks or vines")


func _on_arrow_up_pressed() -> void:
	if stick >= 1 and stone >= 1:
		arrow += 1
		Update_Stick()
		Update_Stone()
		$Inventory/Arrow_INV.text = "Arrow: " + str(arrow)


func _on_forge_up_pressed() -> void:
	if brick >= 30 and forge == 0:
		forge = 1
	elif forge == 1:
		OS.alert("You can only have one forge!")


func _on_metal_up_pressed() -> void:
	if forge == 1 and ore >= 1 and wood >= 3:
		ore -= 1
		metal += 1
		wood -= 3
		$Inventory/Ore_INV.text = "Ore: " + str(ore)
		Update_Wood()
	elif forge == 0:
		OS.alert("You need a forge to smelt ore")
	elif ore == 0:
		OS.alert("You need atleast one ore to use this")
	elif wood < 3:
		OS.alert("You need atleast three pieces of wood to use this")
