-- X-ray Vision Challenge
-- 1 in 4 cards are drawn face down
-- Remember to add localization entries for:
--   - k_xrayvision (name)
--   - k_xrayvision_description (description)

-- Define the challenge data
local challenge_data = {
	key = "xrayvision",
	name = "X-ray Vision",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- Apply game modifiers when run starts
	apply_modifiers = function()
		-- Set the flag to enable face-down card mechanic
		G.GAME.modifiers.xray_vision = true
	end,
}

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "xrayvision",
	challenge_deck = "c_mp_xrayvision"
})

-- Create the deck type (required)
MP.DECK.XRAYVISION = {}
MP.DECK.XRAYVISION.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.XRAYVISION.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.XRAYVISION.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.XRAYVISION.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "xrayvision",
	name = "X-ray Vision",
	rules = {
		custom = {},
		modifiers = {},
	},
	jokers = {},
	consumeables = {},
	vouchers = {},
	restrictions = {
		banned_cards = MP.DECK.XRAYVISION.BANNED_CARDS,
		banned_tags = MP.DECK.XRAYVISION.BANNED_TAGS,
		banned_other = MP.DECK.XRAYVISION.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.XRAYVISION.TYPE,
	},
	unlocked = function(self)
		return false -- Always false for multiplayer challenges
	end,
})

