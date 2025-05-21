-- Loading + Pet Spawner GUI (Delta Mobile Friendly)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "LoadingScriptGUI"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

-- Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 150)
frame.Position = UDim2.new(0.5, -200, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.Parent = gui

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel", frame)
title.Text = "Loading script..."
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(0, 255, 170)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Progress bar background
local progressBarBG = Instance.new("Frame", frame)
progressBarBG.Size = UDim2.new(0.8, 0, 0.15, 0)
progressBarBG.Position = UDim2.new(0.1, 0, 0.7, 0)
progressBarBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", progressBarBG).CornerRadius = UDim.new(0, 6)

-- Progress bar
local progressBar = Instance.new("Frame", progressBarBG)
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 6)

-- Percentage
local percentageLabel = Instance.new("TextLabel", frame)
percentageLabel.Position = UDim2.new(0.5, 0, 0.55, 0)
percentageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
percentageLabel.Size = UDim2.new(0, 100, 0, 30)
percentageLabel.BackgroundTransparency = 1
percentageLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
percentageLabel.Font = Enum.Font.GothamBold
percentageLabel.TextScaled = true
percentageLabel.Text = "1%"

-- Run button (hidden)
local runButton = Instance.new("TextButton", frame)
runButton.Size = UDim2.new(0.8, 0, 0.15, 0)
runButton.Position = progressBarBG.Position
runButton.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
runButton.TextColor3 = Color3.fromRGB(0, 0, 0)
runButton.Font = Enum.Font.GothamBold
runButton.TextScaled = true
runButton.Text = "Run Script"
runButton.Visible = false
Instance.new("UICorner", runButton).CornerRadius = UDim.new(0, 8)

-- Progress bar animation
task.spawn(function()
	for i = 1, 100 do
		progressBar.Size = UDim2.new(i / 100, 0, 1, 0)
		percentageLabel.Text = i .. "%"
		wait(0.02)
	end
	progressBarBG:Destroy()
	percentageLabel:Destroy()
	runButton.Visible = true
end)

-- When finished, run Pet Spawner
runButton.MouseButton1Click:Connect(function()
	gui:Destroy()

	-- Pet Spawner GUI
	local petType = "NFR"
	local function duplicatePet(petName)
		local Loads = require(game.ReplicatedStorage.Fsys).load
		local ClientData = Loads("ClientData")
		local InventoryDB = Loads("InventoryDB")
		local Inventory = ClientData.get("inventory")
		local function generate_prop()
			return {
				flyable = true,
				rideable = true,
				neon = petType == "NFR" or petType == "MFR",
				mega_neon = petType == "MFR",
				age = 1
			}
		end
		local function cloneTable(original)
			local copy = {}
			for key, value in pairs(original) do
				if type(value) == "table" then
					copy[key] = cloneTable(value)
				else
					copy[key] = value
				end
			end
			return copy
		end
		for category_name, category_table in pairs(InventoryDB) do
			for id, item in pairs(category_table) do
				if category_name == "pets" and item.name == petName then
					local fake_uuid = game.HttpService:GenerateGUID()
					local n_item = cloneTable(item)
					n_item["unique"] = "uuid_" .. fake_uuid
					n_item["category"] = "pets"
					n_item["properties"] = generate_prop()
					n_item["newness_order"] = math.random(1, 900000)
					if not Inventory[category_name] then
						Inventory[category_name] = {}
					end
					Inventory[category_name][fake_uuid] = n_item
					return
				end
			end
		end
	end

	-- GUI Build
	local gui2 = Instance.new("ScreenGui", PlayerGui)
	gui2.Name = "PetSpawner"

	local main = Instance.new("Frame", gui2)
	main.Size = UDim2.new(0, 450, 0, 260)
	main.Position = UDim2.new(0.5, -225, 0.5, -130)
	main.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	Instance.new("UICorner", main).CornerRadius = UDim.new(0, 6)

	local title = Instance.new("TextLabel", main)
	title.Text = "Pet Spawner"
	title.Size = UDim2.new(1, 0, 0, 40)
	title.Position = UDim2.new(0, 0, 0, 10)
	title.BackgroundTransparency = 1
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Font = Enum.Font.GothamBold
	title.TextScaled = true

	local function createButton(name, text, pos, onClick)
		local btn = Instance.new("TextButton", main)
		btn.Name = name
		btn.Size = UDim2.new(0, 90, 0, 45)
		btn.Position = pos
		btn.AnchorPoint = Vector2.new(0.5, 0.5)
		btn.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
		btn.Font = Enum.Font.GothamBold
		btn.Text = text
		btn.TextScaled = true
		btn.TextWrapped = true
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
		btn.MouseButton1Click:Connect(onClick)
		return btn
	end

	local FR, NFR, MFR
	FR = createButton("FR", "FR", UDim2.new(0.2, 0, 0.35, 0), function()
		petType = "FR"
		FR.TextColor3 = Color3.fromRGB(25, 255, 21)
		NFR.TextColor3 = Color3.fromRGB(255, 255, 255)
		MFR.TextColor3 = Color3.fromRGB(255, 255, 255)
	end)

	NFR = createButton("NFR", "NFR", UDim2.new(0.5, 0, 0.35, 0), function()
		petType = "NFR"
		NFR.TextColor3 = Color3.fromRGB(25, 255, 21)
		FR.TextColor3 = Color3.fromRGB(255, 255, 255)
		MFR.TextColor3 = Color3.fromRGB(255, 255, 255)
	end)

	MFR = createButton("MFR", "MFR", UDim2.new(0.8, 0, 0.35, 0), function()
		petType = "MFR"
		MFR.TextColor3 = Color3.fromRGB(25, 255, 21)
		FR.TextColor3 = Color3.fromRGB(255, 255, 255)
		NFR.TextColor3 = Color3.fromRGB(255, 255, 255)
	end)

	local nameBox = Instance.new("TextBox", main)
	nameBox.Size = UDim2.new(0, 360, 0, 40)
	nameBox.Position = UDim2.new(0.5, 0, 0.6, 0)
	nameBox.AnchorPoint = Vector2.new(0.5, 0.5)
	nameBox.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
	nameBox.PlaceholderText = "Enter Pet Name"
	nameBox.Font = Enum.Font.GothamBold
	nameBox.Text = ""
	nameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	nameBox.TextScaled = true
	Instance.new("UICorner", nameBox).CornerRadius = UDim.new(0, 6)

	local spawnBtn = Instance.new("TextButton", main)
	spawnBtn.Size = UDim2.new(0, 160, 0, 40)
	spawnBtn.Position = UDim2.new(0.5, 0, 0.83, 0)
	spawnBtn.AnchorPoint = Vector2.new(0.5, 0.5)
	spawnBtn.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
	spawnBtn.Font = Enum.Font.GothamBold
	spawnBtn.Text = "Spawn Pet"
	spawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	spawnBtn.TextScaled = true
	Instance.new("UICorner", spawnBtn).CornerRadius = UDim.new(0, 6)
	spawnBtn.MouseButton1Click:Connect(function()
		duplicatePet(nameBox.Text)
	end)
end)
