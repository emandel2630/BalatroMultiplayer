-- Double or Nothing Challenge
-- All played cards become debuffed after scoring
-- Standard 52-card deck, all with red seal

-- Define the challenge data
local challenge_data = {
	key = "doubleornothing",
	name = "Double or Nothing",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- Apply game modifiers when run starts
	apply_modifiers = function()
		-- Enable the double or nothing modifier
		G.GAME.modifiers.double_or_nothing = true
	end,
}

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "doubleornothing",
	challenge_deck = "c_mp_doubleornothing"
})

-- Create the deck type (required)
MP.DECK.DOUBLEORNOTHING = {}
MP.DECK.DOUBLEORNOTHING.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.DOUBLEORNOTHING.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.DOUBLEORNOTHING.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.DOUBLEORNOTHING.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "doubleornothing",
	name = "Double or Nothing",
	rules = {
		custom = {},
		modifiers = {},
	},
	jokers = {},
	consumeables = {},
	vouchers = {},
	restrictions = {
		banned_cards = MP.DECK.DOUBLEORNOTHING.BANNED_CARDS,
		banned_tags = MP.DECK.DOUBLEORNOTHING.BANNED_TAGS,
		banned_other = MP.DECK.DOUBLEORNOTHING.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.DOUBLEORNOTHING.TYPE,
		-- Custom deck: 52 cards all with red seal
		cards = {
			-- Hearts with red seal
			{s='H',r='A',g='Red'},{s='H',r='2',g='Red'},{s='H',r='3',g='Red'},{s='H',r='4',g='Red'},{s='H',r='5',g='Red'},
			{s='H',r='6',g='Red'},{s='H',r='7',g='Red'},{s='H',r='8',g='Red'},{s='H',r='9',g='Red'},{s='H',r='T',g='Red'},
			{s='H',r='J',g='Red'},{s='H',r='Q',g='Red'},{s='H',r='K',g='Red'},
			
			-- Clubs with red seal
			{s='C',r='A',g='Red'},{s='C',r='2',g='Red'},{s='C',r='3',g='Red'},{s='C',r='4',g='Red'},{s='C',r='5',g='Red'},
			{s='C',r='6',g='Red'},{s='C',r='7',g='Red'},{s='C',r='8',g='Red'},{s='C',r='9',g='Red'},{s='C',r='T',g='Red'},
			{s='C',r='J',g='Red'},{s='C',r='Q',g='Red'},{s='C',r='K',g='Red'},
			
			-- Diamonds with red seal
			{s='D',r='A',g='Red'},{s='D',r='2',g='Red'},{s='D',r='3',g='Red'},{s='D',r='4',g='Red'},{s='D',r='5',g='Red'},
			{s='D',r='6',g='Red'},{s='D',r='7',g='Red'},{s='D',r='8',g='Red'},{s='D',r='9',g='Red'},{s='D',r='T',g='Red'},
			{s='D',r='J',g='Red'},{s='D',r='Q',g='Red'},{s='D',r='K',g='Red'},
			
			-- Spades with red seal
			{s='S',r='A',g='Red'},{s='S',r='2',g='Red'},{s='S',r='3',g='Red'},{s='S',r='4',g='Red'},{s='S',r='5',g='Red'},
			{s='S',r='6',g='Red'},{s='S',r='7',g='Red'},{s='S',r='8',g='Red'},{s='S',r='9',g='Red'},{s='S',r='T',g='Red'},
			{s='S',r='J',g='Red'},{s='S',r='Q',g='Red'},{s='S',r='K',g='Red'},
		}
	},
	unlocked = function(self)
		return false -- Always false for multiplayer challenges
	end,
})

