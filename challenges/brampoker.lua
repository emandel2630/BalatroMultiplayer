-- Bram Poker Challenge
-- Jokers no longer appear in the shop
-- Start with Eternal Vampire, The Emperor, The Empress, Magic Trick (Incantation), Illusion (Talisman)
-- Standard 52 cards

-- Define the challenge data
local challenge_data = {
	key = "brampoker",
	name = "Bram Poker",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- Apply game modifiers when run starts
	apply_modifiers = function()
		-- Disable jokers from appearing in the shop
		G.GAME.modifiers.consumables_only = true
		G.GAME.joker_rate = 0
	end,
}

-- Ban all cards where the id begins with "j" (except j_vampire)
for k, v in pairs(G.P_CENTERS) do
	if type(k) == "string" and k:sub(1, 1) == "j" and k ~= "j_vampire" then
		table.insert(challenge_data.banned_cards, {id = k})
	end
end

-- Ban all cards where the id begins with "j" (except j_vampire)
for k, v in pairs(G.P_CENTERS) do
	if type(k) == "string" and k:sub(1, 1) == "j" then
		table.insert(challenge_data.banned_cards, {id = k})
	end
end

-- Ban multiplayer jokers
table.insert(challenge_data.banned_cards, {id = "j_mp_defensive_joker"})
table.insert(challenge_data.banned_cards, {id = "j_mp_skip_off"})
table.insert(challenge_data.banned_cards, {id = "j_mp_lets_go_gambling"})
table.insert(challenge_data.banned_cards, {id = "j_mp_conjoined_joker"})
table.insert(challenge_data.banned_cards, {id = "j_mp_magnet"})
table.insert(challenge_data.banned_cards, {id = "j_mp_pacifist"})
table.insert(challenge_data.banned_cards, {id = "j_mp_pizza"})
table.insert(challenge_data.banned_cards, {id = "j_mp_taxes"})
table.insert(challenge_data.banned_cards, {id = "j_mp_penny_pincher"})
table.insert(challenge_data.banned_cards, {id = "j_mp_speedrun"})


-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "brampoker",
	challenge_deck = "c_mp_brampoker"
})

-- Create the deck type (required)
MP.DECK.BRAMPOKER = {}
MP.DECK.BRAMPOKER.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.BRAMPOKER.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.BRAMPOKER.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.BRAMPOKER.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "brampoker",
	name = "Bram Poker",
	rules = {
		custom = {
			{id = 'consumables_only'}, -- No jokers in shop
		},
		modifiers = {},
	},
	jokers = {
		{ id = "j_vampire", eternal = true }, -- Eternal Vampire
	},
	consumeables = {
		{ id = "c_emperor" },      -- The Emperor tarot
		{ id = "c_empress" },      -- The Empress tarot
	},
	vouchers = {
		{ id = "v_magic_trick" },  -- Magic Trick (Incantation)
		{ id = "v_illusion" },     -- Illusion (Talisman)
	},
	restrictions = {
		banned_cards = MP.DECK.BRAMPOKER.BANNED_CARDS,
		banned_tags = MP.DECK.BRAMPOKER.BANNED_TAGS,
		banned_other = MP.DECK.BRAMPOKER.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.BRAMPOKER.TYPE,
		-- Standard 52 card deck (default)
	},
	unlocked = function(self)
		return false -- Always false for multiplayer challenges
	end,
})

