-- Oops! All 6s Challenge
-- Start with two negative eternal Oops! All 6s jokers and two Magician tarot cards
-- Remember to add localization entries for:
--   - k_oopsall6s (name)
--   - k_oopsall6s_description (description)

-- Define the challenge data
local challenge_data = {
	key = "oopsall6s",
	name = "Oops! All 6s",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- No special modifiers - just the starting jokers and cards
	apply_modifiers = function()
		-- No additional modifiers for this challenge
	end,
}

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "oopsall6s",
	challenge_deck = "c_mp_oopsall6s"
})

-- Create the deck type (required)
MP.DECK.OOPSALL6S = {}
MP.DECK.OOPSALL6S.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.OOPSALL6S.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.OOPSALL6S.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.OOPSALL6S.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "oopsall6s",
	name = "The Oops! All 6s",
	rules = {
		custom = {},
		modifiers = {},
	},
	jokers = {
		{ id = "j_oops", edition = "negative", eternal = true },
		{ id = "j_oops", edition = "negative", eternal = true },
	},
	consumeables = {
		{ id = "c_magician" },
		{ id = "c_magician" },
	},
	vouchers = {},
	restrictions = {
		banned_cards = MP.DECK.OOPSALL6S.BANNED_CARDS,
		banned_tags = MP.DECK.OOPSALL6S.BANNED_TAGS,
		banned_other = MP.DECK.OOPSALL6S.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.OOPSALL6S.TYPE,
	},
	unlocked = function(self)
		return false
	end,
})

