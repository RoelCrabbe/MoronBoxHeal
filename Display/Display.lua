-------------------------------------------------------------------------------
-- MiniMap Button {{{
-------------------------------------------------------------------------------

MBH_Minimap = CreateFrame("Frame", nil , Minimap) -- Minimap Frame

function MBH_Minimap:CreateMinimapIcon()
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
    self.Button:RegisterForClicks(LeftButtonUp, RightButtonUp)
    self.Button:RegisterForDrag(LeftButton)

	local Overlay = self:CreateTexture(nil, "OVERLAY", self)
	Overlay:SetWidth(52)
	Overlay:SetHeight(52)
	Overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
	Overlay:SetPoint("TOPLEFT", 0, 0)
	
	local MinimapIcon = self:CreateTexture(nil, "BACKGROUND", self)
	MinimapIcon:SetWidth(18)
	MinimapIcon:SetHeight(18)
	MinimapIcon:SetTexture("Interface\\Icons\\Spell_Nature_HealingTouch")
	MinimapIcon:SetTexCoord(0.075, 0.925, 0.075, 0.925)
	MinimapIcon:SetPoint("CENTER", 0, 0)

    local function OnEnter()
        GameTooltip:SetOwner(MBH_Minimap, "ANCHOR_BOTTOMLEFT")
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

            MBH_Minimap:SetPoint(
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