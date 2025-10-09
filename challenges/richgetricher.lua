-- Rich Get Richer Challenge
-- Chips cannot exceed the current $
-- Start with $100, Seed Money voucher, and Money Tree voucher

-- Define the challenge data
local challenge_data = {
	key = "richgetricher",
	name = "Rich Get Richer",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- Apply game modifiers when run starts
	apply_modifiers = function()
		-- Start with $100
		G.GAME.dollars = 100
		
		-- Set up chip cap based on current money
		G.GAME.modifiers.rich_get_richer = true
	end,
}

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Note: The chip cap is implemented via a Lovely patch in lovely/game.toml
-- which checks G.GAME.modifiers.rich_get_richer and caps hand_chips

-- Create the ruleset (required)
MP.Ruleset({
	key = "richgetricher",
	challenge_deck = "c_mp_richgetricher"
})

-- Create the deck type (required)
MP.DECK.RICHGETRICHER = {}
MP.DECK.RICHGETRICHER.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.RICHGETRICHER.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.RICHGETRICHER.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.RICHGETRICHER.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "richgetricher",
	name = "Rich Get Richer",
	rules = {
		custom = {
			-- Note: The chip cap mechanic is implemented via the evaluate_play hook
		},
		modifiers = {
			dollars = 100,
		},
	},
	jokers = {},
	consumeables = {},
	vouchers = {
		{ id = "v_seed_money" }, -- Seed Money
		{ id = "v_money_tree" }, -- Money Tree
	},
	restrictions = {
		banned_cards = MP.DECK.RICHGETRICHER.BANNED_CARDS,
		banned_tags = MP.DECK.RICHGETRICHER.BANNED_TAGS,
		banned_other = MP.DECK.RICHGETRICHER.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.RICHGETRICHER.TYPE,
	},
	unlocked = function(self)
		return false -- Always false for multiplayer challenges
	end,
})
