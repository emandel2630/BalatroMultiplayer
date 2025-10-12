-- Typecast Challenge
-- When ante 4 boss is defeated:
-- - All Jokers become eternal
-- - Set Joker slots to 0
-- Banned Blinds: Verdant Leaf

-- Define the challenge data
local challenge_data = {
	key = "typecast",
	name = "Typecast",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- Apply game modifiers when run starts
	apply_modifiers = function()
		-- All jokers become eternal after defeating ante 3 boss
		G.GAME.modifiers.set_eternal_ante = 3
		
		-- Set joker slots to 0 after defeating ante 3 boss
		G.GAME.modifiers.set_joker_slots_ante = 3
	end,
}

-- Ban Verdant Leaf (The Plant)
table.insert(challenge_data.banned_blinds, {id = "bl_plant"})

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "typecast",
	challenge_deck = "c_mp_typecast"
})

-- Create the deck type (required)
MP.DECK.TYPECAST = {}
MP.DECK.TYPECAST.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.TYPECAST.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.TYPECAST.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.TYPECAST.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "typecast",
	name = "Typecast",
	rules = {
		custom = {
			-- No standard rules - mechanic is explained in the challenge description
		},
		modifiers = {},
	},
	jokers = {},
	consumeables = {},
	vouchers = {},
	restrictions = {
		banned_cards = MP.DECK.TYPECAST.BANNED_CARDS,
		banned_tags = MP.DECK.TYPECAST.BANNED_TAGS,
		banned_other = MP.DECK.TYPECAST.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.TYPECAST.TYPE,
		-- Standard 52 card deck (default)
	},
	unlocked = function(self)
		return false -- Always false for multiplayer challenges
	end,
})


