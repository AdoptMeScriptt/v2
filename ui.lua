local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Clean previous GUIs if exist
local oldLoading = PlayerGui:FindFirstChild("LoadingScriptGUI")
if oldLoading then oldLoading:Destroy() end

local oldSpawner = PlayerGui:FindFirstChild("PetSpawner")
if oldSpawner then oldSpawner:Destroy() end

-- Loading GUI
local loadingGui = Instance.new("ScreenGui", PlayerGui)
loadingGui.Name = "LoadingScriptGUI"

local frame = Instance.new("Frame", loadingGui)
frame.Size = UDim2.new(0, 400, 0, 150)
frame.Position = UDim2.new(0.5, -200, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 10)
title.Text = "Loading script..."
title.TextColor3 = Color3.fromRGB(0, 255, 170)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BackgroundTransparency = 1

local progressBarBG = Instance.new("Frame", frame)
progressBarBG.Size = UDim2.new(0.8, 0, 0.15, 0)
progressBarBG.Position = UDim2.new(0.1, 0, 0.7, 0)
progressBarBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", progressBarBG).CornerRadius = UDim.new(0, 6)

local progressBar = Instance.new("Frame", progressBarBG)
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 6)

local percentageLabel = Instance.new("TextLabel", frame)
percentageLabel.Size = UDim2.new(0, 100, 0, 30)
percentageLabel.Position = UDim2.new(0.5, 0, 0.55, 0)
percentageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
percentageLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
percentageLabel.Font = Enum.Font.GothamBold
percentageLabel.TextScaled = true
percentageLabel.BackgroundTransparency = 1
percentageLabel.Text = "1%"

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

-- Animate progress bar
task.spawn(function()
	for i = 1, 100 do
		progressBar.Size = UDim2.new(i/100, 0, 1, 0)
		percentageLabel.Text = i .. "%"
		wait(0.02)
	end
	progressBarBG:Destroy()
	percentageLabel:Destroy()
	runButton.Visible = true
end)

-- Function to create Pet Spawner GUI
local function createPetSpawner()
	local petType = "NFR"
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
		print("Spawn pet requested:", nameBox.Text, "with type:", petType)
		-- Add your pet spawning code here if you want to test pet spawning
	end)
end

-- Run button click event
runButton.MouseButton1Click:Connect(function()
	loadingGui:Destroy()
	createPetSpawner()
end)
