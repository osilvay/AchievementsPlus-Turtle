---@class AP_Categories
local AP_Categories = AP_ModuleLoader:CreateModule("AP_Categories")
_AP_Categories = {}

local L = AchievementsPlus.L

local categories = {}

local highlightTexture = "Interface\\AddOns\\AchievementsPlus-Turtle\\Images\\AchievementFrame\\UI-Achievement-Category-Highlight"
local backgroundTexture = "Interface\\AddOns\\AchievementsPlus-Turtle\\Images\\AchievementFrame\\UI-Achievement-Category-Background"
local backgroundDesaturatedTexture = "Interface\\AddOns\\AchievementsPlus-Turtle\\Images\\AchievementFrame\\UI-Achievement-Category-Background-Desaturated"
local backgroundSelectedTexture = "Interface\\AddOns\\AchievementsPlus-Turtle\\Images\\AchievementFrame\\UI-Achievement-Category-Selected"
Achievements = {}

--- Enum.Categories
Achievements.Categories = {
  CATEGORY_SUMMARY                      = 'Summary',
  CATEGORY_CHARACTER                    = 'Character',
  CATEGORY_QUESTS                       = 'Quests',
  CATEGORY_QUESTS_KALIMDOR              = 'Kalimdor',
  CATEGORY_QUESTS_EASTERN_KINGDOMS      = 'Eastern Kingdoms',
  CATEGORY_EXPLORATION                  = 'World Exploration',
  CATEGORY_EXPLORATION_KALIMDOR         = 'Kalimdor',
  CATEGORY_EXPLORATION_EASTERN_KINGDOMS = 'Eastern Kingdoms',
  CATEGORY_PVE                          = 'Dungeons and Raids',
  CATEGORY_PVE_INSTANCES                = 'Dungeons',
  CATEGORY_PVE_RAIDS                    = 'Raids',
  CATEGORY_PVE_WORLD_BOSSES             = 'World Bosses',
  CATEGORY_BATTLEGROUNDS                = 'Player vs Player',
  CATEGORY_BG_ALTERAC                   = 'Alterac Valley',
  CATEGORY_BG_WARSONG                   = 'Warsong Gulch',
  CATEGORY_BG_ARATHI                    = 'Arathi Basin',
  CATEGORY_PROFESSIONS                  = 'Professions',
  CATEGORY_REPUTATION                   = 'Reputation',
  CATEGORY_FEATS_OF_STRENGTH            = 'Feats of Strength',
  CATEGORY_EVENTS                       = 'World Events',
  CATEGORY_EVENT_LUNAR_FESTIVAL         = 'Lunar Festival',
  CATEGORY_EVENT_LOVE_IS_IN_THE_AIR     = 'Love is in the Air',
  CATEGORY_EVENT_NOBLEGARDEN            = 'Noblegarden',
  CATEGORY_EVENT_MIDSUMMER              = 'Midsummer Fire Festival',
}

--- Enum.CategoryTree
Achievements.CategoryTree = {
  CATEGORY_SUMMARY = {
    Index     = 1,
    Hidden    = false,
    IsSummary = true,
    Childs    = nil,
  },
  CATEGORY_CHARACTER = {
    Index  = 2,
    Hidden = false,
    Childs = nil,
  },
  CATEGORY_QUESTS = {
    Index = 3,
    Hidden = false,
    Childs = {
      CATEGORY_QUESTS_KALIMDOR = {
        Index = 4,
        Hidden = true,
        Childs = nil
      },
      CATEGORY_QUESTS_EASTERN_KINGDOMS = {
        Index = 5,
        Hidden = true,
        Childs = nil
      },
    }
  },
  CATEGORY_EXPLORATION = {
    Index = 6,
    Hidden = false,
    Childs = {
      CATEGORY_EXPLORATION_KALIMDOR = {
        Index = 7,
        Hidden = true,
        Childs = nil
      },
      CATEGORY_EXPLORATION_EASTERN_KINGDOMS = {
        Index = 8,
        Hidden = true,
        Childs = nil
      },
    }
  },
  CATEGORY_PVE = {
    Index = 9,
    Hidden = false,
    Childs = {
      CATEGORY_PVE_INSTANCES = {
        Index = 10,
        Hidden = true,
        Childs = nil
      },
      CATEGORY_PVE_RAIDS = {
        Index = 11,
        Hidden = true,
        Childs = nil
      },
      CATEGORY_PVE_WORLD_BOSSES = {
        Index = 12,
        Hidden = true,
        Childs = nil
      },
    }
  },
  CATEGORY_BATTLEGROUNDS = {
    Index = 13,
    Hidden = false,
    Childs = {
      CATEGORY_BG_WARSONG = {
        Index = 14,
        Hidden = true,
        Childs = nil
      },
      CATEGORY_BG_ARATHI = {
        Index = 15,
        Hidden = true,
        Childs = nil
      },
      CATEGORY_BG_ALTERAC = {
        Index = 16,
        Hidden = true,
        Childs = nil
      },
    }
  },
  CATEGORY_PROFESSIONS = {
    Index = 17,
    Hidden = false,
    Childs = nil
  },
  CATEGORY_REPUTATION = {
    Index = 18,
    Hidden = false,
    Childs = nil
  },
  CATEGORY_EVENTS = {
    Index = 19,
    Hidden = false,
    Childs = {
      CATEGORY_EVENT_LUNAR_FESTIVAL = {
        Index = 20,
        Hidden = true,
        Childs = nil
      },
      CATEGORY_EVENT_LOVE_IS_IN_THE_AIR = {
        Index = 21,
        Hidden = true,
        Childs = nil
      },
      CATEGORY_EVENT_NOBLEGARDEN = {
        Index = 22,
        Hidden = true,
        Childs = nil
      },
      CATEGORY_EVENT_MIDSUMMER = {
        Index = 23,
        Hidden = true,
        Childs = nil
      },
    }
  },
  CATEGORY_FEATS_OF_STRENGTH = {
    Index = 24,
    Hidden = false,
    Childs = nil
  },
}

---Initialize category
---@param categoryObject table
function _AP_Categories.initializeCategory(categoryObject)
  categoryObject.Label = getfenv(0)[this:GetName() .. "_Label"]
  categoryObject.Background = getfenv(0)[this:GetName() .. "_Background"]
  categoryObject.ToggleButton = getfenv(0)[this:GetName() .. "_ToggleButton"]
  categoryObject:SetScript("OnMouseDown", AP_Categories.CategoryOnMouseDownEvent)
  categoryObject:SetScript("OnEnter", AP_Categories.CategoryOnEnterEvent)
  categoryObject:SetScript("OnLeave", AP_Categories.CategoryOnLeaveEvent)
  categoryObject.ToggleButton:SetScript("OnClick", AP_Categories.CategoryToggleButtonOnClickEvent)
  categoryObject.ToggleButton:SetScript("OnEnter", AP_Categories.CategoryToggleButtonOnEnterEvent)
  categoryObject.ToggleButton:SetScript("OnLeave", AP_Categories.CategoryToggleButtonOnLeaveEvent)
end

function AP_Categories.CategoryToggleButtonOnEnterEvent()
  AP_Categories:ToggleCategoryHighlight(this:GetParent())
end

function AP_Categories.CategoryToggleButtonOnLeaveEvent()
  AP_Categories:ToggleCategoryBackground(this:GetParent())
end

function AP_Categories.CategoryToggleButtonOnClickEvent()
  AP_Categories.ToggleCategorySelected(this)
end

function AP_Categories.CategoryOnEnterEvent()
  AP_Categories:ToggleCategoryHighlight(this)
end

function AP_Categories.CategoryOnLeaveEvent()
  AP_Categories:ToggleCategoryBackground(this)
end

function AP_Categories.CategoryOnMouseDownEvent()
  AP_Categories.ToggleCategorySelected(this)
end

local lastSelected = nil
---Toggle category selected
---@param categoryObject table
function AP_Categories.ToggleCategorySelected(categoryObject)
  local selected = false

  if categoryObject.isSelected then
    selected = false
  else
    selected = true
    if lastSelected ~= nil then
      lastSelected.isSelected = false
    end
  end
  this.isSelected = selected

  if categoryObject.isSubCategory then
    local parentCategory = categories[categoryObject.parentCategoryIndex]
    parentCategory.isExpanded = selected
  end

  if lastSelected ~= nil and not categoryObject.isSubCategory and lastSelected.isSubCategory then
    local lastParentCategory = categories[lastSelected.parentCategoryIndex]
    lastParentCategory.isExpanded = false
  end

  lastSelected = categoryObject
  --AP_Debug("New : " .. lastSelected:GetName() .. " - " .. tostring(lastSelected.isSelected))

  AP_Categories:UpdateCategoryLayout()
end

---Toggle category background
---@param categoryObject table
function AP_Categories:ToggleCategoryHighlight(categoryObject)
  categoryObject.Background:SetTexture(highlightTexture)
end

---Toggle category background
---@param categoryObject table
function AP_Categories:ToggleCategoryBackground(categoryObject)
  if categoryObject.isSelected then
    categoryObject.Background:SetTexture(backgroundSelectedTexture)
  else
    if not categoryObject.isSubCategory then
      categoryObject.Background:SetTexture(backgroundTexture)
    else
      categoryObject.Background:SetTexture(backgroundDesaturatedTexture)
    end
  end
end

function _AP_Categories.buildCategoryTree()
  AP_Categories:BuildCategoryTree()
end

---Build category tree
function AP_Categories:BuildCategoryTree()
  local yOffset = -10
  for categoryIndex, categoryData in pairs(Achievements.CategoryTree) do
    local categoryName = "AchievementsPlusCategory" .. categoryData.Index .. "Frame"
    AP_Categories:CreateCategory(categoryIndex, categoryName, AchievementsPlusCategoriesFrame_ScrollFrame_ScrollChild,
      Achievements.Categories[categoryIndex], yOffset, categoryData, false, (categoryData.Childs ~= nil), nil)
    yOffset = yOffset - 26
    if categoryData.Childs ~= nil then
      yOffset = AP_Categories:BuildSubCategoryTree(categoryData.Childs, yOffset, categoryIndex)
    end
  end
  AP_Categories:UpdateCategoryLayout()
end

---Build sub category tree
---@param subcategories table
---@param yOffset number
---@param parentCategoryIndex string
---@return number
function AP_Categories:BuildSubCategoryTree(subcategories, yOffset, parentCategoryIndex)
  for subCategoryIndex, subCategoryData in pairs(subcategories) do
    local subCategoryName = "AchievementsPlusCategory" .. subCategoryData.Index .. "Frame"
    AP_Categories:CreateCategory(subCategoryIndex, subCategoryName, AchievementsPlusCategoriesFrame_ScrollFrame_ScrollChild,
      Achievements.Categories[subCategoryIndex], yOffset, subCategoryData, true, false, parentCategoryIndex)
    yOffset = yOffset - 22
  end
  return yOffset
end

---Create category
---@param categoryIndex string
---@param name string
---@param parent table
---@param title string
---@param yOffset number
---@param categoryData table
---@param isSubCategory boolean
---@param hasChilds boolean
---@param parentCategoryIndex string|nil
---@return Frame|AchievementsPlusCategoryTemplate
function AP_Categories:CreateCategory(categoryIndex, name, parent, title, yOffset, categoryData, isSubCategory,
                                      hasChilds, parentCategoryIndex)
  local category = CreateFrame("Frame", name, parent, "AchievementsPlusCategoryTemplate")
  category.Label:SetText(title)
  category.categoryID = categoryData and categoryData.Index or nil
  category.categoryIndex = categoryIndex
  category.isSubCategory = isSubCategory
  category.hasChilds = hasChilds
  category:SetPoint("TOPLEFT", parent, 10, yOffset)
  if not category.isSubCategory then
    category.isSelected = categoryData.IsSummary or false
    category.isExpanded = false
    category.parentCategoryIndex = parentCategoryIndex
    category.Background:SetTexture(backgroundTexture)
    category.Background:SetWidth(222)
  else
    category:Hide()
    category.isSelected = false
    category.isExpanded = false
    category.parentCategoryIndex = parentCategoryIndex
    category.Background:SetTexture(backgroundDesaturatedTexture)
    category.Background:SetWidth(212)
  end

  if not category.hasChilds then
    category.ToggleButton:SetNormalTexture("Interface\\AddOns\\AchievementsPlus-Turtle\\Images\\AchievementFrame\\UI-Achievement-Plus-Minus")
    local texture = category.ToggleButton:GetNormalTexture()
    texture:SetTexCoord(0.0, 0.50, 0.25, 0.50)
  else
    category.ToggleButton:SetNormalTexture("Interface\\AddOns\\AchievementsPlus-Turtle\\Images\\AchievementFrame\\UI-Achievement-Plus-Minus")
    local texture = category.ToggleButton:GetNormalTexture()
    texture:SetTexCoord(0.0, 0.50, 0.0, 0.25)
  end

  category.ToggleButton:SetScript("OnClick", function()
    AP_Debug("Click en desplegar categoria")
  end)

  categories[categoryIndex] = category
  if categoryData.IsSummary then
    lastSelected = category
  end
  return category
end

---Update category layout
function AP_Categories:UpdateCategoryLayout()
  local yOffset = -10 -- Posición inicial
  --DEFAULT_CHAT_FRAME:AddMessage("Update layout")
  local orderedCategories = AP_Categories:GetCategoriesInOrder(Achievements.CategoryTree)
  for _, categoryData in pairs(orderedCategories) do
    local categoryIndex = categoryData.CategoryIndex
    --DEFAULT_CHAT_FRAME:AddMessage("Category index : " .. categoryIndex)
    yOffset = AP_Categories:ProcessUpdateCategoryLayout(yOffset, categoryIndex)
    if categoryData.Childs ~= nil then
      for subCategoryIndex, _ in pairs(categoryData.Childs) do
        yOffset = AP_Categories:ProcessUpdateCategoryLayout(yOffset, subCategoryIndex)
      end
    end
  end

  local scrollChild = AchievementsPlusCategoriesFrame_ScrollFrame:GetScrollChild()
  scrollChild:SetHeight(math.abs(yOffset))
end

---Process update category layout
---@param yOffset number
---@param categoryIndex string
---@return number
function AP_Categories:ProcessUpdateCategoryLayout(yOffset, categoryIndex)
  local category = categories[categoryIndex]
  --DEFAULT_CHAT_FRAME:AddMessage("Category index : " .. categoryIndex)
  if not category.isSubCategory then
    category:ClearAllPoints()
    category:SetPoint("TOPLEFT", 10, yOffset)
    yOffset = yOffset - category:GetHeight() + 6
  else
    local parentCategory = categories[category.parentCategoryIndex]
    category:ClearAllPoints()
    category:SetPoint("TOPLEFT", 20, yOffset + 4)
    --DEFAULT_CHAT_FRAME:AddMessage("Category index : " .. category.parentCategoryIndex)
    if (category.parentCategoryIndex ~= nil and parentCategory.isSelected) or category.isSelected
        or parentCategory.isExpanded then
      category:Show()
      yOffset = yOffset - category:GetHeight() + 8
    else
      category:Hide()
    end
    --if lastSelected ~= nil and lastSelected:GetName() == parentCategory:GetName() then
    --  category:Show()
    --  yOffset = yOffset - category:GetHeight() + 8
    --end
  end
  AP_Categories:ToggleCategoryBackground(category)
  return yOffset
end

---Get categories in order
---@param categoryTree table
---@return table
function AP_Categories:GetCategoriesInOrder(categoryTree)
  local currentCategories = {}

  for categoryIndex, category in pairs(categoryTree) do
    category.CategoryIndex = categoryIndex
    table.insert(currentCategories, category)
  end

  table.sort(currentCategories, function(a, b)
    return a.Index < b.Index
  end)

  local result = {}
  for _, category in ipairs(currentCategories) do
    table.insert(result, {
      Index = category.Index,
      CategoryIndex = category.CategoryIndex,
      Hidden = category.Hidden,
      IsSummary = category.IsSummary or false
    })

    if category.Childs then
      local childCategories = AP_Categories:GetCategoriesInOrder(category.Childs)
      for _, child in ipairs(childCategories) do
        table.insert(result, child)
      end
    end
  end
  return result
end
