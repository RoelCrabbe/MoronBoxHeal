-------------------------------------------------------------------------------
-- Frame Names {{{
-------------------------------------------------------------------------------

MBH.MiniMapButton = CreateFrame("Frame", nil , Minimap) -- Minimap Frame

MBH.ScanningTooltip = CreateFrame("GameTooltip", "ScanningTooltip", UIParent, "GameTooltipTemplate")
MBH.MainFrame = CreateFrame("Frame", nil , UIParent) 
MBH.OptionFrame = CreateFrame("Frame", nil , UIParent) 
MBH.ProtectionFrame = CreateFrame("Frame", nil , UIParent) 
MBH.PopupPresetFrame = CreateFrame("Frame", nil , UIParent) 
MBH.PopupDefaultFrame = CreateFrame("Frame", nil , UIParent) 

function MBH_ResetAllWindow()
    MBH_ResetFramePosition(MBH.MainFrame)
    MBH_ResetFramePosition(MBH.OptionFrame)
    MBH_ResetFramePosition(MBH.ProtectionFrame)
    MBH_ResetFramePosition(MBH.PopupPresetFrame)
    MBH_ResetFramePosition(MBH.PopupDefaultFrame)
end

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

-------------------------------------------------------------------------------
-- MiniMap Button {{{
-------------------------------------------------------------------------------

function MBH.MiniMapButton:CreateMinimapIcon()
    local IsMiniMapMoving = false

    self:SetFrameStrata("LOW")
	self:SetWidth(32)
	self:SetHeight(32)
	self:SetPoint("TOPLEFT", 0, 0)
	
	self.Button = CreateFrame("Button", nil, self)
	self.Button:SetPoint("CENTER", 0, 0)
	self.Button:SetWidth(32)
	self.Button:SetHeight(32)
	self.Button:SetFrameLevel(8)
	self.Button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
    self.Button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    self.Button:RegisterForDrag("LeftButton")

	local Overlay = self:CreateTexture(nil, "OVERLAY", self)
	Overlay:SetWidth(52)
	Overlay:SetHeight(52)
	Overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
	Overlay:SetPoint("TOPLEFT", 0, 0)
	
	local MinimapIcon = self:CreateTexture(nil, "BACKGROUND")
	MinimapIcon:SetWidth(18)
	MinimapIcon:SetHeight(18)
	MinimapIcon:SetTexture("Interface\\Icons\\Spell_Nature_HealingTouch")
	MinimapIcon:SetTexCoord(0.075, 0.925, 0.075, 0.925)
	MinimapIcon:SetPoint("CENTER", 0, 0)

    local function OnEnter()
        GameTooltip:SetOwner(MBH.MiniMapButton, "ANCHOR_BOTTOMLEFT")
        GameTooltip:SetText(MBH_TITLE, 1, 1, 0.5)
        GameTooltip:AddLine(MBH_MINIMAPHOVER)
        GameTooltip:Show()
    end

    local function OnLeave()
        GameTooltip:Hide()
    end

    local function OnClick()
        MinimapIcon:SetTexCoord(0.075, 0.925, 0.075, 0.925)
        if MBH.MainFrame:IsShown() then
            MBH.MainFrame:Hide()
        else 
            MBH_ResetAllWindow()
            MBH.MainFrame:Show()
        end
    end

    local function OnMouseDown()
        MinimapIcon:SetTexCoord(0, 1, 0, 1)
    end

    local function OnMouseUp()
        MinimapIcon:SetTexCoord(0.075, 0.925, 0.075, 0.925)
    end

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

            MBH.MiniMapButton:SetPoint(
                "TOPLEFT",
                "Minimap",
                "TOPLEFT",
                54 - (78 * cos(iconPos)),
                (78 * sin(iconPos)) - 55
            )
        end
    end

    local function OnDragStart()
        MinimapIcon:SetTexCoord(0, 1, 0, 1)
        if not IsMiniMapMoving and arg1 == LeftButton then
            self.Button:SetScript("OnUpdate", OnUpdate)
            IsMiniMapMoving = true
        end
    end

    local function OnDragStop()
        MinimapIcon:SetTexCoord(0.075, 0.925, 0.075, 0.925)
        if IsMiniMapMoving then
            self.Button:SetScript("OnUpdate", nil)
            IsMiniMapMoving = false
        end
    end

    self.Button:SetScript("OnEnter", OnEnter)
    self.Button:SetScript("OnLeave", OnLeave)
    self.Button:SetScript("OnClick", OnClick)
    self.Button:SetScript("OnMouseDown", OnMouseDown)
    self.Button:SetScript("OnMouseUp", OnMouseUp)
    self.Button:SetScript("OnDragStart", OnDragStart)
    self.Button:SetScript("OnDragStop", OnDragStop)
end

-------------------------------------------------------------------------------
-- Main Frame {{{
-------------------------------------------------------------------------------

function MBH.MainFrame:CreateMainFrame()

    DefaultFrameTemplate(self)
    DefaultFrameButtons(self)
    
    self.InnerContainer = CreateInnerContainer(self)

    local WelcomeText = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    WelcomeText:SetText(MBH_WELCOME)
    WelcomeText:SetPoint("CENTER", self.InnerContainer, "TOP", 0, -30)

    local InformationText = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    InformationText:SetText(MBH_INFORMATION)
    InformationText:SetWidth(480)
	InformationText:SetHeight(350)
    InformationText:SetPoint("CENTER", self.InnerContainer, "CENTER")
    SetFontSize(InformationText, 13)

    self:Hide()
end

-------------------------------------------------------------------------------
-- Option Frame {{{
-------------------------------------------------------------------------------

function MBH.OptionFrame:CreateOptionFrame()

    DefaultFrameTemplate(self)
    DefaultFrameButtons(self)

    -- Healign Settings
    self.HealingContainer = CreateSmallInnerContainer(self, MBH_HEALSETTINGS)
    self.HealingContainer:SetPoint("TOPLEFT", self, "TOPLEFT", 35, -75)

    local RandomTargetEnable = CreateCheckButton(self.HealingContainer, MBH_RANDOMTARGET, -15)
    RandomTargetEnable:SetPoint("CENTER", self.HealingContainer, "TOP", 0, -35)
    RandomTargetEnable:SetChecked(MoronBoxHeal_Options.AutoHeal.Random_Target and 1 or 0)
    RandomTargetEnable:SetScript("OnClick", function()
        MoronBoxHeal_Options.AutoHeal.Random_Target = (RandomTargetEnable:GetChecked() == 1)
    end)

    local HealTargetSlider = CreateSlider(self.HealingContainer, "HealTargetSlider", 220)
    HealTargetSlider:SetPoint("CENTER", RandomTargetEnable, "CENTER", 0, -50)
    HealTargetSlider:SetScript("OnValueChanged", HealTargetSlider_OnValueChanged)
    HealTargetSlider:SetScript("OnShow", function()
        InitializeSlider(HealTargetSlider, MBH_HEALTARGETNUMBER, MoronBoxHeal_Options.AutoHeal.Heal_Target_Number, 1, 5, 1)
    end)

    local OverHealHealSlider = CreateSlider(self.HealingContainer, "OverHealHealSlider", 220)
    OverHealHealSlider:SetPoint("CENTER", HealTargetSlider, "CENTER", 0, -50)
    OverHealHealSlider:SetScript("OnValueChanged", OverHealHealSlider_OnValueChanged)
    OverHealHealSlider:SetScript("OnShow", function()
        InitializeSlider(OverHealHealSlider, MBH_ALLOWEDOVERHEAL, MoronBoxHeal_Options.AutoHeal.Allowed_Overheal_Percentage)
    end)

    local SmartHealEnable = CreateCheckButton(self.HealingContainer, MBH_SMARTHEAL, -15)
    SmartHealEnable:SetPoint("CENTER", OverHealHealSlider, "CENTER", 0, -35)
    SmartHealEnable:SetChecked(MoronBoxHeal_Options.AutoHeal.Smart_Heal and 1 or 0)
    SmartHealEnable:SetScript("OnClick", function()
        MoronBoxHeal_Options.AutoHeal.Smart_Heal = (SmartHealEnable:GetChecked() == 1)
    end)

    -- Extended Range
    self.ExtendedRangeContainer = CreateSmallInnerContainer(self, MBH_RANGSETTINGS)
    self.ExtendedRangeContainer:SetPoint("TOPRIGHT", self, "TOPRIGHT", -35, -75)

    local ExtendedRangeEnable = CreateCheckButton(self.ExtendedRangeContainer, MBH_EXTENDEDRANGE, -15)
    ExtendedRangeEnable:SetPoint("CENTER", self.ExtendedRangeContainer, "CENTER", 0, 35)
    ExtendedRangeEnable:SetChecked(MoronBoxHeal_Options.ExtendedRange.Enable and 1 or 0)
    ExtendedRangeEnable:SetScript("OnClick", function()
        MoronBoxHeal_Options.ExtendedRange.Enable = (ExtendedRangeEnable:GetChecked() == 1)
    end)

    local ExtendedRangeFrequencySlider = CreateSlider(self.ExtendedRangeContainer, "ExtendedRangeFrequencySlider", 220)
    ExtendedRangeFrequencySlider:SetPoint("CENTER", self.ExtendedRangeContainer, "CENTER", 0, -50)
    ExtendedRangeFrequencySlider:SetScript("OnValueChanged", ExtendedRangeFrequencySlider_OnValueChanged)
    ExtendedRangeFrequencySlider:SetScript("OnShow", function()
        InitializeSlider(ExtendedRangeFrequencySlider, MBH_EXTENDEDRANGEFREQUENCY, MoronBoxHeal_Options.ExtendedRange.Frequency, 1, 5, 0.25)
    end)

    -- Light Of Sight
    self.LineOfSightContainer = CreateSmallInnerContainer(self, MBH_LOSETTINGS)
    self.LineOfSightContainer:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 35, 60)

    local LineOfSightEnable = CreateCheckButton(self.LineOfSightContainer, MBH_LINEOFSIGHT, -15)
    LineOfSightEnable:SetPoint("CENTER", self.LineOfSightContainer, "CENTER", 0, 35)
    LineOfSightEnable:SetChecked(MoronBoxHeal_Options.LineOfSight.Enable and 1 or 0)
    LineOfSightEnable:SetScript("OnClick", function()
        MoronBoxHeal_Options.LineOfSight.Enable = (LineOfSightEnable:GetChecked() == 1)
    end)

    local LineOfSightFrequencySlider = CreateSlider(self.LineOfSightContainer, "LineOfSightFrequencySlider", 220)
    LineOfSightFrequencySlider:SetPoint("CENTER", self.LineOfSightContainer, "CENTER", 0, -50)
    LineOfSightFrequencySlider:SetScript("OnValueChanged", LineOfSightFrequencySlider_OnValueChanged)
    LineOfSightFrequencySlider:SetScript("OnShow", function()
        InitializeSlider(LineOfSightFrequencySlider, MBH_LINEOFSIGHTFREQUENCY, MoronBoxHeal_Options.LineOfSight.TimeOut, 0.5, 5, 0.25)
    end)

    -- Advanced Settings
    self.AdvancedOptionsContainer = CreateSmallInnerContainer(self, MBH_SPECIALSETTINGS)
    self.AdvancedOptionsContainer:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -35, 60)

    local ManaProtectionEnable = CreateCheckButton(self.AdvancedOptionsContainer, MBH_MANAPROTECTION, -35)
    ManaProtectionEnable:SetPoint("CENTER", self.AdvancedOptionsContainer, "CENTER", 0, 50)
    ManaProtectionEnable:SetChecked(MoronBoxHeal_Options.AdvancedOptions.Mana_Protection and 1 or 0)
    ManaProtectionEnable:SetScript("OnClick", function()
        MoronBoxHeal_Options.AdvancedOptions.Mana_Protection = (ManaProtectionEnable:GetChecked() == 1)
    end)

    local IdleProtectionEnable = CreateCheckButton(self.AdvancedOptionsContainer, MBH_IDLEPROTECTIONENABLE, -35)
    IdleProtectionEnable:SetPoint("CENTER", ManaProtectionEnable, "CENTER", 0, -40)
    IdleProtectionEnable:SetChecked(MoronBoxHeal_Options.AdvancedOptions.LagPrevention.Enabled and 1 or 0)
    IdleProtectionEnable:SetScript("OnClick", function()
        MoronBoxHeal_Options.AdvancedOptions.LagPrevention.Enabled = (IdleProtectionEnable:GetChecked() == 1)
    end)

    local IdleProtectionFrequencySlider = CreateSlider(self.AdvancedOptionsContainer, "IdleProtectionFrequencySlider", 220)
    IdleProtectionFrequencySlider:SetPoint("CENTER", self.AdvancedOptionsContainer, "CENTER", 0, -50)
    IdleProtectionFrequencySlider:SetScript("OnValueChanged", IdleProtectionFrequencySlider_OnValueChanged)
    IdleProtectionFrequencySlider:SetScript("OnShow", function()
        InitializeSlider(IdleProtectionFrequencySlider, MBH_IDLEPROTECTIONFREQUENCY, MoronBoxHeal_Options.AdvancedOptions.LagPrevention.Frequency, 1, 5, 0.25)
    end)

    self:Hide()
end

-------------------------------------------------------------------------------
-- Protection Frame {{{
-------------------------------------------------------------------------------

function MBH.ProtectionFrame:CreateProtectionFrame()

    DefaultFrameTemplate(self)
    DefaultFrameButtons(self)
    self.InnerContainer = CreateInnerContainer(self)

    if ( Session.PlayerClass == "Priest" ) then

        -- Flash Heal Section
        local FlashHealTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        FlashHealTitle:SetText(MBH_SPELL_FLASH_HEAL)
        FlashHealTitle:SetPoint("TOPLEFT", self.InnerContainer, "TOPLEFT", 85, -25)

        local FlashHealSlider = CreateSlider(self.InnerContainer, "FlashHealSlider", 180)
        FlashHealSlider:SetPoint("CENTER", FlashHealTitle, "CENTER", 0, -50)
        FlashHealSlider:SetScript("OnValueChanged", FlashHealSlider_OnValueChanged)
        FlashHealSlider:SetScript("OnShow", function()
            InitializeSlider(FlashHealSlider, MBH_FLASHHEALPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Threshold)
        end)

        local FlashHealLAR = CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK)
        FlashHealLAR:SetPoint("CENTER", FlashHealSlider, "CENTER", 50, -50)
        FlashHealLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_LAR)

        local FlashHealHAR = CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK)
        FlashHealHAR:SetPoint("CENTER", FlashHealLAR, "CENTER", 0, -50)
        FlashHealHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_HAR)

        local FlashHealEnable = CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH)
        FlashHealEnable:SetPoint("CENTER", FlashHealHAR, "CENTER", 0, -50)
        FlashHealEnable:SetChecked(MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Switch and 1 or 0)
        FlashHealEnable:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Switch = (FlashHealEnable:GetChecked() == 1)
        end)

        -- Heal Section
        local HealTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        HealTitle:SetText(MBH_SPELL_HEAL)
        HealTitle:SetPoint("CENTER", self.InnerContainer, "TOP", 0, -35)

        local HealSlider = CreateSlider(self.InnerContainer, "HealSlider", 180)
        HealSlider:SetPoint("CENTER", HealTitle, "CENTER", 0, -50)
        HealSlider:SetScript("OnValueChanged", HealSlider_OnValueChanged)
        HealSlider:SetScript("OnShow", function()
            InitializeSlider(HealSlider, MBH_HEALPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Threshold)
        end)

        local HealLAR = CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK)
        HealLAR:SetPoint("CENTER", HealSlider, "CENTER", 50, -50)
        HealLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_LAR)

        local HealHAR = CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK)
        HealHAR:SetPoint("CENTER", HealLAR, "CENTER", 0, -50)
        HealHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_HAR)

        local HealEnable = CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH)
        HealEnable:SetPoint("CENTER", HealHAR, "CENTER", 0, -50)
        HealEnable:SetChecked(MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Switch and 1 or 0)
        HealEnable:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Switch = (HealEnable:GetChecked() == 1)
        end)

        -- Greater Heal
        local GreaterHealTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        GreaterHealTitle:SetText(MBH_SPELL_GREATER_HEAL)
        GreaterHealTitle:SetPoint("TOPRIGHT", self.InnerContainer, "TOPRIGHT", -85, -25)

        local GreaterHealSlider = CreateSlider(self.InnerContainer, "GreaterHealSlider", 180)
        GreaterHealSlider:SetPoint("CENTER", GreaterHealTitle, "CENTER", 0, -50)
        GreaterHealSlider:SetScript("OnValueChanged", GreaterHealSlider_OnValueChanged)
        GreaterHealSlider:SetScript("OnShow", function()
            InitializeSlider(GreaterHealSlider, MBH_GREATERHEALPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Threshold)
        end)

        local GreaterHealLAR = CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK)
        GreaterHealLAR:SetPoint("CENTER", GreaterHealSlider, "CENTER", 50, -50)
        GreaterHealLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_LAR)

        local GreaterHealHAR = CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK)
        GreaterHealHAR:SetPoint("CENTER", GreaterHealLAR, "CENTER", 0, -50)
        GreaterHealHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_HAR)
        
        local GreaterHealEnable = CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH)
        GreaterHealEnable:SetPoint("CENTER", GreaterHealHAR, "CENTER", 0, -50)
        GreaterHealEnable:SetChecked(MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Switch and 1 or 0)
        GreaterHealEnable:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Switch = (GreaterHealEnable:GetChecked() == 1)
        end)

        -- Flash Heal Events 
        local function FlashHealLAR_OnEnterPressed()
            MBH_ValidateLAR(FlashHealHAR, "Flash_Heal")
            FlashHealLAR:ClearFocus()
        end

        local function FlashHealLAR_OnExitFrame()
            FlashHealLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_LAR)
            FlashHealLAR:ClearFocus()
        end

        local function FlashHealLAR_OnTabPressed()
            FlashHealHAR:SetFocus()
        end

        FlashHealLAR:SetScript("OnEnterPressed", FlashHealLAR_OnEnterPressed)
        FlashHealLAR:SetScript("OnEscapePressed", FlashHealLAR_OnExitFrame)
        FlashHealLAR:SetScript("OnTabPressed", FlashHealLAR_OnTabPressed)

        local function FlashHealHAR_OnEnterPressed()
            MBH_ValidateHAR(FlashHealLAR, MBH_GetMaxSpellRank("Heal"), "Flash_Heal")
            FlashHealHAR:ClearFocus()
        end

        local function FlashHealHAR_OnExitFrame()
            FlashHealHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_HAR)
            FlashHealHAR:ClearFocus()
        end

        local function FlashHealHAR_OnTabPressed()
            HealLAR:SetFocus()
        end

        FlashHealHAR:SetScript("OnEnterPressed", FlashHealHAR_OnEnterPressed)
        FlashHealHAR:SetScript("OnEscapePressed", FlashHealHAR_OnExitFrame)
        FlashHealHAR:SetScript("OnTabPressed", FlashHealHAR_OnTabPressed)

        -- Heal Events
        local function HealLAR_OnEnterPressed()
            MBH_ValidateLAR(HealHAR, "Heal")
            HealLAR:ClearFocus()
        end
        
        local function HealLAR_OnExitFrame()
            HealLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_LAR)
            HealLAR:ClearFocus()
        end
        
        local function HealLAR_OnTabPressed()
            HealHAR:SetFocus()
        end
        
        HealLAR:SetScript("OnEnterPressed", HealLAR_OnEnterPressed)
        HealLAR:SetScript("OnEscapePressed", HealLAR_OnExitFrame)
        HealLAR:SetScript("OnTabPressed", HealLAR_OnTabPressed)
        
        local function HealHAR_OnEnterPressed()
            MBH_ValidateHAR(HealLAR, MBH_GetMaxSpellRank("Lesser Heal"), "Heal")
            HealHAR:ClearFocus()
        end
        
        local function HealHAR_OnExitFrame()
            HealHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_HAR)
            HealHAR:ClearFocus()
        end
        
        local function HealHAR_OnTabPressed()
            GreaterHealLAR:SetFocus()
        end
        
        HealHAR:SetScript("OnEnterPressed", HealHAR_OnEnterPressed)
        HealHAR:SetScript("OnEscapePressed", HealHAR_OnExitFrame)
        HealHAR:SetScript("OnTabPressed", HealHAR_OnTabPressed)

        -- Greater Heal Events
        local function GreaterHealLAR_OnEnterPressed()
            MBH_ValidateLAR(GreaterHealHAR, "Greater_Heal")
            GreaterHealLAR:ClearFocus()
        end
        
        local function GreaterHealLAR_OnExitFrame()
            GreaterHealLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_LAR)
            GreaterHealLAR:ClearFocus()
        end
        
        local function GreaterHealLAR_OnTabPressed()
            GreaterHealHAR:SetFocus()
        end
        
        GreaterHealLAR:SetScript("OnEnterPressed", GreaterHealLAR_OnEnterPressed)
        GreaterHealLAR:SetScript("OnEscapePressed", GreaterHealLAR_OnExitFrame)
        GreaterHealLAR:SetScript("OnTabPressed", GreaterHealLAR_OnTabPressed)
        
        local function GreaterHealHAR_OnEnterPressed()
            MBH_ValidateHAR(GreaterHealLAR, MBH_GetMaxSpellRank("Heal"), "Greater_Heal")
            GreaterHealHAR:ClearFocus()
        end
        
        local function GreaterHealHAR_OnExitFrame()
            GreaterHealHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_HAR)
            GreaterHealHAR:ClearFocus()
        end
        
        local function GreaterHealHAR_OnTabPressed()
            GreaterHealHAR:ClearFocus()
        end
        
        GreaterHealHAR:SetScript("OnEnterPressed", GreaterHealHAR_OnEnterPressed)
        GreaterHealHAR:SetScript("OnEscapePressed", GreaterHealHAR_OnExitFrame)
        GreaterHealHAR:SetScript("OnTabPressed", GreaterHealHAR_OnTabPressed)

    elseif ( Session.PlayerClass == "Shaman" ) then
        
        -- Chain Heal Section
        local ChainHealTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        ChainHealTitle:SetText(MBH_SPELL_CHAIN_HEAL)
        ChainHealTitle:SetPoint("TOPLEFT", self.InnerContainer, "TOPLEFT", 145, -25)

        local ChainHealSlider = CreateSlider(self.InnerContainer, "ChainHealSlider", 180)
        ChainHealSlider:SetPoint("CENTER", ChainHealTitle, "CENTER", 0, -50)
        ChainHealSlider:SetScript("OnValueChanged", ChainHealSlider_OnValueChanged)
        ChainHealSlider:SetScript("OnShow", function()
            InitializeSlider(ChainHealSlider, MBH_CHAINHEALPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_Threshold)
        end)

        local ChainHealLAR = CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK)
        ChainHealLAR:SetPoint("CENTER", ChainHealSlider, "CENTER", 50, -50)
        ChainHealLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_LAR)

        local ChainHealHAR = CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK)
        ChainHealHAR:SetPoint("CENTER", ChainHealLAR, "CENTER", 0, -50)
        ChainHealHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_HAR)

        local ChainHealEnable = CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH)
        ChainHealEnable:SetPoint("CENTER", ChainHealHAR, "CENTER", 0, -50)
        ChainHealEnable:SetChecked(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_Switch and 1 or 0)
        ChainHealEnable:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_Switch = (ChainHealEnable:GetChecked() == 1)
        end)

        -- Lesser Healing Wave
        local LesserHealingWaveTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        LesserHealingWaveTitle:SetText(MBH_SPELL_LESSER_HEALING_WAVE)
        LesserHealingWaveTitle:SetPoint("TOPRIGHT", self.InnerContainer, "TOPRIGHT", -145, -25)

        local LesserHealingWaveSlider = CreateSlider(self.InnerContainer, "LesserHealingWaveSlider", 180)
        LesserHealingWaveSlider:SetPoint("CENTER", LesserHealingWaveTitle, "CENTER", 0, -50)
        LesserHealingWaveSlider:SetScript("OnValueChanged", LesserHealingWaveSlider_OnValueChanged)
        LesserHealingWaveSlider:SetScript("OnShow", function()
            InitializeSlider(LesserHealingWaveSlider, MBH_LESSERHEALINGWAVEPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_Threshold)
        end)

        local LesserHealingWaveLAR = CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK)
        LesserHealingWaveLAR:SetPoint("CENTER", LesserHealingWaveSlider, "CENTER", 50, -50)
        LesserHealingWaveLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_LAR)

        local LesserHealingWaveHAR = CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK)
        LesserHealingWaveHAR:SetPoint("CENTER", LesserHealingWaveLAR, "CENTER", 0, -50)
        LesserHealingWaveHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_HAR)
        
        local LesserHealingWaveEnable = CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH)
        LesserHealingWaveEnable:SetPoint("CENTER", LesserHealingWaveHAR, "CENTER", 0, -50)
        LesserHealingWaveEnable:SetChecked(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_Switch and 1 or 0)
        LesserHealingWaveEnable:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_Switch = (LesserHealingWaveEnable:GetChecked() == 1)
        end)

        -- Flash Heal Events 
        local function ChainHealLAR_OnEnterPressed()
            MBH_ValidateLAR(ChainHealHAR, "Chain_Heal")
            ChainHealLAR:ClearFocus()
        end

        local function ChainHealLAR_OnExitFrame()
            ChainHealLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_LAR)
            ChainHealLAR:ClearFocus()
        end

        local function ChainHealLAR_OnTabPressed()
            ChainHealHAR:SetFocus()
        end

        ChainHealLAR:SetScript("OnEnterPressed", ChainHealLAR_OnEnterPressed)
        ChainHealLAR:SetScript("OnEscapePressed", ChainHealLAR_OnExitFrame)
        ChainHealLAR:SetScript("OnTabPressed", ChainHealLAR_OnTabPressed)

        local function ChainHealHAR_OnEnterPressed()
            MBH_ValidateHAR(ChainHealLAR, MBH_GetMaxSpellRank("Healing Wave"), "Chain_Heal")
            ChainHealHAR:ClearFocus()
        end

        local function ChainHealHAR_OnExitFrame()
            ChainHealHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_HAR)
            ChainHealHAR:ClearFocus()
        end

        local function ChainHealHAR_OnTabPressed()
            LesserHealingWaveLAR:SetFocus()
        end

        ChainHealHAR:SetScript("OnEnterPressed", ChainHealHAR_OnEnterPressed)
        ChainHealHAR:SetScript("OnEscapePressed", ChainHealHAR_OnExitFrame)
        ChainHealHAR:SetScript("OnTabPressed", ChainHealHAR_OnTabPressed)

        -- Lesser Healing Wave Events
        local function LesserHealingWaveLAR_OnEnterPressed()
            MBH_ValidateLAR(LesserHealingWaveHAR, "Lesser_Healing_Wave")
            LesserHealingWaveLAR:ClearFocus()
        end
        
        local function LesserHealingWaveLAR_OnExitFrame()
            LesserHealingWaveLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_LAR)
            LesserHealingWaveLAR:ClearFocus()
        end
        
        local function LesserHealingWaveLAR_OnTabPressed()
            LesserHealingWaveHAR:SetFocus()
        end
        
        LesserHealingWaveLAR:SetScript("OnEnterPressed", LesserHealingWaveLAR_OnEnterPressed)
        LesserHealingWaveLAR:SetScript("OnEscapePressed", LesserHealingWaveLAR_OnExitFrame)
        LesserHealingWaveLAR:SetScript("OnTabPressed", LesserHealingWaveLAR_OnTabPressed)
        
        local function LesserHealingWaveHAR_OnEnterPressed()
            MBH_ValidateHAR(LesserHealingWaveLAR, MBH_GetMaxSpellRank("Healing Wave"), "Lesser_Healing_Wave")
            LesserHealingWaveHAR:ClearFocus()
        end
        
        local function LesserHealingWaveHAR_OnExitFrame()
            LesserHealingWaveHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_HAR)
            LesserHealingWaveHAR:ClearFocus()
        end
        
        local function LesserHealingWaveHAR_OnTabPressed()
            LesserHealingWaveHAR:ClearFocus()
        end
        
        LesserHealingWaveHAR:SetScript("OnEnterPressed", LesserHealingWaveHAR_OnEnterPressed)
        LesserHealingWaveHAR:SetScript("OnEscapePressed", LesserHealingWaveHAR_OnExitFrame)
        LesserHealingWaveHAR:SetScript("OnTabPressed", LesserHealingWaveHAR_OnTabPressed)

    elseif ( Session.PlayerClass == "Paladin" ) then
        
        -- Holy Light Section
        local HolyLightTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        HolyLightTitle:SetText(MBH_SPELL_HOLY_LIGHT)
        HolyLightTitle:SetPoint("CENTER", self.InnerContainer, "TOP", 0, -35)

        local HolyLightSlider = CreateSlider(self.InnerContainer, "HolyLightSlider", 180)
        HolyLightSlider:SetPoint("CENTER", HolyLightTitle, "CENTER", 0, -50)
        HolyLightSlider:SetScript("OnValueChanged", HolyLightSlider_OnValueChanged)
        HolyLightSlider:SetScript("OnShow", function()
            InitializeSlider(HolyLightSlider, MBH_HOLYLIGHTPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_Threshold)
        end)

        local HolyLightLAR = CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK)
        HolyLightLAR:SetPoint("CENTER", HolyLightSlider, "CENTER", 50, -50)
        HolyLightLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_LAR)

        local HolyLightHAR = CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK)
        HolyLightHAR:SetPoint("CENTER", HolyLightLAR, "CENTER", 0, -50)
        HolyLightHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_HAR)

        local HolyLightEnable = CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH)
        HolyLightEnable:SetPoint("CENTER", HolyLightHAR, "CENTER", 0, -50)
        HolyLightEnable:SetChecked(MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_Switch and 1 or 0)
        HolyLightEnable:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_Switch = (HolyLightEnable:GetChecked() == 1)
        end)

        -- Holy Light Events 
        local function HolyLightLAR_OnEnterPressed()
            MBH_ValidateLAR(HolyLightHAR, "Holy_Light")
            HolyLightLAR:ClearFocus()
        end

        local function HolyLightLAR_OnExitFrame()
            HolyLightLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_LAR)
            HolyLightLAR:ClearFocus()
        end

        local function HolyLightLAR_OnTabPressed()
            HolyLightHAR:SetFocus()
        end

        HolyLightLAR:SetScript("OnEnterPressed", HolyLightLAR_OnEnterPressed)
        HolyLightLAR:SetScript("OnEscapePressed", HolyLightLAR_OnExitFrame)
        HolyLightLAR:SetScript("OnTabPressed", HolyLightLAR_OnTabPressed)

        local function HolyLightHAR_OnEnterPressed()
            MBH_ValidateHAR(HolyLightLAR, MBH_GetMaxSpellRank("Flash of Light"), "Holy_Light")
            HolyLightHAR:ClearFocus()
        end

        local function HolyLightHAR_OnExitFrame()
            HolyLightHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_HAR)
            HolyLightHAR:ClearFocus()
        end

        local function HolyLightHAR_OnTabPressed()
            HolyLightHAR:ClearFocus()
        end

        HolyLightHAR:SetScript("OnEnterPressed", HolyLightHAR_OnEnterPressed)
        HolyLightHAR:SetScript("OnEscapePressed", HolyLightHAR_OnExitFrame)
        HolyLightHAR:SetScript("OnTabPressed", HolyLightHAR_OnTabPressed)

    elseif ( Session.PlayerClass == "Druid" ) then
        
        -- Regrowth Section
        local RegrowthTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        RegrowthTitle:SetText(MBH_SPELL_REGROWTH)
        RegrowthTitle:SetPoint("CENTER", self.InnerContainer, "TOP", 0, -35)

        local RegrowthSlider = CreateSlider(self.InnerContainer, "RegrowthSlider", 180)
        RegrowthSlider:SetPoint("CENTER", RegrowthTitle, "CENTER", 0, -50)
        RegrowthSlider:SetScript("OnValueChanged", RegrowthSlider_OnValueChanged)
        RegrowthSlider:SetScript("OnShow", function()
            InitializeSlider(RegrowthSlider, MBH_REGROWTHPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_Threshold)
        end)

        local RegrowthLAR = CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK)
        RegrowthLAR:SetPoint("CENTER", RegrowthSlider, "CENTER", 50, -50)
        RegrowthLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_LAR)

        local RegrowthHAR = CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK)
        RegrowthHAR:SetPoint("CENTER", RegrowthLAR, "CENTER", 0, -50)
        RegrowthHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_HAR)

        local RegrowthEnable = CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH)
        RegrowthEnable:SetPoint("CENTER", RegrowthHAR, "CENTER", 0, -50)
        RegrowthEnable:SetChecked(MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_Switch and 1 or 0)
        RegrowthEnable:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_Switch = (RegrowthEnable:GetChecked() == 1)
        end)

        -- Regrowth Events 
        local function RegrowthLAR_OnEnterPressed()
            MBH_ValidateLAR(RegrowthHAR, "Regrowth")
            RegrowthLAR:ClearFocus()
        end

        local function RegrowthLAR_OnExitFrame()
            RegrowthLAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_LAR)
            RegrowthLAR:ClearFocus()
        end

        local function RegrowthLAR_OnTabPressed()
            RegrowthHAR:SetFocus()
        end

        RegrowthLAR:SetScript("OnEnterPressed", RegrowthLAR_OnEnterPressed)
        RegrowthLAR:SetScript("OnEscapePressed", RegrowthLAR_OnExitFrame)
        RegrowthLAR:SetScript("OnTabPressed", RegrowthLAR_OnTabPressed)

        local function RegrowthHAR_OnEnterPressed()
            MBH_ValidateHAR(RegrowthLAR, MBH_GetMaxSpellRank("Healing Touch"), "Regrowth")
            RegrowthHAR:ClearFocus()
        end

        local function RegrowthHAR_OnExitFrame()
            RegrowthHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_HAR)
            RegrowthHAR:ClearFocus()
        end

        local function RegrowthHAR_OnTabPressed()
            RegrowthHAR:ClearFocus()
        end

        RegrowthHAR:SetScript("OnEnterPressed", RegrowthHAR_OnEnterPressed)
        RegrowthHAR:SetScript("OnEscapePressed", RegrowthHAR_OnExitFrame)
        RegrowthHAR:SetScript("OnTabPressed", RegrowthHAR_OnTabPressed)
    end
    
    self:Hide()
end

-------------------------------------------------------------------------------
-- PopupPreset Frame {{{
-------------------------------------------------------------------------------

function MBH.PopupPresetFrame:CreatePopupPresetFrame()

    CreatePopupFrame(self)

    local PopupPresetText = self:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    PopupPresetText:SetText(MBH_PRESETSETTINGSCONFIRM)
    PopupPresetText:SetPoint("CENTER", self, "TOP", 0, -25)

    local function YesButton_OnClick()
        MBH_LoadPresetSettings()
        self:Hide()
    end

    self.AcceptButton:SetScript("OnClick", YesButton_OnClick)
    self:Hide()
end

-------------------------------------------------------------------------------
-- PopupDefault Frame {{{
-------------------------------------------------------------------------------

function MBH.PopupDefaultFrame:CreatePopupDefaultFrame()

    CreatePopupFrame(self)

    local PopupPresetText = self:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    PopupPresetText:SetText(MBH_RESTOREDEFAULTCONFIRM)
    PopupPresetText:SetPoint("CENTER", self, "TOP", 0, -25)

    local function YesButton_OnClick()
        MBH_SetDefaultValues()
        self:Hide()
    end

    self.AcceptButton:SetScript("OnClick", YesButton_OnClick)
    self:Hide()
end

-------------------------------------------------------------------------------
-- Helper Functions {{{
-------------------------------------------------------------------------------

function SetBackdropColor(Frame, Color)
    if not Frame then return end
    Frame:SetBackdropColor(GetColorValue(Color))
    Frame:SetBackdropBorderColor(GetColorValue(Color))
end

function SetFontSize(fontString, size)
    local font, _, flags = fontString:GetFont()
    fontString:SetFont(font, size, flags)
end

function CreateButton(Parent, Text, Width, Height)
    
    Width = Width or 60
    Height = Height or 25

    local Button = CreateFrame("Button", nil, Parent)
    Button:SetWidth(Width)
	Button:SetHeight(Height)
    Button:SetFrameLevel(8)
    Button:SetBackdrop(BackDrop)
    SetBackdropColor(Button, "Gray600")

    local Overlay = Button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    Overlay:SetText(Text)
    Overlay:SetPoint("CENTER", Button, "CENTER")
    Button.Overlay = Overlay

    local function OnEnter()
        SetBackdropColor(this, "Gray400")
    end

    local function OnLeave()
        SetBackdropColor(this, "Gray600")
    end

    local function OnShow()
        SetBackdropColor(this, "Gray600")
    end

    Button:SetScript("OnEnter", OnEnter)
    Button:SetScript("OnLeave", OnLeave)
    Button:SetScript("OnShow", OnShow)
    return Button
end

function CreateInnerContainer(Parent)

    local InnerContainer = CreateFrame("Frame", nil, Parent)
    InnerContainer:SetWidth(730)
	InnerContainer:SetHeight(415)
    InnerContainer:SetPoint("TOPLEFT", Parent, "TOPLEFT", 35, -75)
    InnerContainer:SetBackdrop(BackDrop)
    SetBackdropColor(InnerContainer, "Gray600")
    return InnerContainer
end

function CreateSmallInnerContainer(Parent, Text)

    local SmallInnerContainer = CreateFrame("Frame", nil, Parent)
    SmallInnerContainer:SetWidth(350)
	SmallInnerContainer:SetHeight(200)
    SmallInnerContainer:SetBackdrop(BackDrop)
    SetBackdropColor(SmallInnerContainer, "Gray600")

    local SmallInnerContainerTitle = SmallInnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    SmallInnerContainerTitle:SetText(Text)
    SmallInnerContainerTitle:SetPoint("TOPRIGHT", SmallInnerContainer, "TOPRIGHT", -5, 13)
    SmallInnerContainer.Text = SmallInnerContainerTitle
    return SmallInnerContainer
end

function DefaultFrameTemplate(Frame)
    local IsMoving = false

    Frame:SetFrameStrata("LOW")
    Frame:SetWidth(800)
    Frame:SetHeight(550)
    Frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    Frame:SetBackdrop(BackDrop)
    SetBackdropColor(Frame, "Gray800")
    Frame:SetMovable(true)
    Frame:EnableMouse(true)
    
    local Title = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    Title:SetText(MBH_TITLE)
    Title:SetPoint("CENTER", Frame, "TOP", 0, -30)

    local Author = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    Author:SetText(MBH_AUTHOR)
    Author:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMRIGHT", -10, 15)

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

    local function Frame_OnHide()
        if IsMoving then
            Frame:StopMovingOrSizing()
            IsMoving = false
        end
    end

    Frame:SetScript("OnMouseUp", Frame_OnMouseUp)
    Frame:SetScript("OnMouseDown", Frame_OnMouseDown)
    Frame:SetScript("OnHide", Frame_OnHide)
end

function DefaultFrameButtons(Frame)

    Frame.GeneralButton = CreateButton(Frame, MBH_GENERAL) 
    Frame.GeneralButton:SetPoint("TOPLEFT", Frame, "TOPLEFT", 10, -15)

    local function GeneralButton_OnShow()
        if (Frame == MBH.MainFrame) then
            SetBackdropColor(Frame.GeneralButton, "Blue600")
        else
            SetBackdropColor(Frame.GeneralButton, "Gray600")
        end
    end

    local function GeneralButton_OnEnter()
        if (Frame == MBH.MainFrame) then
            SetBackdropColor(Frame.GeneralButton, "Blue500")
        else
            SetBackdropColor(Frame.GeneralButton, "Gray400")
        end
    end

    local function GeneralButton_OnClick()
        if (not MBH.MainFrame:IsShown()) then
            MBH_ResetAllWindow()
            MBH.MainFrame:Show()
        end

        if Frame == MBH.MainFrame then
            return
        end
    
        Frame:Hide()
    end

    local function GeneralButton_OnLeave()
        GeneralButton_OnShow()
    end

    GeneralButton_OnShow()
    Frame.GeneralButton:SetScript("OnEnter", GeneralButton_OnEnter)
    Frame.GeneralButton:SetScript("OnClick", GeneralButton_OnClick)
    Frame.GeneralButton:SetScript("OnLeave", GeneralButton_OnLeave)

    Frame.OptionButton = CreateButton(Frame, MBH_OPTIONS) 
    Frame.OptionButton:SetPoint("TOPLEFT", Frame.GeneralButton, "TOPRIGHT", 5, 0)

    local function OptionButton_OnShow()
        if (Frame == MBH.OptionFrame) then
            SetBackdropColor(Frame.OptionButton, "Blue600")
        else
            SetBackdropColor(Frame.OptionButton, "Gray600")
        end
    end
    
    local function OptionButton_OnEnter()
        if (Frame == MBH.OptionFrame) then
            SetBackdropColor(Frame.OptionButton, "Blue500")
        else
            SetBackdropColor(Frame.OptionButton, "Gray400")
        end
    end
    
    local function OptionButton_OnClick()
        if (not MBH.OptionFrame:IsShown()) then
            MBH_ResetAllWindow()
            MBH.OptionFrame:Show()
        end

        if Frame == MBH.OptionFrame then
            return
        end
    
        Frame:Hide()
    end
    
    local function OptionButton_OnLeave()
        OptionButton_OnShow()
    end
    
    OptionButton_OnShow()
    Frame.OptionButton:SetScript("OnEnter", OptionButton_OnEnter)
    Frame.OptionButton:SetScript("OnClick", OptionButton_OnClick)
    Frame.OptionButton:SetScript("OnLeave", OptionButton_OnLeave)

    Frame.ProtectionButton = CreateButton(Frame, MBH_PROTECTION, 80) 
    Frame.ProtectionButton:SetPoint("TOPLEFT", Frame.OptionButton, "TOPRIGHT", 5, 0)

    local function ProtectionButton_OnShow()
        if (Frame == MBH.ProtectionFrame) then
            SetBackdropColor(Frame.ProtectionButton, "Blue600")
        else
            SetBackdropColor(Frame.ProtectionButton, "Gray600")
        end
    end
    
    local function ProtectionButton_OnEnter()
        if (Frame == MBH.ProtectionFrame) then
            SetBackdropColor(Frame.ProtectionButton, "Blue500")
        else
            SetBackdropColor(Frame.ProtectionButton, "Gray400")
        end
    end
    
    local function ProtectionButton_OnClick()
        if (not MBH.ProtectionFrame:IsShown()) then
            MBH_ResetAllWindow()
            MBH.ProtectionFrame:Show()
        end

        if Frame == MBH.ProtectionFrame then
            return
        end
    
        Frame:Hide()
    end
    
    local function ProtectionButton_OnLeave()
        ProtectionButton_OnShow()
    end
    
    ProtectionButton_OnShow()
    Frame.ProtectionButton:SetScript("OnEnter", ProtectionButton_OnEnter)
    Frame.ProtectionButton:SetScript("OnClick", ProtectionButton_OnClick)
    Frame.ProtectionButton:SetScript("OnLeave", ProtectionButton_OnLeave)

    Frame.CloseButton = CreateButton(Frame, MBH_HIDE) 
    Frame.CloseButton:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -10, -15)
    
    local function CloseButton_OnEnter()
        SetBackdropColor(Frame.CloseButton, "Red500")
        Frame.CloseButton.Overlay:SetText(MBH_EXIT)
    end

    local function CloseButton_OnLeave()
        SetBackdropColor(Frame.CloseButton, "Gray600")
        Frame.CloseButton.Overlay:SetText(MBH_HIDE)
    end

    local function CloseButton_OnClick()
        Frame:Hide()
    end

    Frame.CloseButton:SetScript("OnEnter", CloseButton_OnEnter)
    Frame.CloseButton:SetScript("OnLeave", CloseButton_OnLeave)
    Frame.CloseButton:SetScript("OnClick", CloseButton_OnClick)

    Frame.DefaultSettingsButton = CreateButton(Frame, MBH_RESTOREDEFAULT, 120) 
    Frame.DefaultSettingsButton:SetPoint("BOTTOMLEFT", Frame, "BOTTOMLEFT", 10, 15)

    local function DefaultSettingsButton_OnEnter()
        SetBackdropColor(Frame.DefaultSettingsButton, "Blue600")
    end

    local function DefaultSettingsButton_OnLeave()
        SetBackdropColor(Frame.DefaultSettingsButton, "Gray600")
    end

    local function DefaultSettingsButton_OnClick()
        if (MBH.PopupPresetFrame:IsShown()) then
            MBH.PopupPresetFrame:Hide()
        end
        MBH.PopupDefaultFrame :Show()
    end

    Frame.DefaultSettingsButton:SetScript("OnEnter", DefaultSettingsButton_OnEnter)
    Frame.DefaultSettingsButton:SetScript("OnLeave", DefaultSettingsButton_OnLeave)
    Frame.DefaultSettingsButton:SetScript("OnClick", DefaultSettingsButton_OnClick)

    Frame.PresetSettingsButton = CreateButton(Frame, MBH_PRESETSETTINGS, 100) 
    Frame.PresetSettingsButton:SetPoint("TOPLEFT", Frame.DefaultSettingsButton, "TOPRIGHT", 5, 0)

    local function PresetSettingsButton_OnEnter()
        SetBackdropColor(Frame.PresetSettingsButton, "Blue600")
    end

    local function PresetSettingsButton_OnLeave()
        SetBackdropColor(Frame.PresetSettingsButton, "Gray600")
    end

    local function PresetSettingsButton_OnClick()
        if (MBH.PopupDefaultFrame :IsShown()) then
            MBH.PopupDefaultFrame :Hide()
        end
        MBH.PopupPresetFrame:Show()
    end

    Frame.PresetSettingsButton:SetScript("OnEnter", PresetSettingsButton_OnEnter)
    Frame.PresetSettingsButton:SetScript("OnLeave", PresetSettingsButton_OnLeave)
    Frame.PresetSettingsButton:SetScript("OnClick", PresetSettingsButton_OnClick)
end

function CreateSlider(Parent, Name, Width, Height)
    
    Width = Width or 220
    Height = Height or 16

    local Slider = CreateFrame("Slider", Name, Parent, 'OptionsSliderTemplate')
    Slider:SetWidth(Width)
	Slider:SetHeight(Height)
    Slider:SetBackdrop(SliderBackDrop)
    return Slider
end

function InitializeSlider(Slider, String, Value, MinStep, MaxStep, ValStep)
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

function CreateEditBox(Parent, Text, Width, Height)

    Width = Width or 50
    Height = Height or 20

    local EditBox = CreateFrame("EditBox", nil, Parent)
    EditBox:SetWidth(Width)
    EditBox:SetHeight(Height)
    EditBox:SetAutoFocus(false)
    EditBox:SetMaxLetters(256)
    EditBox:SetFontObject(GameFontHighlight)

    local LeftCurve = EditBox:CreateTexture(nil, "BACKGROUND")
    LeftCurve:SetTexture("Interface/ClassTrainerFrame/UI-ClassTrainer-FilterBorder")
    LeftCurve:SetWidth(12)
    LeftCurve:SetHeight(29)
    LeftCurve:SetPoint("TOPLEFT", -11, 2)
    LeftCurve:SetTexCoord(0, 0.09375, 0, 1.0)

    local RightCurve = EditBox:CreateTexture(nil, "BACKGROUND")
    RightCurve:SetTexture("Interface/ClassTrainerFrame/UI-ClassTrainer-FilterBorder")
    RightCurve:SetWidth(12)
    RightCurve:SetHeight(29)
    RightCurve:SetPoint("TOPRIGHT", 4, 2)
    RightCurve:SetTexCoord(0.90625, 1.0, 0, 1.0)

    local MiddleTexture = EditBox:CreateTexture(nil, "BACKGROUND")
    MiddleTexture:SetTexture("Interface/ClassTrainerFrame/UI-ClassTrainer-FilterBorder")
    MiddleTexture:SetPoint("TOPLEFT", LeftCurve, "TOPRIGHT")
    MiddleTexture:SetPoint("BOTTOMRIGHT", RightCurve, "BOTTOMLEFT")
    MiddleTexture:SetTexCoord(0.09375, 0.90625, 0, 1.0)

    local EditBoxText = EditBox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    EditBoxText:SetText(Text)
    EditBoxText:SetPoint("RIGHT", EditBox, "LEFT", -40, 0)
    EditBox.Text = EditBoxText

    local function EditBox_OnEscapePressed()
        EditBox:ClearFocus()
    end

    EditBox:SetScript("OnEscapePressed", EditBox_OnEscapePressed)
    return EditBox
end

function CreateCheckButton(Parent, Text, XAsis)

    XAsis = XAsis or -48.5

    local CheckButton = CreateFrame("CheckButton", nil, Parent, "OptionsCheckButtonTemplate")
    local CheckButtonText = CheckButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    CheckButtonText:SetText(Text)
    CheckButtonText:SetPoint("RIGHT", CheckButton, "LEFT", XAsis, 0)
    CheckButton.Text = CheckButtonText
    return CheckButton
end

function CreatePopupFrame(PopupFrame)
    local IsMoving = false

    PopupFrame:SetFrameStrata("HIGH")
    PopupFrame:SetWidth(300)
    PopupFrame:SetHeight(110)
    PopupFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    PopupFrame:SetBackdrop(BackDrop)
    SetBackdropColor(PopupFrame, "Gray800")
    PopupFrame:SetMovable(true)
    PopupFrame:EnableMouse(true)

    local PopupFrameText = PopupFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    PopupFrameText:SetText(MBH_RELOADUI)
    PopupFrameText:SetPoint("CENTER", PopupFrame, "CENTER", 0, 0)
    PopupFrame.Text = PopupFrameText

    local AcceptButton = CreateButton(PopupFrame, MBH_YES, 100) 
    AcceptButton:SetPoint("BOTTOMLEFT", PopupFrame, "BOTTOMLEFT", 5, 7.5)
    SetBackdropColor(AcceptButtonn, "Gray600")
    PopupFrame.AcceptButton = AcceptButton

    local function AcceptButton_OnEnter()
        SetBackdropColor(AcceptButton, "Green600")
    end

    local function AcceptButton_OnLeave()
        SetBackdropColor(AcceptButton, "Gray600")
    end

    AcceptButton:SetScript("OnEnter", AcceptButton_OnEnter)
    AcceptButton:SetScript("OnLeave", AcceptButton_OnLeave)

    local DeclineButton = CreateButton(PopupFrame, MBH_NO, 100) 
    DeclineButton:SetPoint("BOTTOMRIGHT", PopupFrame, "BOTTOMRIGHT", -5, 7.5)
    SetBackdropColor(DeclineButton, "Gray600")
    PopupFrame.DeclineButton = DeclineButton

    local function DeclineButton_OnEnter()
        SetBackdropColor(DeclineButton, "Red500")
    end

    local function DeclineButton_OnLeave()
        SetBackdropColor(DeclineButton, "Gray600")
    end

    local function DeclineButton_OnClick()
        PopupFrame:Hide()
    end

    DeclineButton:SetScript("OnEnter", DeclineButton_OnEnter)
    DeclineButton:SetScript("OnLeave", DeclineButton_OnLeave)
    DeclineButton:SetScript("OnClick", DeclineButton_OnClick)

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

    local function PopupFrame_OnHide()
        if IsMoving then
            PopupFrame:StopMovingOrSizing()
            IsMoving = false
        end
    end

    PopupFrame:SetScript("OnMouseUp", PopupFrame_OnMouseUp)
    PopupFrame:SetScript("OnMouseDown", PopupFrame_OnMouseDown)
    PopupFrame:SetScript("OnHide", PopupFrame_OnHide)
end