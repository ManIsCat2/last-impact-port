if _G.OmmEnabled then
    _G.OmmApi.omm_register_game("SM64 Last Impact", function() return true end, function()
        ---------------
        -- Game data --
        ---------------

        _G.OmmApi.omm_register_game_data(-1, 0, LEVEL_NONE, true, true, 0xFFFF00, 500)

        -----------------
        -- Level stars --
        -----------------
        
        _G.OmmApi.omm_register_star_behavior(bhvWhompNPC, "Whomp NPC", "WHOMP NPC", function(bhvParams) return true end)
        _G.OmmApi.omm_register_star_behavior(id_bhvParentAndChildRabbit, "Mips Parent and Child", "MIPS PARENT AND CHILD", function(bhvParams) return true end)
        _G.OmmApi.omm_register_star_behavior(bhvUnderCoverMagikoopa, "Undercover Witch", "UNDERCOVER WITCH", function(bhvParams) return true end)
        _G.OmmApi.omm_register_star_behavior(bhvRashayButtonStarSpawn, "Buttons", "BUTTONS", function(bhvParams) return true end)
        _G.OmmApi.omm_register_star_behavior(bhvRedAndWhiteTargetSpawnStar, "Target", "TARGET", function(bhvParams) return true end)
        _G.OmmApi.omm_register_star_behavior(bhvStarHexagonStarSpawn, "Hexagons", "HEXAGONS", function(bhvParams) return true end)
        _G.OmmApi.omm_register_star_behavior(bhvVirusBossYellow, "Virus", "VIRUS", function(bhvParams) return true end)
        _G.OmmApi.omm_register_star_behavior(bhvFlipswitch_Panel_StarSpawn_MOP, "Flipswitch", "FLIPSWITCH", function(bhvParams) return true end)
        _G.OmmApi.omm_register_star_behavior(id_bhvWfSlidingPlatform, "Blue Thief", "BLUE THIEF", function(bhvParams) return true end)
        _G.OmmApi.omm_register_star_behavior(bhvCorkDrainWater, "Cork", "CORK", function(bhvParams) return true end)
        _G.OmmApi.omm_register_star_behavior(bhvMusicalFruitStarSpawn, "Musical Fruits", "MUSICAL FRUITS", function(bhvParams) return true end)

        --------------------
        -- Star behaviors --
        --------------------

        --------------------
        -- Camera presets --
        --------------------

        -------------------------
        -- Camera no-col boxes --
        -------------------------

        ----------------
        -- Warp pipes --
        ----------------

        -------------------
        -- Non-Stop mode --
        -------------------
    end)
end