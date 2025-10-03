MP.Ruleset({
	key = "omelette",
	challenge_deck = "c_mp_omelette"
})

MP.DECK.OMELETTE = {}
MP.DECK.OMELETTE.BANNED_CARDS = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS)
MP.DECK.OMELETTE.BANNED_TAGS = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS)
MP.DECK.OMELETTE.BANNED_BLINDS = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS)
MP.DECK.OMELETTE.TYPE = MP.DECK.TYPE .. ""

-- The Omelette challenge: Start with 5 Egg Jokers
SMODS.Challenge({
	key = "omelette",
	name = "The Omelette",
	rules = {
		custom = {},
	modifiers = {
		{ id = "no_extra_hand_money" },
	},
	},
	jokers = {
		{ id = "j_egg"},
		{ id = "j_egg"},
		{ id = "j_egg"},
		{ id = "j_egg"},
		{ id = "j_egg"},
	},
	consumeables = {},
	vouchers = {},
	restrictions = {
		banned_cards = MP.DECK.OMELETTE.BANNED_CARDS,
		banned_tags = MP.DECK.OMELETTE.BANNED_TAGS,
		banned_other = MP.DECK.OMELETTE.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.OMELETTE.TYPE,
	},
	unlocked = function(self)
		return false
	end,
})
