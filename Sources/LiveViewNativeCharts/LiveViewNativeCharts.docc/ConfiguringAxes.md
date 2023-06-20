# Configuring Axes

Use axis marks to customize the display of axes in a chart.

## Overview

An axis mark can be used within the ``AxisMarks`` element.
This element is used as the content of the ``ChartXAxisModifier`` and ``ChartYAxisModifier`` modifiers.

```html
<Chart modifiers={chart_x_axis(@native, content: :my_axes)}>
  ...
  <AxisMarks template={:my_axes}>
    <AxisGridLine />
  </AxisMarks>
</Chart>
```

Axis marks can be customized with modifiers.

## Topics

### Axis Mark Containers
- ``AxisMarks``

### Axis Mark Elements
- ``AxisGridLine``

### Modifiers
- ``FontModifier``
- ``ForegroundStyleModifier``
- ``OffsetModifier``
