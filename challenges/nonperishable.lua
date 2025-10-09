-- Non-Perishable Challenge
-- All Jokers are Eternal
-- Standard 52 cards
-- Banned Jokers: Gros Michel, Cavendish, Ice Cream, Turtle Bean, Ramen, Diet Cola, Seltzer, Popcorn, Mr. Bones, Invisible Joker, Luchador
-- Banned Blinds: Verdant Leaf

-- Define the challenge data
local challenge_data = {
	key = "nonperishable",
	name = "Non-Perishable",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- Apply game modifiers when run starts
	apply_modifiers = function()
		-- All jokers are eternal
		G.GAME.modifiers.all_eternal = true
	end,
}

-- Ban perishable/consumable jokers
local banned_jokers = {
	{id = "j_gros_michel"},    -- Gros Michel
	{id = "j_cavendish"},      -- Cavendish
	{id = "j_ice_cream"},      -- Ice Cream
	{id = "j_turtle_bean"},    -- Turtle Bean
	{id = "j_ramen"},          -- Ramen
	{id = "j_diet_cola"},      -- Diet Cola
	{id = "j_seltzer"},        -- Seltzer
	{id = "j_popcorn"},        -- Popcorn
	{id = "j_mr_bones"},       -- Mr. Bones
	{id = "j_invisible"},      -- Invisible Joker
	{id = "j_luchador"},       -- Luchador
}

for _, joker in ipairs(banned_jokers) do
	table.insert(challenge_data.banned_cards, joker)
end

-- Ban Verdant Leaf blind (The Plant)
table.insert(challenge_data.banned_blinds, {id = "bl_verdant_leaf"})

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "nonperishable",
	challenge_deck = "c_mp_nonperishable"
})

-- Create the deck type (required)
MP.DECK.NONPERISHABLE = {}
MP.DECK.NONPERISHABLE.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.NONPERISHABLE.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.NONPERISHABLE.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.NONPERISHABLE.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "nonperishable",
	name = "Non-Perishable",
	rules = {
		custom = {
			{id = 'all_eternal'}, -- All jokers are eternal
		},
		modifiers = {},
	},
	jokers = {},
	consumeables = {},
	vouchers = {},
	restrictions = {
		banned_cards = MP.DECK.NONPERISHABLE.BANNED_CARDS,
		banned_tags = MP.DECK.NONPERISHABLE.BANNED_TAGS,
		banned_other = MP.DECK.NONPERISHABLE.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.NONPERISHABLE.TYPE,
		-- Standard 52 card deck (default)
	},
	unlocked = function(self)
		return false -- Always false for multiplayer challenges
	end,
})

