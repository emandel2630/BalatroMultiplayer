-- Omelette Challenge
-- Start with 5 Egg Jokers. A challenging PvP mode focused on joker synergies and egg hatching mechanics.

-- Define the challenge data
local omelette_challenge = {
	key = "omelette",
	name = "Omelette",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- Apply game modifiers when run starts
	apply_modifiers = function()
		-- Omelette ruleset: Start with 4 money, no interest, no money from wins, no comeback bonus
		G.GAME.dollars = 4
		G.GAME.interest_amount = 0
		G.GAME.interest_cap = 0
		
		-- Disable comeback bonus for omelette mode
		MP.LOBBY.config.gold_on_life_loss = false
		
		-- Set up modifiers to disable money from extra hands and blind rewards
		G.GAME.modifiers.no_extra_hand_money = true
		G.GAME.modifiers.no_blind_reward = {
			["Small"] = true,
			["Big"] = true,
			["Boss"] = true
		}
	end,
}

-- Register the challenge
MP.Challenge.register(omelette_challenge)

-- Create the ruleset
MP.Ruleset({
	key = "omelette",
	challenge_deck = "c_mp_omelette"
})

-- Create the deck type
MP.DECK.OMELETTE = {}
MP.DECK.OMELETTE.BANNED_CARDS = omelette_challenge.banned_cards
MP.DECK.OMELETTE.BANNED_TAGS = omelette_challenge.banned_tags
MP.DECK.OMELETTE.BANNED_BLINDS = omelette_challenge.banned_blinds
MP.DECK.OMELETTE.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge
SMODS.Challenge({
	key = "omelette",
	name = "The Omelette",
	rules = {
		custom = {
			-- Custom rules are applied via apply_modifiers() function
			{id = 'no_interest'},
			{id = 'no_reward'},
		},
		modifiers = {
			-- Empty - we apply modifiers manually in apply_modifiers()
		},
	},
	jokers = {
		{ id = "j_egg"},
		{ id = "j_egg"},
		{ id = "j_egg"},
		{ id = "j_egg"},
		{ id = "j_egg"},
	},
	consumeables = {},
	vouchers = {},
	restrictions = {
		banned_cards = MP.DECK.OMELETTE.BANNED_CARDS,
		banned_tags = MP.DECK.OMELETTE.BANNED_TAGS,
		banned_other = MP.DECK.OMELETTE.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.OMELETTE.TYPE,
	},
	unlocked = function(self)
		return false
	end,
})

