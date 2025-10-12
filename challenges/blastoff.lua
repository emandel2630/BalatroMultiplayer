-- Blast Off Challenge
-- 2 hands per round, 2 discards per round
-- 4 Joker Slots
-- Start with Eternal Constellation, Eternal Rocket, Planet Merchant voucher, Planet Tycoon voucher
-- Standard 52 cards
-- Banned Vouchers: Grabber, Nacho Tong
-- Banned Jokers: Burglar

-- Define the challenge data
local challenge_data = {
	key = "blastoff",
	name = "Blast Off",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- Apply game modifiers when run starts
	apply_modifiers = function()
		-- Set hands and discards per round
		G.GAME.round_resets.hands = 2
		G.GAME.round_resets.discards = 2
		
		-- Reduce joker slots from 5 to 4
		G.jokers:change_size(-1)
	end,
}

-- Add banned vouchers
table.insert(challenge_data.banned_cards, {id = "v_grabber"})      -- Grabber
table.insert(challenge_data.banned_cards, {id = "v_nacho_tong"})   -- Nacho Tong

-- Add banned joker
table.insert(challenge_data.banned_cards, {id = "j_burglar"})      -- Burglar

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "blastoff",
	challenge_deck = "c_mp_blastoff"
})

-- Create the deck type (required)
MP.DECK.BLASTOFF = {}
MP.DECK.BLASTOFF.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.BLASTOFF.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.BLASTOFF.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.BLASTOFF.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "blastoff",
	name = "Blast Off",
	rules = {
		custom = {},
		modifiers = {},
	},
	jokers = {
		{ id = "j_constellation", eternal = true },  -- Eternal Constellation
		{ id = "j_rocket", eternal = true },         -- Eternal Rocket
	},
	consumeables = {},
	vouchers = {
		{ id = "v_planet_merchant" },  -- Planet Merchant
		{ id = "v_planet_tycoon" },    -- Planet Tycoon
	},
	restrictions = {
		banned_cards = MP.DECK.BLASTOFF.BANNED_CARDS,
		banned_tags = MP.DECK.BLASTOFF.BANNED_TAGS,
		banned_other = MP.DECK.BLASTOFF.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.BLASTOFF.TYPE,
	},
	unlocked = function(self)
		return false -- Always false for multiplayer challenges
	end,
})

