--[[

    Author: sinsly
    License: MIT
    Github: https://github.com/sinsly

--]]

-- execution history logger for analytics debugging and management purposes
-- at the end it will print the information
-- simple unharmful log information

local Players = game:GetService("Players")
local Analytics = game:GetService("RbxAnalyticsService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")

local logFile = "executor_log.json"

local player = Players.LocalPlayer
local username = player.Name
local uhd = Analytics:GetClientId()
local timestamp = os.date("%Y-%m-%d %H:%M:%S")

local placeId = game.PlaceId
local gameName = MarketplaceService:GetProductInfo(placeId).Name
local jobId = game.JobId
local gameLink = "https://www.roblox.com/games/"..placeId.."/"..gameName:gsub(" ", "-").."?gameId="..jobId
local profileLink = "https://www.roblox.com/users/"..player.UserId.."/profile"

local previousLog = {}
if isfile(logFile) then
    local success, data = pcall(readfile, logFile)
    if success and data ~= "" then
        local ok, decoded = pcall(HttpService.JSONDecode, HttpService, data)
        if ok then
            previousLog = decoded
        end
    end
end

previousLog[username] = previousLog[username] or 0
previousLog[username] = previousLog[username] + 1

local logEntry = {
    Username = username,
    GameName = gameName,
    GameLink = gameLink,
    ProfileLink = profileLink,
    Time = timestamp,
    UHD = uhd,
    Executions = previousLog[username]
}

previousLog["Logs"] = previousLog["Logs"] or {}
table.insert(previousLog["Logs"], logEntry)

writefile(logFile, HttpService:JSONEncode(previousLog))

for key, value in pairs(logEntry) do
    print(key .. ": " .. tostring(value))
end
