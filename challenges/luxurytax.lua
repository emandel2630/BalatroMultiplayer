-- Luxury Tax Challenge
-- Hold -1 cards in hand for every $5 you have
-- Starting hand size = 10

-- Define the challenge data
local challenge_data = {
	key = "luxurytax",
	name = "Luxury Tax",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- Apply game modifiers when run starts
	apply_modifiers = function()
		-- Enable the luxury tax modifier
		G.GAME.modifiers.luxury_tax = true
		
		-- Start with larger hand size (will be reduced based on money dynamically)
		G.hand:change_size(2) -- Base hand is 8, so this makes it 10
	end,
}

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "luxurytax",
	challenge_deck = "c_mp_luxurytax"
})

-- Create the deck type (required)
MP.DECK.LUXURYTAX = {}
MP.DECK.LUXURYTAX.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.LUXURYTAX.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.LUXURYTAX.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.LUXURYTAX.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "luxurytax",
	name = "Luxury Tax",
	rules = {
		custom = {
			-- Custom rule for display
		},
		modifiers = {},
	},
	jokers = {},
	consumeables = {},
	vouchers = {},
	restrictions = {
		banned_cards = MP.DECK.LUXURYTAX.BANNED_CARDS,
		banned_tags = MP.DECK.LUXURYTAX.BANNED_TAGS,
		banned_other = MP.DECK.LUXURYTAX.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.LUXURYTAX.TYPE,
	},
	unlocked = function(self)
		return false -- Always false for multiplayer challenges
	end,
})

-- Note: The dynamic hand size reduction is implemented via a Lovely patch in lovely/luxurytax.toml
-- which checks G.GAME.modifiers.luxury_tax and adjusts hand size based on current money

