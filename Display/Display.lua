-------------------------------------------------------------------------------
-- Frame Names {{{
-------------------------------------------------------------------------------

MBH.MiniMapButton = CreateFrame("Frame", nil , Minimap) -- Minimap Frame
MBH.MainFrame = CreateFrame("Frame", nil , UIParent) -- MainFrame Frame

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
        if MoronBoxHealMainFrame:IsShown() then
            MoronBoxHealMainFrame:Hide()
        else 
            MBH_ResetAllWindow()
            MoronBoxHealMainFrame:Show()
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

MBH.MainFrame = CreateFrame("Frame", nil , UIParent) -- MainFrame Frame
MBH.OptionFrame = CreateFrame("Frame", nil , UIParent) -- MainFrame Frame
MBH.ProtectionFrame = CreateFrame("Frame", nil , UIParent) -- MainFrame Frame

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
end

function MBH.OptionFrame:CreateOptionFrame()

    DefaultFrameTemplate(self)
    DefaultFrameButtons(self)

    self.InnerContainer = CreateInnerContainer(self)

    self:Hide()
end

function MBH.ProtectionFrame:CreateProtectionFrame()

    DefaultFrameTemplate(self)
    DefaultFrameButtons(self)

    self.InnerContainer = CreateInnerContainer(self)

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
    Button:SetBackdropColor(GetColorValue("Gray600"))
    Button:SetBackdropBorderColor(GetColorValue("Gray600"))

    local Overlay = Button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    Overlay:SetText(Text)
    Overlay:SetPoint("CENTER", Button, "CENTER")
    Button.Overlay = Overlay

    local function OnEnter()
        MBH_SetBackdropColors("Gray400")
    end

    local function OnLeave()
        MBH_SetBackdropColors("Gray600")
    end

    local function OnShow()
        MBH_SetBackdropColors("Gray600")
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
        if (MoronBoxHealMainPopupPresetFrame:IsShown()) then
            MoronBoxHealMainPopupPresetFrame:Hide()
        end
        MoronBoxHealMainPopupDefaultFrame:Show()
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
        if (MoronBoxHealMainPopupDefaultFrame:IsShown()) then
            MoronBoxHealMainPopupDefaultFrame:Hide()
        end
        MoronBoxHealMainPopupPresetFrame:Show()
    end

    Frame.PresetSettingsButton:SetScript("OnEnter", PresetSettingsButton_OnEnter)
    Frame.PresetSettingsButton:SetScript("OnLeave", PresetSettingsButton_OnLeave)
    Frame.PresetSettingsButton:SetScript("OnClick", PresetSettingsButton_OnClick)
end