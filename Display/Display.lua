-------------------------------------------------------------------------------
-- Frame Names {{{
-------------------------------------------------------------------------------

local _G, _M = getfenv(0), {}
setfenv(1, setmetatable(_M, {__index=_G}))

MBH.MiniMapButton = CreateFrame("Frame", nil , Minimap)
MBH.MainFrame = CreateFrame("Frame", nil , UIParent) 
MBH.OptionFrame = CreateFrame("Frame", nil , UIParent) 
MBH.ProtectionFrame = CreateFrame("Frame", nil , UIParent) 
MBH.PopupPresetFrame = CreateFrame("Frame", nil , UIParent) 
MBH.PopupDefaultFrame = CreateFrame("Frame", nil , UIParent) 

function MBH:CreateWindows()
    MBH.MiniMapButton:CreateMinimapIcon()
    MBH.MainFrame:CreateMainFrame()
    MBH.OptionFrame:CreateOptionFrame()
    MBH.ProtectionFrame:CreateProtectionFrame()
    MBH.PopupPresetFrame:CreatePopupPresetFrame()
    MBH.PopupDefaultFrame:CreatePopupDefaultFrame()
end

function MBH_ResetAllWindow()
    MBH_ResetFramePosition(MBH.MainFrame)
    MBH_ResetFramePosition(MBH.OptionFrame)
    MBH_ResetFramePosition(MBH.ProtectionFrame)
    MBH_ResetFramePosition(MBH.PopupPresetFrame)
    MBH_ResetFramePosition(MBH.PopupDefaultFrame)
end

function MBH_OpenMainFrame()
    if MBH.MainFrame:IsShown() then
        MBH_CloseAllWindow()
    else 
        MBH.MainFrame:Show()
    end
end

function MBH_CloseAllWindow()
    MBH_ResetAllWindow()
    MBH.MainFrame:Hide()
    MBH.OptionFrame:Hide()
    MBH.ProtectionFrame:Hide()
    MBH.PopupPresetFrame:Hide()
    MBH.PopupDefaultFrame:Hide()
end

-------------------------------------------------------------------------------
-- Locals {{{
-------------------------------------------------------------------------------

local ColorPicker = {
    White = { r = 1, g = 1, b = 1, a = 1 },                 -- #ffffff
    Black = { r = 0, g = 0, b = 0, a = 1 },                 -- #000000 

    -- Gray Shades
    Gray50 = { r = 0.976, g = 0.976, b = 0.976, a = 1 },    -- #f9f9f9
    Gray100 = { r = 0.925, g = 0.925, b = 0.925, a = 1 },   -- #ececec
    Gray200 = { r = 0.890, g = 0.890, b = 0.890, a = 1 },   -- #e3e3e3
    Gray300 = { r = 0.804, g = 0.804, b = 0.804, a = 1 },   -- #cdcdcd
    Gray400 = { r = 0.706, g = 0.706, b = 0.706, a = 1 },   -- #b4b4b4
    Gray500 = { r = 0.608, g = 0.608, b = 0.608, a = 1 },   -- #9b9b9b
    Gray600 = { r = 0.404, g = 0.404, b = 0.404, a = 1 },   -- #676767
    Gray700 = { r = 0.259, g = 0.259, b = 0.259, a = 1 },   -- #424242
    Gray800 = { r = 0.184, g = 0.184, b = 0.184, a = 1 },   -- #2f2f2f

    -- Blue Shades
    Blue50 = { r = 0.678, g = 0.725, b = 0.776, a = 1 },    -- #adb9c6
    Blue100 = { r = 0.620, g = 0.675, b = 0.737, a = 1 },   -- #9eaebd
    Blue200 = { r = 0.561, g = 0.624, b = 0.698, a = 1 },   -- #8fa0b2
    Blue300 = { r = 0.502, g = 0.576, b = 0.659, a = 1 },   -- #8093a8
    Blue400 = { r = 0.443, g = 0.529, b = 0.620, a = 1 },   -- #71879e
    Blue500 = { r = 0.384, g = 0.482, b = 0.682, a = 1 },   -- #627bb0
    Blue600 = { r = 0.325, g = 0.435, b = 0.643, a = 1 },   -- #5370a4
    Blue700 = { r = 0.267, g = 0.388, b = 0.604, a = 1 },   -- #44639a
    Blue800 = { r = 0.208, g = 0.341, b = 0.565, a = 1 },   -- #355791

    -- Green Shades
    Green50 = { r = 0.561, g = 0.698, b = 0.624, a = 1 },   -- #8fb28f
    Green100 = { r = 0.502, g = 0.659, b = 0.576, a = 1 },  -- #80a89a
    Green200 = { r = 0.443, g = 0.620, b = 0.529, a = 1 },  -- #719e86
    Green300 = { r = 0.384, g = 0.682, b = 0.482, a = 1 },  -- #62ae7b
    Green400 = { r = 0.325, g = 0.643, b = 0.435, a = 1 },  -- #53a480
    Green500 = { r = 0.267, g = 0.604, b = 0.388, a = 1 },  -- #439a63
    Green600 = { r = 0.208, g = 0.565, b = 0.341, a = 1 },  -- #359155
    Green700 = { r = 0.149, g = 0.525, b = 0.294, a = 1 },  -- #27864b
    Green800 = { r = 0.090, g = 0.486, b = 0.247, a = 1 },  -- #176f3f

    -- Red Shades
    Red500 = { r = 0.937, g = 0.267, b = 0.267, a = 1 },    -- #ef4444
    Red700 = { r = 0.725, g = 0.110, b = 0.110, a = 1 },    -- #b91c1c
}

local BackDrop = {
    bgFile = "Interface/Buttons/WHITE8X8",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    tile = false,
    tileSize = 16,
    edgeSize = 4,
    insets = {
        left = 1,
        right = 1,
        top = 1,
        bottom = 1
    }
}

local SliderBackDrop = {
    bgFile = "Interface/Buttons/UI-SliderBar-Background",
    edgeFile = "Interface/Buttons/UI-SliderBar-Border",
    tile = false,
    tileSize = 16,
    edgeSize = 1,
    insets = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0
    }
}

local ProtectionSpellsAndCheckbox = { }

function MBH_InitializeProtectionSpellsAndCheckbox()
    ProtectionSpellsAndCheckbox = {
        Priest = {
            Flash_Heal_Switch = MBH.ProtectionFrame.FlashHealCheckButton,
            Heal_Switch = MBH.ProtectionFrame.HealCheckButton,
            Greater_Heal_Switch = MBH.ProtectionFrame.GreaterHealCheckButton
        },
        Shaman = {
            Chain_Heal_Switch = MBH.ProtectionFrame.ChainHealCheckButton,
            Lesser_Healing_Wave_Switch = MBH.ProtectionFrame.LesserHealingWaveCheckButton
        },
        Paladin = {
            Holy_Light_Switch = MBH.ProtectionFrame.HolyLightCheckButton
        },
        Druid = {
            Regrowth_Switch = MBH.ProtectionFrame.RegrowthCheckButton
        }
    }
end

-------------------------------------------------------------------------------
-- MiniMap Button {{{
-------------------------------------------------------------------------------

function MBH.MiniMapButton:CreateMinimapIcon()
    local IsMiniMapMoving = false

    self:SetFrameStrata("LOW")
    MBH_SetSize(self, 32, 32)
	self:SetPoint("TOPLEFT", 0, 0)
	
	self.Button = CreateFrame("Button", nil, self)
    MBH_SetSize(self.Button, 32, 32)
    MBH_RegisterAllClicksAndDrags(self.Button)
	self.Button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

	self.Overlay = self:CreateTexture(nil, "OVERLAY", self)
    MBH_SetSize(self.Overlay, 52, 52)
    self.Overlay:SetPoint("TOPLEFT", 0, 0)
	self.Overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
	
	self.MinimapIcon = self:CreateTexture(nil, "BACKGROUND")
    MBH_SetSize(self.MinimapIcon, 18, 18)
	self.MinimapIcon:SetTexture("Interface\\Icons\\Spell_Nature_HealingTouch")
    self.MinimapIcon:SetTexCoord(0.075, 0.925, 0.075, 0.925)

    local function OnUpdate()
        if IsMiniMapMoving then

            local xpos, ypos = GetCursorPosition()
            local xmin, ymin = Minimap:GetLeft(), Minimap:GetBottom()
            xpos = xmin - xpos / UIParent:GetScale() + 70
            ypos = ypos / UIParent:GetScale() - ymin - 70
            local iconPos = math.deg(math.atan2(ypos, xpos))

            if iconPos < 0 then
                iconPos = iconPos + 360
            end

            self:SetPoint(
                "TOPLEFT",
                "Minimap",
                "TOPLEFT",
                54 - (78 * cos(iconPos)),
                (78 * sin(iconPos)) - 55
            )
        end
    end

    local function OnDragStart()
        if not IsMiniMapMoving and arg1 == "LeftButton" then
            self.Button:SetScript("OnUpdate", OnUpdate)
            IsMiniMapMoving = true
        end
    end

    local function OnDragStop()
        if IsMiniMapMoving then
            self.Button:SetScript("OnUpdate", nil)
            IsMiniMapMoving = false
        end
    end

    local function OnClick()
        MBH_OpenMainFrame()
    end

    self.Button:SetScript("OnDragStart", OnDragStart)
    self.Button:SetScript("OnDragStop", OnDragStop)
    self.Button:SetScript("OnClick", OnClick)
    self.Button:SetScript("OnLeave", MBH_HideTooltip)
    self.Button:SetScript("OnEnter", function()
        MBH_ShowToolTip(self, MBH_TITLE, MBH_MINIMAPHOVER)
    end)   
end

-------------------------------------------------------------------------------
-- Main Frame {{{
-------------------------------------------------------------------------------

function MBH.MainFrame:CreateMainFrame()

    MBH_DefaultFrameTemplate(self)
    MBH_DefaultFrameButtons(self)
    
    self.InnerContainer = MBH_CreateInnerContainer(self)

    self.WelcomeText = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    self.WelcomeText:SetText(MBH_WELCOME)
    self.WelcomeText:SetPoint("CENTER", self.InnerContainer, "TOP", 0, -30)

    self.InformationText = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    self.InformationText:SetText(MBH_INFORMATION)
    MBH_SetSize(self.InformationText, 480, 350)
    MBH_SetFontSize(self.InformationText)

    self:Hide()
end

-------------------------------------------------------------------------------
-- Option Frame {{{
-------------------------------------------------------------------------------

function MBH.OptionFrame:CreateOptionFrame()

    MBH_DefaultFrameTemplate(self)
    MBH_DefaultFrameButtons(self)

    -- Healing Settings
    self.HealingContainer = MBH_CreateSmallInnerContainer(self, MBH_HEALSETTINGS)
    self.HealingContainer:SetPoint("TOPLEFT", self, "TOPLEFT", 35, -75)

        self.RandomTargetCheckButton = MBH_CreateCheckButton(self.HealingContainer, MBH_RANDOMTARGET, MoronBoxHeal_Options.AutoHeal.Random_Target, -15)
        self.RandomTargetCheckButton:SetPoint("CENTER", self.HealingContainer, "TOP", 0, -35)
        self.RandomTargetCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.AutoHeal.Random_Target = (self.RandomTargetCheckButton:GetChecked() == 1)
        end)

        self.HealTargetSlider = MBH_CreateSlider(self.HealingContainer, "HealTargetSlider", 220)
        self.HealTargetSlider:SetPoint("CENTER", self.RandomTargetCheckButton, "CENTER", 0, -50)
        self.HealTargetSlider:SetScript("OnValueChanged", HealTargetSlider_OnValueChanged)
        self.HealTargetSlider:SetScript("OnShow", function()
            MBH_InitializeSlider(self.HealTargetSlider, MBH_HEALTARGETNUMBER, MoronBoxHeal_Options.AutoHeal.Heal_Target_Number, 1, 5, 1)
        end)

        self.OverHealHealSlider = MBH_CreateSlider(self.HealingContainer, "OverHealHealSlider", 220)
        self.OverHealHealSlider:SetPoint("CENTER", self.HealTargetSlider, "CENTER", 0, -50)
        self.OverHealHealSlider:SetScript("OnValueChanged", OverHealHealSlider_OnValueChanged)
        self.OverHealHealSlider:SetScript("OnShow", function()
            MBH_InitializeSlider(self.OverHealHealSlider, MBH_ALLOWEDOVERHEAL, MoronBoxHeal_Options.AutoHeal.Allowed_Overheal_Percentage)
        end)

        self.SmartHealCheckButton = MBH_CreateCheckButton(self.HealingContainer, MBH_SMARTHEAL, MoronBoxHeal_Options.AutoHeal.Smart_Heal, -15)
        self.SmartHealCheckButton:SetPoint("CENTER", self.OverHealHealSlider, "CENTER", 0, -35)
        self.SmartHealCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.AutoHeal.Smart_Heal = (self.SmartHealCheckButton:GetChecked() == 1)
        end)

    -- Extended Range
    self.ExtendedRangeContainer = MBH_CreateSmallInnerContainer(self, MBH_RANGSETTINGS)
    self.ExtendedRangeContainer:SetPoint("TOPRIGHT", self, "TOPRIGHT", -35, -75)

        self.ExtendedRangeCheckButton = MBH_CreateCheckButton(self.ExtendedRangeContainer, MBH_EXTENDEDRANGE, MoronBoxHeal_Options.ExtendedRange.Enable, -15)
        self.ExtendedRangeCheckButton:SetPoint("CENTER", self.ExtendedRangeContainer, "CENTER", 0, 35)
        self.ExtendedRangeCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.ExtendedRange.Enable = (self.ExtendedRangeCheckButton:GetChecked() == 1)
        end)

        self.ExtendedRangeFrequencySlider = MBH_CreateSlider(self.ExtendedRangeContainer, "ExtendedRangeFrequencySlider", 220)
        self.ExtendedRangeFrequencySlider:SetPoint("CENTER", self.ExtendedRangeContainer, "CENTER", 0, -50)
        self.ExtendedRangeFrequencySlider:SetScript("OnValueChanged", ExtendedRangeFrequencySlider_OnValueChanged)
        self.ExtendedRangeFrequencySlider:SetScript("OnShow", function()
            MBH_InitializeSlider(self.ExtendedRangeFrequencySlider, MBH_EXTENDEDRANGEFREQUENCY, MoronBoxHeal_Options.ExtendedRange.Frequency, 1, 5, 0.25)
        end)

    -- Light Of Sight
    self.LineOfSightContainer = MBH_CreateSmallInnerContainer(self, MBH_LOSETTINGS)
    self.LineOfSightContainer:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 35, 60)

        self.LineOfSightCheckButton = MBH_CreateCheckButton(self.LineOfSightContainer, MBH_LINEOFSIGHT, MoronBoxHeal_Options.LineOfSight.Enable, -15)
        self.LineOfSightCheckButton:SetPoint("CENTER", self.LineOfSightContainer, "CENTER", 0, 35)
        self.LineOfSightCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.LineOfSight.Enable = (self.LineOfSightCheckButton:GetChecked() == 1)
        end)

        self.LineOfSightFrequencySlider = MBH_CreateSlider(self.LineOfSightContainer, "LineOfSightFrequencySlider", 220)
        self.LineOfSightFrequencySlider:SetPoint("CENTER", self.LineOfSightContainer, "CENTER", 0, -50)
        self.LineOfSightFrequencySlider:SetScript("OnValueChanged", LineOfSightFrequencySlider_OnValueChanged)
        self.LineOfSightFrequencySlider:SetScript("OnShow", function()
            MBH_InitializeSlider(self.LineOfSightFrequencySlider, MBH_LINEOFSIGHTFREQUENCY, MoronBoxHeal_Options.LineOfSight.TimeOut, 0.5, 5, 0.25)
        end)

    -- Advanced Settings
    self.AdvancedOptionsContainer = MBH_CreateSmallInnerContainer(self, MBH_SPECIALSETTINGS)
    self.AdvancedOptionsContainer:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -35, 60)

        self.ManaProtectionCheckButton = MBH_CreateCheckButton(self.AdvancedOptionsContainer, MBH_MANAPROTECTION, MoronBoxHeal_Options.AdvancedOptions.Mana_Protection, -15)
        self.ManaProtectionCheckButton:SetPoint("CENTER", self.AdvancedOptionsContainer, "CENTER", 0, 50)
        self.ManaProtectionCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.AdvancedOptions.Mana_Protection = (self.ManaProtectionCheckButton:GetChecked() == 1)
            if (MoronBoxHeal_Options.AdvancedOptions.Mana_Protection) then
                MBH_EnabledProtection()
            end
        end)

        self.IdleProtectionCheckButton = MBH_CreateCheckButton(self.AdvancedOptionsContainer, MBH_IDLEPROTECTIONENABLE, MoronBoxHeal_Options.AdvancedOptions.LagPrevention.Enabled, -15)
        self.IdleProtectionCheckButton:SetPoint("CENTER", self.ManaProtectionCheckButton, "CENTER", 0, -40)
        self.IdleProtectionCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.AdvancedOptions.LagPrevention.Enabled = (self.IdleProtectionCheckButton:GetChecked() == 1)
        end)

        self.IdleProtectionFrequencySlider = MBH_CreateSlider(self.AdvancedOptionsContainer, "IdleProtectionFrequencySlider", 220)
        self.IdleProtectionFrequencySlider:SetPoint("CENTER", self.AdvancedOptionsContainer, "CENTER", 0, -50)
        self.IdleProtectionFrequencySlider:SetScript("OnValueChanged", IdleProtectionFrequencySlider_OnValueChanged)
        self.IdleProtectionFrequencySlider:SetScript("OnShow", function()
            MBH_InitializeSlider(self.IdleProtectionFrequencySlider, MBH_IDLEPROTECTIONFREQUENCY, MoronBoxHeal_Options.AdvancedOptions.LagPrevention.Frequency, 1, 5, 0.25)
        end)

    self:Hide()
end

-------------------------------------------------------------------------------
-- Protection Frame {{{
-------------------------------------------------------------------------------

function MBH.ProtectionFrame:CreateProtectionFrame()

    MBH_DefaultFrameTemplate(self)
    MBH_DefaultFrameButtons(self)
    self.InnerContainer = MBH_CreateInnerContainer(self)

    if ( Session.PlayerClass == "Priest" ) then

        -- Flash Heal Section
        self.FlashHealTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        self.FlashHealTitle:SetText(MBH_SPELL_FLASH_HEAL)
        self.FlashHealTitle:SetPoint("TOPLEFT", self.InnerContainer, "TOPLEFT", 85, -25)

        self.FlashHealThresholdSlider = MBH_CreateSlider(self.InnerContainer, "FlashHealThresholdSlider", 180)
        self.FlashHealThresholdSlider:SetPoint("CENTER", self.FlashHealTitle, "CENTER", 0, -50)
        self.FlashHealThresholdSlider:SetScript("OnValueChanged", FlashHealThresholdSlider__OnValueChanged)
        self.FlashHealThresholdSlider:SetScript("OnShow", function()
            MBH_InitializeSlider(self.FlashHealThresholdSlider, MBH_FLASHHEALPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Threshold)
        end)

        self.FlashHealLAR = MBH_CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_LAR)
        self.FlashHealLAR:SetPoint("CENTER", self.FlashHealThresholdSlider, "CENTER", 50, -50)

        self.FlashHealHAR = MBH_CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_HAR)
        self.FlashHealHAR:SetPoint("CENTER", self.FlashHealLAR, "CENTER", 0, -50)
   
        self.FlashHealCheckButton = MBH_CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH, MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Switch)
        self.FlashHealCheckButton:SetPoint("CENTER", self.FlashHealHAR, "CENTER", 0, -50)
        self.FlashHealCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Switch = (self.FlashHealCheckButton:GetChecked() == 1)
            MBH_CheckAndDisableManaProtection(self.FlashHealCheckButton)
        end)

        -- Heal Section
        self.HealTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        self.HealTitle:SetText(MBH_SPELL_HEAL)
        self.HealTitle:SetPoint("CENTER", self.InnerContainer, "TOP", 0, -35)

        self.HealThresholdSlider = MBH_CreateSlider(self.InnerContainer, "HealThresholdSlider", 180)
        self.HealThresholdSlider:SetPoint("CENTER", self.HealTitle, "CENTER", 0, -50)
        self.HealThresholdSlider:SetScript("OnValueChanged", HealThresholdSlider_OnValueChanged)
        self.HealThresholdSlider:SetScript("OnShow", function()
            MBH_InitializeSlider(self.HealThresholdSlider, MBH_HEALPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Threshold)
        end)

        self.HealLAR = MBH_CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_LAR)
        self.HealLAR:SetPoint("CENTER", self.HealThresholdSlider, "CENTER", 50, -50)

        self.HealHAR = MBH_CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_HAR)
        self.HealHAR:SetPoint("CENTER", self.HealLAR, "CENTER", 0, -50)

        self.HealCheckButton = MBH_CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH, MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Switch)
        self.HealCheckButton:SetPoint("CENTER", self.HealHAR, "CENTER", 0, -50)
        self.HealCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Switch = (self.HealCheckButton:GetChecked() == 1)
            MBH_CheckAndDisableManaProtection(self.HealCheckButton)
        end)

        -- Greater Heal
        self.GreaterHealTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        self.GreaterHealTitle:SetText(MBH_SPELL_GREATER_HEAL)
        self.GreaterHealTitle:SetPoint("TOPRIGHT", self.InnerContainer, "TOPRIGHT", -85, -25)

        self.GreaterHealThresholdSlider = MBH_CreateSlider(self.InnerContainer, "GreaterHealThresholdSlider", 180)
        self.GreaterHealThresholdSlider:SetPoint("CENTER", self.GreaterHealTitle, "CENTER", 0, -50)
        self.GreaterHealThresholdSlider:SetScript("OnValueChanged", GreaterHealThresholdSlider_OnValueChanged)
        self.GreaterHealThresholdSlider:SetScript("OnShow", function()
            MBH_InitializeSlider(self.GreaterHealThresholdSlider, MBH_GREATERHEALPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Threshold)
        end)

        self.GreaterHealLAR = MBH_CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_LAR)
        self.GreaterHealLAR:SetPoint("CENTER", self.GreaterHealThresholdSlider, "CENTER", 50, -50)

        self.GreaterHealHAR = MBH_CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_HAR)
        self.GreaterHealHAR:SetPoint("CENTER", self.GreaterHealLAR, "CENTER", 0, -50)
        
        self.GreaterHealCheckButton = MBH_CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH, MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Switch)
        self.GreaterHealCheckButton:SetPoint("CENTER", self.GreaterHealHAR, "CENTER", 0, -50)
        self.GreaterHealCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Switch = (self.GreaterHealCheckButton:GetChecked() == 1)
            MBH_CheckAndDisableManaProtection(self.GreaterHealCheckButton)
        end)

        -- Flash Heal Events 
        local function FlashHealLAR_OnEditFocusLost()
            self.FlashHealLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_LAR)
        end
        
        local function FlashHealLAR_OnEscapePressed()
            FlashHealLAR_OnEditFocusLost()
            self.FlashHealLAR:ClearFocus()
        end
        
        local function FlashHealLAR_OnTabPressed()
            self.FlashHealHAR:SetFocus()
        end
        
        local function FlashHealLAR_OnEnterPressed()
            MBH_ValidateLAR(self.FlashHealHAR, "Flash_Heal")
            FlashHealLAR_OnEscapePressed()
        end
        
        self.FlashHealLAR:SetScript("OnEditFocusLost", FlashHealLAR_OnEditFocusLost)
        self.FlashHealLAR:SetScript("OnEscapePressed", FlashHealLAR_OnEscapePressed)
        self.FlashHealLAR:SetScript("OnTabPressed", FlashHealLAR_OnTabPressed)
        self.FlashHealLAR:SetScript("OnEnterPressed", FlashHealLAR_OnEnterPressed)
        
        local function FlashHealHAR_OnEditFocusLost()
            self.FlashHealHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_HAR)
        end
        
        local function FlashHealHAR_OnEscapePressed()
            FlashHealHAR_OnEditFocusLost()
            self.FlashHealHAR:ClearFocus()
        end
        
        local function FlashHealHAR_OnTabPressed()
            self.HealLAR:SetFocus()
        end
        
        local function FlashHealHAR_OnEnterPressed()
            MBH_ValidateHAR(self.FlashHealLAR, MBH_GetMaxSpellRank("Heal"), "Flash_Heal")
            FlashHealHAR_OnEscapePressed()
        end
        
        self.FlashHealHAR:SetScript("OnEditFocusLost", FlashHealHAR_OnEditFocusLost)
        self.FlashHealHAR:SetScript("OnEscapePressed", FlashHealHAR_OnEscapePressed)
        self.FlashHealHAR:SetScript("OnTabPressed", FlashHealHAR_OnTabPressed)
        self.FlashHealHAR:SetScript("OnEnterPressed", FlashHealHAR_OnEnterPressed)

        -- Heal Events
        local function HealLAR_OnEditFocusLost()
            self.HealLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_LAR)
        end
        
        local function HealLAR_OnEscapePressed()
            HealLAR_OnEditFocusLost()
            self.HealLAR:ClearFocus()
        end
        
        local function HealLAR_OnTabPressed()
            self.HealHAR:SetFocus()
        end
        
        local function HealLAR_OnEnterPressed()
            MBH_ValidateLAR(self.HealHAR, "Heal")
            HealLAR_OnEscapePressed()
        end
        
        self.HealLAR:SetScript("OnEditFocusLost", HealLAR_OnEditFocusLost)
        self.HealLAR:SetScript("OnEscapePressed", HealLAR_OnEscapePressed)
        self.HealLAR:SetScript("OnTabPressed", HealLAR_OnTabPressed)
        self.HealLAR:SetScript("OnEnterPressed", HealLAR_OnEnterPressed)
        
        local function HealHAR_OnEditFocusLost()
            self.HealHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_HAR)
        end
        
        local function HealHAR_OnEscapePressed()
            HealHAR_OnEditFocusLost()
            self.HealHAR:ClearFocus()
        end
        
        local function HealHAR_OnTabPressed()
            self.GreaterHealLAR:SetFocus()
        end
        
        local function HealHAR_OnEnterPressed()
            MBH_ValidateHAR(self.HealLAR, MBH_GetMaxSpellRank("Lesser Heal"), "Heal")
            HealHAR_OnEscapePressed()
        end
        
        self.HealHAR:SetScript("OnEditFocusLost", HealHAR_OnEditFocusLost)
        self.HealHAR:SetScript("OnEscapePressed", HealHAR_OnEscapePressed)
        self.HealHAR:SetScript("OnTabPressed", HealHAR_OnTabPressed)
        self.HealHAR:SetScript("OnEnterPressed", HealHAR_OnEnterPressed)

        -- Greater Heal Events
        local function GreaterHealLAR_OnEditFocusLost()
            self.GreaterHealLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_LAR)
        end
        
        local function GreaterHealLAR_OnEscapePressed()
            GreaterHealLAR_OnEditFocusLost()
            self.GreaterHealLAR:ClearFocus()
        end
        
        local function GreaterHealLAR_OnTabPressed()
            self.GreaterHealHAR:SetFocus()
        end
        
        local function GreaterHealLAR_OnEnterPressed()
            MBH_ValidateLAR(self.GreaterHealHAR, "Greater_Heal")
            GreaterHealLAR_OnEscapePressed()
        end
        
        self.GreaterHealLAR:SetScript("OnEditFocusLost", GreaterHealLAR_OnEditFocusLost)
        self.GreaterHealLAR:SetScript("OnEscapePressed", GreaterHealLAR_OnEscapePressed)
        self.GreaterHealLAR:SetScript("OnTabPressed", GreaterHealLAR_OnTabPressed)
        self.GreaterHealLAR:SetScript("OnEnterPressed", GreaterHealLAR_OnEnterPressed)
        
        local function GreaterHealHAR_OnEditFocusLost()
            self.GreaterHealHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_HAR)
        end
        
        local function GreaterHealHAR_OnEscapePressed()
            GreaterHealHAR_OnEditFocusLost()
            self.GreaterHealHAR:ClearFocus()
        end
        
        local function GreaterHealHAR_OnEnterPressed()
            MBH_ValidateHAR(self.GreaterHealLAR, MBH_GetMaxSpellRank("Heal"), "Greater_Heal")
            GreaterHealHAR_OnEscapePressed()
        end
        
        self.GreaterHealHAR:SetScript("OnEditFocusLost", GreaterHealHAR_OnEditFocusLost)
        self.GreaterHealHAR:SetScript("OnEscapePressed", GreaterHealHAR_OnEscapePressed)
        self.GreaterHealHAR:SetScript("OnTabPressed", GreaterHealHAR_OnEscapePressed)
        self.GreaterHealHAR:SetScript("OnEnterPressed", GreaterHealHAR_OnEnterPressed)

    elseif ( Session.PlayerClass == "Shaman" ) then
        
        -- Chain Heal Section
        self.ChainHealTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        self.ChainHealTitle:SetText(MBH_SPELL_CHAIN_HEAL)
        self.ChainHealTitle:SetPoint("TOPLEFT", self.InnerContainer, "TOPLEFT", 145, -25)

        self.ChainHealThresholdSlider = MBH_CreateSlider(self.InnerContainer, "ChainHealThresholdSlider", 180)
        self.ChainHealThresholdSlider:SetPoint("CENTER", self.ChainHealTitle, "CENTER", 0, -50)
        self.ChainHealThresholdSlider:SetScript("OnValueChanged", ChainHealThresholdSlider_OnValueChanged)
        self.ChainHealThresholdSlider:SetScript("OnShow", function()
            MBH_InitializeSlider(self.ChainHealThresholdSlider, MBH_CHAINHEALPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_Threshold)
        end)

        self.ChainHealLAR = MBH_CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_LAR)
        self.ChainHealLAR:SetPoint("CENTER", self.ChainHealThresholdSlider, "CENTER", 50, -50)

        self.ChainHealHAR = MBH_CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_HAR)
        self.ChainHealHAR:SetPoint("CENTER", self.ChainHealLAR, "CENTER", 0, -50)

        self.ChainHealCheckButton = MBH_CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_Switch)
        self.ChainHealCheckButton:SetPoint("CENTER", self.ChainHealHAR, "CENTER", 0, -50)
        self.ChainHealCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_Switch = (self.ChainHealCheckButton:GetChecked() == 1)
            MBH_CheckAndDisableManaProtection(self.ChainHealCheckButton)
        end)

        -- Lesser Healing Wave
        self.LesserHealingWaveTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        self.LesserHealingWaveTitle:SetText(MBH_SPELL_LESSER_HEALING_WAVE)
        self.LesserHealingWaveTitle:SetPoint("TOPRIGHT", self.InnerContainer, "TOPRIGHT", -145, -25)

        self.LesserHealingWaveThresholdSlider = MBH_CreateSlider(self.InnerContainer, "LesserHealingWaveThresholdSlider", 180)
        self.LesserHealingWaveThresholdSlider:SetPoint("CENTER", self.LesserHealingWaveTitle, "CENTER", 0, -50)
        self.LesserHealingWaveThresholdSlider:SetScript("OnValueChanged", LesserHealingWaveThresholdSlider_OnValueChanged)
        self.LesserHealingWaveThresholdSlider:SetScript("OnShow", function()
            MBH_InitializeSlider(self.LesserHealingWaveThresholdSlider, MBH_LESSERHEALINGWAVEPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_Threshold)
        end)

        self.LesserHealingWaveLAR = MBH_CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_LAR)
        self.LesserHealingWaveLAR:SetPoint("CENTER", self.LesserHealingWaveThresholdSlider, "CENTER", 50, -50)

        self.LesserHealingWaveHAR = MBH_CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_HAR)
        self.LesserHealingWaveHAR:SetPoint("CENTER", self.LesserHealingWaveLAR, "CENTER", 0, -50)

        self.LesserHealingWaveCheckButton = MBH_CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_Switch)
        self.LesserHealingWaveCheckButton:SetPoint("CENTER", self.LesserHealingWaveHAR, "CENTER", 0, -50)
        self.LesserHealingWaveCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_Switch = (self.LesserHealingWaveCheckButton:GetChecked() == 1)
            MBH_CheckAndDisableManaProtection(self.LesserHealingWaveCheckButton)
        end)

        -- Chain Heal Events 
        local function ChainHealLAR_OnEditFocusLost()
            self.ChainHealLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_LAR)
        end
        
        local function ChainHealLAR_OnEscapePressed()
            ChainHealLAR_OnEditFocusLost()
            self.ChainHealLAR:ClearFocus()
        end
        
        local function ChainHealLAR_OnTabPressed()
            self.ChainHealHAR:SetFocus()
        end
        
        local function ChainHealLAR_OnEnterPressed()
            MBH_ValidateLAR(self.ChainHealHAR, "Chain_Heal")
            ChainHealLAR_OnEscapePressed()
        end
        
        self.ChainHealLAR:SetScript("OnEditFocusLost", ChainHealLAR_OnEditFocusLost)
        self.ChainHealLAR:SetScript("OnEscapePressed", ChainHealLAR_OnEscapePressed)
        self.ChainHealLAR:SetScript("OnTabPressed", ChainHealLAR_OnTabPressed)
        self.ChainHealLAR:SetScript("OnEnterPressed", ChainHealLAR_OnEnterPressed)
        
        local function ChainHealHAR_OnEditFocusLost()
            self.ChainHealHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_HAR)
        end
        
        local function ChainHealHAR_OnEscapePressed()
            ChainHealHAR_OnEditFocusLost()
            self.ChainHealHAR:ClearFocus()
        end
        
        local function ChainHealHAR_OnTabPressed()
            self.LesserHealingWaveLAR:SetFocus()
        end
        
        local function ChainHealHAR_OnEnterPressed()
            MBH_ValidateHAR(self.ChainHealLAR, MBH_GetMaxSpellRank("Healing Wave"), "Chain_Heal")
            ChainHealHAR_OnEscapePressed()
        end
        
        self.ChainHealHAR:SetScript("OnEditFocusLost", ChainHealHAR_OnEditFocusLost)
        self.ChainHealHAR:SetScript("OnEscapePressed", ChainHealHAR_OnEscapePressed)
        self.ChainHealHAR:SetScript("OnTabPressed", ChainHealHAR_OnTabPressed)
        self.ChainHealHAR:SetScript("OnEnterPressed", ChainHealHAR_OnEnterPressed)

        -- Lesser Healing Wave Events
        local function LesserHealingWaveLAR_OnEditFocusLost()
            self.LesserHealingWaveLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_LAR)
        end
        
        local function LesserHealingWaveLAR_OnEscapePressed()
            LesserHealingWaveLAR_OnEditFocusLost()
            self.LesserHealingWaveLAR:ClearFocus()
        end
        
        local function LesserHealingWaveLAR_OnTabPressed()
            self.LesserHealingWaveHAR:SetFocus()
        end
        
        local function LesserHealingWaveLAR_OnEnterPressed()
            MBH_ValidateLAR(self.LesserHealingWaveHAR, "Lesser_Healing_Wave")
            LesserHealingWaveLAR_OnEscapePressed()
        end
        
        self.LesserHealingWaveLAR:SetScript("OnEditFocusLost", LesserHealingWaveLAR_OnEditFocusLost)
        self.LesserHealingWaveLAR:SetScript("OnEscapePressed", LesserHealingWaveLAR_OnEscapePressed)
        self.LesserHealingWaveLAR:SetScript("OnTabPressed", LesserHealingWaveLAR_OnTabPressed)
        self.LesserHealingWaveLAR:SetScript("OnEnterPressed", LesserHealingWaveLAR_OnEnterPressed)
        
        local function LesserHealingWaveHAR_OnEditFocusLost()
            self.LesserHealingWaveHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_HAR)
        end
        
        local function LesserHealingWaveHAR_OnEscapePressed()
            LesserHealingWaveHAR_OnEditFocusLost()
            self.LesserHealingWaveHAR:ClearFocus()
        end
        
        local function LesserHealingWaveHAR_OnEnterPressed()
            MBH_ValidateHAR(self.LesserHealingWaveLAR, MBH_GetMaxSpellRank("Healing Wave"), "Lesser_Healing_Wave")
            LesserHealingWaveHAR_OnEscapePressed()
        end
        
        self.LesserHealingWaveHAR:SetScript("OnEditFocusLost", LesserHealingWaveHAR_OnEditFocusLost)
        self.LesserHealingWaveHAR:SetScript("OnEscapePressed", LesserHealingWaveHAR_OnEscapePressed)
        self.LesserHealingWaveHAR:SetScript("OnTabPressed", LesserHealingWaveHAR_OnEscapePressed)
        self.LesserHealingWaveHAR:SetScript("OnEnterPressed", LesserHealingWaveHAR_OnEnterPressed)

    elseif ( Session.PlayerClass == "Paladin" ) then
        
        -- Holy Light Section
        self.HolyLightTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        self.HolyLightTitle:SetText(MBH_SPELL_HOLY_LIGHT)
        self.HolyLightTitle:SetPoint("CENTER", self.InnerContainer, "TOP", 0, -35)

        self.HolyLightThresholdSlider = MBH_CreateSlider(self.InnerContainer, "HolyLightThresholdSlider", 180)
        self.HolyLightThresholdSlider:SetPoint("CENTER", self.HolyLightTitle, "CENTER", 0, -50)
        self.HolyLightThresholdSlider:SetScript("OnValueChanged", HolyLightThresholdSlider_OnValueChanged)
        self.HolyLightThresholdSlider:SetScript("OnShow", function()
            MBH_InitializeSlider(self.HolyLightThresholdSlider, MBH_HOLYLIGHTPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_Threshold)
        end)

        self.HolyLightLAR = MBH_CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_LAR)
        self.HolyLightLAR:SetPoint("CENTER", self.HolyLightThresholdSlider, "CENTER", 50, -50)

        self.HolyLightHAR = MBH_CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_HAR)
        self.HolyLightHAR:SetPoint("CENTER", self.HolyLightLAR, "CENTER", 0, -50)

        self.HolyLightCheckButton = MBH_CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH, MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_Switch)
        self.HolyLightCheckButton:SetPoint("CENTER", self.HolyLightHAR, "CENTER", 0, -50)
        self.HolyLightCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_Switch = (self.HolyLightCheckButton:GetChecked() == 1)
            MBH_CheckAndDisableManaProtection(self.HolyLightCheckButton)
        end)

        -- Holy Light Events 
        local function HolyLightLAR_OnEditFocusLost()
            self.HolyLightLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_LAR)
        end

        local function HolyLightLAR_OnEscapePressed()
            HolyLightLAR_OnEditFocusLost()
            self.HolyLightLAR:ClearFocus()
        end

        local function HolyLightLAR_OnTabPressed()
            self.HolyLightHAR:SetFocus()
        end

        local function HolyLightLAR_OnEnterPressed()
            MBH_ValidateLAR(self.HolyLightHAR, "Holy_Light")
            HolyLightLAR_OnEscapePressed()
        end

        self.HolyLightLAR:SetScript("OnEditFocusLost", HolyLightLAR_OnEditFocusLost)
        self.HolyLightLAR:SetScript("OnEscapePressed", HolyLightLAR_OnEscapePressed)
        self.HolyLightLAR:SetScript("OnTabPressed", HolyLightLAR_OnTabPressed)
        self.HolyLightLAR:SetScript("OnEnterPressed", HolyLightLAR_OnEnterPressed)

        local function HolyLightHAR_OnEditFocusLost()
            self.HolyLightHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_HAR)
        end

        local function HolyLightHAR_OnEscapePressed()
            HolyLightHAR_OnEditFocusLost()
            self.HolyLightHAR:ClearFocus()
        end

        local function HolyLightHAR_OnEnterPressed()
            MBH_ValidateHAR(self.HolyLightLAR, MBH_GetMaxSpellRank("Flash of Light"), "Holy_Light")
            HolyLightHAR_OnEscapePressed()
        end

        self.HolyLightHAR:SetScript("OnEditFocusLost", HolyLightHAR_OnEditFocusLost)
        self.HolyLightHAR:SetScript("OnEscapePressed", HolyLightHAR_OnEscapePressed)
        self.HolyLightHAR:SetScript("OnTabPressed", HolyLightHAR_OnEscapePressed)
        self.HolyLightHAR:SetScript("OnEnterPressed", HolyLightHAR_OnEnterPressed)
        
    elseif ( Session.PlayerClass == "Druid" ) then
        
        -- Regrowth Section
        self.RegrowthTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        self.RegrowthTitle:SetText(MBH_SPELL_REGROWTH)
        self.RegrowthTitle:SetPoint("CENTER", self.InnerContainer, "TOP", 0, -35)

        self.RegrowthThresholdSlider = MBH_CreateSlider(self.InnerContainer, "RegrowthThresholdSlider", 180)
        self.RegrowthThresholdSlider:SetPoint("CENTER", self.RegrowthTitle, "CENTER", 0, -50)
        self.RegrowthThresholdSlider:SetScript("OnValueChanged", RegrowthThresholdSlider_OnValueChanged)
        self.RegrowthThresholdSlider:SetScript("OnShow", function()
            MBH_InitializeSlider(self.RegrowthThresholdSlider, MBH_REGROWTHPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_Threshold)
        end)

        self.RegrowthLAR = MBH_CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_LAR)
        self.RegrowthLAR:SetPoint("CENTER", self.RegrowthThresholdSlider, "CENTER", 50, -50)

        self.RegrowthHAR = MBH_CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_HAR)
        self.RegrowthHAR:SetPoint("CENTER", self.RegrowthLAR, "CENTER", 0, -50)

        self.RegrowthCheckButton = MBH_CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH, MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_Switch)
        self.RegrowthCheckButton:SetPoint("CENTER", self.RegrowthHAR, "CENTER", 0, -50)
        self.RegrowthCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_Switch = (self.RegrowthCheckButton:GetChecked() == 1)
            MBH_CheckAndDisableManaProtection(self.RegrowthCheckButton)
        end)

        -- Regrowth Events 
        local function RegrowthLAR_OnEditFocusLost()
            self.RegrowthLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_LAR)
        end

        local function RegrowthLAR_OnEscapePressed()
            RegrowthLAR_OnEditFocusLost()
            self.RegrowthLAR:ClearFocus()
        end

        local function RegrowthLAR_OnTabPressed()
            self.RegrowthHAR:SetFocus()
        end

        local function RegrowthLAR_OnEnterPressed()
            MBH_ValidateLAR(self.RegrowthHAR, "Regrowth")
            RegrowthLAR_OnEscapePressed()
        end

        self.RegrowthLAR:SetScript("OnEditFocusLost", RegrowthLAR_OnEditFocusLost)
        self.RegrowthLAR:SetScript("OnEscapePressed", RegrowthLAR_OnEscapePressed)
        self.RegrowthLAR:SetScript("OnTabPressed", RegrowthLAR_OnTabPressed)
        self.RegrowthLAR:SetScript("OnEnterPressed", RegrowthLAR_OnEnterPressed)

        local function RegrowthHAR_OnEditFocusLost()
            self.RegrowthHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_HAR)
        end

        local function RegrowthHAR_OnEscapePressed()
            RegrowthHAR_OnEditFocusLost()
            self.RegrowthHAR:ClearFocus()
        end

        local function RegrowthHAR_OnEnterPressed()
            MBH_ValidateHAR(self.RegrowthLAR, MBH_GetMaxSpellRank("Healing Touch"), "Regrowth")
            RegrowthHAR_OnEscapePressed()
        end

        self.RegrowthHAR:SetScript("OnEditFocusLost", RegrowthHAR_OnEditFocusLost)
        self.RegrowthHAR:SetScript("OnEscapePressed", RegrowthHAR_OnEscapePressed)
        self.RegrowthHAR:SetScript("OnTabPressed", RegrowthHAR_OnEscapePressed)
        self.RegrowthHAR:SetScript("OnEnterPressed", RegrowthHAR_OnEnterPressed)
    end
    
    self:Hide()
end

-------------------------------------------------------------------------------
-- PopupPreset Frame {{{
-------------------------------------------------------------------------------

function MBH.PopupPresetFrame:CreatePopupPresetFrame()

    MBH_CreatePopupFrame(self)

    self.PopupPresetText = self:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    self.PopupPresetText:SetText(MBH_PRESETSETTINGSCONFIRM)
    self.PopupPresetText:SetPoint("CENTER", self, "TOP", 0, -25)

    self.AcceptButton:SetScript("OnClick", function()
        MBH_LoadPresetSettings()
        self:Hide()
    end)

    self:Hide()
end

-------------------------------------------------------------------------------
-- PopupDefault Frame {{{
-------------------------------------------------------------------------------

function MBH.PopupDefaultFrame:CreatePopupDefaultFrame()

    MBH_CreatePopupFrame(self)

    self.PopupPresetText = self:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    self.PopupPresetText:SetText(MBH_RESTOREDEFAULTCONFIRM)
    self.PopupPresetText:SetPoint("CENTER", self, "TOP", 0, -25)

    self.AcceptButton:SetScript("OnClick", function()
        MBH_SetDefaultValues()
        self:Hide()
    end)

    self:Hide()
end

-------------------------------------------------------------------------------
-- Helper Functions {{{
-------------------------------------------------------------------------------

function MBH_ResetFramePosition(Frame)
    if not Frame then return end

    Frame:ClearAllPoints()
    Frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    Frame:Hide()
end

function MBH_SetBackdropColor(Frame, Color)
    if not Frame or not Color then return end
    Frame:SetBackdropColor(MBH_GetColorValue(Color))
    Frame:SetBackdropBorderColor(MBH_GetColorValue(Color))
end

function MBH_SetFontSize(FontString, Size)
    if not FontString then return end
    if not Size then Size = 13 end
    local font, _, flags = FontString:GetFont()
    FontString:SetFont(font, Size, flags)
end

function MBH_SetSize(Frame, Width, Height)
    if not Frame or not Width or not Height then return end
    Frame:SetWidth(Width)
	Frame:SetHeight(Height)
    Frame:SetPoint("CENTER", 0, 0)
end

function MBH_ShowToolTip(Parent, Title, Text)
    if not Parent or not Title or not Text then return end
    GameTooltip:SetOwner(Parent, "ANCHOR_BOTTOMLEFT")
    GameTooltip:SetText(Title, 1, 1, 0.5)
    GameTooltip:AddLine(Text)
    GameTooltip:Show()
end

function MBH_HideTooltip()
    GameTooltip:Hide()
end

function MBH_GetColorValue(colorKey)
    return ColorPicker[colorKey].r, ColorPicker[colorKey].g, ColorPicker[colorKey].b, ColorPicker[colorKey].a
end

function MBH_RegisterAllClicksAndDrags(Frame)
    if not Frame then return end
    Frame:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
    Frame:RegisterForDrag("LeftButton", "RightButton")
end

function MBH_CreateButton(Parent, Text, Width, Height)
    if not Parent or not Text then return end

    Width = Width or 60
    Height = Height or 25

    local Button = CreateFrame("Button", nil, Parent)
    Button:SetBackdrop(BackDrop)
    MBH_SetSize(Button, Width, Height)
    MBH_SetBackdropColor(Button, "Gray600")

    local Overlay = Button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    Overlay:SetText(Text)
    Overlay:SetPoint("CENTER", Button, "CENTER")
    Button.Overlay = Overlay

    local function Button_OnEnter()
        MBH_SetBackdropColor(Button, "Gray400")
    end

    local function Button_OnLeave()
        MBH_SetBackdropColor(Button, "Gray600")
    end

    Button:SetScript("OnEnter", Button_OnEnter)
    Button:SetScript("OnLeave", Button_OnLeave)
    return Button
end

function MBH_CreateInnerContainer(Parent)
    if not Parent then return end

    local InnerContainer = CreateFrame("Frame", nil, Parent)
    InnerContainer:SetBackdrop(BackDrop)
    MBH_SetSize(InnerContainer, 730, 415)
    MBH_SetBackdropColor(InnerContainer, "Gray600")
    InnerContainer:SetPoint("TOPLEFT", Parent, "TOPLEFT", 35, -75)
    Parent.InnerContainer = InnerContainer

    return InnerContainer
end

function MBH_CreateSmallInnerContainer(Parent, Title)
    if not Parent or not Title then return end

    local SmallInnerContainer = CreateFrame("Frame", nil, Parent)
    SmallInnerContainer:SetBackdrop(BackDrop)
    MBH_SetSize(SmallInnerContainer, 350, 200)
    MBH_SetBackdropColor(SmallInnerContainer, "Gray600")

    local ContainerTitle = SmallInnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    ContainerTitle:SetText(Title)
    ContainerTitle:SetPoint("TOPRIGHT", SmallInnerContainer, "TOPRIGHT", -5, 14)
    SmallInnerContainer.ContainerTitle = ContainerTitle

    return SmallInnerContainer
end

function MBH_DefaultFrameTemplate(Frame)
    local IsMoving = false

    Frame:SetFrameStrata("LOW")
    Frame:SetBackdrop(BackDrop)
    Frame:SetMovable(true)
    Frame:EnableMouse(true)
    MBH_SetSize(Frame, 800, 550)
    MBH_SetBackdropColor(Frame, "Gray800")

    local Title = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    Title:SetText(MBH_TITLE)
    Title:SetPoint("CENTER", Frame, "TOP", 0, -30)
    Frame.Title = Title

    local Author = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    Author:SetText(MBH_AUTHOR)
    Author:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMRIGHT", -10, 15)
    Frame.Author = Author

    local function Frame_OnMouseUp()
        if IsMoving then
            Frame:StopMovingOrSizing()
            IsMoving = false
        end
    end

    local function Frame_OnMouseDown()
        if not IsMoving and arg1 == "LeftButton" then
            Frame:StartMoving()
            IsMoving = true
        end
    end

    Frame:SetScript("OnMouseUp", Frame_OnMouseUp)
    Frame:SetScript("OnMouseDown", Frame_OnMouseDown)
    Frame:SetScript("OnHide", Frame_OnMouseUp)
end

function MBH_DefaultFrameButtons(Parent)

    local GeneralButton = MBH_CreateButton(Parent, MBH_GENERAL) 
    GeneralButton:SetPoint("TOPLEFT", Parent, "TOPLEFT", 10, -15)
    Parent.GeneralButton = GeneralButton
    
    local function GeneralButton_OnShow()
        MBH_SetBackdropColor(GeneralButton, "Gray600")

        if (Parent == MBH.MainFrame) then
            MBH_SetBackdropColor(GeneralButton, "Blue600")
        end
    end

    GeneralButton_OnShow()

    local function GeneralButton_OnEnter()
        MBH_SetBackdropColor(GeneralButton, "Gray400")

        if (Frame == MBH.MainFrame) then
            MBH_SetBackdropColor(GeneralButton, "Blue500")
        end
    end
    
    GeneralButton:SetScript("OnEnter", GeneralButton_OnEnter)
    GeneralButton:SetScript("OnLeave", GeneralButton_OnShow)
    GeneralButton:SetScript("OnClick", function()
        if MBH.MainFrame:Show() then return end
        MBH_CloseAllWindow()
        MBH.MainFrame:Show()
    end)

    local OptionButton = MBH_CreateButton(Parent, MBH_OPTIONS) 
    OptionButton:SetPoint("TOPLEFT", GeneralButton, "TOPRIGHT", 5, 0)
    Parent.OptionButton = OptionButton

    local function OptionButton_OnShow()
        MBH_SetBackdropColor(OptionButton, "Gray600")

        if (Parent == MBH.OptionFrame) then
            MBH_SetBackdropColor(OptionButton, "Blue600")
        end
    end
    
    OptionButton_OnShow()

    local function OptionButton_OnEnter()
        MBH_SetBackdropColor(OptionButton, "Gray400")

        if (Parent == MBH.OptionFrame) then
            MBH_SetBackdropColor(OptionButton, "Blue500")
        end
    end
    
    OptionButton:SetScript("OnEnter", OptionButton_OnEnter)
    OptionButton:SetScript("OnLeave", OptionButton_OnShow)
    OptionButton:SetScript("OnClick", function()
        if MBH.OptionFrame:Show() then return end
        MBH_CloseAllWindow()
        MBH.OptionFrame:Show()
    end)

    local ProtectionButton = MBH_CreateButton(Parent, MBH_PROTECTION, 80) 
    ProtectionButton:SetPoint("TOPLEFT", OptionButton, "TOPRIGHT", 5, 0)
    Parent.ProtectionButton = ProtectionButton

    local function ProtectionButton_OnShow()
        MBH_SetBackdropColor(ProtectionButton, "Gray600")

        if (Parent == MBH.ProtectionFrame) then
            MBH_SetBackdropColor(ProtectionButton, "Blue600")
        end
    end
    
    ProtectionButton_OnShow()

    local function ProtectionButton_OnEnter()
        if (Parent == MBH.ProtectionFrame) then
            MBH_SetBackdropColor(ProtectionButton, "Blue500")
        else
            MBH_SetBackdropColor(ProtectionButton, "Gray400")
        end
    end
    
    ProtectionButton:SetScript("OnEnter", ProtectionButton_OnEnter)
    ProtectionButton:SetScript("OnLeave", ProtectionButton_OnShow)
    ProtectionButton:SetScript("OnClick", function()
        if MBH.ProtectionFrame:Show() then return end
        MBH_CloseAllWindow()
        MBH.ProtectionFrame:Show()
    end)

    local CloseButton = MBH_CreateButton(Parent, MBH_HIDE) 
    CloseButton:SetPoint("TOPRIGHT", Parent, "TOPRIGHT", -10, -15)
    Parent.CloseButton = CloseButton

    local function CloseButton_OnEnter()
        MBH_SetBackdropColor(CloseButton, "Red500")
        CloseButton.Overlay:SetText(MBH_EXIT)
    end

    local function CloseButton_OnLeave()
        MBH_SetBackdropColor(CloseButton, "Gray600")
        CloseButton.Overlay:SetText(MBH_HIDE)
    end

    CloseButton:SetScript("OnEnter", CloseButton_OnEnter)
    CloseButton:SetScript("OnLeave", CloseButton_OnLeave)
    CloseButton:SetScript("OnClick", function()
        Parent:Hide()
    end)

    local DefaultSettingsButton = MBH_CreateButton(Parent, MBH_RESTOREDEFAULT, 120) 
    DefaultSettingsButton:SetPoint("BOTTOMLEFT", Parent, "BOTTOMLEFT", 10, 15)
    Parent.DefaultSettingsButton = DefaultSettingsButton

    local function DefaultSettingsButton_OnEnter()
        MBH_SetBackdropColor(DefaultSettingsButton, "Blue600")
    end

    DefaultSettingsButton:SetScript("OnEnter", DefaultSettingsButton_OnEnter)
    DefaultSettingsButton:SetScript("OnClick", function()
        if (MBH.PopupPresetFrame:IsShown()) then
            MBH.PopupPresetFrame:Hide()
        end
        MBH.PopupDefaultFrame:Show()
    end)

    local PresetSettingsButton = MBH_CreateButton(Parent, MBH_PRESETSETTINGS, 120) 
    PresetSettingsButton:SetPoint("TOPLEFT", DefaultSettingsButton, "TOPRIGHT", 5, 0)
    Parent.PresetSettingsButton = PresetSettingsButton

    local function PresetSettingsButton_OnEnter()
        MBH_SetBackdropColor(PresetSettingsButton, "Blue600")
    end

    PresetSettingsButton:SetScript("OnEnter", PresetSettingsButton_OnEnter)
    PresetSettingsButton:SetScript("OnClick", function()
        if (MBH.PopupDefaultFrame:IsShown()) then
            MBH.PopupDefaultFrame:Hide()
        end
        MBH.PopupPresetFrame:Show()
    end)
end

function MBH_CreateSlider(Parent, Name, Width, Height)
    if not Parent or not Name then return end

    Width = Width or 220
    Height = Height or 16

    local Slider = CreateFrame("Slider", Name, Parent, 'OptionsSliderTemplate')
    Slider:SetBackdrop(SliderBackDrop)
    MBH_SetSize(Slider, Width, Height)
    Parent.Slider = Slider

    return Slider
end

function _G.MBH_SliderValueChanged(Value, String)
    getglobal(this:GetName().."Text"):SetText(string.gsub(String, "$p", Value))
    getglobal(this:GetName().."Text"):SetPoint("BOTTOM", this, "TOP", 0, 5)
end

function MBH_InitializeSlider(Slider, String, Value, MinStep, MaxStep, ValStep)
    getglobal(Slider:GetName().."Text"):SetText(string.gsub(String, "$p", Value))
    getglobal(Slider:GetName().."Text"):SetPoint("BOTTOM", Slider, "TOP", 0, 5)

    MinStep = MinStep or 1
    MaxStep = MaxStep or 100

    Slider:SetMinMaxValues(MinStep, MaxStep)
    Slider:SetValueStep(ValStep or 1)
    Slider:SetValue(Value)

    getglobal(Slider:GetName().."Low"):Hide()
    getglobal(Slider:GetName().."High"):Hide()

    local minValueText = Slider:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    minValueText:SetText(MinStep)
    minValueText:SetPoint("CENTER", Slider, "LEFT", -10, 0)

    local maxValueText = Slider:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    maxValueText:SetText(MaxStep)
    maxValueText:SetPoint("CENTER", Slider, "RIGHT", 10, 0)
end

function MBH_CreateEditBox(Parent, Name, PlaceHolder, Width, Height)
    if not Parent or not Name then return end

    PlaceHolder = PlaceHolder or ""
    Width = Width or 50
    Height = Height or 20

    local EditBox = CreateFrame("EditBox", nil, Parent)
    EditBox:SetText(PlaceHolder)
    EditBox:SetAutoFocus(false)
    EditBox:SetMaxLetters(256)
    EditBox:SetFontObject(GameFontHighlight)
    MBH_SetSize(EditBox, Width, Height)

    EditBox.LeftCurve = EditBox:CreateTexture(nil, "BACKGROUND")
    MBH_SetSize(EditBox.LeftCurve, 12, 29)
    EditBox.LeftCurve:SetPoint("TOPLEFT", -11, 2)
    EditBox.LeftCurve:SetTexture("Interface/ClassTrainerFrame/UI-ClassTrainer-FilterBorder")
    EditBox.LeftCurve:SetTexCoord(0, 0.09375, 0, 1.0)

    EditBox.RightCurve = EditBox:CreateTexture(nil, "BACKGROUND")
    MBH_SetSize(EditBox.RightCurve, 12, 29)
    EditBox.RightCurve:SetPoint("TOPRIGHT", 4, 2)
    EditBox.RightCurve:SetTexture("Interface/ClassTrainerFrame/UI-ClassTrainer-FilterBorder")
    EditBox.RightCurve:SetTexCoord(0.90625, 1.0, 0, 1.0)

    EditBox.MiddleTexture = EditBox:CreateTexture(nil, "BACKGROUND")
    EditBox.MiddleTexture:SetPoint("TOPLEFT", EditBox.LeftCurve, "TOPRIGHT")
    EditBox.MiddleTexture:SetPoint("BOTTOMRIGHT", EditBox.RightCurve, "BOTTOMLEFT")
    EditBox.MiddleTexture:SetTexture("Interface/ClassTrainerFrame/UI-ClassTrainer-FilterBorder")
    EditBox.MiddleTexture:SetTexCoord(0.09375, 0.90625, 0, 1.0)

    local EditBoxText = EditBox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    EditBoxText:SetText(Name)
    EditBoxText:SetPoint("RIGHT", EditBox, "LEFT", -40, 0)
    EditBox.EditBoxText = EditBoxText

    EditBox:SetScript("OnEscapePressed", function()
        EditBox:ClearFocus()
    end)

    return EditBox
end

function MBH_CreateCheckButton(Parent, Title, Value, XAsis)
    if not Parent or not Title then return end

    Value = Value or 0
    XAsis = XAsis or -48.5

    local CheckButton = CreateFrame("CheckButton", nil, Parent, "OptionsCheckButtonTemplate")
    CheckButton:SetChecked(Value)
    
    local CheckButtonText = CheckButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    CheckButtonText:SetText(Title)
    CheckButtonText:SetPoint("RIGHT", CheckButton, "LEFT", XAsis, 0)
    CheckButton.CheckButtonText = CheckButtonText

    return CheckButton
end

function MBH_CreatePopupFrame(PopupFrame)
    local IsMoving = false

    PopupFrame:SetFrameStrata("HIGH")
    PopupFrame:SetMovable(true)
    PopupFrame:EnableMouse(true)
    PopupFrame:SetBackdrop(BackDrop)
    MBH_SetSize(PopupFrame, 300, 110)
    MBH_SetBackdropColor(PopupFrame, "Gray800")

    local PopupFrameText = PopupFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    PopupFrameText:SetText(MBH_RELOADUI)
    PopupFrameText:SetPoint("CENTER", PopupFrame, "CENTER", 0, 0)
    PopupFrame.PopupFrameText = PopupFrameText

    local AcceptButton = MBH_CreateButton(PopupFrame, MBH_YES, 100) 
    AcceptButton:SetPoint("BOTTOMLEFT", PopupFrame, "BOTTOMLEFT", 5, 7.5)
    PopupFrame.AcceptButton = AcceptButton

    local function AcceptButton_OnEnter()
        MBH_SetBackdropColor(AcceptButton, "Green600")
    end

    AcceptButton:SetScript("OnEnter", AcceptButton_OnEnter)

    local DeclineButton = MBH_CreateButton(PopupFrame, MBH_NO, 100) 
    DeclineButton:SetPoint("BOTTOMRIGHT", PopupFrame, "BOTTOMRIGHT", -5, 7.5)
    PopupFrame.DeclineButton = DeclineButton

    local function DeclineButton_OnEnter()
        MBH_SetBackdropColor(DeclineButton, "Red500")
    end

    DeclineButton:SetScript("OnEnter", DeclineButton_OnEnter)
    DeclineButton:SetScript("OnClick", function()
        PopupFrame:Hide()
    end)

    local function PopupFrame_OnMouseUp()
        if IsMoving then
            PopupFrame:StopMovingOrSizing()
            IsMoving = false
        end
    end

    local function PopupFrame_OnMouseDown()
        if not IsMoving and arg1 == "LeftButton" then
            PopupFrame:StartMoving()
            IsMoving = true
        end
    end

    PopupFrame:SetScript("OnMouseUp", PopupFrame_OnMouseUp)
    PopupFrame:SetScript("OnMouseDown", PopupFrame_OnMouseDown)
    PopupFrame:SetScript("OnHide", PopupFrame_OnMouseUp)
end

-------------------------------------------------------------------------------
-- EditBox Checking {{{
-------------------------------------------------------------------------------

function MBH_ValidateLAR(FrameHAR, Value)
    local LARValue = tonumber(this:GetText())
    local HARValue = tonumber(FrameHAR:GetText())

    if ( LARValue and LARValue >= 1 ) then
        if ( HARValue and LARValue <= HARValue ) then
            MoronBoxHeal_Options.ManaProtectionValues[Session.PlayerClass][Value.."_LAR"] = LARValue
        end
    end

    this:SetText(MoronBoxHeal_Options.ManaProtectionValues[Session.PlayerClass][Value.."_LAR"])
end

function MBH_ValidateHAR(FrameLAR, MaxRank, Value)
    local HARValue = tonumber(this:GetText())
    local LARValue = tonumber(FrameLAR:GetText())

    if ( HARValue and HARValue >= 1 ) then
        if ( HARValue <= MaxRank ) and ( LARValue and HARValue >= LARValue ) then
            MoronBoxHeal_Options.ManaProtectionValues[Session.PlayerClass][Value.."_HAR"] = HARValue
        else
            MoronBoxHeal_Options.ManaProtectionValues[Session.PlayerClass][Value.."_HAR"] = MaxRank
        end
    end

    this:SetText(MoronBoxHeal_Options.ManaProtectionValues[Session.PlayerClass][Value.."_HAR"])
end

-------------------------------------------------------------------------------
-- CheckBox Checking {{{
-------------------------------------------------------------------------------

function MBH_EnabledProtection()

    if not next(ProtectionSpellsAndCheckbox) then
        MBH_InitializeProtectionSpellsAndCheckbox()
    end

    local MPOptions = MoronBoxHeal_Options.ManaProtectionValues[Session.PlayerClass]

    if MPOptions then
        local ShouldBeEnabled = true
        for Spell, _ in pairs(ProtectionSpellsAndCheckbox[Session.PlayerClass]) do
            if MPOptions[Spell] then
                ShouldBeEnabled = false
                break
            end
        end

        if ShouldBeEnabled then
            for Spell, CheckButton in pairs(ProtectionSpellsAndCheckbox[Session.PlayerClass]) do
                MPOptions[Spell] = true
                CheckButton:SetChecked(true)
            end
        end
    end
end

function MBH_CheckAndDisableManaProtection(CheckBox)
    if CheckBox:GetChecked() then return end

    if not next(ProtectionSpellsAndCheckbox) then
        MBH_InitializeProtectionSpellsAndCheckbox()
    end

    local MPOptions = MoronBoxHeal_Options.ManaProtectionValues[Session.PlayerClass]

    if MPOptions then
        local shouldDisable = true
        for Spell, _ in pairs(ProtectionSpellsAndCheckbox[Session.PlayerClass]) do
            if MPOptions[Spell] then
                shouldDisable = false
            end
        end

        if shouldDisable then
            MoronBoxHeal_Options.AdvancedOptions.Mana_Protection = false
            MBH.OptionFrame.ManaProtectionCheckButton:SetChecked(false)
        end
    end
end