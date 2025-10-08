# Challenges System

This folder contains the modular challenge system for Balatro Multiplayer. Each challenge is self-contained in its own file with all related code, making it easy to add, modify, or remove challenges.

## How It Works

1. **`_challenges.lua`** - The core challenge system that:
   - Manages challenge registration
   - Applies challenge modifiers automatically when a game starts
   - Provides utilities for the UI to list and select challenges

2. **Individual challenge files** (e.g., `omelette.lua`) - Each challenge contains:
   - Challenge metadata (key, name, banned cards)
   - Game modifiers (money, interest, special rules)
   - Ruleset definition
   - SMODS.Challenge definition (starting jokers, consumables, etc.)

## Adding a New Challenge

### Step 1: Create the Challenge File

1. Copy `_template.lua` to a new file (e.g., `mynewchallenge.lua`)
2. Edit the file and replace all instances of "yourchallenge" with your challenge key
3. Customize the challenge properties:
   - `key`: Unique identifier (lowercase, no spaces)
   - `name`: Display name shown in UI
   - `apply_modifiers()`: Custom game modifiers
   - Starting jokers, consumables, vouchers
   - Banned cards/tags/blinds

### Step 2: Add Localization

Add entries to `localization/en-us.lua`:

```lua
-- In the dictionary section:
k_mynewchallenge = "My New Challenge",
k_mynewchallenge_description = "Description of what makes this challenge unique and fun!",

-- In the challenge_names section:
c_mp_mynewchallenge = "My New Challenge",
```

### Step 3: Done!

That's it! The challenge will automatically:
- Load when the mod starts
- Appear in the Challenge Modes dropdown
- Apply its modifiers when a game starts
- Work with the multiplayer system

## Challenge Structure

### Basic Example

```lua
local challenge_data = {
    key = "speedrun",
    name = "Speedrun",
    
    apply_modifiers = function()
        -- Start with extra money
        G.GAME.dollars = 20
        
        -- Faster blind scaling
        G.GAME.modifiers.scaling = 2
    end,
}

MP.Challenge.register(challenge_data)

MP.Ruleset({
    key = "speedrun",
    challenge_deck = "c_mp_speedrun"
})

MP.DECK.SPEEDRUN = {}
MP.DECK.SPEEDRUN.BANNED_CARDS = challenge_data.banned_cards
MP.DECK.SPEEDRUN.BANNED_TAGS = challenge_data.banned_tags
MP.DECK.SPEEDRUN.BANNED_BLINDS = challenge_data.banned_blinds
MP.DECK.SPEEDRUN.TYPE = MP.DECK.TYPE .. ""

SMODS.Challenge({
    key = "speedrun",
    name = "The Speedrun",
    rules = {
        custom = {
            -- These are for DISPLAY in the challenge UI
            {id = 'no_reward'},
            {id = 'no_interest'},
        },
        modifiers = {
            -- Leave empty - use apply_modifiers() instead
        },
    },
    jokers = {
        { id = "j_joker" },
        { id = "j_greedy_joker", edition = "negative", eternal = true },
    },
    -- ... rest of SMODS.Challenge config
})
```

## Important: Rules vs Modifiers

### `rules.custom` - For Display Only
The `rules.custom` section in SMODS.Challenge shows players what the challenge does. Use **standard Balatro rule IDs** that exist in the base game:
- `{id = 'no_reward'}` - Shows "No money from blinds"
- `{id = 'no_interest'}` - Shows "No interest"
- `{id = 'joker_stickers'}` - Shows "Jokers have stickers"

**These don't actually change the game** - they're just descriptions!

### `apply_modifiers()` - For Actual Changes
The `apply_modifiers()` function is where you make **real changes** to the game. This is called when the run starts and modifies game state.

```lua
apply_modifiers = function()
    -- This ACTUALLY sets money to 10
    G.GAME.dollars = 10
    
    -- This ACTUALLY disables interest
    G.GAME.interest_amount = 0
    G.GAME.interest_cap = 0
end
```

**Always use both**: Put display rules in `rules.custom` and actual changes in `apply_modifiers()`.

## Available Modifiers

You can modify many aspects of the game in `apply_modifiers()`:

### Money & Economy
- `G.GAME.dollars` - Starting money
- `G.GAME.interest_amount` - Interest per $5
- `G.GAME.interest_cap` - Maximum interest
- `MP.LOBBY.config.gold_on_life_loss` - Comeback bonus enabled/disabled

### Game Modifiers
- `G.GAME.modifiers.no_extra_hand_money` - Disable money from unused hands
- `G.GAME.modifiers.no_blind_reward` - Disable blind completion rewards
- `G.GAME.modifiers.jokers_only` - Only jokers in shop
- `G.GAME.modifiers.no_interest` - Disable interest
- And many more...

### Hands & Discards
- `G.GAME.round_resets.hands` - Hands per blind
- `G.GAME.round_resets.discards` - Discards per blind

### Shop
- `G.GAME.shop_size` - Number of shop slots
- `G.GAME.shop_rate` - Shop refresh cost

## Tips

- **Keep it balanced**: Remember this is PvP - both players have the same challenge
- **Test thoroughly**: Use the Testing Mode toggle in lobby options for solo testing
- **Use descriptive names**: Make it clear what the challenge does
- **Document your modifiers**: Add comments explaining why you chose specific values
- **Check existing challenges**: Look at `omelette.lua` for a complete working example

## Troubleshooting

### Challenge doesn't appear in dropdown
- Make sure the file is in the `challenges/` folder
- Check that `MP.Challenge.register()` is called
- Verify the challenge key doesn't have spaces or special characters

### Modifiers not applying
- Ensure `apply_modifiers()` function is defined
- Check the console for any errors
- Verify you're modifying the correct global variables

### Game crashes on start
- Check that all SMODS.Challenge required fields are present
- Ensure ruleset key matches challenge key
- Verify all joker/consumable IDs are valid

### Game crashes when viewing challenge info in shop
- **Don't use custom modifiers in `rules.modifiers`** - use `apply_modifiers()` instead
- Only use `rules.custom` with standard Balatro rule IDs (`no_reward`, `no_interest`, etc.)
- See the "Important: Rules vs Modifiers" section above

### Game crashes when starting with jokers/consumables with editions
- **Don't use `e_` prefix for editions** - use `edition = "negative"` NOT `edition = "e_negative"`
- Valid edition names: `"negative"`, `"foil"`, `"holographic"`, `"polychrome"`
- The system automatically adds the `e_` prefix internally

## Files

- `_challenges.lua` - Core challenge system (don't modify unless adding features)
- `_template.lua` - Template for new challenges (copy this to start)
- `omelette.lua` - Example challenge (reference this for guidance)
- `README.md` - This file

## See Also

- [SMODS Documentation](https://github.com/Steamopollys/Steamodded) for more info on modifiers
- `rulesets/` folder for ruleset examples
- `ui/main_menu.lua` for how challenges are displayed in UI

