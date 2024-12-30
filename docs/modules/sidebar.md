# 📰 Sidebar

**`#bs.sidebar:help`**

Create a visually appealing and dynamic sidebar using the scoreboard.

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Create

```{function} #bs.sidebar:create

Create and register a new sidebar.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **objective**: An objective used for the sidebar.
    - {nbt}`string` **display_name**: Displayed objective name. Must be a valid JSON text component.
    - {nbt}`list` **contents**: Lines displayed on the sidebar.
      - {nbt}`list` {nbt}`string`: Must either be a valid JSON text component or an array with two JSON text components for the left and right sides.
  :::
```

*Create and display a new sidebar with left-aligned text:*
```{code-block} mcfunction
:force:
# Create a new sidebar
function #bs.sidebar:create { \
    objective: "my_guessing_game", \
    display_name: '{"text":"Guess my name"}', \
    contents: [ \
        '{"text":" Clues:","color":"gold","bold":true}', \
        '{"text":"  • I gave my name to a famous test"}', \
        '{"text":"  • I am a pioneer of computer science and AI"}', \
        '[{"text":" My name is: "},{"score":{"objective":"enigma","name":"VHVyaW5n"}}]', \
    ], \
}

# Display the sidebar
scoreboard objectives setdisplay sidebar my_guessing_game
```

*Create and display a new sidebar with right-aligned text:*
```{code-block} mcfunction
:force:
# Create a new sidebar
function #bs.sidebar:create { \
    objective: "my_guessing_game_2", \
    display_name: '{"text":"Guess my name V2"}', \
    contents: [ \
        ['""','{"text":" Clues:","color":"gold","bold":true}'], \
        ['""','{"text":"  • I gave my name to a famous test"}'], \
        ['""','{"text":"  • I am a pioneer of computer science and AI"}'], \
        ['""','[{"text":" My name is: "},{"score":{"objective":"enigma","name":"VHVyaW5n"}}]'], \
    ], \
}

# Display the sidebar
scoreboard objectives setdisplay sidebar my_guessing_game_2
```

> **Credits**: Aksiome

---

### Refresh

```{function} #bs.sidebar:refresh

Update dynamic parts of the sidebar.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **objective**: The objective for the sidebar to refresh.
  :::
```

*Refresh a sidebar:*
```mcfunction
function #bs.sidebar:refresh {objective:"my_guessing_game"}
```

> **Credits**: Aksiome

---

<div id="gs-comments" align=center>

**💬 Did it help you?**

Feel free to leave your questions and feedbacks below!

</div>
