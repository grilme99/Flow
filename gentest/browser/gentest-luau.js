// based on: https://github.com/facebook/yoga/blob/v1.19.0/gentest/gentest-javascript.js

/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

var LuauEmitter = function () {
  Emitter.call(this, "luau", "    ");
};

function toValueLuau(value) {
  if (value.match(/^[0-9.e+-]+px$/i)) return parseFloat(value);
  if (value.match(/^[0-9.e+-]+%/i)) return JSON.stringify(value);
  if (value == "Flow.Auto") return '"auto"';
  return value;
}

function toLuauUpper(symbol) {
  var out = "";
  for (var i = 0; i < symbol.length; i++) {
    var c = symbol[i];
    if (
      c == c.toUpperCase() &&
      i != 0 &&
      symbol[i - 1] != symbol[i - 1].toUpperCase()
    ) {
      out += "_";
    }
    out += c.toUpperCase();
  }
  return out;
}

LuauEmitter.prototype = Object.create(Emitter.prototype, {
  constructor: { value: LuauEmitter },

  emitPrologue: {
    value: function () {
      this.push([
        "--!strict",
        "",
        'local ReplicatedStorage = game:GetService("ReplicatedStorage")',
        "",
        "local Packages = ReplicatedStorage.Packages",
        "local Flow = require(Packages.Flow)",
        // 'local Flow = require("../../packages/flow/src/init")',
        "",
      ]);
    },
  },

  emitTestPrologue: {
    value: function (name, experiments) {
      this.push("do");
      this.pushIndent();
      this.push(`print(${JSON.stringify(name)})`);
      this.push("local config = Flow.Config.new()");
      this.push("");

      if (experiments.length > 0) {
        for (var i in experiments) {
          this.push(
            "config:setExperimentalFeatureEnabled(Flow.ExperimentalFeature." +
              experiments[i] +
              ", true)"
          );
        }
        this.push("");
      }
    },
  },

  emitTestTreePrologue: {
    value: function (nodeName) {
      this.push("local " + nodeName + " = Flow.Node.new(config)");
    },
  },

  emitTestEpilogue: {
    value: function (_experiments) {
      this.push("root:freeRecursive()");
      this.push("config:free()");

      this.popIndent();
      this.push("end");
    },
  },

  emitEpilogue: {
    value: function () {
      this.push("");
      this.push("return nil");
      this.push("");
    },
  },

  AssertEQ: {
    value: function (v0, v1) {
      this.push(
        "assert(" +
          v0 +
          " == " +
          v1 +
          ', "' +
          v0 +
          " == " +
          v1 +
          ' (" .. ' +
          v1 +
          ' .. ")");'
      );
    },
  },

  YGAlignAuto: { value: "Flow.Align.Auto" },
  YGAlignCenter: { value: "Flow.Align.Center" },
  YGAlignFlexEnd: { value: "Flow.Align.FlexEnd" },
  YGAlignFlexStart: { value: "Flow.Align.FlexStart" },
  YGAlignStretch: { value: "Flow.Align.Stretch" },
  YGAlignSpaceBetween: { value: "Flow.Align.SpaceBetween" },
  YGAlignSpaceAround: { value: "Flow.Align.SpaceAround" },
  YGAlignBaseline: { value: "Flow.Align.Baseline" },

  YGDirectionInherit: { value: "Flow.Direction.Inherit" },
  YGDirectionLTR: { value: "Flow.Direction.LTR" },
  YGDirectionRTL: { value: "Flow.Direction.RTL" },

  YGEdgeBottom: { value: "Flow.Edge.Bottom" },
  YGEdgeEnd: { value: "Flow.Edge.End" },
  YGEdgeLeft: { value: "Flow.Edge.Left" },
  YGEdgeRight: { value: "Flow.Edge.Right" },
  YGEdgeStart: { value: "Flow.Edge.Start" },
  YGEdgeTop: { value: "Flow.Edge.Top" },

  YGFlexDirectionColumn: { value: "Flow.FlexDirection.Column" },
  YGFlexDirectionColumnReverse: {
    value: "Flow.FlexDirection.ColumnReverse",
  },
  YGFlexDirectionRow: { value: "Flow.FlexDirection.Row" },
  YGFlexDirectionRowReverse: { value: "Flow.FlexDirection.RowReverse" },

  YGJustifyCenter: { value: "Flow.Justify.Center" },
  YGJustifyFlexEnd: { value: "Flow.Justify.FlexEnd" },
  YGJustifyFlexStart: { value: "Flow.Justify.FlexStart" },
  YGJustifySpaceAround: { value: "Flow.Justify.SpaceAround" },
  YGJustifySpaceBetween: { value: "Flow.Justify.SpaceBetween" },
  YGJustifySpaceEvenly: { value: "Flow.Justify.SpaceEvenly" },

  YGOverflowHidden: { value: "Flow.Overflow.Hidden" },
  YGOverflowVisible: { value: "Flow.Overflow.Visible" },

  YGPositionTypeAbsolute: { value: "Flow.PositionType.Absolute" },
  YGPositionTypeRelative: { value: "Flow.PositionType.Relative" },

  YGAuto: { value: "Flow.Auto" },

  YGWrapNoWrap: { value: "Flow.Wrap.NoWrap" },
  YGWrapWrap: { value: "Flow.Wrap.Wrap" },
  YGWrapWrapReverse: { value: "Flow.Wrap.WrapReverse" },

  YGUndefined: { value: "nil" },

  YGDisplayFlex: { value: "Flow.Display.Flex" },
  YGDisplayNone: { value: "Flow.Display.None" },

  YGNodeCalculateLayout: {
    value: function (node, dir, experiments) {
      this.push(node + ":calculateLayout(nil, nil, " + dir + ")");
    },
  },

  YGNodeInsertChild: {
    value: function (parentName, nodeName, index) {
      this.push(parentName + ":insertChild(" + nodeName + ", " + index + ")");
    },
  },

  YGNodeLayoutGetLeft: {
    value: function (nodeName) {
      return nodeName + ":getComputedLeft()";
    },
  },

  YGNodeLayoutGetTop: {
    value: function (nodeName) {
      return nodeName + ":getComputedTop()";
    },
  },

  YGNodeLayoutGetWidth: {
    value: function (nodeName) {
      return nodeName + ":getComputedWidth()";
    },
  },

  YGNodeLayoutGetHeight: {
    value: function (nodeName) {
      return nodeName + ":getComputedHeight()";
    },
  },

  YGNodeStyleSetAlignContent: {
    value: function (nodeName, value) {
      this.push(nodeName + ":setAlignContent(" + toValueLuau(value) + ")");
    },
  },

  YGNodeStyleSetAlignItems: {
    value: function (nodeName, value) {
      this.push(nodeName + ":setAlignItems(" + toValueLuau(value) + ")");
    },
  },

  YGNodeStyleSetAlignSelf: {
    value: function (nodeName, value) {
      this.push(nodeName + ":setAlignSelf(" + toValueLuau(value) + ")");
    },
  },

  YGNodeStyleSetBorder: {
    value: function (nodeName, edge, value) {
      this.push(
        nodeName +
          ":setBorder(" +
          toValueLuau(edge) +
          ", " +
          toValueLuau(value) +
          ")"
      );
    },
  },

  YGNodeStyleSetDirection: {
    value: function (nodeName, value) {
      this.push(nodeName + ":setDirection(" + toValueLuau(value) + ")");
    },
  },

  YGNodeStyleSetDisplay: {
    value: function (nodeName, value) {
      this.push(nodeName + ":setDisplay(" + toValueLuau(value) + ")");
    },
  },

  YGNodeStyleSetFlexBasis: {
    value: function (nodeName, value) {
      this.push(nodeName + ":setFlexBasis(" + toValueLuau(value) + ")");
    },
  },

  YGNodeStyleSetFlexDirection: {
    value: function (nodeName, value) {
      this.push(nodeName + ":setFlexDirection(" + toValueLuau(value) + ")");
    },
  },

  YGNodeStyleSetFlexGrow: {
    value: function (nodeName, value) {
      this.push(nodeName + ":setFlexGrow(" + toValueLuau(value) + ")");
    },
  },

  YGNodeStyleSetFlexShrink: {
    value: function (nodeName, value) {
      this.push(nodeName + ":setFlexShrink(" + toValueLuau(value) + ")");
    },
  },

  YGNodeStyleSetFlexWrap: {
    value: function (nodeName, value) {
      this.push(nodeName + ":setFlexWrap(" + toValueLuau(value) + ")");
    },
  },

  YGNodeStyleSetHeight: {
    value: function (nodeName, value) {
      this.push(nodeName + ":setHeight(" + toValueLuau(value) + ")");
    },
  },

  YGNodeStyleSetJustifyContent: {
    value: function (nodeName, value) {
      this.push(nodeName + ":setJustifyContent(" + toValueLuau(value) + ")");
    },
  },

  YGNodeStyleSetMargin: {
    value: function (nodeName, edge, value) {
      this.push(
        nodeName +
          ":setMargin(" +
          toValueLuau(edge) +
          ", " +
          toValueLuau(value) +
          ")"
      );
    },
  },

  YGNodeStyleSetMaxHeight: {
    value: function (nodeName, value) {
      this.push(nodeName + ":setMaxHeight(" + toValueLuau(value) + ")");
    },
  },

  YGNodeStyleSetMaxWidth: {
    value: function (nodeName, value) {
      this.push(nodeName + ":setMaxWidth(" + toValueLuau(value) + ")");
    },
  },

  YGNodeStyleSetMinHeight: {
    value: function (nodeName, value) {
      this.push(nodeName + ":setMinHeight(" + toValueLuau(value) + ")");
    },
  },

  YGNodeStyleSetMinWidth: {
    value: function (nodeName, value) {
      this.push(nodeName + ":setMinWidth(" + toValueLuau(value) + ")");
    },
  },

  YGNodeStyleSetOverflow: {
    value: function (nodeName, value) {
      this.push(nodeName + ":setOverflow(" + toValueLuau(value) + ")");
    },
  },

  YGNodeStyleSetPadding: {
    value: function (nodeName, edge, value) {
      this.push(
        nodeName +
          ":setPadding(" +
          toValueLuau(edge) +
          ", " +
          toValueLuau(value) +
          ")"
      );
    },
  },

  YGNodeStyleSetPosition: {
    value: function (nodeName, edge, value) {
      this.push(
        nodeName +
          ":setPosition(" +
          toValueLuau(edge) +
          ", " +
          toValueLuau(value) +
          ")"
      );
    },
  },

  YGNodeStyleSetPositionType: {
    value: function (nodeName, value) {
      this.push(nodeName + ":setPositionType(" + toValueLuau(value) + ")");
    },
  },

  YGNodeStyleSetWidth: {
    value: function (nodeName, value) {
      this.push(nodeName + ":setWidth(" + toValueLuau(value) + ")");
    },
  },
});
