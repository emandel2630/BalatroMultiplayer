-- Cruelty Challenge
-- Small and Big Blinds give no reward money
-- 3 Joker Slots

-- Define the challenge data
local challenge_data = {
	key = "cruelty",
	name = "Cruelty",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- Apply game modifiers when run starts
	apply_modifiers = function()
		-- Disable money rewards from Small and Big blinds (but not Boss)
		G.GAME.modifiers.no_blind_reward = {
			["Small"] = true,
			["Big"] = true,
		}
		
		-- Reduce joker slots from 5 to 3
		G.jokers:change_size(-2)
	end,
}

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "cruelty",
	challenge_deck = "c_mp_cruelty"
})

-- Create the deck type (required)
MP.DECK.CRUELTY = {}
MP.DECK.CRUELTY.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.CRUELTY.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.CRUELTY.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.CRUELTY.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "cruelty",
	name = "Cruelty",
	rules = {
		custom = {
			{id = 'no_small_blind_reward'},
			{id = 'no_big_blind_reward'},
		},
		modifiers = {
			joker_slot = 3,  -- 3 Joker slots
		},
	},
	jokers = {},
	consumeables = {},
	vouchers = {},
	restrictions = {
		banned_cards = MP.DECK.CRUELTY.BANNED_CARDS,
		banned_tags = MP.DECK.CRUELTY.BANNED_TAGS,
		banned_other = MP.DECK.CRUELTY.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.CRUELTY.TYPE,
		-- Standard 52 card deck (default)
	},
	unlocked = function(self)
		return false -- Always false for multiplayer challenges
	end,
})

