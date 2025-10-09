-- 15 Minute City Challenge
-- Two copies of every face card; no Aces, 2s, or 3s
-- Custom rules: Eternal, Ride the Bus, Shortcut

-- Define the challenge data
local challenge_data = {
	key = "15minutecity",
	name = "15 Minute City",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- Apply game modifiers when run starts
	apply_modifiers = function()
		-- Shortcut: Start at Ante 4
		if G.GAME.round_resets.ante then
			G.GAME.round_resets.ante = 4
		end
	end,
}

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "15minutecity",
	challenge_deck = "c_mp_15minutecity"
})

-- Create the deck type (required)
MP.DECK.FIFTEENMINUTECITY = {}
MP.DECK.FIFTEENMINUTECITY.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.FIFTEENMINUTECITY.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.FIFTEENMINUTECITY.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.FIFTEENMINUTECITY.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "15minutecity",
	name = "15 Minute City",
	rules = {
		custom = {},
		modifiers = {
			-- Empty - we apply modifiers manually if needed
		},
	},
	jokers = {
		{ id = "j_ride_the_bus", eternal = true }, -- Ride the Bus
		{ id = "j_shortcut", eternal = true }, -- Shortcut
	},
	consumeables = {},
	vouchers = {},
	restrictions = {
		banned_cards = MP.DECK.FIFTEENMINUTECITY.BANNED_CARDS,
		banned_tags = MP.DECK.FIFTEENMINUTECITY.BANNED_TAGS,
		banned_other = MP.DECK.FIFTEENMINUTECITY.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.FIFTEENMINUTECITY.TYPE,
		-- Custom deck configuration
		cards = {
			-- 1 copy of each 4-10, 2 copies of each face card (J, Q, K) in all 4 suits
			-- Hearts - regular cards (1 copy each)
			{s='H',r='4'},{s='H',r='5'},{s='H',r='6'},{s='H',r='7'},{s='H',r='8'},{s='H',r='9'},{s='H',r='T'},
			-- Hearts - face cards (2 copies each)
			{s='H',r='J'},{s='H',r='J'},{s='H',r='Q'},{s='H',r='Q'},{s='H',r='K'},{s='H',r='K'},
			-- Clubs - regular cards (1 copy each)
			{s='C',r='4'},{s='C',r='5'},{s='C',r='6'},{s='C',r='7'},{s='C',r='8'},{s='C',r='9'},{s='C',r='T'},
			-- Clubs - face cards (2 copies each)
			{s='C',r='J'},{s='C',r='J'},{s='C',r='Q'},{s='C',r='Q'},{s='C',r='K'},{s='C',r='K'},
			-- Diamonds - regular cards (1 copy each)
			{s='D',r='4'},{s='D',r='5'},{s='D',r='6'},{s='D',r='7'},{s='D',r='8'},{s='D',r='9'},{s='D',r='T'},
			-- Diamonds - face cards (2 copies each)
			{s='D',r='J'},{s='D',r='J'},{s='D',r='Q'},{s='D',r='Q'},{s='D',r='K'},{s='D',r='K'},
			-- Spades - regular cards (1 copy each)
			{s='S',r='4'},{s='S',r='5'},{s='S',r='6'},{s='S',r='7'},{s='S',r='8'},{s='S',r='9'},{s='S',r='T'},
			-- Spades - face cards (2 copies each)
			{s='S',r='J'},{s='S',r='J'},{s='S',r='Q'},{s='S',r='Q'},{s='S',r='K'},{s='S',r='K'},
		}
	},
	unlocked = function(self)
		return false -- Always false for multiplayer challenges
	end,
})

