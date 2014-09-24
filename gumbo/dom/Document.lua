local Element = require "gumbo.dom.Element"
local Text = require "gumbo.dom.Text"
local Comment = require "gumbo.dom.Comment"
local util = require "gumbo.dom.util"

local Document = util.merge("Node", "NonElementParentNode", {
    type = "document",
    nodeName = "#document",
    nodeType = 9,
    contentType = "text/html",
    characterSet = "UTF-8",
    URL = "about:blank"
})

local getters = {}

function getters:documentURI()
    return self.URL
end

function getters:firstChild()
    return self.childNodes[1]
end

function getters:lastChild()
    local cnodes = self.childNodes
    return cnodes[#cnodes]
end

function getters:compatMode()
    if self.quirksMode == "quirks" then
        return "BackCompat"
    else
        return "CSS1Compat"
    end
end

function Document:__index(k)
    if type(k) == "number" then
        return self.childNodes[k]
    end
    local field = Document[k]
    if field then
        return field
    else
        local getter = getters[k]
        if getter then
            return getter(self)
        end
    end
end

function Document:createElement(localName)
    if not string.find(localName, "^[A-Za-z:_][A-Za-z0-9:_.-]*$") then
        return error("InvalidCharacterError")
    end
    return setmetatable({localName = localName:lower()}, Element)
end

function Document:createTextNode(data)
    return setmetatable({data = data}, Text)
end

function Document:createComment(data)
    return setmetatable({data = data}, Comment)
end

return Document
