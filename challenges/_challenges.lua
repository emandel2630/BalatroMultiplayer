-- Challenge system for Balatro Multiplayer
-- Challenges are self-contained game modes with special rules and starting conditions

MP.Challenges = {}
MP.Challenge = {
	-- Registry of all challenges
	registered = {},
	
	-- Register a new challenge
	register = function(challenge_data)
		local key = challenge_data.key
		MP.Challenges[key] = challenge_data
		table.insert(MP.Challenge.registered, key)
		
		sendDebugMessage("Registered challenge: " .. key, "MULTIPLAYER")
	end,
	
	-- Get challenge by key
	get = function(key)
		return MP.Challenges[key]
	end,
	
	-- Apply challenge modifiers when starting a run
	apply_modifiers = function(ruleset_key)
		-- Extract challenge key from ruleset (e.g., "ruleset_mp_omelette" -> "omelette")
		local challenge_key = ruleset_key:match("ruleset_mp_(.+)")
		if not challenge_key then return end
		
		local challenge = MP.Challenge.get(challenge_key)
		if not challenge then return end
		
		-- Call the challenge's apply_modifiers function if it exists
		if challenge.apply_modifiers then
			sendDebugMessage("Applying modifiers for challenge: " .. challenge_key, "MULTIPLAYER")
			challenge.apply_modifiers()
		end
	end,
	
	-- Get list of all challenge names for UI
	get_all_names = function()
		local names = {}
		for _, key in ipairs(MP.Challenge.registered) do
			local challenge = MP.Challenges[key]
			if challenge and challenge.name then
				table.insert(names, challenge.name)
			end
		end
		return names
	end,
	
	-- Get challenge key from display name
	get_key_from_name = function(name)
		for key, challenge in pairs(MP.Challenges) do
			if challenge.name == name then
				return key
			end
		end
		return nil
	end,
}

