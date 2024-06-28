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

function OpenMainFrame()
    if MBH.MainFrame:IsShown() then
        MBH.MainFrame:Hide()
    else 
        MBH_ResetAllWindow()
        MBH.MainFrame:Show()
    end
end

-------------------------------------------------------------------------------
-- MiniMap Button {{{
-------------------------------------------------------------------------------

function SetSize(Frame, Width, Height)
    Frame:SetWidth(Width)
	Frame:SetHeight(Height)
    Frame:SetPoint("CENTER", 0, 0)
end

function ShowToolTip(Parent, Title, Text)
    GameTooltip:SetOwner(Parent, "ANCHOR_BOTTOMLEFT")
    GameTooltip:SetText(Title, 1, 1, 0.5)
    GameTooltip:AddLine(Text)
    GameTooltip:Show()
end

function HideTooltip()
    GameTooltip:Hide()
end

function RegisterAllClicksAndDrags(Frame)
    Frame:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
    Frame:RegisterForDrag("LeftButton", "RightButton")
end

function ClearFrameFocus(Frame, Text)
    Frame:ClearFocus()
    if Text then Frame:SetText(Text) end
end


function MBH.MiniMapButton:CreateMinimapIcon()
    local IsMiniMapMoving = false

    self:SetFrameStrata("LOW")
    SetSize(self, 32, 32)
	self:SetPoint("TOPLEFT", 0, 0)
	
	self.Button = CreateFrame("Button", nil, self)
    SetSize(self.Button, 32, 32)
	self.Button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
    RegisterAllClicksAndDrags(self.Button)

	self.Overlay = self:CreateTexture(nil, "OVERLAY", self)
    SetSize(self.Overlay, 52, 52)
    self.Overlay:SetPoint("TOPLEFT", 0, 0)
	self.Overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
	
	self.MinimapIcon = self:CreateTexture(nil, "BACKGROUND")
    SetSize(self.MinimapIcon, 18, 18)
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
        OpenMainFrame()
    end

    self.Button:SetScript("OnDragStart", OnDragStart)
    self.Button:SetScript("OnDragStop", OnDragStop)
    self.Button:SetScript("OnClick", OnClick)
    self.Button:SetScript("OnLeave", HideTooltip)
    self.Button:SetScript("OnEnter", function()
        ShowToolTip(self, MBH_TITLE, MBH_MINIMAPHOVER)
    end)   
end

-------------------------------------------------------------------------------
-- Main Frame {{{
-------------------------------------------------------------------------------

function MBH.MainFrame:CreateMainFrame()

    DefaultFrameTemplate(self)
    DefaultFrameButtons(self)
    
    self.InnerContainer = CreateInnerContainer(self)

    self.WelcomeText = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    self.WelcomeText:SetText(MBH_WELCOME)
    self.WelcomeText:SetPoint("CENTER", self.InnerContainer, "TOP", 0, -30)

    self.InformationText = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    self.InformationText:SetText(MBH_INFORMATION)
    SetSize(self.InformationText, 480, 350)
    SetFontSize(self.InformationText, 13)

    self:Hide()
end

-------------------------------------------------------------------------------
-- Option Frame {{{
-------------------------------------------------------------------------------

function MBH.OptionFrame:CreateOptionFrame()

    DefaultFrameTemplate(self)
    DefaultFrameButtons(self)

    -- Healing Settings
    self.HealingContainer = CreateSmallInnerContainer(self, MBH_HEALSETTINGS)
    self.HealingContainer:SetPoint("TOPLEFT", self, "TOPLEFT", 35, -75)

        self.RandomTargetCheckButton = CreateCheckButton(self.HealingContainer, MBH_RANDOMTARGET, MoronBoxHeal_Options.AutoHeal.Random_Target, -15)
        self.RandomTargetCheckButton:SetPoint("CENTER", self.HealingContainer, "TOP", 0, -35)
        self.RandomTargetCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.AutoHeal.Random_Target = (self.RandomTargetCheckButton:GetChecked() == 1)
        end)

        self.HealTargetSlider = CreateSlider(self.HealingContainer, "HealTargetSlider", 220)
        self.HealTargetSlider:SetPoint("CENTER", self.RandomTargetCheckButton, "CENTER", 0, -50)
        self.HealTargetSlider:SetScript("OnValueChanged", HealTargetSlider_OnValueChanged)
        self.HealTargetSlider:SetScript("OnShow", function()
            InitializeSlider(self.HealTargetSlider, MBH_HEALTARGETNUMBER, MoronBoxHeal_Options.AutoHeal.Heal_Target_Number, 1, 5, 1)
        end)

        self.OverHealHealSlider = CreateSlider(self.HealingContainer, "OverHealHealSlider", 220)
        self.OverHealHealSlider:SetPoint("CENTER", self.HealTargetSlider, "CENTER", 0, -50)
        self.OverHealHealSlider:SetScript("OnValueChanged", OverHealHealSlider_OnValueChanged)
        self.OverHealHealSlider:SetScript("OnShow", function()
            InitializeSlider(self.OverHealHealSlider, MBH_ALLOWEDOVERHEAL, MoronBoxHeal_Options.AutoHeal.Allowed_Overheal_Percentage)
        end)

        self.SmartHealCheckButton = CreateCheckButton(self.HealingContainer, MBH_SMARTHEAL, MoronBoxHeal_Options.AutoHeal.Smart_Heal, -15)
        self.SmartHealCheckButton:SetPoint("CENTER", self.OverHealHealSlider, "CENTER", 0, -35)
        self.SmartHealCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.AutoHeal.Smart_Heal = (self.SmartHealCheckButton:GetChecked() == 1)
        end)

    -- Extended Range
    self.ExtendedRangeContainer = CreateSmallInnerContainer(self, MBH_RANGSETTINGS)
    self.ExtendedRangeContainer:SetPoint("TOPRIGHT", self, "TOPRIGHT", -35, -75)

        self.ExtendedRangeCheckButton = CreateCheckButton(self.ExtendedRangeContainer, MBH_EXTENDEDRANGE, MoronBoxHeal_Options.ExtendedRange.Enable, -15)
        self.ExtendedRangeCheckButton:SetPoint("CENTER", self.ExtendedRangeContainer, "CENTER", 0, 35)
        self.ExtendedRangeCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.ExtendedRange.Enable = (self.ExtendedRangeCheckButton:GetChecked() == 1)
        end)

        self.ExtendedRangeFrequencySlider = CreateSlider(self.ExtendedRangeContainer, "ExtendedRangeFrequencySlider", 220)
        self.ExtendedRangeFrequencySlider:SetPoint("CENTER", self.ExtendedRangeContainer, "CENTER", 0, -50)
        self.ExtendedRangeFrequencySlider:SetScript("OnValueChanged", ExtendedRangeFrequencySlider_OnValueChanged)
        self.ExtendedRangeFrequencySlider:SetScript("OnShow", function()
            InitializeSlider(self.ExtendedRangeFrequencySlider, MBH_EXTENDEDRANGEFREQUENCY, MoronBoxHeal_Options.ExtendedRange.Frequency, 1, 5, 0.25)
        end)

    -- Light Of Sight
    self.LineOfSightContainer = CreateSmallInnerContainer(self, MBH_LOSETTINGS)
    self.LineOfSightContainer:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 35, 60)

        self.LineOfSightCheckButton = CreateCheckButton(self.LineOfSightContainer, MBH_LINEOFSIGHT, MoronBoxHeal_Options.LineOfSight.Enable, -15)
        self.LineOfSightCheckButton:SetPoint("CENTER", self.LineOfSightContainer, "CENTER", 0, 35)
        self.LineOfSightCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.LineOfSight.Enable = (self.LineOfSightCheckButton:GetChecked() == 1)
        end)

        self.LineOfSightFrequencySlider = CreateSlider(self.LineOfSightContainer, "LineOfSightFrequencySlider", 220)
        self.LineOfSightFrequencySlider:SetPoint("CENTER", self.LineOfSightContainer, "CENTER", 0, -50)
        self.LineOfSightFrequencySlider:SetScript("OnValueChanged", LineOfSightFrequencySlider_OnValueChanged)
        self.LineOfSightFrequencySlider:SetScript("OnShow", function()
            InitializeSlider(self.LineOfSightFrequencySlider, MBH_LINEOFSIGHTFREQUENCY, MoronBoxHeal_Options.LineOfSight.TimeOut, 0.5, 5, 0.25)
        end)

    -- Advanced Settings
    self.AdvancedOptionsContainer = CreateSmallInnerContainer(self, MBH_SPECIALSETTINGS)
    self.AdvancedOptionsContainer:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -35, 60)

        self.ManaProtectionCheckButton = CreateCheckButton(self.AdvancedOptionsContainer, MBH_MANAPROTECTION, MoronBoxHeal_Options.AdvancedOptions.Mana_Protection, -15)
        self.ManaProtectionCheckButton:SetPoint("CENTER", self.AdvancedOptionsContainer, "CENTER", 0, 50)
        self.ManaProtectionCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.AdvancedOptions.Mana_Protection = (self.ManaProtectionCheckButton:GetChecked() == 1)
        end)

        self.IdleProtectionCheckButton = CreateCheckButton(self.AdvancedOptionsContainer, MBH_IDLEPROTECTIONENABLE, MoronBoxHeal_Options.AdvancedOptions.LagPrevention.Enabled, -15)
        self.IdleProtectionCheckButton:SetPoint("CENTER", self.ManaProtectionCheckButton, "CENTER", 0, -40)
        self.IdleProtectionCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.AdvancedOptions.LagPrevention.Enabled = (self.IdleProtectionCheckButton:GetChecked() == 1)
        end)

        self.IdleProtectionFrequencySlider = CreateSlider(self.AdvancedOptionsContainer, "IdleProtectionFrequencySlider", 220)
        self.IdleProtectionFrequencySlider:SetPoint("CENTER", self.AdvancedOptionsContainer, "CENTER", 0, -50)
        self.IdleProtectionFrequencySlider:SetScript("OnValueChanged", IdleProtectionFrequencySlider_OnValueChanged)
        self.IdleProtectionFrequencySlider:SetScript("OnShow", function()
            InitializeSlider(self.IdleProtectionFrequencySlider, MBH_IDLEPROTECTIONFREQUENCY, MoronBoxHeal_Options.AdvancedOptions.LagPrevention.Frequency, 1, 5, 0.25)
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
        self.FlashHealTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        self.FlashHealTitle:SetText(MBH_SPELL_FLASH_HEAL)
        self.FlashHealTitle:SetPoint("TOPLEFT", self.InnerContainer, "TOPLEFT", 85, -25)

        self.FlashHealThresholdSlider = CreateSlider(self.InnerContainer, "FlashHealThresholdSlider", 180)
        self.FlashHealThresholdSlider:SetPoint("CENTER", self.FlashHealTitle, "CENTER", 0, -50)
        self.FlashHealThresholdSlider:SetScript("OnValueChanged", FlashHealThresholdSlider__OnValueChanged)
        self.FlashHealThresholdSlider:SetScript("OnShow", function()
            InitializeSlider(self.FlashHealThresholdSlider, MBH_FLASHHEALPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Threshold)
        end)

        self.FlashHealLAR = CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_LAR)
        self.FlashHealLAR:SetPoint("CENTER", self.FlashHealThresholdSlider, "CENTER", 50, -50)

        self.FlashHealHAR = CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_HAR)
        self.FlashHealHAR:SetPoint("CENTER", self.FlashHealLAR, "CENTER", 0, -50)
   
        self.FlashHealCheckButton = CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH, MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Switch)
        self.FlashHealCheckButton:SetPoint("CENTER", self.FlashHealHAR, "CENTER", 0, -50)
        self.FlashHealCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_Switch = (self.FlashHealCheckButton:GetChecked() == 1)
        end)

        -- Heal Section
        self.HealTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        self.HealTitle:SetText(MBH_SPELL_HEAL)
        self.HealTitle:SetPoint("CENTER", self.InnerContainer, "TOP", 0, -35)

        self.HealThresholdSlider = CreateSlider(self.InnerContainer, "HealThresholdSlider", 180)
        self.HealThresholdSlider:SetPoint("CENTER", self.HealTitle, "CENTER", 0, -50)
        self.HealThresholdSlider:SetScript("OnValueChanged", HealThresholdSlider_OnValueChanged)
        self.HealThresholdSlider:SetScript("OnShow", function()
            InitializeSlider(self.HealThresholdSlider, MBH_HEALPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Threshold)
        end)

        self.HealLAR = CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_LAR)
        self.HealLAR:SetPoint("CENTER", self.HealThresholdSlider, "CENTER", 50, -50)

        self.HealHAR = CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_HAR)
        self.HealHAR:SetPoint("CENTER", self.HealLAR, "CENTER", 0, -50)

        self.HealCheckButton = CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH, MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Switch)
        self.HealCheckButton:SetPoint("CENTER", self.HealHAR, "CENTER", 0, -50)
        self.HealCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_Switch = (self.HealCheckButton:GetChecked() == 1)
        end)

        -- Greater Heal
        self.GreaterHealTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        self.GreaterHealTitle:SetText(MBH_SPELL_GREATER_HEAL)
        self.GreaterHealTitle:SetPoint("TOPRIGHT", self.InnerContainer, "TOPRIGHT", -85, -25)

        self.GreaterHealThresholdSlider = CreateSlider(self.InnerContainer, "GreaterHealThresholdSlider", 180)
        self.GreaterHealThresholdSlider:SetPoint("CENTER", self.GreaterHealTitle, "CENTER", 0, -50)
        self.GreaterHealThresholdSlider:SetScript("OnValueChanged", GreaterHealThresholdSlider_OnValueChanged)
        self.GreaterHealThresholdSlider:SetScript("OnShow", function()
            InitializeSlider(self.GreaterHealThresholdSlider, MBH_GREATERHEALPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Threshold)
        end)

        self.GreaterHealLAR = CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_LAR)
        self.GreaterHealLAR:SetPoint("CENTER", self.GreaterHealThresholdSlider, "CENTER", 50, -50)

        self.GreaterHealHAR = CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_HAR)
        self.GreaterHealHAR:SetPoint("CENTER", self.GreaterHealLAR, "CENTER", 0, -50)
        
        self.GreaterHealCheckButton = CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH, MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Switch)
        self.GreaterHealCheckButton:SetPoint("CENTER", self.GreaterHealHAR, "CENTER", 0, -50)
        self.GreaterHealCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_Switch = (self.GreaterHealCheckButton:GetChecked() == 1)
        end)

        -- Flash Heal Events 
        local function FlashHealLAR_OnEnterPressed()
            ClearFrameFocus(self.FlashHealLAR)
            MBH_ValidateLAR(self.FlashHealHAR, "Flash_Heal")
        end

        local function FlashHealLAR_OnExitFrame()
            ClearFrameFocus(self.FlashHealLAR, MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_LAR)
        end

        local function FlashHealLAR_OnTabPressed()
            self.FlashHealHAR:SetFocus()
        end

        self.FlashHealLAR:SetScript("OnEnterPressed", FlashHealLAR_OnEnterPressed)
        self.FlashHealLAR:SetScript("OnEscapePressed", FlashHealLAR_OnExitFrame)
        self.FlashHealLAR:SetScript("OnTabPressed", FlashHealLAR_OnTabPressed)

        local function FlashHealHAR_OnEnterPressed()
            ClearFrameFocus(self.FlashHealHAR)
            MBH_ValidateHAR(self.FlashHealLAR, MBH_GetMaxSpellRank("Heal"), "Flash_Heal")
        end

        local function FlashHealHAR_OnExitFrame()
            ClearFrameFocus(self.FlashHealHAR, MoronBoxHeal_Options.ManaProtectionValues.Priest.Flash_Heal_HAR)
        end

        local function FlashHealHAR_OnTabPressed()
            self.HealLAR:SetFocus()
        end

        self.FlashHealHAR:SetScript("OnEnterPressed", FlashHealHAR_OnEnterPressed)
        self.FlashHealHAR:SetScript("OnEscapePressed", FlashHealHAR_OnExitFrame)
        self.FlashHealHAR:SetScript("OnTabPressed", FlashHealHAR_OnTabPressed)

        -- Heal Events
        local function HealLAR_OnEnterPressed()
            ClearFrameFocus(self.HealLAR)
            MBH_ValidateLAR(self.HealHAR, "Heal")
        end
        
        local function HealLAR_OnExitFrame()
            ClearFrameFocus(self.HealLAR, MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_LAR)
        end
        
        local function HealLAR_OnTabPressed()
            self.HealHAR:SetFocus()
        end
        
        self.HealLAR:SetScript("OnEnterPressed", HealLAR_OnEnterPressed)
        self.HealLAR:SetScript("OnEscapePressed", HealLAR_OnExitFrame)
        self.HealLAR:SetScript("OnTabPressed", HealLAR_OnTabPressed)
        
        local function HealHAR_OnEnterPressed()
            ClearFrameFocus(self.HealHAR)
            MBH_ValidateHAR(self.HealLAR, MBH_GetMaxSpellRank("Lesser Heal"), "Heal")
        end
        
        local function HealHAR_OnExitFrame()
            ClearFrameFocus(self.HealHAR, MoronBoxHeal_Options.ManaProtectionValues.Priest.Heal_HAR)
        end
        
        local function HealHAR_OnTabPressed()
            self.GreaterHealLAR:SetFocus()
        end
        
        self.HealHAR:SetScript("OnEnterPressed", HealHAR_OnEnterPressed)
        self.HealHAR:SetScript("OnEscapePressed", HealHAR_OnExitFrame)
        self.HealHAR:SetScript("OnTabPressed", HealHAR_OnTabPressed)

        -- Greater Heal Events
        local function GreaterHealLAR_OnEnterPressed()
            ClearFrameFocus(self.GreaterHealLAR)
            MBH_ValidateLAR(self.GreaterHealHAR, "Greater_Heal")
        end
        
        local function GreaterHealLAR_OnExitFrame()
            ClearFrameFocus(self.GreaterHealLAR, MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_LAR)
        end
        
        local function GreaterHealLAR_OnTabPressed()
            self.GreaterHealHAR:SetFocus()
        end
        
        self.GreaterHealLAR:SetScript("OnEnterPressed", GreaterHealLAR_OnEnterPressed)
        self.GreaterHealLAR:SetScript("OnEscapePressed", GreaterHealLAR_OnExitFrame)
        self.GreaterHealLAR:SetScript("OnTabPressed", GreaterHealLAR_OnTabPressed)
        
        local function GreaterHealHAR_OnEnterPressed()
            ClearFrameFocus(self.GreaterHealHAR)
            MBH_ValidateHAR(self.GreaterHealLAR, MBH_GetMaxSpellRank("Heal"), "Greater_Heal")
        end
        
        local function GreaterHealHAR_OnExitFrame()
            ClearFrameFocus(self.GreaterHealHAR, MoronBoxHeal_Options.ManaProtectionValues.Priest.Greater_Heal_HAR)
        end
        
        local function GreaterHealHAR_OnTabPressed()
            self.GreaterHealHAR:ClearFocus()
        end
        
        self.GreaterHealHAR:SetScript("OnEnterPressed", GreaterHealHAR_OnEnterPressed)
        self.GreaterHealHAR:SetScript("OnEscapePressed", GreaterHealHAR_OnExitFrame)
        self.GreaterHealHAR:SetScript("OnTabPressed", GreaterHealHAR_OnTabPressed)

    elseif ( Session.PlayerClass == "Shaman" ) then
        
        -- Chain Heal Section
        self.ChainHealTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        self.ChainHealTitle:SetText(MBH_SPELL_CHAIN_HEAL)
        self.ChainHealTitle:SetPoint("TOPLEFT", self.InnerContainer, "TOPLEFT", 145, -25)

        self.ChainHealThresholdSlider = CreateSlider(self.InnerContainer, "ChainHealThresholdSlider", 180)
        self.ChainHealThresholdSlider:SetPoint("CENTER", self.ChainHealTitle, "CENTER", 0, -50)
        self.ChainHealThresholdSlider:SetScript("OnValueChanged", ChainHealThresholdSlider_OnValueChanged)
        self.ChainHealThresholdSlider:SetScript("OnShow", function()
            InitializeSlider(self.ChainHealThresholdSlider, MBH_CHAINHEALPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_Threshold)
        end)

        self.ChainHealLAR = CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_LAR)
        self.ChainHealLAR:SetPoint("CENTER", self.ChainHealThresholdSlider, "CENTER", 50, -50)

        self.ChainHealHAR = CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_HAR)
        self.ChainHealHAR:SetPoint("CENTER", self.ChainHealLAR, "CENTER", 0, -50)

        self.ChainHealCheckButton = CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_Switch)
        self.ChainHealCheckButton:SetPoint("CENTER", self.ChainHealHAR, "CENTER", 0, -50)
        self.ChainHealCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Shaman.Chain_Heal_Switch = (self.ChainHealCheckButton:GetChecked() == 1)
        end)

        -- Lesser Healing Wave
        self.LesserHealingWaveTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        self.LesserHealingWaveTitle:SetText(MBH_SPELL_LESSER_HEALING_WAVE)
        self.LesserHealingWaveTitle:SetPoint("TOPRIGHT", self.InnerContainer, "TOPRIGHT", -145, -25)

        self.LesserHealingWaveThresholdSlider = CreateSlider(self.InnerContainer, "LesserHealingWaveThresholdSlider", 180)
        self.LesserHealingWaveThresholdSlider:SetPoint("CENTER", self.LesserHealingWaveTitle, "CENTER", 0, -50)
        self.LesserHealingWaveThresholdSlider:SetScript("OnValueChanged", LesserHealingWaveThresholdSlider_OnValueChanged)
        self.LesserHealingWaveThresholdSlider:SetScript("OnShow", function()
            InitializeSlider(self.LesserHealingWaveThresholdSlider, MBH_LESSERHEALINGWAVEPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_Threshold)
        end)

        self.LesserHealingWaveLAR = CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_LAR)
        self.LesserHealingWaveLAR:SetPoint("CENTER", self.LesserHealingWaveThresholdSlider, "CENTER", 50, -50)

        self.LesserHealingWaveHAR = CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_HAR)
        self.LesserHealingWaveHAR:SetPoint("CENTER", self.LesserHealingWaveLAR, "CENTER", 0, -50)

        self.LesserHealingWaveCheckButton = CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH, MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_Switch)
        self.LesserHealingWaveCheckButton:SetPoint("CENTER", self.LesserHealingWaveHAR, "CENTER", 0, -50)
        self.LesserHealingWaveCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_Switch = (self.LesserHealingWaveCheckButton:GetChecked() == 1)
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
        self.ChainHealLAR:SetScript("OnEscapePressed", ChainHealLAR_OnExitFrame)
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
            self.ChainHealHAR:ClearFocus()
        end
        
        local function ChainHealHAR_OnEnterPressed()
            MBH_ValidateHAR(self.ChainHealLAR, MBH_GetMaxSpellRank("Healing Wave"), "Chain_Heal")
            ChainHealHAR_OnEscapePressed()
        end
        
        self.ChainHealHAR:SetScript("OnEditFocusLost", ChainHealHAR_OnEditFocusLost)
        self.ChainHealHAR:SetScript("OnEscapePressed", ChainHealHAR_OnExitFrame)
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
        self.LesserHealingWaveLAR:SetScript("OnEscapePressed", LesserHealingWaveLAR_OnExitFrame)
        self.LesserHealingWaveLAR:SetScript("OnTabPressed", LesserHealingWaveLAR_OnTabPressed)
        self.LesserHealingWaveLAR:SetScript("OnEnterPressed", LesserHealingWaveLAR_OnEnterPressed)
        
        local function LesserHealingWaveHAR_OnEditFocusLost()
            self.LesserHealingWaveHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Shaman.Lesser_Healing_Wave_HAR)
        end
        
        local function LesserHealingWaveHAR_OnEscapePressed()
            LesserHealingWaveHAR_OnEditFocusLost()
            self.LesserHealingWaveHAR:ClearFocus()
        end
        
        local function LesserHealingWaveHAR_OnTabPressed()
            self.LesserHealingWaveHAR:ClearFocus()
        end
        
        local function LesserHealingWaveHAR_OnEnterPressed()
            MBH_ValidateHAR(self.LesserHealingWaveLAR, MBH_GetMaxSpellRank("Healing Wave"), "Lesser_Healing_Wave")
            LesserHealingWaveHAR_OnEscapePressed()
        end
        
        self.LesserHealingWaveHAR:SetScript("OnEditFocusLost", LesserHealingWaveHAR_OnEditFocusLost)
        self.LesserHealingWaveHAR:SetScript("OnEscapePressed", LesserHealingWaveHAR_OnExitFrame)
        self.LesserHealingWaveHAR:SetScript("OnTabPressed", LesserHealingWaveHAR_OnTabPressed)
        self.LesserHealingWaveHAR:SetScript("OnEnterPressed", LesserHealingWaveHAR_OnEnterPressed)

    elseif ( Session.PlayerClass == "Paladin" ) then
        
        -- Holy Light Section
        self.HolyLightTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        self.HolyLightTitle:SetText(MBH_SPELL_HOLY_LIGHT)
        self.HolyLightTitle:SetPoint("CENTER", self.InnerContainer, "TOP", 0, -35)

        self.HolyLightThresholdSlider = CreateSlider(self.InnerContainer, "HolyLightThresholdSlider", 180)
        self.HolyLightThresholdSlider:SetPoint("CENTER", self.HolyLightTitle, "CENTER", 0, -50)
        self.HolyLightThresholdSlider:SetScript("OnValueChanged", HolyLightThresholdSlider_OnValueChanged)
        self.HolyLightThresholdSlider:SetScript("OnShow", function()
            InitializeSlider(self.HolyLightThresholdSlider, MBH_HOLYLIGHTPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_Threshold)
        end)

        self.HolyLightLAR = CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_LAR)
        self.HolyLightLAR:SetPoint("CENTER", self.HolyLightThresholdSlider, "CENTER", 50, -50)

        self.HolyLightHAR = CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_HAR)
        self.HolyLightHAR:SetPoint("CENTER", self.HolyLightLAR, "CENTER", 0, -50)

        self.HolyLightCheckButton = CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH, MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_Switch)
        self.HolyLightCheckButton:SetPoint("CENTER", self.HolyLightHAR, "CENTER", 0, -50)
        self.HolyLightCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_Switch = (self.HolyLightCheckButton:GetChecked() == 1)
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
        self.HolyLightLAR:SetScript("OnEscapePressed", HolyLightLAR_OnExitFrame)
        self.HolyLightLAR:SetScript("OnTabPressed", HolyLightLAR_OnTabPressed)
        self.HolyLightLAR:SetScript("OnEnterPressed", HolyLightLAR_OnEnterPressed)

        local function HolyLightHAR_OnEditFocusLost()
            self.HolyLightHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Paladin.Holy_Light_HAR)
        end

        local function HolyLightHAR_OnEscapePressed()
            HolyLightHAR_OnEditFocusLost()
            self.HolyLightHAR:ClearFocus()
        end

        local function HolyLightHAR_OnTabPressed()
            self.HolyLightHAR:ClearFocus()
        end

        local function HolyLightHAR_OnEnterPressed()
            MBH_ValidateHAR(self.HolyLightLAR, MBH_GetMaxSpellRank("Flash of Light"), "Holy_Light")
            HolyLightHAR_OnEscapePressed()
        end

        self.HolyLightHAR:SetScript("OnEditFocusLost", HolyLightHAR_OnEditFocusLost)
        self.HolyLightHAR:SetScript("OnEscapePressed", HolyLightHAR_OnExitFrame)
        self.HolyLightHAR:SetScript("OnTabPressed", HolyLightHAR_OnTabPressed)
        self.HolyLightHAR:SetScript("OnEnterPressed", HolyLightHAR_OnEnterPressed)
        
    elseif ( Session.PlayerClass == "Druid" ) then
        
        -- Regrowth Section
        self.RegrowthTitle = self.InnerContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        self.RegrowthTitle:SetText(MBH_SPELL_REGROWTH)
        self.RegrowthTitle:SetPoint("CENTER", self.InnerContainer, "TOP", 0, -35)

        self.RegrowthThresholdSlider = CreateSlider(self.InnerContainer, "RegrowthThresholdSlider", 180)
        self.RegrowthThresholdSlider:SetPoint("CENTER", self.RegrowthTitle, "CENTER", 0, -50)
        self.RegrowthThresholdSlider:SetScript("OnValueChanged", RegrowthThresholdSlider_OnValueChanged)
        self.RegrowthThresholdSlider:SetScript("OnShow", function()
            InitializeSlider(self.RegrowthThresholdSlider, MBH_REGROWTHPROTECTIONTHRESHOLD, MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_Threshold)
        end)

        self.RegrowthLAR = CreateEditBox(self.InnerContainer, MBH_LOWEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_LAR)
        self.RegrowthLAR:SetPoint("CENTER", self.RegrowthThresholdSlider, "CENTER", 50, -50)

        self.RegrowthHAR = CreateEditBox(self.InnerContainer, MBH_HIGHEST_RANK, MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_HAR)
        self.RegrowthHAR:SetPoint("CENTER", self.RegrowthLAR, "CENTER", 0, -50)

        self.RegrowthCheckButton = CreateCheckButton(self.InnerContainer, MNH_ACTIVESWITCH, MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_Switch)
        self.RegrowthCheckButton:SetPoint("CENTER", self.RegrowthHAR, "CENTER", 0, -50)
        self.RegrowthCheckButton:SetScript("OnClick", function()
            MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_Switch = (self.RegrowthCheckButton:GetChecked() == 1)
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
        self.RegrowthLAR:SetScript("OnEscapePressed", RegrowthLAR_OnExitFrame)
        self.RegrowthLAR:SetScript("OnTabPressed", RegrowthLAR_OnTabPressed)
        self.RegrowthLAR:SetScript("OnEnterPressed", RegrowthLAR_OnEnterPressed)

        local function RegrowthHAR_OnEditFocusLost()
            self.RegrowthHAR:SetText(MoronBoxHeal_Options.ManaProtectionValues.Druid.Regrowth_HAR)
        end

        local function RegrowthHAR_OnEscapePressed()
            RegrowthHAR_OnEditFocusLost()
            self.RegrowthHAR:ClearFocus()
        end

        local function RegrowthHAR_OnTabPressed()
            self.RegrowthHAR:ClearFocus()
        end

        local function RegrowthHAR_OnEnterPressed()
            MBH_ValidateHAR(self.RegrowthLAR, MBH_GetMaxSpellRank("Healing Touch"), "Regrowth")
            RegrowthHAR_OnEscapePressed()
        end

        self.RegrowthHAR:SetScript("OnEditFocusLost", RegrowthHAR_OnEditFocusLost)
        self.RegrowthHAR:SetScript("OnEscapePressed", RegrowthHAR_OnExitFrame)
        self.RegrowthHAR:SetScript("OnTabPressed", RegrowthHAR_OnTabPressed)
        self.RegrowthHAR:SetScript("OnEnterPressed", RegrowthHAR_OnEnterPressed)
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

function CreateEditBox(Parent, Name, PlaceHolder, Width, Height)

    Width = Width or 50
    Height = Height or 20

    local EditBox = CreateFrame("EditBox", nil, Parent)
    EditBox:SetWidth(Width)
    EditBox:SetHeight(Height)
    EditBox:SetText(PlaceHolder)
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
    EditBoxText:SetText(Name)
    EditBoxText:SetPoint("RIGHT", EditBox, "LEFT", -40, 0)
    EditBox.Text = EditBoxText

    local function EditBox_OnEscapePressed()
        EditBox:ClearFocus()
    end

    EditBox:SetScript("OnEscapePressed", EditBox_OnEscapePressed)
    return EditBox
end

function CreateCheckButton(Parent, Text, Value, XAsis)

    XAsis = XAsis or -48.5

    local CheckButton = CreateFrame("CheckButton", nil, Parent, "OptionsCheckButtonTemplate")
    CheckButton:SetChecked(Value)
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