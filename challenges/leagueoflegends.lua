-- League of Legends Challenge
-- Adds Perkeo, Canio, Yorick, and Triboulet jokers that are negative and eternal

-- Define the challenge data
local challenge_data = {
	key = "leagueoflegends", -- Challenge key (lowercase, no spaces)
	name = "League of Legends", -- Display name for the UI
	
	-- Banned cards for this challenge (optional)
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- Apply game modifiers when run starts (optional)
	-- This function is called automatically when the game starts
	apply_modifiers = function()
		-- No special modifiers needed for this challenge
	end,
}

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "leagueoflegends", -- Must match challenge key
	challenge_deck = "c_mp_leagueoflegends" -- Must match SMODS.Challenge key below
})

-- Create the deck type (required)
MP.DECK.LEAGUEOFLEGENDS = {} -- Challenge name in uppercase
MP.DECK.LEAGUEOFLEGENDS.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.LEAGUEOFLEGENDS.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.LEAGUEOFLEGENDS.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.LEAGUEOFLEGENDS.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "leagueoflegends", -- Must match challenge key
	name = "League of Legends", -- Display name in challenge select
	rules = {
		custom = {
			-- Custom rules displayed in UI (optional)
			-- Use standard Balatro rule IDs that exist in the base game
			-- These are for DISPLAY purposes - actual modifiers go in apply_modifiers()
		},
		modifiers = {
			-- Leave empty - use apply_modifiers() function instead
		},
	},
	jokers = {
		-- Starting jokers: Perkeo, Canio, Yorick, and Triboulet as negative and eternal
		{ id = "j_perkeo", edition = "negative", eternal = true },
		{ id = "j_canio", edition = "negative", eternal = true },
		{ id = "j_yorick", edition = "negative", eternal = true },
		{ id = "j_triboulet", edition = "negative", eternal = true },
	},
	consumeables = {
		-- No starting consumables
	},
	vouchers = {
		-- No starting vouchers
	},
	restrictions = {
		banned_cards = MP.DECK.LEAGUEOFLEGENDS.BANNED_CARDS,
		banned_tags = MP.DECK.LEAGUEOFLEGENDS.BANNED_TAGS,
		banned_other = MP.DECK.LEAGUEOFLEGENDS.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.LEAGUEOFLEGENDS.TYPE,
	},
	unlocked = function(self)
		return false -- Always false for multiplayer challenges
	end,
})

