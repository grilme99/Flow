-- upstream: https://github.com/dead/typeflex/blob/422cb26/tests/tools.js

-- upstream: https://github.com/facebook/yoga/blob/342aebe1d73e5770a1862b6a94c6b877c1439a9b/javascript/tests/tools.js

--[[
	MIT License

Copyright (c) Facebook, Inc. and its affiliates.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Flow = require(Packages.Flow)

type MeasureMode = Flow.MeasureMode

local Tools = {}

function Tools.getMeasureCounter(
    cb: (
        (number, MeasureMode, number, MeasureMode) -> { width: number?, height: number? }
    )?,
    staticWidth: number?,
    staticHeight: number?
)
    local counter = 0

    return {
        inc = function(width: number, widthMode: MeasureMode, height: number, heightMode: MeasureMode)
            counter += 1
            if cb then
                return cb(width, widthMode, height, heightMode)
            else
                return { width = staticWidth, height = staticHeight }
            end
        end,

        get = function()
            return counter
        end,
    }
end

function Tools.getMeasureCounterMax()
    return Tools.getMeasureCounter(function(width, widthMode, height, heightMode)
        local measuredWidth = if widthMode == Flow.MeasureMode.Undefined then 10 else width
        local measuredHeight = if heightMode == Flow.MeasureMode.Undefined then 10 else height

        return { width = measuredWidth, height = measuredHeight }
    end)
end

function Tools.getMeasureCounterMin()
    return Tools.getMeasureCounter(function(width, widthMode, height, heightMode)
        local measuredWidth = if widthMode == Flow.MeasureMode.Undefined
                or (widthMode == Flow.MeasureMode.AtMost and width > 10)
            then 10
            else width
        local measuredHeight = if heightMode == Flow.MeasureMode.Undefined
                or (heightMode == Flow.MeasureMode.AtMost and height > 10)
            then 10
            else height

        return { width = measuredWidth, height = measuredHeight }
    end)
end

return Tools
