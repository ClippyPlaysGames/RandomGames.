extends Control

# Reasources
var ore  = 0
var stone = 0
var stick = 0
var wood  = 0

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
var heath      = 10
var max_health = 10
var energy     = 20
var max_energy = 20


func _on_stone_up_pressed() -> void:
	stone += 1
	$Inventory/Stone_INV.text = "Stone: " + str(stone)



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
		$Inventory/Stone_INV.text = "Stone: " + str(stone)
		Update_Stick()
		$Inventory/Axe_INV.text = "Axe: " + str(axe) + "                  " + str(axe_hth) + "/8"


func _on_wood_up_pressed() -> void:
	if axe == 1:
		if energy > 0:
			wood += lumb_lvl
			lumb_skill += 1
			energy -= 1
			$Main_Form/Energy.text = "Energy: " + str(energy) + "/" + str(max_energy)
			$Inventory/Wood_INV.text = "Wood: " + str(wood)
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
			$Main_Form/Energy.text = "Energy: " + str(energy) + "/" + str(max_energy)
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
		$Inventory/Stone_INV.text = "Stone: " + str(stone)
		Update_Stick()
		$Inventory/Pick_INV.text = "Pickaxe: "  + str(pick) + "           " + str(pick_hth) + "/8"


func _on_show_skill_pressed() -> void:
	$Inventory.visible = false
	$Resources.visible = false
	$Skills.visible = true
	$Cooking.visible = false
	$Main_Form.visible = false


func _on_show_res_pressed() -> void:
	$Inventory.visible = false
	$Resources.visible = true
	$Skills.visible = false
	$Cooking.visible = false
	$Main_Form.visible = false


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


func _on_dag_up_pressed() -> void:
	if dagger == 1:
		OS.alert("You can only have one dagger at a time")
	elif stone >= 1 and stick >= 1:
		dagger += 1
		dagger_hth = 4
		stone -= 1
		stick -= 1
		$Inventory/Dag_INV.text = "Dagger: " + str(dagger) + "            " + str(dagger_hth) + "/" + "4" 


func _on_raw_meat_up_pressed() -> void:
	if spear == 1:
		raw_meat += 2 + hunt_lvl
		hunt_skill += 2
		spear_hth -= 1
		$Inventory/Spear_INV.text = "Spear: 1" + "              " + str(spear_hth) + "/" + "6" 
		if spear_hth == 0:
			spear -= 1
			$Inventory/Spear_INV.text = "Spear: 0"
		if hunt_skill >= hunt_exp:
			hunt_lvl += 1
			hunt_exp *= 2
			hunt_skill = 0
		$Skills/Hunt_Skill.text = "Hunting Skill " + str(hunt_skill) + "/" + str(hunt_exp)
		$Inventory/Raw_INV.text = "Raw Meat: " + str(raw_meat)
	elif dagger == 1:
		raw_meat += hunt_lvl
		hunt_skill += 1
		dagger_hth -= 1
		$Inventory/Dag_INV.text = "Dagger: 1" + "            " + str(dagger_hth) + "/" + "4" 
		if dagger_hth == 0:
			dagger -= 1
			$Inventory/Dag_INV.text = "Dagger: 0"
		if hunt_skill == hunt_exp:
			hunt_lvl += 1
			hunt_exp *= 2
			hunt_skill = 0
		$Skills/Hunt_Skill.text = "Hunting Skill " + str(hunt_skill) + "/" + str(hunt_exp)
		$Inventory/Raw_INV.text = "Raw Meat: " + str(raw_meat)
	elif dagger == 0 or spear == 0:
		OS.alert("You need a weapon to hunt!")
		


func _on_energy_up_pressed() -> void:
	if energy >= max_energy:
		energy = max_energy
	elif energy < max_energy:
		energy += 2
		$Main_Form/Energy.text = "Energy: " + str(energy) + "/" + str(max_energy)

func Update_Stick():
	$Inventory/Stick_INV.text = "Stick: " + str(stick)

func Update_Stone():
	$Inventory/Stine_INV.text = "Stone: " + str(stone)


func _on_hide_cook_pressed() -> void:
	$Inventory.visible = false
	$Resources.visible = false
	$Skills.visible = false
	$Cooking.visible = false
	$Main_Form.visible = true


func _on_cook_up_pressed() -> void:
	if raw_meat >= 1 and wood >=1:
		cooked_meat += 1
		raw_meat -= 1
		$Inventory/Cook_INV.text = "Cooked Meat: " + str(cooked_meat)
	elif raw_meat >= 1 and stick >= 2:
		cooked_meat += 1
		raw_meat -= 1
		$Inventory/Cook_INV.text = "Cooked Meat: " + str(cooked_meat)
	elif raw_meat == 0:
		OS.alert("You don't have enough raw meat")
	elif wood == 0 and stick <= 1:
		OS.alert("You don't have enough wood or sticks")
	elif wood == 0:
		OS.alert("You don't have enough wood")
	elif stick <= 1:
		OS.alert("You don't have enough sticks")


func _on_show_cooking_pressed() -> void:
	$Skills.visible = false
	$Resources.visible = false
	$Inventory.visible = false
	$Cooking.visible = true
	$Main_Form.visible = false



func _on_spear_up_pressed() -> void:
	if spear == 1:
		OS.alert("You can only have 1 spear at a time!")
	elif wood >= 2 and stone >= 1:
		spear += 1
		wood -= 2
		stone -= 1
		$Inventory/Spear_INV.text = "Spear: " + str(spear)
