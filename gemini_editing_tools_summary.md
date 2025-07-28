# Gemini CLI: A Summary of File Editing Tools

This document provides a concise overview of the primary file editing tools available to the Gemini CLI agent, clarifying their intended use cases and observed behaviors based on recent experiments.

## 1. `write_file` Tool

*   **Primary Function:** To write content to a specified file. If the file exists, it will be completely overwritten. If the file doesn't exist, it (and any necessary parent directories) will be created.
*   **Key Characteristic:** This tool performs a **full overwrite** of the file's content.
*   **Observed Behavior (TUI):**
    *   When used to modify an existing file, the Gemini CLI's TUI performs an internal comparison between the file's state *before* and *after* the `write_file` operation.
    *   If differences are detected, the TUI automatically generates and displays a visual diff to the user *after* the tool call has been approved and executed.
    *   The user's control point for this tool is the initial approval of the `write_file` tool call itself, which includes the full content to be written. There is no pre-approval diff of the *changes* presented by the tool.
*   **Best Use Case (AI's Perspective):** Ideal for creating new files, or for overwriting existing files where the AI has constructed the entire desired content in memory and wants to assert that as the new state. It is also the underlying mechanism for the "read, modify in memory, overwrite" strategy that produces clean diffs in the TUI.

## 2. `replace` Tool

*   **Primary Function:** To replace specific occurrences of `old_string` with `new_string` within a file. By default, it replaces a single occurrence, but can replace multiple occurrences if `expected_replacements` is specified.
*   **Key Characteristic:** Requires an **exact, literal match** for the `old_string` (including all whitespace, line endings, and invisible characters).
*   **Observed Behavior (TUI):**
    *   When proposed, the TUI is designed to present a diff of the proposed change for user review *before* the modification is applied.
*   **Challenges/Limitations (Observed by AI):**
    *   Extremely brittle for multi-line modifications or when dealing with subtle formatting differences, as constructing an `old_string` that is a perfect, literal match is very difficult.
    *   Frequent failures due to "0 occurrences found" when the `old_string` does not match precisely.
*   **Best Use Case (AI's Perspective):** Best suited for very small, precise, single-line text substitutions where the `old_string` is unambiguous and easily matched. Less reliable for complex code modifications.

## 3. `edit_file` Tool

*   **Primary Function:** To make line-based edits to a text file. It takes a list of `edits`, where each edit specifies an `oldText` (the exact lines to be replaced) and `newText` (the lines to replace them with).
*   **Key Characteristic:** Designed to perform **in-place modifications** and, crucially, to **return a `git`-style diff** as part of its output. It supports a `dryRun` parameter.
*   **Observed Behavior (TUI):**
    *   When called with `dryRun=True`, the tool calculates the diff of the proposed changes and returns it. The Gemini CLI's TUI then presents this diff to the user for explicit approval *before* any changes are applied to the file on disk. This is the primary mechanism for pre-approval diffs.
    *   If approved, the tool is then called again with `dryRun=False` (or omitted) to apply the changes.
*   **Best Use Case (AI's Perspective):** The **preferred tool for precise, line-based code modifications** where user review and pre-approval of the exact changes are critical. It offers a robust way to perform edits while maintaining transparency and user control.

## Conclusion

The choice of editing tool depends on the specific task:
*   Use `write_file` for creating new files or for overwriting entire files with new content (especially when combined with a "read, modify in memory" strategy for clean diffs).
*   Use `replace` for very small, precise, single-line text substitutions.
*   Use `edit_file` for all other in-place code modifications, leveraging its `dryRun` feature for pre-approval diffs and ensuring user control.

This understanding will guide Gemini's future file modification operations to be more reliable and transparent.
