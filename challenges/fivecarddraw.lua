-- Five-Card Draw Challenge
-- 6 discards per round
-- 5 hand size
-- 7 Joker slots
-- Start with Card Sharp voucher and a basic Joker
-- Standard 52 cards
-- Banned Jokers: Juggler, Troubadour, Turtle Bean


-- CRASHES THE GAME
-- Define the challenge data
local challenge_data = {
	key = "fivecarddraw",
	name = "Five-Card Draw",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- Apply game modifiers when run starts
	apply_modifiers = function()
		-- Set 6 discards per round
		G.GAME.round_resets.discards = 6
		
		-- Set 5 hands per round
		G.GAME.round_resets.hands = 5

		-- Increase joker slots from 5 to 7
		G.jokers:change_size(2)
	end,
}

-- Add banned jokers
table.insert(challenge_data.banned_cards, {id = "j_juggler"})      -- Juggler
table.insert(challenge_data.banned_cards, {id = "j_troubadour"})   -- Troubadour
table.insert(challenge_data.banned_cards, {id = "j_turtle_bean"})  -- Turtle Bean

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "fivecarddraw",
	challenge_deck = "c_mp_fivecarddraw"
})

-- Create the deck type (required)
MP.DECK.FIVECARDDRAW = {}
MP.DECK.FIVECARDDRAW.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.FIVECARDDRAW.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.FIVECARDDRAW.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.FIVECARDDRAW.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "fivecarddraw",
	name = "Five-Card Draw",
	rules = {
		custom = {},
		modifiers = {
			joker_slot = 7,  -- 7 Joker slots
		},
	},
	jokers = {
		{ id = "j_card_sharp" },  -- Start with a card sharp Joker
		{ id = "j_joker" },  -- Start with a basic Joker
	},
	consumeables = {},
	vouchers = {},  
	restrictions = {
		banned_cards = MP.DECK.FIVECARDDRAW.BANNED_CARDS,
		banned_tags = MP.DECK.FIVECARDDRAW.BANNED_TAGS,
		banned_other = MP.DECK.FIVECARDDRAW.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.FIVECARDDRAW.TYPE,
		-- Standard 52 card deck (default)
	},
	unlocked = function(self)
		return false -- Always false for multiplayer challenges
	end,
})

