local Players = game:GetService("Players")
local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
repeat task.wait() until player and player:FindFirstChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "TestGUI"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 200)
frame.Parent = gui
frame.ZIndex = 10

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, 0, 1, 0)
button.Text = "Click Me"
button.TextScaled = true
button.Parent = frame
button.ZIndex = 11

button.MouseButton1Click:Connect(function()
    print("Button clicked!")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Button",
        Text = "Clicked!",
        Duration = 3
    })
end)
