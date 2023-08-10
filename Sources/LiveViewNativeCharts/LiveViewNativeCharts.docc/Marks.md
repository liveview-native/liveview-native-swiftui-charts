# Marks

Use marks to display data in a chart.

## Overview

A mark is a basic building block of a chart. Combine marks within a ``Chart`` to display complex data.

Each mark represents a single item to plot. To display many values in a chart, such as a series of lines, use a for loop.

Value should be provided via attributes such as `x` and `y`. Any value must have a `label` as well.
If no label is provided, it is assumed to be a fixed numeric value.

```html
<%= for item <- @data do %>
  <BarMark
    x={item.department}
    x:label="Department"

    y={item.profit}
    y:label="Profit"
  />
<% end %>
```

Each mark supports different values. These attributes are detailed in their documentation.

## Topics

### Mark Elements
- ``Charts/AreaMark``
- ``Charts/BarMark``
- ``Charts/LineMark``
- ``Charts/PointMark``
- ``Charts/RectangleMark``
- ``Charts/RuleMark``

### Grouping Marks
- ``Plot``

### Modifiers
- ``ForegroundStyleModifier``
- ``OffsetModifier``
- ``SymbolModifier``
