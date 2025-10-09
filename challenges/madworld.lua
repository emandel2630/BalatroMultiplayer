-- Mad World Challenge
-- Extra Hands no longer earn money
-- Earn no Interest at end of round
-- Start with Eternal, Negative Pareidolia and Eternal Business Card
-- Ranks 2 through 9 only, 32 cards total
-- Banned Blinds: The Plant

-- Define the challenge data
local challenge_data = {
	key = "madworld",
	name = "Mad World",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- Apply game modifiers when run starts
	apply_modifiers = function()
		-- No money from extra hands
		G.GAME.modifiers.no_extra_hand_money = true
		
		-- No interest at end of round
		G.GAME.interest_amount = 0
		G.GAME.interest_cap = 0
	end,
}

-- Ban The Plant blind
table.insert(challenge_data.banned_blinds, {id = "bl_plant"})

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "madworld",
	challenge_deck = "c_mp_madworld"
})

-- Create the deck type (required)
MP.DECK.MADWORLD = {}
MP.DECK.MADWORLD.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.MADWORLD.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.MADWORLD.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.MADWORLD.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "madworld",
	name = "Mad World",
	rules = {
		custom = {
			{id = 'no_extra_hand_money'}, -- No money from extra hands
			{id = 'no_interest'},          -- No interest
		},
		modifiers = {},
	},
	jokers = {
		{ id = "j_pareidolia", edition = "negative", eternal = true }, -- Eternal, Negative Pareidolia
		{ id = "j_business", eternal = true },                          -- Eternal Business Card
	},
	consumeables = {},
	vouchers = {},
	restrictions = {
		banned_cards = MP.DECK.MADWORLD.BANNED_CARDS,
		banned_tags = MP.DECK.MADWORLD.BANNED_TAGS,
		banned_other = MP.DECK.MADWORLD.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.MADWORLD.TYPE,
		-- Custom deck configuration: Ranks 2-9 only, all 4 suits (32 cards total)
		cards = {
			-- Hearts (8 cards)
			{s='H',r='2'},{s='H',r='3'},{s='H',r='4'},{s='H',r='5'},
			{s='H',r='6'},{s='H',r='7'},{s='H',r='8'},{s='H',r='9'},
			-- Clubs (8 cards)
			{s='C',r='2'},{s='C',r='3'},{s='C',r='4'},{s='C',r='5'},
			{s='C',r='6'},{s='C',r='7'},{s='C',r='8'},{s='C',r='9'},
			-- Diamonds (8 cards)
			{s='D',r='2'},{s='D',r='3'},{s='D',r='4'},{s='D',r='5'},
			{s='D',r='6'},{s='D',r='7'},{s='D',r='8'},{s='D',r='9'},
			-- Spades (8 cards)
			{s='S',r='2'},{s='S',r='3'},{s='S',r='4'},{s='S',r='5'},
			{s='S',r='6'},{s='S',r='7'},{s='S',r='8'},{s='S',r='9'},
		}
	},
	unlocked = function(self)
		return false -- Always false for multiplayer challenges
	end,
})

