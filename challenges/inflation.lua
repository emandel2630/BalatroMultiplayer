-- Inflation Challenge
-- Permanently raise prices by $1 on every purchase
-- Starting with Credit Card joker

-- Define the challenge data
local challenge_data = {
	key = "inflation",
	name = "Inflation",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- Apply game modifiers when run starts
	apply_modifiers = function()
		-- Enable the inflation modifier
		G.GAME.modifiers.inflation = true
		
		-- Initialize inflation tracker if not exists
		if not G.GAME.inflation_increases then
			G.GAME.inflation_increases = 0
		end
	end,
}

-- Ban Clearance Sale and Liquidation vouchers
table.insert(challenge_data.banned_cards, {
	id = "v_clearance_sale",
})
table.insert(challenge_data.banned_cards, {
	id = "v_liquidation",
})

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "inflation",
	challenge_deck = "c_mp_inflation"
})

-- Create the deck type (required)
MP.DECK.INFLATION = {}
MP.DECK.INFLATION.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.INFLATION.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.INFLATION.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.INFLATION.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "inflation",
	name = "Inflation",
	rules = {
		custom = {
			-- Custom rules displayed in UI
		},
		modifiers = {},
	},
	jokers = {
		-- Start with Credit Card joker
		{ id = "j_credit_card" },
	},
	consumeables = {},
	vouchers = {},
	restrictions = {
		banned_cards = MP.DECK.INFLATION.BANNED_CARDS,
		banned_tags = MP.DECK.INFLATION.BANNED_TAGS,
		banned_other = MP.DECK.INFLATION.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.INFLATION.TYPE,
	},
	unlocked = function(self)
		return false -- Always false for multiplayer challenges
	end,
})

