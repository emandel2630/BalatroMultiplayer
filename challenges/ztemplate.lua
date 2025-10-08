-- Challenge Template
-- Copy this file and rename it to create a new challenge
-- Remember to add localization entries for:
--   - k_yourchallenge (name)
--   - k_yourchallenge_description (description)

-- Define the challenge data
local challenge_data = {
	key = "yourchallenge", -- Change this to your challenge key (lowercase, no spaces)
	name = "Your Challenge", -- Display name for the UI
	
	-- Banned cards for this challenge (optional)
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- Apply game modifiers when run starts (optional)
	-- This function is called automatically when the game starts
	apply_modifiers = function()
		-- Example: Modify starting money
		-- G.GAME.dollars = 10
		
		-- Example: Modify interest
		-- G.GAME.interest_amount = 5
		-- G.GAME.interest_cap = 25
		
		-- Example: Disable comeback bonus
		-- MP.LOBBY.config.gold_on_life_loss = false
		
		-- Example: Set game modifiers
		-- G.GAME.modifiers.no_extra_hand_money = true
		-- G.GAME.modifiers.no_blind_reward = {
		-- 	["Small"] = true,
		-- 	["Big"] = true,
		-- 	["Boss"] = true
		-- }
	end,
}

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "yourchallenge", -- Must match challenge key
	challenge_deck = "c_mp_yourchallenge" -- Must match SMODS.Challenge key below
})

-- Create the deck type (required)
MP.DECK.YOURCHALLENGE = {} -- Change to your challenge name in uppercase
MP.DECK.YOURCHALLENGE.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.YOURCHALLENGE.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.YOURCHALLENGE.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.YOURCHALLENGE.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "yourchallenge", -- Must match challenge key
	name = "Your Challenge Name", -- Display name in challenge select
	rules = {
		custom = {
			-- Custom rules displayed in UI (optional)
			-- Use standard Balatro rule IDs that exist in the base game
			-- These are for DISPLAY purposes - actual modifiers go in apply_modifiers()
			-- Examples:
			-- {id = 'no_reward'},      -- Shows "No money from blinds" in UI
			-- {id = 'no_interest'},    -- Shows "No interest" in UI
			-- {id = 'joker_stickers'}, -- Shows "Jokers have stickers" in UI
		},
		modifiers = {
			-- Leave empty - use apply_modifiers() function instead
			-- Only use this if you know the exact modifier exists in base game
		},
	},
	jokers = {
		-- Starting jokers (optional)
		-- Examples:
		-- { id = "j_joker" },
		-- { id = "j_greedy_joker" },
		-- { id = "j_joker", edition = "negative" },  -- With negative edition (NO "e_" prefix!)
		-- { id = "j_joker", eternal = true },         -- Eternal joker
		-- { id = "j_joker", edition = "foil", perishable = true },  -- Multiple properties
	},
	consumeables = {
		-- Starting consumables (optional)
		-- Examples:
		-- { id = "c_fool" },
		-- { id = "c_magician" },
	},
	vouchers = {
		-- Starting vouchers (optional)
		-- Examples:
		-- { id = "v_overstock_norm" },
	},
	restrictions = {
		banned_cards = MP.DECK.YOURCHALLENGE.BANNED_CARDS,
		banned_tags = MP.DECK.YOURCHALLENGE.BANNED_TAGS,
		banned_other = MP.DECK.YOURCHALLENGE.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.YOURCHALLENGE.TYPE,
	},
	unlocked = function(self)
		return false -- Always false for multiplayer challenges
	end,
})

