-- Fragile Challenge
-- Start with 2x Eternal, Negative Oops! All 6s
-- Standard 52-card deck, all glass
-- All methods of adding non-glass cards or removing glass enhancements are banned

-- Define the challenge data
local challenge_data = {
	key = "fragile",
	name = "Fragile",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- No special modifiers - just the starting jokers and glass deck
	apply_modifiers = function()
		-- No additional modifiers for this challenge
	end,
}

-- Add banned jokers
table.insert(challenge_data.banned_cards, { id = "j_marble" })       -- Marble Joker
table.insert(challenge_data.banned_cards, { id = "j_vampire" })      -- Vampire
table.insert(challenge_data.banned_cards, { id = "j_midas_mask" })   -- Midas Mask
table.insert(challenge_data.banned_cards, { id = "j_certificate" })  -- Certificate

-- Add banned tarot cards
table.insert(challenge_data.banned_cards, { id = "c_magician" })     -- The Magician
table.insert(challenge_data.banned_cards, { id = "c_empress" })      -- The Empress
table.insert(challenge_data.banned_cards, { id = "c_hierophant" })   -- The Hierophant
table.insert(challenge_data.banned_cards, { id = "c_chariot" })      -- The Chariot
table.insert(challenge_data.banned_cards, { id = "c_devil" })        -- The Devil
table.insert(challenge_data.banned_cards, { id = "c_tower" })        -- The Tower
table.insert(challenge_data.banned_cards, { id = "c_lovers" })       -- The Lovers

-- Add banned spectral cards
table.insert(challenge_data.banned_cards, { id = "c_incantation" })  -- Incantation
table.insert(challenge_data.banned_cards, { id = "c_grim" })         -- Grim
table.insert(challenge_data.banned_cards, { id = "c_familiar" })     -- Familiar

-- Add banned vouchers
table.insert(challenge_data.banned_cards, { id = "v_magic_trick" })  -- Magic Trick
table.insert(challenge_data.banned_cards, { id = "v_illusion" })     -- Illusion

-- Add banned booster packs (all Standard Pack variants)
table.insert(challenge_data.banned_cards, { id = "p_standard_normal_1" })
table.insert(challenge_data.banned_cards, { id = "p_standard_normal_2" })
table.insert(challenge_data.banned_cards, { id = "p_standard_normal_3" })
table.insert(challenge_data.banned_cards, { id = "p_standard_normal_4" })
table.insert(challenge_data.banned_cards, { id = "p_standard_jumbo_1" })
table.insert(challenge_data.banned_cards, { id = "p_standard_jumbo_2" })
table.insert(challenge_data.banned_cards, { id = "p_standard_mega_1" })
table.insert(challenge_data.banned_cards, { id = "p_standard_mega_2" })

-- Add banned tags
table.insert(challenge_data.banned_tags, { id = "tag_standard" })    -- Standard Tag

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "fragile",
	challenge_deck = "c_mp_fragile"
})

-- Create the deck type (required)
MP.DECK.FRAGILE = {}
MP.DECK.FRAGILE.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.FRAGILE.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.FRAGILE.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.FRAGILE.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "fragile",
	name = "Fragile",
	rules = {
		custom = {},
		modifiers = {},
	},
	jokers = {
		{ id = "j_oops", edition = "negative", eternal = true },
		{ id = "j_oops", edition = "negative", eternal = true },
	},
	consumeables = {},
	vouchers = {},
	restrictions = {
		banned_cards = MP.DECK.FRAGILE.BANNED_CARDS,
		banned_tags = MP.DECK.FRAGILE.BANNED_TAGS,
		banned_other = MP.DECK.FRAGILE.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.FRAGILE.TYPE,
		-- Custom deck: 52 cards, all with glass enhancement
		cards = {
			-- Hearts - All glass
			{s='H',r='A',e='m_glass'},{s='H',r='2',e='m_glass'},{s='H',r='3',e='m_glass'},{s='H',r='4',e='m_glass'},{s='H',r='5',e='m_glass'},
			{s='H',r='6',e='m_glass'},{s='H',r='7',e='m_glass'},{s='H',r='8',e='m_glass'},{s='H',r='9',e='m_glass'},{s='H',r='T',e='m_glass'},
			{s='H',r='J',e='m_glass'},{s='H',r='Q',e='m_glass'},{s='H',r='K',e='m_glass'},
			
			-- Clubs - All glass
			{s='C',r='A',e='m_glass'},{s='C',r='2',e='m_glass'},{s='C',r='3',e='m_glass'},{s='C',r='4',e='m_glass'},{s='C',r='5',e='m_glass'},
			{s='C',r='6',e='m_glass'},{s='C',r='7',e='m_glass'},{s='C',r='8',e='m_glass'},{s='C',r='9',e='m_glass'},{s='C',r='T',e='m_glass'},
			{s='C',r='J',e='m_glass'},{s='C',r='Q',e='m_glass'},{s='C',r='K',e='m_glass'},
			
			-- Diamonds - All glass
			{s='D',r='A',e='m_glass'},{s='D',r='2',e='m_glass'},{s='D',r='3',e='m_glass'},{s='D',r='4',e='m_glass'},{s='D',r='5',e='m_glass'},
			{s='D',r='6',e='m_glass'},{s='D',r='7',e='m_glass'},{s='D',r='8',e='m_glass'},{s='D',r='9',e='m_glass'},{s='D',r='T',e='m_glass'},
			{s='D',r='J',e='m_glass'},{s='D',r='Q',e='m_glass'},{s='D',r='K',e='m_glass'},
			
			-- Spades - All glass
			{s='S',r='A',e='m_glass'},{s='S',r='2',e='m_glass'},{s='S',r='3',e='m_glass'},{s='S',r='4',e='m_glass'},{s='S',r='5',e='m_glass'},
			{s='S',r='6',e='m_glass'},{s='S',r='7',e='m_glass'},{s='S',r='8',e='m_glass'},{s='S',r='9',e='m_glass'},{s='S',r='T',e='m_glass'},
			{s='S',r='J',e='m_glass'},{s='S',r='Q',e='m_glass'},{s='S',r='K',e='m_glass'},
		}
	},
	unlocked = function(self)
		return false -- Always false for multiplayer challenges
	end,
})

