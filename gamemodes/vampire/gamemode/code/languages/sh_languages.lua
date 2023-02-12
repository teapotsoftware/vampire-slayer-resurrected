
local cv_lang = CreateConVar("vs_language", "en", FCVAR_ARCHIVE + FCVAR_USERINFO, "Language of text for Vampire Slayer to use.")

function LocalText(key)
	local lang = cv_lang:GetString()

	-- Invalid languages default to English
	if not LANG[lang] then
		lang = "en"
	end

	if not LANG[lang][key] then
		-- Fall back to English if our language doesn't have that key yet
		if LANG["en"][key] then
			return LANG["en"][key]
		end

		-- Otherwise, spam console with an error
		print("BAD LANG KEY: " .. key)
		return "### MISSING ###"
	end

	return LANG[lang][key]
end

function LangKeyExists(key)
	local lang = cv_lang:GetString()
	if not LANG[lang] then
		lang = "en"
	end

	return LANG[lang][key] ~= nil
end
