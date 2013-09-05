-- FOOD MOD
-- A mod written by rubenwardy that adds
-- food to the minetest game
-- =====================================
-- >> food/init.lua
-- The support api for the mod, and some
-- basic foods
-- =====================================

food = { supported={} }
function food.support(group,mod,item)
	if not minetest.get_modpath(mod) then
		print("'"..mod.."' is not installed")
		return
	end

	local mtype = "item"

	if minetest.registered_nodes[item] then
		mtype = "node"
	end

	local data = minetest.registered_items[item]

	if not data then
		print(item.." not found")
		return
	end

	data.groups["food_"..group]=1

	if mtype == "item" then
		minetest.register_craftitem(":"..item,data)
	else
		minetest.register_node(":"..item,data)
	end
	food.supported[group] = true	
end
function food.asupport(group,add)
	if food.supported[group] then
		return
	end

	for name, def in pairs(minetest.registered_items) do
		local g = def.groups and def.groups[group] or 0
		if g > 0 then
			return
		end
	end

	print("registering "..group.." inbuilt definition")
 
	add()
end

-- Add support for other mods
food.support("wheat","farming","farming:wheat")
food.support("flour","farming","farming:flour")
food.support("tomato","farming_plus","farming_plus:tomato_item")
food.support("tomato","plantlib","plantlib:tomato")
food.support("strawberry","farming_plus","farming_plus:strawberry_item")
food.support("strawberry","plantlib","plantlib:strawberry")
food.support("carrot","farming_plus","farming_plus:carrot_item")
food.support("carrot","docfarming","docfarming:carrot")
food.support("carrot","plantlib","plantlib:carrot")
food.support("cocoa","farming_plus","farming_plus:cocoa_bean")
food.support("milk","animalmaterials","animalmaterials:milk")
food.support("milk","my_mobs","my_mobs:milk_glass_cup")
food.support("egg","animalmaterials","animalmaterials:egg")

-- Default inbuilt ingrediants
food.asupport("wheat",function()
	minetest.register_craftitem("food:wheat", {
		description = "Wheat",
		inventory_image = "food_wheat.png",
		groups = {food_wheat=1}
	})

	minetest.register_craft({
		output = "food:wheat",
		recipe = {
			{"default:dry_shrub"},
		}
	})
end)
food.asupport("flour",function()
	minetest.register_craftitem("food:flour", {
		description = "Flour",
		inventory_image = "food_flour.png",
		groups = {food_flour = 1}
	})
	minetest.register_craft({
		output = "food:flour",
		recipe = {
			{"group:food_wheat"},
			{"group:food_wheat"}
		}
	})
	minetest.register_craft({
		output = "food:flour",
		recipe = {
			{"default:sand"},
			{"default:sand"}
		}
	})
end)
food.asupport("tomato",function()
	minetest.register_craftitem("food:tomato", {
		description = "Tomato",
		inventory_image = "food_tomato.png",
		groups = {food_tomato = 1}
	})
	minetest.register_craft({
		output = "food:tomato",
		recipe = {
			{"", "default:desert_sand", ""},
			{"default:desert_sand", "", "default:desert_sand"},
			{"", "default:desert_sand", ""}
		}
	})
end)
food.asupport("strawberry",function()
	minetest.register_craftitem("food:strawberry", {
		description = "Strawberry",
		inventory_image = "food_strawberry.png",
		on_use = minetest.item_eat(2),
		groups = {food_strawberry=1}
	})
	minetest.register_craft({
		output = "food:strawberry",
		recipe = {
			{"default:apple"},
		}
	})
end)
food.asupport("carrot",function()
	minetest.register_craftitem("food:carrot", {
		description = "Carrot",
		inventory_image = "food_carrot.png",
		groups = {food_carrot=1},
		on_use = minetest.item_eat(3)
	})
	minetest.register_craft({
		output = "food:carrot",
		recipe = {
			{"default:apple","default:apple","default:apple"},
		}
	})
end)
food.asupport("milk",function()
	minetest.register_craftitem("food:milk", {
		description = "Milk",
		image = "food_milk.png",
		on_use = minetest.item_eat(1),
		groups = { eatable=1, food_milk = 1 },
		stack_max=10
	})
	minetest.register_craft({
		output = "food:milk",
		recipe = {
			{"default:sand"},
			{"bucket:bucket_water"}
		},
		replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}},
	})
end)
food.asupport("egg",function()
	minetest.register_craftitem("food:egg",{
		description = "Egg",
		inventory_image = "food_egg.png",
		groups = {food_egg=1}
	})
	minetest.register_craft({
		output = "food:egg",
		recipe = {
			{"", "default:sand", ""},
			{"default:sand", "", "default:sand"},
			{"", "default:sand", ""}
		}
	})
end)
food.asupport("cocoa",function()
	minetest.register_craftitem("food:cocoa", {
		description = "Cocoa Bean",
		inventory_image = "food_cocoa.png",
		groups = {food_cocoa=1}
	})
	minetest.register_craft({
		output = "food:cocoa",
		recipe = {
			{"","default:apple",""},
			{"default:apple","","default:apple"},
			{"","default:apple",""}
		}
	})
end)

-- Register sugar
minetest.register_craftitem("food:sugar", {
	description = "Sugar",
	inventory_image = "food_sugar.png",
	groups = {food_sugar=1}
})
minetest.register_craft({
	output = "food:sugar 20",
	recipe = {
		{"default:papyrus"},
	}
})

-- Register chocolate powder	
minetest.register_craftitem("food:chocolate_powder", {
	description = "Chocolate Powder",
	inventory_image = "food_chocolate_powder.png",
	groups = {food_choco_powder = 1}
})
minetest.register_craft({
	output = "food:chocolate_powder 16",
	recipe = {
		{"group:food_cocoa","group:food_cocoa","group:food_cocoa"},
		{"group:food_cocoa","group:food_cocoa","group:food_cocoa"},
		{"group:food_cocoa","group:food_cocoa","group:food_cocoa"}
	}
})

-- Register dark chocolate
minetest.register_craftitem("food:dark_chocolate",{
	description = "Dark Chocolate",
	inventory_image = "food_dark_chocolate.png",
	groups = {food_dark_chocolate=1}
})
minetest.register_craft({
	output = "food:dark_chocolate",
	recipe = {
		{"group:food_cocoa","group:food_cocoa","group:food_cocoa"}
	}
})

-- Register milk chocolate
minetest.register_craftitem("food:milk_chocolate",{
	description = "Milk Chocolate",
	inventory_image = "food_milk_chocolate.png",
	groups = {food_milk_chocolate=1}
})
minetest.register_craft({
	output = "food:milk_chocolate",
	recipe = {
			{"","group:food_milk",""},
			{"group:food_cocoa","group:food_cocoa","group:food_cocoa"}
	}
})

-- Register pasta
minetest.register_craftitem("food:pasta",{
	description = "Pasta",
	inventory_image = "food_pasta.png",
	groups = {food_pasta=1}
})
minetest.register_craft({
	output = "food:pasta 4",
	type = "shapeless",
	recipe = {"group:food_flour","group:food_egg","group:food_egg"}
})

-- Register bowl
minetest.register_craftitem("food:bowl",{
	description = "Bowl",
	inventory_image = "food_bowl.png",
	groups = {food_bowl=1}
})
-- Register butter
minetest.register_craftitem("food:butter", {
	description = "Butter",
	inventory_image = "food_butter.png",
	groups = {food_butter=1}
})
minetest.register_craft({
	output = "food:butter",
	recipe = {
		{"group:food_milk","group:food_milk"},
	}
})

-- Register cheese
minetest.register_craftitem("food:cheese", {
	description = "Cheese",
	inventory_image = "food_cheese.png",
	on_use = minetest.item_eat(4),
	groups = {food_cheese=1}
})
minetest.register_craft({
	output = "food:cheese",
	recipe = {
		{"group:food_butter","group:food_butter"},
	}
})

-- Register pasta bake
minetest.register_craftitem("food:pasta_bake",{
	description = "Pasta Bake",
	inventory_image = "food_pasta_bake.png",
	groups = {food=3}
})
minetest.register_craftitem("food:pasta_bake_raw",{
	description = "Raw Pasta Bake",
	inventory_image = "food_pasta_bake_raw.png",
})
minetest.register_craft({
	output = "food:pasta_bake",
	type = "cooking",
 	recipe = "food:pasta_bake_raw"
})
minetest.register_craft({
	output = "food:pasta_bake_raw",
 	recipe = {
		{"group:food_cheese"},
		{"group:food_pasta"},
		{"group:food_bowl"}
	}
})

-- Register cakes
minetest.register_node("food:cake", {
	description = "Cake",
	on_use = minetest.item_eat(4),
	groups={food=3,crumbly=3},
	tiles = {
		"food_cake_texture.png",
		"food_cake_texture.png",
		"food_cake_texture_side.png",
		"food_cake_texture_side.png",
		"food_cake_texture_side.png",
		"food_cake_texture_side.png"
	},
	walkable = false,
	sunlight_propagates = true,
	drawtype="nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.250000,-0.500000,-0.296880,0.250000,-0.250000,0.312502}, --NodeBox 1
			{-0.309375,-0.500000,-0.250000,0.309375,-0.250000,0.250000}, --NodeBox 2
			{-0.250000,-0.250000,-0.250000,0.250000,-0.200000,0.250000}, --NodeBox 3
		}
	}
})
minetest.register_node("food:cake_choco", {
	description = "Chocolate Cake",
	on_use = minetest.item_eat(4),
	groups={food=3,crumbly=3},
	tiles = {
		"food_cake_choco_texture.png",
		"food_cake_choco_texture.png",
		"food_cake_choco_texture_side.png",
		"food_cake_choco_texture_side.png",
		"food_cake_choco_texture_side.png",
		"food_cake_choco_texture_side.png"
	},
	walkable = false,
	sunlight_propagates = true,
	drawtype="nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.250000,-0.500000,-0.296880,0.250000,-0.250000,0.312502}, --NodeBox 1
			{-0.309375,-0.500000,-0.250000,0.309375,-0.250000,0.250000}, --NodeBox 2
			{-0.250000,-0.250000,-0.250000,0.250000,-0.200000,0.250000}, --NodeBox 3
		}
	}
})
minetest.register_node("food:cake_carrot", {
	description = "Carrot Cake",
	on_use = minetest.item_eat(4),
	groups={food=3,crumbly=3},
	walkable = false,
	sunlight_propagates = true,
	tiles = {
		"food_cake_carrot_texture.png",
		"food_cake_carrot_texture.png",
		"food_cake_carrot_texture_side.png",
		"food_cake_carrot_texture_side.png",
		"food_cake_carrot_texture_side.png",
		"food_cake_carrot_texture_side.png"
	},
	drawtype="nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.250000,-0.500000,-0.296880,0.250000,-0.250000,0.312502}, --NodeBox 1
			{-0.309375,-0.500000,-0.250000,0.309375,-0.250000,0.250000}, --NodeBox 2
			{-0.250000,-0.250000,-0.250000,0.250000,-0.200000,0.250000}, --NodeBox 3
		}
	}
})
minetest.register_craftitem("food:cake_cheese",{
	description = "Cheese cake",
	inventory_image = "food_cake_cheese.png",
	on_use = minetest.item_eat(4),
	groups={food=3,crumbly=3}
})
minetest.register_craft({
	type = "cooking",
	output = "food:cake",
	recipe = "food:cakemix_plain",
	cooktime = 10,
})
minetest.register_craft({
	type = "cooking",
	output = "food:cake_choco",
	recipe = "food:cakemix_choco",
	cooktime = 10,
})
minetest.register_craft({
	type = "cooking",
	output = "food:cake_carrot",
	recipe = "food:cakemix_carrot",
	cooktime = 10,
})
minetest.register_craft({
	type = "cooking",
	output = "food:cake_cheese",
	recipe = "food:cakemix_cheese",
	cooktime = 10,
})

-- Cake mix
minetest.register_craftitem("food:cakemix_plain",{
	description = "Cake Mix",
	inventory_image = "food_cakemix_plain.png",
})

minetest.register_craftitem("food:cakemix_choco",{
	description = "Chocolate Cake Mix",
	inventory_image = "food_cakemix_choco.png",
})

minetest.register_craftitem("food:cakemix_carrot",{
	description = "Carrot Cake Mix",
	inventory_image = "food_cakemix_carrot.png",
})

minetest.register_craftitem("food:cakemix_cheese",{
	description = "Cheese Cake Mix",
	inventory_image = "food_cakemix_carrot.png",
})
minetest.register_craft({
	output = "food:cakemix_plain",
	recipe = {
		{"group:food_flour","group:food_sugar","group:food_egg"},
	}
})
minetest.register_craft({
	output = "food:cakemix_choco",
	recipe = {
		{"","group:food_choco_powder",""},
		{"group:food_flour","group:food_sugar","group:food_egg"},
	}
})
minetest.register_craft({
	output = "food:cakemix_carrot",
	recipe = {
		{"","group:food_carrot",""},
		{"group:food_flour","group:food_sugar","group:food_egg"},
	}
})
minetest.register_craft({
	output = "food:cakemix_cheese",
	recipe = {
		{"group:food_cheese","group:food_strawberry",""},
		{"group:food_flour","group:food_sugar","group:food_egg"},
	}
})
