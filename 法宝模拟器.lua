_G.farmNearest = false
_G.autoCollect = false

local plr = game.Players.LocalPlayer.Character.HumanoidRootPart

function getNear()
    local near;
    local nearr = math.huge

    for i, v in pairs(game:GetService("Workspace").Fight.ClientChests:GetChildren()) do
        if (plr.Position - v.Root.Position).Magnitude < nearr then
            near = v
            nearr = (plr.Position - v.Root.Position).Magnitude
        end
    end

    return near
end

local OpenUI = Instance.new("ScreenGui") 
local ImageButton = Instance.new("ImageButton") 
local UICorner = Instance.new("UICorner") 
OpenUI.Name = "OpenUI" 
OpenUI.Parent = game.CoreGui 
OpenUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling 
ImageButton.Parent = OpenUI 
ImageButton.BackgroundColor3 = Color3.fromRGB(5, 6, 7) 
ImageButton.BackgroundTransparency = 0.500 
ImageButton.Position = UDim2.new(0.0235790554, 0, 0.466334164, 0) 
ImageButton.Size = UDim2.new(0, 50, 0, 50) 
ImageButton.Image = "rbxassetid://15613380753" 
ImageButton.Draggable = true 
UICorner.CornerRadius = UDim.new(0, 200) 
UICorner.Parent = ImageButton 
ImageButton.MouseButton1Click:Connect(function() 
  if uihide == false then
	uihide = true
	game.CoreGui.ui.Main:TweenSize(UDim2.new(0, 0, 0, 0),"In","Quad",0.4,true)
else
	uihide = false
	game.CoreGui.ui.Main:TweenSize(UDim2.new(0, 560, 0, 319),"Out","Quad",0.4,true)
		end 
		
end)

uihide = false

local lib = loadstring(game:HttpGet"https://pastebin.com/raw/aDQ86WZA")()

local win = lib:Window("龙脚本--法宝模拟器",Color3.fromRGB(0, 255, 0), Enum.KeyCode.E)

local tab = win:Tab("主要功能")

tab:Toggle("自动打怪", false, function(v)
    _G.farmNearest = v

    spawn(function()
        while task.wait() do
            if not _G.farmNearest then break end
            pcall(function()
                local nearest = getNear()

                plr.CFrame = nearest.Root.CFrame * CFrame.new(0,0,10)
                wait(.2)

                workspace.Fight.Events.FightAttack:InvokeServer(0,nearest.Name)   

                repeat task.wait()
                    plr.CFrame = nearest.Root.CFrame * CFrame.new(0,0,10)
                until nearest.Root == nil or not _G.farmNearest
            end)
        end
    end)
end)

tab:Toggle("自动收集", false, function(v)
    _G.autoCollect = v

    spawn(function()
        while task.wait() do
            if not _G.autoCollect then break end
            for i, v in pairs(game:GetService("Workspace").Rewards:GetChildren()) do
                if v ~= nil then
                    v.CFrame = plr.CFrame
                end
            end
        end
    end)
end)