-- upstream: https://github.com/dead/typeflex/blob/422cb26/src/event.ts

-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/event/event.h
-- upstream: https://github.com/facebook/yoga/blob/v1.19.0/yoga/event/event.cpp

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

--!optimize 2
--!strict

local PackageRoot = script.Parent
local Packages = PackageRoot.Parent

local LuauPolyfill = require(Packages.LuauPolyfill)
local Array = LuauPolyfill.Array

local Types = require(PackageRoot.types)
type YGConfig = Types.YGConfig
type YGNode = Types.YGNode

local Enums = require(PackageRoot.enums)
type YGMeasureMode = Enums.YGMeasureMode

type Array<T> = { T }

local Event = {}

-- deviation: predefine functions and globals
local push: (newHead: Subscriber) -> Subscriber
local subscribers: Subscribers

local LayoutType = { kLayout = 1, kMeasure = 2, kCachedLayout = 3, kCachedMeasure = 4 }
export type LayoutType = number
Event.LayoutType = LayoutType

local LayoutPassReason = {
    kInitial = 1,
    kAbsLayout = 2,
    kStretch = 3,
    kMultilineStretch = 4,
    kFlexLayout = 5,
    kMeasureChild = 6,
    kAbsMeasureChild = 7,
    kFlexMeasure = 8,
}
export type LayoutPassReason = number
Event.LayoutPassReason = LayoutPassReason

type LayoutPassCounts = Array<number>
export type LayoutData = {
    layouts: number,
    measures: number,
    maxMeasureCache: number,
    cachedLayouts: number,
    cachedMeasures: number,
    measureCallbacks: number,
    measureCallbackReasonsCount: LayoutPassCounts,
}
local LayoutData = {}
LayoutData.__index = LayoutData

function LayoutData.new(
    layouts: number?,
    measures: number?,
    maxMeasureCache: number?,
    cachedLayouts: number?,
    cachedMeasures: number?,
    measureCallbacks: number?,
    measureCallbackReasonsCount: LayoutPassCounts?
): LayoutData
    local self = setmetatable({}, LayoutData)
    if layouts == nil then
        layouts = 0
    end
    if measures == nil then
        measures = 0
    end
    if maxMeasureCache == nil then
        maxMeasureCache = 0
    end
    if cachedLayouts == nil then
        cachedLayouts = 0
    end
    if cachedMeasures == nil then
        cachedMeasures = 0
    end
    if measureCallbacks == nil then
        measureCallbacks = 0
    end
    if measureCallbackReasonsCount == nil then
        measureCallbackReasonsCount = { 0, 0, 0, 0, 0, 0, 0, 0 }
    end
    self.layouts = layouts
    self.measures = measures
    self.maxMeasureCache = maxMeasureCache
    self.cachedLayouts = cachedLayouts
    self.cachedMeasures = cachedMeasures
    self.measureCallbacks = measureCallbacks
    self.measureCallbackReasonsCount = measureCallbackReasonsCount
    return (self :: any) :: LayoutData
end
Event.LayoutData = LayoutData

local function LayoutPassReasonToString(value: LayoutPassReason): string
    if value == LayoutPassReason.kInitial then
        return "initial"
    elseif value == LayoutPassReason.kAbsLayout then
        return "abs_layout"
    elseif value == LayoutPassReason.kStretch then
        return "stretch"
    elseif value == LayoutPassReason.kMultilineStretch then
        return "multiline_stretch"
    elseif value == LayoutPassReason.kFlexLayout then
        return "flex_layout"
    elseif value == LayoutPassReason.kMeasureChild then
        return "measure"
    elseif value == LayoutPassReason.kAbsMeasureChild then
        return "abs_measure"
    elseif value == LayoutPassReason.kFlexMeasure then
        return "flex_measure"
    end

    return "unknown"
end
Event.LayoutPassReasonToString = LayoutPassReasonToString

-- deviation: enum name is 'EventType' instead of 'Type' as it can't be defined
-- under the class in TypeScript and the naming is vague if left as-is.
local EventType = {
    NodeAllocation = 1,
    NodeDeallocation = 2,
    NodeLayout = 3,
    LayoutPassStart = 4,
    LayoutPassEnd = 5,
    MeasureCallbackStart = 6,
    MeasureCallbackEnd = 7,
    NodeBaselineStart = 8,
    NodeBaselineEnd = 9,
}
export type EventType = number
Event.EventType = EventType

type Subscriber = typeof(setmetatable({}, {
    __call = (function() end :: any) :: (_self: any, node: YGNode, type: EventType, data: any) -> (),
}))

type Subscribers = Array<Subscriber>

-- deviation: class name is 'YGEvent' instead of 'Event' to prevent name clash.
local YGEvent = {}
export type YGEvent = {}
YGEvent.__index = YGEvent

function YGEvent.new(): YGEvent
    local self = setmetatable({}, YGEvent)
    return (self :: any) :: YGEvent
end

function YGEvent.reset(): ()
    Array.splice(subscribers, 1, #subscribers)
end

function YGEvent.subscribe(subscriber: Subscriber): ()
    push(subscriber)
end

-- deviation: we expect 'eventType' in the public implementation of
-- 'publish' as we can't infer 'eventType' with just 'eventData' being
-- provided as it's an interface and not a class.
function YGEvent.publish(node: YGNode, eventType: EventType, eventData: EventData?): ()
    for _, subscriber in ipairs(subscribers) do
        subscriber(node, eventType, eventData)
    end
end
Event.YGEvent = YGEvent

export type EventData =
    NodeAllocationData
    | NodeDeallocationData
    | LayoutPassStartData
    | LayoutPassEndData
    | MeasureCallbackEndData
    | NodeLayoutData

export type NodeAllocationData = { config: YGConfig }

export type NodeDeallocationData = { config: YGConfig }

export type LayoutPassStartData = { layoutContext: any }

export type LayoutPassEndData = { layoutContext: any, layoutData: LayoutData }

export type MeasureCallbackEndData = {
    layoutContext: any,
    width: number,
    widthMeasureMode: YGMeasureMode,
    height: number,
    heightMeasureMode: YGMeasureMode,
    measuredWidth: number,
    measuredHeight: number,
    reason: LayoutPassReason,
}

export type NodeLayoutData = { layoutType: LayoutType, layoutContext: any }

-- deviation: use a list of subscribers instead of a reverse linked list for
-- tracking active subscribers to simplify implementation.
subscribers = {}

function push(newHead: Subscriber): Subscriber
    local oldHead: Subscriber = nil
    if #subscribers > 0 then
        oldHead = subscribers[#subscribers]
    end
    table.insert(subscribers, newHead)
    return oldHead
end

return Event
