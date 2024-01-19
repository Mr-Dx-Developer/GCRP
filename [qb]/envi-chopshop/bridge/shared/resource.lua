resource = {}

---Resource Version
---@param name string
resource.version = function(name)
    local version = GetResourceMetadata(name, 'version', 0)
    return version
end