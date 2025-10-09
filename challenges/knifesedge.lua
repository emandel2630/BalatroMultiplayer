-- On a Knife's Edge Challenge
-- Start with an eternal Ceremonial Dagger joker

-- Define the challenge data
local challenge_data = {
	key = "knifesedge",
	name = "On a Knife's Edge",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- No special modifiers - just the starting joker
	apply_modifiers = function()
		-- No additional modifiers for this challenge
	end,
}

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "knifesedge",
	challenge_deck = "c_mp_knifesedge"
})

-- Create the deck type (required)
MP.DECK.KNIFESEDGE = {}
MP.DECK.KNIFESEDGE.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.KNIFESEDGE.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.KNIFESEDGE.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.KNIFESEDGE.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "knifesedge",
	name = "On a Knife's Edge",
	rules = {
		custom = {},
		modifiers = {},
	},
	jokers = {
		{ id = "j_ceremonial", eternal = true },
	},
	consumeables = {},
	vouchers = {},
	restrictions = {
		banned_cards = MP.DECK.KNIFESEDGE.BANNED_CARDS,
		banned_tags = MP.DECK.KNIFESEDGE.BANNED_TAGS,
		banned_other = MP.DECK.KNIFESEDGE.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.KNIFESEDGE.TYPE,
	},
	unlocked = function(self)
		return false
	end,
})

