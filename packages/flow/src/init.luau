--!optimize 2
--!strict

local PackageRoot = script
local Packages = PackageRoot.Parent

local YogaSys = require(Packages.YogaSys)

local Config = require(PackageRoot.config)
local Node = require(PackageRoot.node)
local Utils = require(PackageRoot.utils)

local Flow = {}

local YogaEnums = YogaSys.YGEnum
Flow.Align = YogaEnums.YGAlign
export type Align = YogaSys.YGAlign
Flow.Dimension = YogaEnums.YGDimension
export type Dimension = YogaSys.YGDimension
Flow.Direction = YogaEnums.YGDirection
export type Direction = YogaSys.YGDirection
Flow.Display = YogaEnums.YGDisplay
export type Display = YogaSys.YGDisplay
Flow.Edge = YogaEnums.YGEdge
export type Edge = YogaSys.YGEdge
Flow.ExperimentalFeature = YogaEnums.YGExperimentalFeature
export type ExperimentalFeature = YogaSys.YGExperimentalFeature
Flow.FlexDirection = YogaEnums.YGFlexDirection
export type FlexDirection = YogaSys.YGFlexDirection
Flow.Justify = YogaEnums.YGJustify
export type Justify = YogaSys.YGJustify
Flow.LogLevel = YogaEnums.YGLogLevel
export type LogLevel = YogaSys.YGLogLevel
Flow.MeasureMode = YogaEnums.YGMeasureMode
export type MeasureMode = YogaSys.YGMeasureMode
Flow.NodeType = YogaEnums.YGNodeType
export type NodeType = YogaSys.YGNodeType
Flow.Overflow = YogaEnums.YGOverflow
export type Overflow = YogaSys.YGOverflow
Flow.PositionType = YogaEnums.YGPositionType
export type PositionType = YogaSys.YGPositionType
Flow.Unit = YogaEnums.YGUnit
export type Unit = YogaSys.YGUnit
Flow.Wrap = YogaEnums.YGWrap
export type Wrap = YogaSys.YGWrap

Flow.Config = Config
export type Config = Config.Config
Flow.Node = Node
export type Node = Node.Node

Flow.Size = Utils.Size
export type Size = Utils.Size
Flow.Value = Utils.Value
export type Value = Utils.Value
export type Layout = Utils.Layout

return Flow
