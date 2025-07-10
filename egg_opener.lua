local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Поиск нужного RemoteEvent (варианты названий)
local EggEvent
for _, name in ipairs({"OpenEgg", "EggOpened", "RequestOpenEgg", "EggEvent"}) do
    if ReplicatedStorage:FindFirstChild(name) then
        EggEvent = ReplicatedStorage:FindFirstChild(name)
        break
    end
end

if not EggEvent then
    -- Если не нашли автоматически, выводим список всех RemoteEvents для ручного поиска
    print("Не найден ивент! Доступные RemoteEvents:")
    for _, child in ipairs(ReplicatedStorage:GetChildren()) do
        if child:IsA("RemoteEvent") then
            print(child.Name)
        end
    end
    return
end

-- Функция моментального открытия
local function openEggs()
    for i = 1, 50 do  -- 50 быстрых запросов
        EggEvent:FireServer()
    end
end

-- Автоматическое открытие каждую секунду
spawn(function()
    while true do
        openEggs()
        wait(0.1)  -- Интервал между пакетами
    end
end)

-- Открытие по клику
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        openEggs()
    end
end)

print("Скрипт активирован! Яйца будут открываться моментально.")
