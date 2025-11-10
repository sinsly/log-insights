local seen = {}

local function logUrl(url)
    if type(url) ~= "string" then return end
    if not seen[url] then
        seen[url] = true
        print("[HTTP Detected] →", url)
    end
end

local function hookRequestFunc(name, func)
    if typeof(func) ~= "function" then return end

    local old = func
    local hooked
    hooked = function(tbl)
        local url = nil

        if type(tbl) == "table" then
            url = tbl.Url or tbl.url
        elseif type(tbl) == "string" then
            url = tbl
        end

        if url then
            logUrl(url)
        end

        return old(tbl)
    end

    getgenv()[name] = hooked
end

hookRequestFunc("syn.request", syn and syn.request)
hookRequestFunc("request", request)
hookRequestFunc("http_request", http_request)
hookRequestFunc("http.request", http and http.request)
hookRequestFunc("fluxus.request", fluxus and fluxus.request)

print("[HTTP Monitor] initialized — watching all executor HTTP calls.")
