if _G.OmmEnabled then
    _G.OmmApi.omm_register_game("SM64 Last Impact", function() return true end, function()
        ---------------
        -- Game data --
        ---------------
        
        _G.OmmApi.omm_force_setting("hud", 3)
        
        -----------------
        -- Level stars --
        -----------------

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