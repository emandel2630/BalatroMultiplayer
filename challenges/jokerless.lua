-- Jokerless Challenge
-- Jokers no longer appear in the shop
-- 0 Joker Slots
-- Standard 52 cards
-- Banned: Judgement, Wraith, Soul, various tags, Crimson Heart, Verdant Leaf, Amber Acorn, Antimatter, Buffoon Packs

-- Define the challenge data
local challenge_data = {
	key = "jokerless",
	name = "Jokerless",
	
	-- Banned cards for this challenge
	banned_cards = MP.UTILS.shallow_copy(MP.DECK.BANNED_CARDS),
	banned_tags = MP.UTILS.shallow_copy(MP.DECK.BANNED_TAGS),
	banned_blinds = MP.UTILS.shallow_copy(MP.DECK.BANNED_BLINDS),
	
	-- Apply game modifiers when run starts
	apply_modifiers = function()
		-- Disable jokers from appearing in the shop
		G.GAME.modifiers.consumables_only = true
		G.GAME.dollars = 800
		G.jokers:change_size(-5)
		G.GAME.joker_rate = 0
	end,
}

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


-- Ban Tarot Cards
table.insert(challenge_data.banned_cards, {id = "c_judgement"})   -- Judgement

-- Ban Spectral Cards
table.insert(challenge_data.banned_cards, {id = "c_wraith"})      -- Wraith
table.insert(challenge_data.banned_cards, {id = "c_soul"})        -- The Soul

-- Ban Tags
table.insert(challenge_data.banned_tags, {id = "tag_uncommon"})    -- Uncommon Tag
table.insert(challenge_data.banned_tags, {id = "tag_rare"})        -- Rare Tag
table.insert(challenge_data.banned_tags, {id = "tag_negative"})    -- Negative Tag
table.insert(challenge_data.banned_tags, {id = "tag_foil"})        -- Foil Tag
table.insert(challenge_data.banned_tags, {id = "tag_holo"})        -- Holographic Tag
table.insert(challenge_data.banned_tags, {id = "tag_polychrome"})  -- Polychrome Tag
table.insert(challenge_data.banned_tags, {id = "tag_investment"})  -- Buffoon Tag
table.insert(challenge_data.banned_tags, {id = "tag_top_up"})      -- Top-up Tag

-- Ban Blinds
table.insert(challenge_data.banned_blinds, {id = "bl_final_heart"})  -- Crimson Heart
table.insert(challenge_data.banned_blinds, {id = "bl_final_leaf"})   -- Verdant Leaf
table.insert(challenge_data.banned_blinds, {id = "bl_final_acorn"})  -- Amber Acorn

-- Ban Vouchers
table.insert(challenge_data.banned_cards, {id = "v_antimatter"})    -- Antimatter

-- Ban Buffoon Packs (all 4 variants)
table.insert(challenge_data.banned_cards, {id = "p_buffoon_normal_1"})  -- Buffoon Pack (Normal)
table.insert(challenge_data.banned_cards, {id = "p_buffoon_normal_2"})  -- Buffoon Pack (Normal 2)
table.insert(challenge_data.banned_cards, {id = "p_buffoon_jumbo_1"})   -- Jumbo Buffoon Pack
table.insert(challenge_data.banned_cards, {id = "p_buffoon_mega_1"})    -- Mega Buffoon Pack

-- Register the challenge (required)
MP.Challenge.register(challenge_data)

-- Create the ruleset (required)
MP.Ruleset({
	key = "jokerless",
	challenge_deck = "c_mp_jokerless"
})

-- Create the deck type (required)
MP.DECK.JOKERLESS = {}
MP.DECK.JOKERLESS.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.JOKERLESS.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.JOKERLESS.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.JOKERLESS.TYPE = MP.DECK.TYPE .. ""

-- Create the challenge definition (required)
SMODS.Challenge({
	key = "jokerless",
	name = "Jokerless",
	rules = {
		custom = {
			{id = 'consumables_only'}, -- No jokers in shop
		},
		modifiers = {
			dollars = 800,
		},
	},
	jokers = {},
	consumeables = {},
	vouchers = {},
	restrictions = {
		banned_cards = MP.DECK.JOKERLESS.BANNED_CARDS,
		banned_tags = MP.DECK.JOKERLESS.BANNED_TAGS,
		banned_other = MP.DECK.JOKERLESS.BANNED_BLINDS,
	},
	deck = {
		type = MP.DECK.JOKERLESS.TYPE,
		-- Standard 52 card deck (default)
	},
	unlocked = function(self)
		return false -- Always false for multiplayer challenges
	end,
})

