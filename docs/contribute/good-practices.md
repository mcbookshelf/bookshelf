# 🛡️ Good Practices

Bookshelf's development emphasizes collaboration, clarity, and efficiency. By following these guidelines, you can help maintain a high standard of code that is accessible, understandable, and non-intrusive.

---

## 💬 Commenting Code

Bookshelf is a collaborative project designed to be both pedagogical and accessible. This means the code is not only functional but also understandable by developers and curious users alike.

To achieve this, **commenting your code regularly and cleanly** is essential:

- Explain the purpose of each function and its key components
- Ensure comments are concise but provide enough context for others
- Update comments when the functionality changes to avoid confusion

Clear comments contribute to a smoother collaboration and make Bookshelf easier to learn from.

---

## ♻️ Conservation Principle

Bookshelf follows a conservation principle inspired by Antoine Lavoisier's maxim:

```{pull-quote}
"Nothing is lost, nothing is created, everything is transformed"

-- Antoine Lavoisier
```

This principle minimizes interference with scores and other data, aiming to prevent accidental overwrites or unnecessary operations.

### Key Guidelines:

- **Minimize the creation of new scores**: Use existing ones whenever possible
- **Strictly avoid score deletion**: Instead, repurpose scores or reset their values if necessary
- **Reduce unnecessary score rewrites**: Only update scores when absolutely required

Each function should handle inputs responsibly, ensuring that only outputs are altered.
