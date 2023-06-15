--[[Button Frame Names:
	Questlog
	ColQL - Collapse QuestLog 				(Lines 23-39)
	ExQL - Expand QuestLog 					(Lines 42-56)
	TradeSkills
	ColTS - Collapse TradeSkill Recipe List (Lines 59-94)
	ExTS - Expand TradeSkill Recipe List 	(Lines 98-131)
	Reputation
	RepCBtn - Collapse Reputation List 		(Lines 134-152)
	RepExBtn - Expand Reputation List 		(Lines 156-173)
	Currency
	CurCol - Collapse Currency List 		(Lines 176-199)
	CurEx - Expand Currency List 			(Lines 202-226)
	Encounter Journal
	EJCol - Collapse Overviews List			(Lines 230-264)
	EJExp - Expand Overviews List 			(Lines 267-294)
	EJCol2 - Collapse Abilities List		(Lines 298-325)
	EJExp2 - Expand Abilities List			(Lines 328-371)
	]]

local frameLoaded = false

--Quest Log Button-CollapseQLBtn
local ColQL = CreateFrame("Button", "Collapse QuestLog", QuestScrollFrame, 'UIPanelButtonTemplate')
	--Set frame strata to draw over most other frames
ColQL:SetFrameStrata("HIGH")
ColQL:SetFrameLevel(100)
ColQL:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")

	--Set Attributes for button (i.e. size, anchor, text)
ColQL:SetSize(20, 20)
ColQL:SetPoint("TOPRIGHT", 0, 0)
ColQL.tooltipText = "Collapse"


	--Make button work with left click and execute collapse
ColQL:RegisterForClicks("LeftButtonUp")
ColQL:SetScript("OnClick", function() CollapseQuestHeader(0) 
end)


--Quest Log Button-Expand
local ExQL = CreateFrame("Button", "Expand QuestLog", QuestScrollFrame, 'UIPanelButtonTemplate')
	--Set frame strata to draw over most other frames
ExQL:SetFrameStrata("HIGH")
ExQL:SetFrameLevel(100)
ExQL:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")

	--Set Attributes for button (i.e. size, anchor, text)
ExQL:SetSize(20, 20)
ExQL:SetPoint("TOPRIGHT", -20, 0)
ExQL.tooltipText = "Expand"

	--Make button work with left click and execute Expand
ExQL:RegisterForClicks("LeftButtonUp")
ExQL:SetScript("OnClick", function() ExpandQuestHeader(0) end)


--Tradeskill Button-Collapse
local ColTS = CreateFrame("Button", "Collapse TradeSkills", ProfessionsFrame.CraftingPage.RecipeList, 'UIPanelButtonTemplate')
local TSscrollBox = ProfessionsFrame.CraftingPage.RecipeList.ScrollBox

	--Set frame strata to draw over most other frames
ColTS:SetFrameStrata("HIGH")
ColTS:SetFrameLevel(100)
ColTS:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")

	--Set Attributes for button (i.e. size, anchor, text)
ColTS:SetSize(20,20)
ColTS:SetPoint("TOPRIGHT", -0,20)
ColTS.tooltipText = "Collapse"

	--make button work with left click and execute collapse. two methods:
ColTS:RegisterForClicks("LeftButtonUp")

	--make button work with left click and execute Collapse
local function SetHeadersCollapseState(collapsed)
	local dataProvider = TSscrollBox:GetDataProvider()

	dataProvider:GetRootNode():SetChildrenCollapsed(collapsed, TreeListDataProviderConstants.RetainChildCollapse, TreeListDataProviderConstants.SkipInvalidation)
	dataProvider:Invalidate()

	TSscrollBox:ForEachFrame(function (frame, node)
		local elementData = node:GetData()

		if elementData.categoryInfo then
			frame:SetCollapseState(collapsed)
		end
	end)
end

ColTS:SetScript("OnClick", function()
	SetHeadersCollapseState(true)
end)


--Tradeskill Button-Expand (for dual button method)
local ExTS = CreateFrame("Button", "Expand Tradeskills", ProfessionsFrame.CraftingPage.RecipeList, 'UIPanelButtonTemplate')
local TSscrollBox = ProfessionsFrame.CraftingPage.RecipeList.ScrollBox

	--Set frame strata to draw over most other frames
ExTS:SetFrameStrata("HIGH")
ExTS:SetFrameLevel(100)
ExTS:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")

	--Set Attributes for button (i.e. size, anchor, text)
ExTS:SetSize(20,20)
ExTS:SetPoint("TOPRIGHT", -20,20)
ExTS.tooltipText = "Expand"

	--Make button work with left click and execute Expand
ExTS:RegisterForClicks("LeftButtonUp")

local function SetHeadersCollapseState(collapsed)
	local dataProvider = TSscrollBox:GetDataProvider()

	dataProvider:GetRootNode():SetChildrenCollapsed(collapsed, TreeListDataProviderConstants.RetainChildCollapse, TreeListDataProviderConstants.SkipInvalidation)
	dataProvider:Invalidate()

	TSscrollBox:ForEachFrame(function (frame, node)
		local elementData = node:GetData()

		if elementData.categoryInfo then
			frame:SetCollapseState(collapsed)
		end
	end)
end

ExTS:SetScript("OnClick", function()
	SetHeadersCollapseState(false)
end)


--Reputation Button-Collapse
local RepC = CreateFrame("Button", "Collapse Reputation", ReputationFrame, 'UIPanelButtonTemplate')
local numFactions = GetNumFactions()

--Set frame strata to draw over most other frames
RepC:SetFrameStrata("HIGH")
RepC:SetFrameLevel(100)
RepC:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")

	--Set Attributes for button (i.e. size, anchor, text)
RepC:SetSize(20, 20)
RepC:SetPoint("TOPRIGHT", 0, -40)
RepC.tooltipText = "Collapse"

	--Make button work with left click and execute collapse
	RepC:RegisterForClicks("LeftButtonUp")
	RepC:SetScript("OnClick", function()
			CollapseAllFactionHeaders()
		end)


--Reputation Button-Expand
local RepEx = CreateFrame("Button", "Expand Reputation", ReputationFrame, 'UIPanelButtonTemplate')


	--Set frame strata to draw over most other frames
RepEx:SetFrameStrata("HIGH")
RepEx:SetFrameLevel(100)
RepEx:SetNormalTexture("Interface\\Buttons\\UI-PLusButton-Up")

	--Set Attributes for button (i.e. size, anchor, text)
RepEx:SetSize(20, 20)
RepEx:SetPoint("TOPRIGHT", -20, -40)
RepEx.tooltipText = "Expand"

	--Make button work with left click and execute collapse
RepEx:RegisterForClicks("LeftButtonUp")
RepEx:SetScript("OnClick", function() 
			ExpandAllFactionHeaders()
		end)


--Currency Button-Collapse
local CurCol = CreateFrame("Button", "Collapse Currency", TokenFrame, 'UIPanelButtonTemplate')
	--Set frame strata to draw over most other frames
CurCol:SetFrameStrata("HIGH")
CurCol:SetFrameLevel(100)
CurCol:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")

	--Set Attributes for button (i.e. size, anchor, text)
CurCol:SetSize(20, 20)
CurCol:SetPoint("TOPRIGHT", 0, -40)
CurCol.tooltipText = "Collapse"

	--Make button work with left click and execute collapse
CurCol:RegisterForClicks("LeftButtonUp")

CurCol:SetScript("OnClick", function()
	local size = C_CurrencyInfo.GetCurrencyListSize()
	for k = 1, size, 1 do
		C_CurrencyInfo.ExpandCurrencyList(k,false)
	end
		--Hide and Show to force update of the Frame
	TokenFrame:Hide()
	TokenFrame:Show()
end)


--Currency Button-Expand
local CurE = CreateFrame("Button", "Expand Currency", TokenFrame, 'UIPanelButtonTemplate')

	--Set frame strata to draw over most other frames
CurE:SetFrameStrata("HIGH")
CurE:SetFrameLevel(100)
CurE:SetNormalTexture("Interface\\Buttons\\UI-PLusButton-Up")

	--Set Attributes for button (i.e. size, anchor, text)
CurE:SetSize(20, 20)
CurE:SetPoint("TOPRIGHT", -20, -40)
CurE.tooltipText = "Expand"

	--Make button work with left click and execute collapse
CurE:RegisterForClicks("LeftButtonUp")

CurE:SetScript("OnClick", function()
	local size = C_CurrencyInfo.GetCurrencyListSize()
	for k = size, 0, -1 do
		C_CurrencyInfo.ExpandCurrencyList(k,true)
	end
		--Hide and Show to force update of the Frame
	TokenFrame:Hide()
	TokenFrame:Show()
end)



local function CreateButtons()
    -- Check if the Encounter Journal frame is loaded
    if not frameLoaded or not EncounterJournal then
        return
    end

	--Encounter Journal Overview Collapse
	--Create the Collapse button
	local EJCol = CreateFrame("Button", "Encounter Overview Collapse", EncounterJournal.encounter.info.overviewScroll.ScrollBar, 'UIPanelButtonTemplate')
		--Set frame strata to draw over most other frames
	EJCol:SetFrameStrata("HIGH")
	EJCol:SetFrameLevel(100)
	EJCol:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")

		--Set Attributes for button (i.e. size, anchor, text)
	EJCol:SetSize(20, 20)
	EJCol:SetPoint("TOPRIGHT", EncounterJournal.encounter.info.detailsScroll.ScrollBar,"TOPLEFT",10,55)
	EJCol.tooltipText = "Collapse"

	--Make button work with left click and execute collapse
	EJCol:RegisterForClicks("LeftButtonUp")
	
	local function CollapseOverviewHeaders()
	   for i = 1, 10 do 		-- Adjust the range based on the number of headers you have
		  local header = _G["EncounterJournalOverviewInfoHeader" .. i]
		  if header and header.expanded then
			 header.button:Click()
		  end
	   end
	end
	
	
	EJCol:SetScript("OnClick", function()
		  CollapseOverviewHeaders()
	end)
	
	
	--Encounter Journal Overview Expand
	--Create the expand button
	local EJExp = CreateFrame("Button", "Encounter Overview Expand", EncounterJournal.encounter.info.overviewScroll.ScrollBar, 'UIPanelButtonTemplate')
	
		--Set frame strata to draw over most other frames
	EJExp:SetFrameStrata("HIGH")
	EJExp:SetFrameLevel(100)
	EJExp:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")

	--Set Attributes for button (i.e. size, anchor, text)
	EJExp:SetSize(20, 20)
	EJExp:SetPoint("TOPRIGHT", EJCol,"TOPLEFT", 0, 0)
	EJExp.tooltipText = "Expand"

	--Make button work with left click and execute expand
	EJExp:RegisterForClicks("LeftButtonUp")
	
	local function ExpandOverviewHeaders()
	   for i = 1, 10 do 		-- Adjust the range based on the number of headers you have
		  local header = _G["EncounterJournalOverviewInfoHeader" .. i]
		  if header and not header.expanded then
			 header.button:Click()      end
	end
	end
	
	EJExp:SetScript("OnClick", function()
		  ExpandOverviewHeaders()
	end)
	
	

--Encounter Journal Abilities Collapse
-- Create the Collapse button
local EJCol2= CreateFrame("Button", "Encounter Journal Collapse", EncounterJournal.encounter.info.detailsScroll.ScrollBar, 'UIPanelButtonTemplate')
-- Set frame strata to draw over most other frames
EJCol2:SetFrameStrata("HIGH")
EJCol2:SetFrameLevel(100)
EJCol2:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")

-- Set Attributes for button (i.e. size, anchor, text)
EJCol2:SetSize(20, 20)
EJCol2:SetPoint("TOPRIGHT", EncounterJournal.encounter.info.detailsScroll.ScrollBar, "TOPLEFT",10,55)
EJCol2.tooltipText = "Collapse"

-- Make button work with left click and execute collapse
EJCol2:RegisterForClicks("LeftButtonUp")

local function CollapseAbilityHeaders()
   for i = 1, 50 do 		-- Adjust the range based on the number of headers you have
      local header = _G["EncounterJournalInfoHeader" .. i]
      if header and header.expanded then
         header.button:Click()
      end
   end
end

EJCol2:SetScript("OnClick", function()
      CollapseAbilityHeaders()
end)


--Encounter Journal Abilities Expand
-- Create the Expand button
local EJExp2 = CreateFrame("Button", "Encounter Journal Ability Expand", EncounterJournal.encounter.info.detailsScroll.ScrollBar, 'UIPanelButtonTemplate')
-- Set frame strata to draw over most other frames
EJExp2:SetFrameStrata("HIGH")
EJExp2:SetFrameLevel(100)
EJExp2:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")

-- Set Attributes for button (i.e. size, anchor, text)
EJExp2:SetSize(20, 20)
EJExp2:SetPoint("TOPRIGHT", EJCol2, "TOPLEFT", 0,0)
EJExp2.tooltipText = "Expand"

-- Make button work with left click and execute expand
EJExp2:RegisterForClicks("LeftButtonUp")

local function ExpandAbilityHeaders()
   for i = 1, 50 do 		-- Adjust the range based on the number of headers you have
      local header = _G["EncounterJournalInfoHeader" .. i]
      if header and not header.expanded then
         header.button:Click()
      end
   end
end

EJExp2:SetScript("OnClick", function()
      ExpandAbilityHeaders()
end)
end


local function OnEvent(self, event, addon)
    -- Check if the Encounter Journal frame is loaded
    if addon == "Blizzard_EncounterJournal" then
        frameLoaded = true
        CreateButtons()
        -- Unregister the event to avoid redundant checks
        self:UnregisterEvent(event)
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", OnEvent)




--____________________________________________________________________________________________________________________________________________
--Experimental below this line



