-- detect executor / banlist ones you don't support example

local blacklist = {
    ["Xeno"] = true,
}

local executors = {
    ["Wave"] = {platform="Windows", type="EXE"},
    ["Volt"] = {platform="Windows", type="EXE"},
    ["Seliware"] = {platform="Windows", type="EXE"},
    ["Volcano"] = {platform="Windows", type="EXE"},
    ["Bunni.lol"] = {platform="Windows", type="EXE"},
    ["ChocoSploit"] = {platform="Windows", type="EXE"},
    ["Velocity"] = {platform="Windows", type="EXE"},
    ["Valex"] = {platform="Windows", type="EXE"},
    ["Potassium"] = {platform="Windows", type="EXE"},
    ["Solara"] = {platform="Windows", type="EXE"},
    ["Xeno"] = {platform="Windows", type="EXE"},
    ["Sirhurt"] = {platform="Windows", type="EXE"},
    ["Lovreware"] = {platform="Windows", type="EXE"},

    ["Hydrogen"] = {platform="Mac", type="EXE"},
    ["Macsploit"] = {platform="Mac", type="EXE"},
    ["Cryptic"] = {platform="Mac", type="EXE"},

    ["Delta"] = {platform="Mobile", type="Android/iOS"},
    ["Codex"] = {platform="Mobile", type="Android"},
    ["Cryptic Mobile"] = {platform="Mobile", type="Android"},
}

local function detectExecutor()
    if identifyexecutor then
        local n = identifyexecutor()
        return n
    elseif getexecutorname then
        return getexecutorname()
    elseif syn then
        return "Synapse X"
    end
    return "Unknown"
end

local function getSupported()
    local list = {}
    for name,_ in pairs(executors) do
        if not blacklist[name] then
            table.insert(list, name)
        end
    end
    return list
end

local execName = detectExecutor()

if blacklist[execName] then
    game.Players.LocalPlayer:Kick(
        "Your exploit ("..execName..") is not supported.\n" ..
        "Reason: Executor is not protected.\n\nSupported executors:\n" ..
        table.concat(getSupported(), ", ")
    )
    return
end
