-- Golden Needle Challenge
-- Discards each cost $1
-- 1 hand per round
-- 6 discards per round
-- Start with $10
-- Start with Credit Card joker
-- Standard 52 cards
-- Banned Jokers: Burglar
-- Banned Vouchers: Grabber, Nacho Tong

-- Define the challenge data
local challenge_data = {
	key = "goldenneedle",
	name = "Golden Needle",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- Apply game modifiers when run starts
	apply_modifiers = function()
		-- Set starting money to $10
		G.GAME.dollars = 10
		
		-- Set 1 hand per round
		G.GAME.round_resets.hands = 1
		
		-- Set 6 discards per round
		G.GAME.round_resets.discards = 6
		
		-- Enable the discard cost modifier (costs $1 per discard)
		-- This is implemented via the lovely/goldenneedle.toml patch
		G.GAME.modifiers.discard_cost = 1
	end,
}

-- Add banned jokers
table.insert(challenge_data.banned_cards, {id = "j_burglar"})  -- Burglar

-- Add banned vouchers
table.insert(challenge_data.banned_cards, {id = "v_grabber"})       -- Grabber
table.insert(challenge_data.banned_cards, {id = "v_nacho_tong"})    -- Nacho Tong

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "goldenneedle",
	challenge_deck = "c_mp_goldenneedle"
})

-- Create the deck type (required)
MP.DECK.GOLDENNEEDLE = {}
MP.DECK.GOLDENNEEDLE.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.GOLDENNEEDLE.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.GOLDENNEEDLE.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.GOLDENNEEDLE.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "goldenneedle",
	name = "Golden Needle",
	rules = {
		custom = {},
		modifiers = {},
	},
	jokers = {
		{ id = "j_credit_card" },  -- Start with Credit Card joker
	},
	consumeables = {},
	vouchers = {},
	restrictions = {
		banned_cards = MP.DECK.GOLDENNEEDLE.BANNED_CARDS,
		banned_tags = MP.DECK.GOLDENNEEDLE.BANNED_TAGS,
		banned_other = MP.DECK.GOLDENNEEDLE.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.GOLDENNEEDLE.TYPE,
		-- Standard 52 card deck (default)
	},
	unlocked = function(self)
		return false -- Always false for multiplayer challenges
	end,
})

