-- CanalBuilder
-- prototypes.waterfill

local function emptyPic()
	return {
		filename = "__core__/graphics/empty.png",
		priority = "high",
		width = 1,
		height = 1,
		shift = {0,0}
	}
end

local function emptySprites()
	return {
		north = emptyPic(),
		east = emptyPic(),
		south = emptyPic(),
		west = emptyPic()
	}
end

local waterfill_item = {
	type = "item",
	name = "waterfill-item",
	icon = "__CanalBuilder__/graphics/icons/waterfill_small.png",
	icon_size = 32,
	icon_mipmaps = 1,
	--flags = {"goes-to-main-inventory"},
	subgroup = "terrain",
	order = "c[landfill]-z-a[water]",
	stack_size = 100,
	place_result = "waterfill-placer"	
}


local waterfill = table.deepcopy(data.raw["offshore-pump"]["offshore-pump"])
local updates = {
	name = "waterfill-placer",
	icon = "__CanalBuilder__/graphics/icons/waterfill_small.png",
	icon_size = 32,
	icon_mipmaps = 1,
	picture = emptyPic(),
	collision_mask = { "ground-tile" },
	fluid_box_tile_collision_test = { "ground-tile" },
	adjacent_tile_collision_test = { "water-tile" },
	collision_box = {{-0.6, -1.05}, {0.6, 0.3}},
	selection_box = {{-1, -1.49}, {1, 0.49}},
	fluid_box =
	{
		base_area = 1,
		base_level = 1,
		pipe_covers = emptySprites(),
		filter = "water",
		pipe_connections = {
			{
				position = {0, 1},
				type = "output"
			}
		}
	},
	tile_width = 1,
	tile_height = 1,
}
for k,v in pairs(updates) do
	waterfill[k] = updates[k]
end
waterfill.center_collision_mask = nil
waterfill.graphics_set = nil
waterfill.water_reflection = nil
waterfill.working_sound = nil
waterfill.vehicle_impact_sound = nil
waterfill.adjacent_tile_collision_mask = nil
waterfill.adjacent_tile_collision_box = nil
waterfill.damaged_trigger_effect = nil

local waterfill_tech = {
	type = "technology",
	name = "waterfill-tech",
	icon = "__CanalBuilder__/graphics/icons/waterfill_large.png",
	icon_size = 128,
	effects =
	{
		{type = "unlock-recipe", recipe = "waterfill-recipe"},
	},
	prerequisites = {"landfill","explosives"},
	unit =
	{
		count = 100,
		ingredients =
		{
			{"automation-science-pack", 1},
			{"logistic-science-pack", 1},
		},
		time = 30
	},
	order = "a"
}

local waterfill_recipe = {
	type = "recipe",
	name = "waterfill-recipe",
	energy_required = 0.5,
	enabled = false,
	category = "crafting",
	ingredients =
	{
		{type = "item", name = "explosives", amount = 1},
	},
	result = "waterfill-item",
	result_count = 1
}



data:extend({
	waterfill,
	waterfill_tech,
	waterfill_recipe,
	waterfill_item,
	waterfill_actual})

