if _G.OmmEnabled then
    _G.OmmApi.omm_register_game("SM64 Last Impact", function() return true end, function()
        ---------------
        -- Game data --
        ---------------

        -----------------
        -- Level stars --
        -----------------

        if bhvWhompNPC and bhvUnderCoverMagikoopa and id_bhvParentAndChildRabbit then
            _G.OmmApi.omm_register_star_behavior(bhvWhompNPC, "Whomp NPC", "WHOMP NPC", function(bhvParams) return true end)
            _G.OmmApi.omm_register_star_behavior(id_bhvParentAndChildRabbit, "Mips Parent and Child", "MIPS PARENT AND CHILD", function(bhvParams) return true end)
            _G.OmmApi.omm_register_star_behavior(bhvUnderCoverMagikoopa, "Undercover Witch", "UNDERCOVER WITCH", function(bhvParams) return true end)
            _G.OmmApi.omm_register_star_behavior(bhvRashayButtonStarSpawn, "Buttons", "BUTTONS", function(bhvParams) return true end)
        end

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