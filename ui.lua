‎-- Roblox Loading to Pet Spawner GUI
‎
‎local gui = Instance.new("ScreenGui")
‎gui.Name = "LoadingScriptGUI"
‎gui.ResetOnSpawn = false
‎gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
‎
‎local frame = Instance.new("Frame")
‎frame.Size = UDim2.new(0, 400, 0, 150)
‎frame.Position = UDim2.new(0.5, -200, 0.5, -75)
‎frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
‎frame.Parent = gui
‎
‎local corner = Instance.new("UICorner", frame)
‎corner.CornerRadius = UDim.new(0, 12)
‎
‎local title = Instance.new("TextLabel", frame)
‎title.Text = "Loading script!"
‎title.Size = UDim2.new(1, 0, 0, 50)
‎title.Position = UDim2.new(0, 0, 0, 10)
‎title.BackgroundTransparency = 1
‎title.TextColor3 = Color3.fromRGB(0, 255, 170)
‎title.Font = Enum.Font.GothamBold
‎title.TextScaled = true
‎
‎local progressBarBG = Instance.new("Frame", frame)
‎progressBarBG.Size = UDim2.new(0.8, 0, 0.15, 0)
‎progressBarBG.Position = UDim2.new(0.1, 0, 0.7, 0)
‎progressBarBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
‎Instance.new("UICorner", progressBarBG).CornerRadius = UDim.new(0, 6)
‎
‎local progressBar = Instance.new("Frame", progressBarBG)
‎progressBar.Size = UDim2.new(0, 0, 1, 0)
‎progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
‎Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 6)
‎
‎local percentageLabel = Instance.new("TextLabel", frame)
‎percentageLabel.Position = UDim2.new(0.5, 0, 0.55, 0)
‎percentageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
‎percentageLabel.Size = UDim2.new(0, 100, 0, 30)
‎percentageLabel.BackgroundTransparency = 1
‎percentageLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
‎percentageLabel.Font = Enum.Font.GothamBold
‎percentageLabel.TextScaled = true
‎percentageLabel.Text = "1%"
‎
‎local runButton = Instance.new("TextButton", frame)
‎runButton.Size = UDim2.new(0.8, 0, 0.15, 0)
‎runButton.Position = progressBarBG.Position
‎runButton.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
‎runButton.TextColor3 = Color3.fromRGB(0, 0, 0)
‎runButton.Font = Enum.Font.GothamBold
‎runButton.TextScaled = true
‎runButton.Text = "Run Script"
‎runButton.Visible = false
‎Instance.new("UICorner", runButton).CornerRadius = UDim.new(0, 8)
‎
‎task.spawn(function()
‎	for i = 1, 100 do
‎		progressBar.Size = UDim2.new(i / 100, 0, 1, 0)
‎		percentageLabel.Text = i .. "%"
‎		task.wait(0.05)
‎	end
‎	progressBarBG:Destroy()
‎	percentageLabel:Destroy()
‎	runButton.Visible = true
‎end)
‎
‎runButton.MouseButton1Click:Connect(function()
‎	gui:Destroy()
‎
‎	-- Pet Spawner GUI
‎	local petType = "NFR"
‎	local function duplicatePet(petName)
‎		local Loads = require(game.ReplicatedStorage.Fsys).load
‎		local ClientData = Loads("ClientData")
‎		local InventoryDB = Loads("InventoryDB")
‎		local Inventory = ClientData.get("inventory")
‎
‎		local function generate_prop()
‎			return {
‎				flyable = true,
‎				rideable = true,
‎				neon = petType == "NFR" or petType == "MFR",
‎				mega_neon = petType == "MFR",
‎				age = 1
‎			}
‎		end
‎
‎		local function cloneTable(original)
‎			local copy = {}
‎			for key, value in pairs(original) do
‎				copy[key] = type(value) == "table" and cloneTable(value) or value
‎			end
‎			return copy
‎		end
‎
‎		for category_name, category_table in pairs(InventoryDB) do
‎			for id, item in pairs(category_table) do
‎				if category_name == "pets" and item.name == petName then
‎					local fake_uuid = game.HttpService:GenerateGUID(false)
‎					local n_item = cloneTable(item)
‎					n_item.unique = "uuid_" .. fake_uuid
‎					n_item.category = "pets"
‎					n_item.properties = generate_prop()
‎					n_item.newness_order = math.random(1, 999999)
‎					Inventory[category_name] = Inventory[category_name] or {}
‎					Inventory[category_name][fake_uuid] = n_item
‎					return
‎				end
‎			end
‎		end
‎	end
‎
‎	local Spawner = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
‎	Spawner.Name = "Spawner"
‎	Spawner.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
‎
‎	local Main = Instance.new("Frame", Spawner)
‎	Main.Name = "Main"
‎	Main.AnchorPoint = Vector2.new(0.5, 0.5)
‎	Main.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
‎	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
‎	Main.Size = UDim2.new(0, 446, 0, 260)
‎	Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6)
‎
‎	local Title = Instance.new("TextLabel", Main)
‎	Title.Text = "Pet Spawner"
‎	Title.TextScaled = true
‎	Title.Font = Enum.Font.GothamBold
‎	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
‎	Title.BackgroundTransparency = 1
‎	Title.Size = UDim2.new(0, 406, 0, 46)
‎	Title.Position = UDim2.new(0.5, 0, 0.1, 0)
‎	Title.AnchorPoint = Vector2.new(0.5, 0.5)
‎
‎	local function createButton(name, text, pos, callback)
‎		local btn = Instance.new("TextButton", Main)
‎		btn.Name = name
‎		btn.Size = UDim2.new(0, 89, 0, 50)
‎		btn.Position = pos
‎		btn.AnchorPoint = Vector2.new(0.5, 0.5)
‎		btn.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
‎		btn.Font = Enum.Font.GothamBold
‎		btn.Text = text
‎		btn.TextScaled = true
‎		btn.TextWrapped = true
‎		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
‎		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
‎		btn.MouseButton1Click:Connect(callback)
‎		return btn
‎	end
‎
‎	local FR, NFR, MFR
‎	FR = createButton("FR", "FR", UDim2.new(0.2, 0, 0.35, 0), function()
‎		petType = "FR"
‎		FR.TextColor3, NFR.TextColor3, MFR.TextColor3 = Color3.fromRGB(25, 255, 21), Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255)
‎	end)
‎	NFR = createButton("NFR", "NFR", UDim2.new(0.5, 0, 0.35, 0), function()
‎		petType = "NFR"
‎		NFR.TextColor3, FR.TextColor3, MFR.TextColor3 = Color3.fromRGB(25, 255, 21), Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255)
‎	end)
‎	MFR = createButton("MFR", "MFR", UDim2.new(0.8, 0, 0.35, 0), function()
‎		petType = "MFR"
‎		MFR.TextColor3, FR.TextColor3, NFR.TextColor3 = Color3.fromRGB(25, 255, 21), Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255)
‎	end)
‎
‎	local NameBox = Instance.new("TextBox", Main)
‎	NameBox.Size = UDim2.new(0, 354, 0, 45)
‎	NameBox.Position = UDim2.new(0.5, 0, 0.6, 0)
‎	NameBox.AnchorPoint = Vector2.new(0.5, 0.5)
‎	NameBox.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
‎	NameBox.PlaceholderText = "Enter Pet Name Here"
‎	NameBox.Font = Enum.Font.GothamBold
‎	NameBox.Text = ""
‎	NameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
‎	NameBox.TextScaled = true
‎	Instance.new("UICorner", NameBox).CornerRadius = UDim.new(0, 6)
‎
‎	local Spawn = Instance.new("TextButton", Main)
‎	Spawn.Size = UDim2.new(0, 176, 0, 41)
‎	Spawn.Position = UDim2.new(0.5, 0, 0.85, 0)
‎	Spawn.AnchorPoint = Vector2.new(0.5, 0.5)
‎	Spawn.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
‎	Spawn.Font = Enum.Font.GothamBold
‎	Spawn.Text = "Spawn"
‎	Spawn.TextColor3 = Color3.fromRGB(255, 255, 255)
‎	Spawn.TextScaled = true
‎	Instance.new("UICorner", Spawn).CornerRadius = UDim.new(0, 6)
‎	Spawn.MouseButton1Click:Connect(function()
‎		duplicatePet(NameBox.Text)
‎	end)
‎end)
