# ✅ Contribution Validation

Contributing often requires additional changes beyond the code itself. To ensure all contributions are properly integrated, we follow a series of validation steps.

---

## ⚙️ Automatic Validation

We use automated scripts to validate contributions whenever a pull request is opened or updated with new commits. These scripts check:
- Whether metadata is defined and up to date (see [metadata page](project:metadata.md))
- Whether the code passes all unit tests, ensuring no regressions (see [debug page](project:debug-tools.md#-unit-tests))

Bookshelf contributors can also manually run these checks locally using the following commands:
```sh
pdm run modules check
pdm run modules test
```

---

## 📄 Pull Request Template

When creating a pull request, contributors are provided with a checklist template to ensure no essential steps are overlooked. This checklist covers changes that cannot be automatically validated, such as:
- Updating the changelog with details about the contribution and the pull request ID
- Adding or updating documentation for new or existing features
- Including unit tests where applicable
- Linking the pull request to an existing issue

This checklist ensures contributions meet project standards before submission.

---

## 🔎 Manual Review

After automated checks, other Bookshelf contributors manually review the pull request. This review ensures:
- Code quality and alignment with project standards
- Adequate documentation and testing
- Compliance with the overall contribution guidelines

Once the review process is complete, the contribution is approved and merged.
