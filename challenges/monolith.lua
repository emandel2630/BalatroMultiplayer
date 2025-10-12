-- Monolith Challenge
-- Start with Eternal Obelisk and Eternal Negative Marble Joker
-- Standard 52 cards

-- Define the challenge data
local challenge_data = {
	key = "monolith",
	name = "Monolith",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- No special modifiers - just the starting jokers
	apply_modifiers = function()
		-- No additional modifiers for this challenge
	end,
}

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "monolith",
	challenge_deck = "c_mp_monolith"
})

-- Create the deck type (required)
MP.DECK.MONOLITH = {}
MP.DECK.MONOLITH.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.MONOLITH.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.MONOLITH.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.MONOLITH.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "monolith",
	name = "The Monolith",
	rules = {
		custom = {},
		modifiers = {},
	},
	jokers = {
		{ id = "j_obelisk", eternal = true },
		{ id = "j_marble", edition = "negative", eternal = true },
	},
	consumeables = {},
	vouchers = {},
	restrictions = {
		banned_cards = MP.DECK.MONOLITH.BANNED_CARDS,
		banned_tags = MP.DECK.MONOLITH.BANNED_TAGS,
		banned_other = MP.DECK.MONOLITH.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.MONOLITH.TYPE,
	},
	unlocked = function(self)
		return false
	end,
})

