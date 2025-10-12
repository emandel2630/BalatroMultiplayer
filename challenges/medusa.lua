-- Medusa Challenge
-- Start with Eternal Marble Joker
-- 52 cards, with all face cards (J, Q, K) replaced by Stone cards

-- Define the challenge data
local challenge_data = {
	key = "medusa",
	name = "Medusa",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- No special modifiers - just the starting joker and stone face cards
	apply_modifiers = function()
		-- No additional modifiers for this challenge
	end,
}

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "medusa",
	challenge_deck = "c_mp_medusa"
})

-- Create the deck type (required)
MP.DECK.MEDUSA = {}
MP.DECK.MEDUSA.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.MEDUSA.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.MEDUSA.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.MEDUSA.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "medusa",
	name = "Medusa",
	rules = {
		custom = {},
		modifiers = {},
	},
	jokers = {
		{ id = "j_marble", eternal = true }, -- Eternal Marble Joker
	},
	consumeables = {},
	vouchers = {},
	restrictions = {
		banned_cards = MP.DECK.MEDUSA.BANNED_CARDS,
		banned_tags = MP.DECK.MEDUSA.BANNED_TAGS,
		banned_other = MP.DECK.MEDUSA.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.MEDUSA.TYPE,
		-- Custom deck: 52 cards with all face cards as Stone cards
		cards = {
			-- Hearts - A, 2-10 normal
			{s='H',r='A'},{s='H',r='2'},{s='H',r='3'},{s='H',r='4'},{s='H',r='5'},
			{s='H',r='6'},{s='H',r='7'},{s='H',r='8'},{s='H',r='9'},{s='H',r='T'},
			-- Hearts - Face cards as Stone
			{s='H',r='J',e='m_stone'},{s='H',r='Q',e='m_stone'},{s='H',r='K',e='m_stone'},
			
			-- Clubs - A, 2-10 normal
			{s='C',r='A'},{s='C',r='2'},{s='C',r='3'},{s='C',r='4'},{s='C',r='5'},
			{s='C',r='6'},{s='C',r='7'},{s='C',r='8'},{s='C',r='9'},{s='C',r='T'},
			-- Clubs - Face cards as Stone
			{s='C',r='J',e='m_stone'},{s='C',r='Q',e='m_stone'},{s='C',r='K',e='m_stone'},
			
			-- Diamonds - A, 2-10 normal
			{s='D',r='A'},{s='D',r='2'},{s='D',r='3'},{s='D',r='4'},{s='D',r='5'},
			{s='D',r='6'},{s='D',r='7'},{s='D',r='8'},{s='D',r='9'},{s='D',r='T'},
			-- Diamonds - Face cards as Stone
			{s='D',r='J',e='m_stone'},{s='D',r='Q',e='m_stone'},{s='D',r='K',e='m_stone'},
			
			-- Spades - A, 2-10 normal
			{s='S',r='A'},{s='S',r='2'},{s='S',r='3'},{s='S',r='4'},{s='S',r='5'},
			{s='S',r='6'},{s='S',r='7'},{s='S',r='8'},{s='S',r='9'},{s='S',r='T'},
			-- Spades - Face cards as Stone
			{s='S',r='J',e='m_stone'},{s='S',r='Q',e='m_stone'},{s='S',r='K',e='m_stone'},
		}
	},
	unlocked = function(self)
		return false -- Always false for multiplayer challenges
	end,
})

