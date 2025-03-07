# 👆 Component

**`#bs.component:help`**

Create graphical components in Minecraft easily.

```{epigraph}
"About ten years ago, most push buttons went "3D". Using shades of grey, they appear to pop out of the screen. This is not just to look cool: it's important because 3D buttons afford pushing."

-- Joel Spolsky
```

The Component API is a high-level API to create GUI components.
This API uses the Interaction API under the hood to create components and events.
You can fall back to the Interaction API to create more complex components.

---

## 🔧 Functions

You can find all available functions in this API below.

---

### Create Button

:::::{tab-set}
::::{tab-item} Block Display Button

```{function} #bs.component:create_block_button

Create a button represented by a block display.
The button triggers a given event when left-clicked and by default glows when hovered and plays a sound when clicked.

:Inputs:
  **Execution `at <position>`**: The position of the button.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`float` **width**: The width of the button. This will also be used as the width of the interaction hitbox.
    - {nbt}`float` **height**: The height of the button. This will also be used as the width of the interaction hitbox.
    - {nbt}`string` **on_click**: The event to trigger when the button is left-clicked.
    - {nbt}`string` **block**: The block to use to display the button.
    - {nbt}`compound` **properties**: The properties of the block to display. Same as block display NBT `properties`.
    - {nbt}`compound` **with**: Optional parameters.
      - {nbt}`string` **on_hover**: The event to trigger when the button is hovered. Glows the block by default.
      - {nbt}`string` **on_hover_leave**: The event to trigger when the mouse leaves the button. Unglows the block by default.
      - {nbt}`string` **tooltip**: The tooltip to display when the button is hovered. Should be a raw JSON text (see Text component format in the Minecraft Wiki). Displayed through the entity display name. Empty by default.
      - {nbt}`bool` **disabled**: If true, the button is disabled (unclickable). Defaults to `false`.
      - {nbt}`bool` **disabled_click_sound**: If false, disables the click sound when the button is disabled. Defaults to `true`.
      - {nbt}`bool` **click_sound**: If false, disables the click sound.
      - {nbt}`compound` **entity_data**: Other entity NBTs.
  :::

:Outputs:
  **State**: A clickable button, represented by the defined block display.
```

*Add a new button represented by a 1×1 slime block that triggers "say Clicked" when clicked:*

```mcfunction
function #bs.component:create_block_button { width: 1f, height: 1f, on_click: "say Clicked", block: "minecraft:slime_block", properties: {}, with: {} }
```
::::
::::{tab-item} Item Display Button

```{function} #bs.component:create_item_button

Create a button represented by an item display.
The button triggers a given event when left-clicked and by default glows when hovered and plays a sound when clicked.

:Inputs:
  **Execution `at <position>`**: The position of the button.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`float` **width**: The width of the button. This will also be used as the width of the interaction hitbox.
    - {nbt}`float` **height**: The height of the button. This will also be used as the width of the interaction hitbox.
    - {nbt}`string` **on_click**: The event to trigger when the button is left-clicked.
    - {nbt}`string` **item**: The item to use to display the button.
    - {nbt}`compound` **with**: Optional parameters.
      - {nbt}`string` **on_hover**: The event to trigger when the button is hovered. Glows the item by default.
      - {nbt}`string` **on_hover_leave**: The event to trigger when the mouse leaves the button. Unglows the item by default.
      - {nbt}`string` **tooltip**: The tooltip to display when the button is hovered. Should be a raw JSON text (see Text component format in the Minecraft Wiki). Displayed through the entity display name. Empty by default.
      - {nbt}`bool` **disabled**: If true, the button is disabled (unclickable). Defaults to `false`.
      - {nbt}`bool` **disabled_click_sound**: If false, disables the click sound when the button is disabled. Defaults to `true`.
      - {nbt}`bool` **click_sound**: If false, disables the click sound.
      - {nbt}`string` **item_display**: The model to display. Can be `none`, `thirdperson_lefthand`, `thirdperson_righthand`, `firstperson_lefthand`, `firstperson_righthand`, `head`, `gui`, `ground`, or `fixed`. Defaults to `none`.
      - {nbt}`compound` **item**: The properties of the item to display. Empty by default.
        - {nbt}`compound` **components**: The data components of the item. See Data component format in the Minecraft Wiki.
      - {nbt}`compound` **entity_data**: Other entity NBTs.
  :::

:Outputs:
  **State**: A clickable button, represented by the defined item display.
```

*Add a new button represented by a 1×1 slimeball that triggers "say Clicked" when clicked:*

```mcfunction
function #bs.component:create_item_button { width: 1f, height: 1f, on_click: "say Clicked", item: "minecraft:slimeball", with: {} }
```
::::
::::{tab-item} Text Display Button

```{function} #bs.component:create_text_button

Create a button represented by a text display.
The button triggers a given event when left-clicked and by default glows when hovered and plays a sound when clicked.

:Inputs:
  **Execution `at <position>`**: The position of the button.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`float` **width**: The width of the button. This will also be used as the width of the interaction hitbox.
    - {nbt}`float` **height**: The height of the button. This will also be used as the width of the interaction hitbox.
    - {nbt}`string` **on_click**: The event to trigger when the button is left-clicked.
    - {nbt}`string` **text**: The text to display on the button. Should be a raw JSON text (see Text component format in the Minecraft Wiki).
    - {nbt}`compound` **with**: Optional parameters.
      - {nbt}`string` **on_hover**: The event to trigger when the button is hovered. Glows the text by default.
      - {nbt}`string` **on_hover_leave**: The event to trigger when the mouse leaves the button. Unglows the text by default.
      - {nbt}`string` **tooltip**: The tooltip to display when the button is hovered. Should be a raw JSON text (see Text component format in the Minecraft Wiki). Displayed through the entity display name. Empty by default.
      - {nbt}`bool` **disabled**: If true, the button is disabled (unclickable). Defaults to `false`.
      - {nbt}`bool` **disabled_click_sound**: If false, disables the click sound when the button is disabled. Defaults to `true`.
      - {nbt}`bool` **click_sound**: If false, disables the click sound.
      - {nbt}`string` **alignment**: The alignment of the text. Can be `center`, `left`, or `right`. Defaults to `center`.
      - {nbt}`int` **background**: The background color of the text. Defaults to `1073741824`.
      - {nbt}`bool` **default_background**: If true, uses the default background color. Defaults to `false`.
      - {nbt}`int` **line_width**: The maximum width of the text (note: new lines can also be added with `\n` characters). Defaults to `200`.
      - {nbt}`bool` **see_through**: If true, the text can be seen through blocks. Defaults to `false`.
      - {nbt}`bool` **shadow**: If true, the text has a shadow. Defaults to `false`.
      - {nbt}`int` **text_opacity**: The opacity of the text. Defaults to `255` (completely opaque).
      - {nbt}`compound` **entity_data**: Other entity NBTs.
  :::

:Outputs:
  **State**: A clickable button, represented by the defined text display.
```

*Add a new button represented by the "Hello World!" text that triggers "say Hello World!" when clicked:*

```mcfunction
function #bs.component:create_text_button { width: 1f, height: 1f, on_click: "say Hello World!", text: "Hello World!", with: {} }
```
::::
:::::

> **Credits**: theogiraudet

---

### Create Checkbox

:::::{tab-set}
::::{tab-item} Block Display Checkbox

```{function} #bs.component:create_block_checkbox

Create a checkbox represented by a block display.
The checkbox can be selected or deselected and triggers a given event for each state.
By default, the checkbox is not selected, will glow when selected, unglow when deselected and play a sound when clicked.

:Inputs:
  **Execution `at <position>`**: The position of the checkbox.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`float` **width**: The width of the checkbox. This will also be used as the width of the interaction hitbox.
    - {nbt}`float` **height**: The height of the checkbox. This will also be used as the width of the interaction hitbox.
    - {nbt}`string` **on_selected**: The event to trigger when the checkbox is selected.
    - {nbt}`string` **on_deselected**: The event to trigger when the checkbox is deselected.
    - {nbt}`string` **block**: The block to use to display the checkbox.
    - {nbt}`compound` **properties**: The properties of the block to display. Same as block display NBT `properties`.
    - {nbt}`compound` **with**: Optional parameters.
      - {nbt}`string` **on_hover**: The event to trigger when the checkbox is hovered. Do nothing by default.
      - {nbt}`string` **on_hover_leave**: The event to trigger when the mouse leaves the checkbox. Do nothing by default.
      - {nbt}`bool` **selected**: If true, the checkbox is selected by default. Defaults to `false`.
      - {nbt}`bool` **disabled**: If true, the checkbox is disabled (unclickable). Defaults to `false`.
      - {nbt}`bool` **disabled_click_sound**: If false, disables the click sound when the checkbox is disabled. Defaults to `true`.
      - {nbt}`string` **tooltip**: The tooltip to display when the checkbox is hovered. Should be a raw JSON text (see Text component format in the Minecraft Wiki). Displayed through the entity display name. Empty by default.
      - {nbt}`bool` **click_sound**: If false, disables the click sound.
      - {nbt}`bool` **glow**: If true, the checkbox will glow when selected. Defaults to `true`.
      - {nbt}`compound` **entity_data**: Other entity NBTs.
  :::

:Outputs:
  **State**: A clickable checkbox, represented by the defined block display.
```

*Add a new checkbox represented by a 1×1 slime block that triggers "say Selected" when selected and "say Deselected" when deselected:*

```mcfunction
function #bs.component:create_block_checkbox { width: 1f, height: 1f, on_selected: "say Selected", on_deselected: "say Deselected", block: "minecraft:slime_block", properties: {}, with: {} }
```
::::
::::{tab-item} Item Display Checkbox

```{function} #bs.component:create_item_checkbox

Create a checkbox represented by an item display.
The checkbox can be selected or deselected and triggers a given event for each state.
By default, the checkbox is not selected, will glow when selected, unglow when deselected and play a sound when clicked.

:Inputs:
  **Execution `at <position>`**: The position of the checkbox.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`float` **width**: The width of the checkbox. This will also be used as the width of the interaction hitbox.
    - {nbt}`float` **height**: The height of the checkbox. This will also be used as the width of the interaction hitbox.
    - {nbt}`string` **on_selected**: The event to trigger when the checkbox is selected.
    - {nbt}`string` **on_deselected**: The event to trigger when the checkbox is deselected.
    - {nbt}`string` **item**: The item to use to display the checkbox.
    - {nbt}`compound` **with**: Optional parameters.
      - {nbt}`string` **on_hover**: The event to trigger when the checkbox is hovered. Do nothing by default.
      - {nbt}`string` **on_hover_leave**: The event to trigger when the mouse leaves the checkbox. Do nothing by default.
      - {nbt}`bool` **selected**: If true, the checkbox is selected by default. Defaults to `false`.
      - {nbt}`bool` **disabled**: If true, the checkbox is disabled (unclickable). Defaults to `false`.
      - {nbt}`string` **tooltip**: The tooltip to display when the checkbox is hovered. Should be a raw JSON text (see Text component format in the Minecraft Wiki). Displayed through the entity display name. Empty by default.
      - {nbt}`bool` **disabled_click_sound**: If false, disables the click sound when the checkbox is disabled. Defaults to `true`.
      - {nbt}`bool` **click_sound**: If false, disables the click sound.
      - {nbt}`bool` **glow**: If true, the checkbox will glow when selected. Defaults to `true`.
      - {nbt}`string` **item_display**: The model to display. Can be `none`, `thirdperson_lefthand`, `thirdperson_righthand`, `firstperson_lefthand`, `firstperson_righthand`, `head`, `gui`, `ground`, or `fixed`. Defaults to `none`.
      - {nbt}`compound` **item**: The properties of the item to display. Empty by default.
        - {nbt}`compound` **components**: The data components of the item. See Data component format in the Minecraft Wiki.
      - {nbt}`compound` **entity_data**: Other entity NBTs.
  :::

:Outputs:
  **State**: A clickable checkbox, represented by the defined item display.
```

*Add a new checkbox represented by a 1×1 slimeball that triggers "say Selected" when selected and "say Deselected" when deselected:*

```mcfunction
function #bs.component:create_item_checkbox { width: 1f, height: 1f, on_selected: "say Selected", on_deselected: "say Deselected", item: "minecraft:slimeball", with: {} }
```
::::
::::{tab-item} Text Display Checkbox

```{function} #bs.component:create_text_checkbox

Create a checkbox represented by a text display.
The checkbox can be selected or deselected and triggers a given event for each state.
By default, the checkbox is not selected, will glow when selected, unglow when deselected and play a sound when clicked.

:Inputs:
  **Execution `at <position>`**: The position of the checkbox.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`float` **width**: The width of the checkbox. This will also be used as the width of the interaction hitbox.
    - {nbt}`float` **height**: The height of the checkbox. This will also be used as the width of the interaction hitbox.
    - {nbt}`string` **on_selected**: The event to trigger when the checkbox is selected.
    - {nbt}`string` **on_deselected**: The event to trigger when the checkbox is deselected.
    - {nbt}`string` **text**: The text to display on the button. Should be a raw JSON text (see Text component format in the Minecraft Wiki).
    - {nbt}`compound` **with**: Optional parameters.
      - {nbt}`string` **on_hover**: The event to trigger when the checkbox is hovered. Do nothing by default.
      - {nbt}`string` **on_hover_leave**: The event to trigger when the mouse leaves the checkbox. Do nothing by default.
      - {nbt}`bool` **selected**: If true, the checkbox is selected by default. Defaults to `false`.
      - {nbt}`string` **tooltip**: The tooltip to display when the checkbox is hovered. Should be a raw JSON text (see Text component format in the Minecraft Wiki). Displayed through the entity display name. Empty by default.
      - {nbt}`bool` **disabled**: If true, the checkbox is disabled (unclickable). Defaults to `false`.
      - {nbt}`bool` **disabled_click_sound**: If false, disables the click sound when the checkbox is disabled. Defaults to `true`.
      - {nbt}`bool` **click_sound**: If false, disables the click sound.
      - {nbt}`bool` **glow**: If true, the checkbox will glow when selected. Defaults to `true`.
      - {nbt}`string` **alignment**: The alignment of the text. Can be `center`, `left`, or `right`. Defaults to `center`.
      - {nbt}`int` **background**: The background color of the text. Defaults to `1073741824`.
      - {nbt}`bool` **default_background**: If true, uses the default background color. Defaults to `false`.
      - {nbt}`int` **line_width**: The maximum width of the text (note: new lines can also be added with `\n` characters). Defaults to `200`.
      - {nbt}`bool` **see_through**: If true, the text can be seen through blocks. Defaults to `false`.
      - {nbt}`bool` **shadow**: If true, the text has a shadow. Defaults to `false`.
      - {nbt}`int` **text_opacity**: The opacity of the text. Defaults to `255` (completely opaque).
      - {nbt}`compound` **entity_data**: Other entity NBTs.
  :::

:Outputs:
  **State**: A clickable checkbox, represented by the defined text display.
```

*Add a new checkbox represented by the "Hello World!" text that triggers "say Selected" when selected and "say Deselected" when deselected:*

```mcfunction
function #bs.component:create_text_checkbox { width: 1f, height: 1f, on_selected: "say Selected", on_deselected: "say Deselected", text: "Hello World!", with: {} }
```
::::
:::::

> **Credits**: theogiraudet

---

### Create Radio Button

:::::{tab-set}
::::{tab-item} Block Display Radio Button

```{function} #bs.component:create_block_radio_button

Create a radio button represented by a block display.
By default, do nothing when clicked and must be put in a group to be functional.
When in group and selected, will glow and play a sound.
By default, the radio button is not deselected.

:Inputs:
  **Execution `at <position>`**: The position of the radio button.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`float` **width**: The width of the radio button. This will also be used as the width of the interaction hitbox.
    - {nbt}`float` **height**: The height of the radio button. This will also be used as the width of the interaction hitbox.
    - {nbt}`string` **on_selected**: The event to trigger when the radio button is selected.
    - {nbt}`string` **block**: The block to use to display the radio button.
    - {nbt}`compound` **properties**: The properties of the block to display. Same as block display NBT `properties`.
    - {nbt}`compound` **with**: Optional parameters.
      - {nbt}`string` **on_hover**: The event to trigger when the radio button is hovered. Do nothing by default.
      - {nbt}`string` **on_hover_leave**: The event to trigger when the mouse leaves the radio button. Do nothing by default.
      - {nbt}`bool` **selected**: If true, the radio button is selected by default. Defaults to `false`.
      - {nbt}`string` **tooltip**: The tooltip to display when the radio button is hovered. Should be a raw JSON text (see Text component format in the Minecraft Wiki). Displayed through the entity display name. Empty by default.
      - {nbt}`bool` **disabled**: If true, the radio button is disabled (unclickable). Defaults to `false`.
      - {nbt}`bool` **disabled_click_sound**: If false, disables the click sound when the radio button is disabled. Defaults to `true`.
      - {nbt}`bool` **click_sound**: If false, disables the click sound.
      - {nbt}`bool` **glow**: If true, the radio button will glow when selected. Defaults to `true`.
      - {nbt}`compound` **entity_data**: Other entity NBTs.
  :::

:Outputs:
  **State**: A clickable radio button, represented by the defined block display.
```

*Add a new radio button represented by a 1×1 slime block that triggers "say Selected" when selected and in a group with other radio buttons:*

```mcfunction
function #bs.component:create_block_radio_button { width: 1f, height: 1f, block: "minecraft:slime_block", properties: {}, with: {} }
```
::::
::::{tab-item} Item Display Radio Button

```{function} #bs.component:create_item_radio_button

Create a radio button represented by an item display.
By default, do nothing when clicked and must be put in a group to be functional.
When in group and selected, will glow and play a sound.
By default, the radio button is not deselected.

:Inputs:
  **Execution `at <position>`**: The position of the radio button.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`float` **width**: The width of the radio button. This will also be used as the width of the interaction hitbox.
    - {nbt}`float` **height**: The height of the radio button. This will also be used as the width of the interaction hitbox.
    - {nbt}`string` **on_selected**: The event to trigger when the radio button is selected.
    - {nbt}`string` **item**: The item to use to display the radio button.
    - {nbt}`compound` **with**: Optional parameters.
      - {nbt}`string` **on_hover**: The event to trigger when the radio button is hovered. Do nothing by default.
      - {nbt}`string` **on_hover_leave**: The event to trigger when the mouse leaves the radio button. Do nothing by default.
      - {nbt}`bool` **selected**: If true, the radio button is selected by default. Defaults to `false`.
      - {nbt}`string` **tooltip**: The tooltip to display when the radio button is hovered. Should be a raw JSON text (see Text component format in the Minecraft Wiki). Displayed through the entity display name. Empty by default.
      - {nbt}`bool` **disabled**: If true, the radio button is disabled (unclickable). Defaults to `false`.
      - {nbt}`bool` **disabled_click_sound**: If false, disables the click sound when the radio button is disabled. Defaults to `true`.
      - {nbt}`bool` **click_sound**: If false, disables the click sound.
      - {nbt}`bool` **glow**: If true, the radio button will glow when selected. Defaults to `true`.
      - {nbt}`string` **item_display**: The model to display. Can be `none`, `thirdperson_lefthand`, `thirdperson_righthand`, `firstperson_lefthand`, `firstperson_righthand`, `head`, `gui`, `ground`, or `fixed`. Defaults to `none`.
      - {nbt}`compound` **item**: The properties of the item to display. Empty by default.
        - {nbt}`compound` **components**: The data components of the item. See Data component format in the Minecraft Wiki.
      - {nbt}`compound` **entity_data**: Other entity NBTs.
  :::

:Outputs:
  **State**: A clickable radio button, represented by the defined item display.
```

*Add a new radio button represented by a 1×1 slimeball that triggers "say Selected" when selected and in a group with other radio buttons:*

```mcfunction
function #bs.component:create_item_radio_button { width: 1f, height: 1f, on_selected: "say Selected", item: "minecraft:slimeball", with: {} }
```
::::
::::{tab-item} Text Display Radio Button

```{function} #bs.component:create_text_radio_button

Create a radio button represented by a text display.
By default, do nothing when clicked and must be put in a group to be functional.
When in group and selected, will glow and play a sound.
By default, the radio button is not deselected.

:Inputs:
  **Execution `at <position>`**: The position of the radio button.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`float` **width**: The width of the radio button. This will also be used as the width of the interaction hitbox.
    - {nbt}`float` **height**: The height of the radio button. This will also be used as the width of the interaction hitbox.
    - {nbt}`string` **on_selected**: The event to trigger when the radio button is selected.
    - {nbt}`string` **text**: The text to display on the button. Should be a raw JSON text (see Text component format in the Minecraft Wiki).
    - {nbt}`compound` **with**: Optional parameters.
      - {nbt}`string` **on_hover**: The event to trigger when the radio button is hovered. Do nothing by default.
      - {nbt}`string` **on_hover_leave**: The event to trigger when the mouse leaves the radio button. Do nothing by default.
      - {nbt}`bool` **selected**: If true, the radio button is selected by default. Defaults to `false`.
      - {nbt}`string` **tooltip**: The tooltip to display when the radio button is hovered. Should be a raw JSON text (see Text component format in the Minecraft Wiki). Displayed through the entity display name. Empty by default.
      - {nbt}`bool` **disabled**: If true, the radio button is disabled (unclickable). Defaults to `false`.
      - {nbt}`bool` **disabled_click_sound**: If false, disables the click sound when the radio button is disabled. Defaults to `true`.
      - {nbt}`bool` **click_sound**: If false, disables the click sound.
      - {nbt}`bool` **glow**: If true, the radio button will glow when selected. Defaults to `true`.
      - {nbt}`string` **alignment**: The alignment of the text. Can be `center`, `left`, or `right`. Defaults to `center`.
      - {nbt}`int` **background**: The background color of the text. Defaults to `1073741824`.
      - {nbt}`bool` **default_background**: If true, uses the default background color. Defaults to `false`.
      - {nbt}`int` **line_width**: The maximum width of the text (note: new lines can also be added with `\n` characters). Defaults to `200`.
      - {nbt}`bool` **see_through**: If true, the text can be seen through blocks. Defaults to `false`.
      - {nbt}`bool` **shadow**: If true, the text has a shadow. Defaults to `false`.
      - {nbt}`int` **text_opacity**: The opacity of the text. Defaults to `255` (completely opaque).
      - {nbt}`compound` **entity_data**: Other entity NBTs.
  :::

:Outputs:
  **State**: A clickable radio button, represented by the defined text display.
```

*Add a new radio button represented by the "Hello World!" text that triggers "say Selected" when selected and "say Deselected" when deselected:*

```mcfunction
function #bs.component:create_text_radio_button { width: 1f, height: 1f, on_selected: "say Selected", text: "Hello World!", with: {} }
```
::::
:::::

> **Credits**: theogiraudet

---

### Radio Button Group

:::::{tab-set}
::::{tab-item} Group
```{function} #bs.component:create_radio_button_group

Create a radio button group from existing radio buttons.
In a group, only one radio button can be selected at a time, triggering its `on_selected` event.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`string` **id**: An unique identifier for the radio button group.
  - {nbt}`compound` **tag**: The tag that each radio button must have to be part of the group.
  :::

:Outputs:
  **State**: A radio button group.
```

*Add a new radio button group with two radio buttons:*

```mcfunction
# Create two radio buttons
function #bs.component:create_block_button { width: 1f, height: 1f, on_click: "say Clicked", block: "minecraft:slime_block", properties: {}, with: { entity_data: { Tags: [ "bs.radio_button" ]}}}
execute positioned ~2 ~ ~ run function #bs.component:create_block_button { width: 1f, height: 1f, on_click: "say Clicked", block: "minecraft:slime_block", properties: {}, with: { entity_data: { Tags: [ "bs.radio_button" ]}}}

# Create a radio button group
function #bs.component:create_radio_button_group { id: "my_radio_button_group", tag: "bs.radio_button" }
```
::::
::::{tab-item} Ungroup
```{function} #bs.component:ungroup

Ungroup a radio button group.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`string` **id**: The unique identifier of the radio button group to ungroup.
  :::

:Outputs:
  **State**: The radio button group (only) is removed.
```

*Ungroup a radio button group:*

```mcfunction
# Create two radio buttons
function #bs.component:create_block_radio_button { width: 1f, height: 1f, on_selected: "say Selected", block: "minecraft:slime_block", properties: {}, with: { entity_data: { Tags: [ "bs.radio_button" ]}}}
execute positioned ~2 ~ ~ run function #bs.component:create_block_radio_button { width: 1f, height: 1f, on_selected: "say Selected", block: "minecraft:slime_block", properties: {}, with: { entity_data: { Tags: [ "bs.radio_button" ]}}}

# Create a radio button group
function #bs.component:create_radio_button_group { id: "my_radio_button_group", tag: "bs.radio_button" }

# Ungroup the radio button group
function #bs.component:ungroup { id: "my_radio_button_group" }
```
::::
:::::

> **Credits**: theogiraudet

---

### Edit Component

:::::{tab-set}
::::{tab-item} Edit Button

```{function} #bs.component:edit_button

Change the properties of a button.

:Inputs:
  **Execution `as <entity>`**: The entity representing the button to edit.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`compound` **with**: Optional parameters.
      - {nbt}`string` **on_click**: The event to trigger when the button is left-clicked.
      - {nbt}`string` **on_hover**: The event to trigger when the button is hovered. Glows the block by default.
      - {nbt}`string` **on_hover_leave**: The event to trigger when the mouse leaves the button. Unglows the block by default.
      - {nbt}`string` **tooltip**: The tooltip to display when the button is hovered. Should be a raw JSON text (see Text component format in the Minecraft Wiki). Displayed through the entity display name. Empty by default.
      - {nbt}`bool` **disabled**: If true, the button is disabled (unclickable). Defaults to `false`.
      - {nbt}`bool` **disabled_click_sound**: If false, disables the click sound when the button is disabled. Defaults to `true`.
      - {nbt}`bool` **click_sound**: If false, disables the click sound.
  :::

  :Outputs:
    **State**: The button properties are changed.
```

*Change the `on_click` event of a button:*

```mcfunction
function #bs.component:create_block_button { width: 1f, height: 1f, on_click: "say Clicked", block: "minecraft:slime_block", properties: {}, with:  { entity_data: { Tags: [ "bs.button" ]}}}
execute as @e[tag=bs.button] run function #bs.component:edit_button { with: { on_click: "say Clicked new" }}
```
::::
::::{tab-item} Edit Checkbox
```{function} #bs.component:edit_checkbox

Change the properties of a checkbox.

:Inputs:
  **Execution `as <entity>`**: The entity representing the checkbox to edit.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`compound` **with**: Optional parameters.
      - {nbt}`string` **on_selected**: The event to trigger when the checkbox is selected.
      - {nbt}`string` **on_deselected**: The event to trigger when the checkbox is deselected.
      - {nbt}`string` **on_hover**: The event to trigger when the checkbox is hovered. Do nothing by default.
      - {nbt}`string` **on_hover_leave**: The event to trigger when the mouse leaves the checkbox. Do nothing by default.
      - {nbt}`string` **tooltip**: The tooltip to display when the checkbox is hovered. Should be a raw JSON text (see Text component format in the Minecraft Wiki). Displayed through the entity display name. Empty by default.
      - {nbt}`bool` **disabled**: If true, the checkbox is disabled (unclickable). Defaults to `false`.
      - {nbt}`bool` **disabled_click_sound**: If false, disables the click sound when the checkbox is disabled. Defaults to `true`.
      - {nbt}`bool` **click_sound**: If false, disables the click sound.
      - {nbt}`bool` **glow**: If true, the checkbox will glow when selected. Defaults to `true`.
  :::

  :Outputs:
    **State**: The checkbox properties are changed.
```

*Change the `on_selected` event of a checkbox:*

```mcfunction
function #bs.component:create_block_checkbox { width: 1f, height: 1f, on_selected: "say Selected", block: "minecraft:slime_block", properties: {}, with:  { entity_data: { Tags: [ "bs.checkbox" ]}}}
execute as @e[tag=bs.checkbox] run function #bs.component:edit_checkbox { with: { on_selected: "say Selected new" }}
```
::::
::::{tab-item} Edit Radio Button
```{function} #bs.component:edit_radio_button

Change the properties of a radio button.

:Inputs:
  **Execution `as <entity>`**: The entity representing the radio button to edit.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`compound` **with**: Optional parameters.
      - {nbt}`string` **on_selected**: The event to trigger when the radio button is selected.
      - {nbt}`string` **on_hover**: The event to trigger when the radio button is hovered. Do nothing by default.
      - {nbt}`string` **on_hover_leave**: The event to trigger when the mouse leaves the radio button. Do nothing by default.
      - {nbt}`string` **tooltip**: The tooltip to display when the radio button is hovered. Should be a raw JSON text (see Text component format in the Minecraft Wiki). Displayed through the entity display name. Empty by default.
      - {nbt}`bool` **disabled**: If true, the radio button is disabled (unclickable). Defaults to `false`.
      - {nbt}`bool` **disabled_click_sound**: If false, disables the click sound when the radio button is disabled. Defaults to `true`.
      - {nbt}`bool` **click_sound**: If false, disables the click sound.
      - {nbt}`bool` **glow**: If true, the radio button will glow when selected. Defaults to `true`.
  :::

  :Outputs:
    **State**: The radio button properties are changed.
```

*Change the `on_selected` event of a radio button:*

```mcfunction
function #bs.component:create_block_radio_button { width: 1f, height: 1f, on_selected: "say Selected", block: "minecraft:slime_block", properties: {}, with:  { entity_data: { Tags: [ "bs.radio_button" ]}}}
execute as @e[tag=bs.radio_button] run function #bs.component:edit_radio_button { with: { on_selected: "say Selected new" }}
```
::::
:::::

> **Credits**: theogiraudet

---

### Delete component

```{function} #bs.component:delete

Delete a component.

:Inputs:
  **Execution `as <entity>`**: The entity representing the component to delete.

:Outputs:
  **State**: The component and associated entities are deleted.
```

*Delete a component:*

```mcfunction
function #bs.component:create_block_radio_button { width: 1f, height: 1f, on_selected: "say Selected", block: "minecraft:slime_block", properties: {}, with: { entity_data: { Tags: [ "bs.radio_button" ]}}}
execute as @e[tag=bs.radio_button] run function #bs.component:delete
```
::::
:::::

> **Credits**: theogiraudet

---

## 👁️ Predicates

You can find below all predicates available in this module.

---

### Is Selected

**`bs.component:is_selected`**

Determine if a component is selected.

> **Credits**: theogiraudet

---

### Is Disabled

**`bs.component:is_disabled`**

Determine if a component is disabled.

> **Credits**: theogiraudet

---

<div id="gs-comments" align=center>

**💬 Did it help you?**

Feel free to leave your questions and feedbacks below!

</div>
