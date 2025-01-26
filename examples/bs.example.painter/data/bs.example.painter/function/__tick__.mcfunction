# We use both an advancement and an objective for educational purposes and to handle potential limitations:
# - Advancements allow continuous usage but may fail with certain blocks like signs.
# - Scores work universally but cannot be used continuously.

# Run the use_brush function if the brush is used.
execute as @a[scores={bs.example.painter.use_brush=1..}] run function bs.example.painter:use_brush
