-- Modified by Maxfunkey (aka Carambha of EU-Loardaeron) for patch 3.0.2 November 2nd 2008

if GetLocale() ~= "frFR" then
	return;
end

local function EscapePattern(text)
	if (not text) then
		return;
	end
	return text:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$])","%%%1");
end

local function AddRetailSecondaryStatPatterns(list)
	local statMap = {
		{ STAT_CRITICAL_STRIKE or CRIT_ABBR, { "CRIT", "SPELLCRIT" } },
		{ STAT_HASTE, { "HASTE", "SPELLHASTE" } },
		{ STAT_MASTERY, "MASTERY" },
		{ STAT_VERSATILITY or _G["ITEM_MOD_VERSATILITY"], "VERSATILITY" },
		{ STAT_LIFESTEAL or _G["ITEM_MOD_LIFESTEAL"], "LIFESTEAL" },
		{ STAT_AVOIDANCE or _G["ITEM_MOD_AVOIDANCE"], "AVOIDANCE" },
	};
	for _, entry in ipairs(statMap) do
		local label = EscapePattern(entry[1]);
		if (label) then
			list[#list + 1] = { p = "%+(%d+) "..label, s = entry[2] };
		end
	end
end

LibGearExam.Patterns = {
	--  Base Stats  --
	{ p = "%+(%d+) Force", s = "STR" },
	{ p = "%+(%d+) Agilit�", s = "AGI" },
	{ p = "%+(%d+) Endurance", s = "STA" },
	{ p = "Endurance %+(%d+)", s = "STA" }, -- WORKAROUND: Infused Amethyst (31116)
	{ p = "%+(%d+) Intelligence", s = "INT" },
	{ p = "%+(%d+) Esprit", s = "SPI" },
	{ p = "Armure : (%d+)", s = "ARMOR" },
	{ p = "%+(%d+) Armure", s = "ARMOR" },

	--  Resistances (Exclude the Resist-"ance" then it picks up armor patches as well)  --
	{ p = "%+(%d+) � la r�sistance Arcane", s = "ARCANERESIST" },
	{ p = "%+(%d+) � la r�sistance Feu", s = "FIRERESIST" },
	{ p = "%+(%d+) � la r�sistance Nature", s = "NATURERESIST" },
	{ p = "%+(%d+) � la r�sistance Givre", s = "FROSTRESIST" },
	{ p = "%+(%d+) � la r�sistance Ombre", s = "SHADOWRESIST" },
	{ p = "%+(%d+) � toutes les r�sistances", s = { "ARCANERESIST", "FIRERESIST", "NATURERESIST", "FROSTRESIST", "SHADOWRESIST" } },

	--  Equip: Other  --
	{ p = "Augmente de (%d+) le score de r�silience%.", s = "RESILIENCE" },

	{ p = "Augmente le score de d�fense de (%d+)%.", s = "DEFENSE" },
	{ p = "%+(%d+) score de d�fense", s = "DEFENSE" },
	{ p = "Score de d�fense augment� de (%d+)%.", s = "DEFENSE" },

	{ p = "Augmente de (%d+) le score d'esquive%.", s = "DODGE" },
	{ p = "%+(%d+) score d'esquive", s = "DODGE" },
	{ p = "Augmente votre score d'esquive de (%d+)%.", s = "DODGE" },

	{ p = "Augmente de (%d+) le score de parade%.", s = "PARRY" },
	{ p = "Augmente votre score de parade de (%d+)%.", s = "PARRY" },

	{ p = "Augmente de (%d+) le score de blocage%.", s = "BLOCK" },
	{ p = "%+(%d+) score de blocage", s = "BLOCK" },
	{ p = "Augmente votre score de blocage de (%d+)%.", s = "BLOCK" },

	{ p = "Augmente la valeur de blocage de votre bouclier de (%d+)%.", s = "BLOCKVALUE" },
	{ p = "Bloquer : (%d+)", s = "BLOCKVALUE" },

	--  Equip: Melee & Ranged & Magic  --
	{ p = "Augmente de (%d+) le score de coup critique%.", s = "CRIT", "SPELLCRIT" },
	{ p = "Augmente votre score de coup critique de (%d+)%.", s = "CRIT", "SPELLCRIT" },
	{ p = "+(%d+) score de coup critique%.", s = "CRIT", "SPELLCRIT" },
	{ p = "Augmente de (%d+) le score de toucher%.", s = "HIT", "SPELLHIT" },
	{ p = "Augmente votre score de toucher de (%d+)%.", s = "HIT", "SPELLHIT" },
	{ p = "+(%d+) score de toucher de toucher%.", s = "HIT", "SPELLHIT" },
	{ p = "Augmente de (%d+) le score de h�te%.", s = "HASTE", "SPELLHASTE" },
	{ p = "Augmente votre score de h�te de (%d+)%.", s = "HASTE", "SPELLHASTE" },
	{ p = "+(%d+) score de h�te%.", s = "HASTE", "SPELLHASTE" },

                   -- Equip: melee & Raged
	{ p = "Augmente de (%d+) la puissance d'attaque%.", s = "AP" },
	{ p = "+(%d+) puissance d'attaque%.", s = "AP" },
	{ p = "Augmente la puissance des attaques � distance de (%d+)%.", s = "RAP" },
	{ p = "+(%d+) puissance d'attaque � distance%.", s = "RAP" },
	{ p = "Augmente de (%d+) la puissance d'attaque pour les formes de f�lin, d'ours, d'ours redoutable et de s�l�nien uniquement%.", s = "APFERAL" },


	{ p = "Augmente votre score d'expertise de (%d+)%.", s = "EXPERTISE" },
	{ p = "%+(%d+) score d'expertise", s = "EXPERTISE" },
	{ p = "Vos attaques ignorent (%d+) points de l'armure de votre adversaire%.", s = "ARMORPENETRATION" },

	--  Equip: Magic --



	{ p = "Augmente la p�n�tration de vos sorts de (%d+)%.", s = "SPELLPENETRATION" },

	{ p = "Augmente la puissance des sorts de (%d+)%.", s = { "HEAL", "SPELLDMG" } }, -- New 3.0 spellpower
	{ p = "Augmente les d�g�ts et les soins produits par les sorts et effets magiques de (%d+) au maximum%.", s = { "SPELLDMG", "HEAL" } }, -- No longer used in 3.0+ but due to some inconsistencies the formulation may have remained in some cases
	{ p = "Augmente l�g�rement la puissance des sorts.%.", s = { "SPELLDMG", "HEAL" }, v = 6 },

	{ p = "d�g�ts inflig�s par les sorts et effets des Arcanes de (%d+) au maximum%.", s = "ARCANEDMG" },
	{ p = "d�g�ts inflig�s par les sorts et effets de Feu de (%d+) au maximum%.", s = "FIREDMG" },
	{ p = "d�g�ts inflig�s par les sorts et effets de Nature de (%d+) au maximum%.", s = "NATUREDMG" },
	{ p = "d�g�ts inflig�s par les sorts et effets de Givre de (%d+) au maximum%.", s = "FROSTDMG" },
	{ p = "d�g�ts inflig�s par les sorts et effets d'Ombre de (%d+) au maximum%.", s = "SHADOWDMG" },
	{ p = "d�g�ts inflig�s par les sorts et effets du Sacr� (%d+) au maximum%.", s = "HOLYDMG" },

	--  Health & Mana Per 5 Sec  --
	{ p = "(%d+) points de mana toutes les 5 sec", s = "MP5" },
	{ p = "%+(%d+) � la r�g�n. de mana", s = "MP5" },
	{ p = "%+(%d+) R�g�n. de mana", s = "MP5" },

	{ p = "Rend (%d+) points de vie toutes les 5 sec%.", s = "HP5" },

	--  Enchants / Gems / Socket Bonuses / Mixed / Misc  --
	{ p = "^%+(%d+) PV$", s = "HP" },
	{ p = "^%+(%d+) points de vie$", s = "HP" },
	{ p = "^%+(%d+) points de mana$", s = "MP" },

	{ p = "^Vitalit�$", s = { "MP5", "HP5" }, v = 4 },
	{ p = "^Sauvagerie$", s = "AP", v = 70 },
	{ p = "^Pied s�r$", s = "HIT", v = 10 },
	{ p = "^�me de givre$", s = { "FROSTDMG", "SHADOWDMG" }, v = 54 },
	{ p = "^Feu solaire$", s = { "ARCANEDMG", "FIREDMG" }, v = 50 },

	{ p = "%+(%d+) � toutes les caract�ristiques", s = { "STR", "AGI", "STA", "INT", "SPI" } },

	{ p = "%+(%d+) au score de r�silience", s = "RESILIENCE" },
	{ p = "%+(%d+) au score d'esquive", s = "DODGE" },
	{ p = "%+(%d+) au score de parade", s = "PARRY" },
	{ p = "%+(%d+) au score de d�fense", s = "DEFENSE" },

	{ p = "%+(%d+) � la puissance d'attaque", s = "AP" },

	{ p = "%+(%d+) au score de coup critique|r$", s = "CRIT", "SPELLCRIT" },
	{ p = "%+(%d+) au score de coup critique et", s = "CRIT", "SPELLCRIT" },
	{ p = "%+(%d+) au score de coup critique$", s = "CRIT", "SPELLCRIT" },
	{ p = "%+(%d+) au score de critique$", s = "CRIT", "SPELLCRIT" },
	{ p = "%+(%d+) au score de toucher|r$", s = "HIT", "SPELLHIT" },
	{ p = "%+(%d+) au score de toucher$", s = "HIT", "SPELLHIT" },

	{ p = "%+(%d+) aux sorts de soins", s = "HEAL"},
	{ p = "%+(%d+) aux soins", s = "HEAL"},
	{ p = "%+(%d+) � la puissance des sorts", s = "SPELLDMG", "HEAL" },


	{ p = "%+(%d+) � la p�n�tration des sorts", s = "SPELLPENETRATION" },


	{ p = "%+(%d+) aux  d�g�ts des sorts des Arcanes", s = "ARCANEDMG" },
	{ p = "%+(%d+) aux d�g�ts des sorts de Feu", s = "FIREDMG" },
	{ p = "%+(%d+) aux d�g�ts des sorts de Nature", s = "NATUREDMG" },
	{ p = "%+(%d+) aux d�g�ts des sorts de Givre", s = "FROSTDMG" },
	{ p = "%+(%d+) aux d�g�ts des sorts d'Ombre", s = "SHADOWDMG" },
	{ p = "%+(%d+) aux d�g�ts des sorts du Sacr�", s = "HOLYDMG" },

--[[	{ p = "%+(%d+) S?h?i?e?l?d? ?Block Rating", s = "BLOCK" }, -- Combined Pattern: Covers [Shield Enchant] [Socket Bonus]

	{ p = "%+(%d+) Block Value", s = "BLOCKVALUE" },

	{ p = "%+(%d+) Ranged Attack Power", s = "RAP" },
	{ p = "%+(%d+) Haste Rating", s = "HASTE" },
	{ p = "%+(%d+) Expertise Rating", s = "EXPERTISE" },

	{ p = "%+(%d+) Weapon Damage", s = "WPNDMG" },-]]
	{ p = "^Lunette %(%+(%d+) .* de d�g�ts%)$", s = "RANGEDDMG" },

	-- Demon's Blood
	{ p = "Augmente le score de d�fense de 5, la r�sistance � l'Ombre de 10 et votre r�g�n�ration des points de vie normale de 3%.", s = { "DEFENSE", "SHADOWRESIST", "HP5" }, v = { 5, 10, 3 } },

	-- Void Star Talisman (Warlock T5 Class Trinket)
	{ p = "Augmente les r�sistances de votre familier de 130 et votre puissance des sorts de 48 au maximum%.", s = "SPELLDMG", v = 48 },
};

AddRetailSecondaryStatPatterns(LibGearExam.Patterns);