# Editing Tools Test Suite for Gemini CLI
Ver. 1.1

This document outlines a test suite for evaluating the behavior and effectiveness of file editing tools within the Gemini CLI, specifically focusing on `write_file`, `replace`, and `edit_file`. The tests aim to verify expected TUI feedback (diffs, prompts) and tool functionality under various conditions.

## Setup

1.  **Test Files:**
    *   Create a base file: `test_fable_base.md` with the following content:
        ```markdown
        # The Tale of the Wandering Words

        Once upon a time, in in a digital kingdom, there lived a brave little variable named `hero`.
        `hero` was always looking for adventure, but sometimes, `hero` would get lost.
        The wise old function, `guide_path`, always knew where `hero` should go.
        One day, `hero` decided to explore the `dark_forest` of the codebase.
        `guide_path` warned `hero` about the `shadow_bugs` lurking there.
        ```
    *   Create copies of this base file for each test case to ensure a clean slate:
        *   `test_case_write_file.md`
        *   `test_case_replace_exact.md`
        *   `test_case_replace_brittle.md`
        *   `test_case_edit_file_dryrun.md`
        *   `test_case_edit_file_execute.md`

## Test Cases

### Test Case 1: `write_file` (Full Overwrite with Minimal Transformation)

*   **Objective:** Verify that `write_file`, when used with a minimally transformed content, produces a clear diff in the TUI for post-operation review.
*   **File:** `test_case_write_file.md`
*   **Procedure:**
    1.  Read the content of `test_fable_base.md`.
    2.  Modify the content in memory to change every other line (as done in previous `fable.md` experiment).
    3.  Call `write_file` with the modified content and `file_path = "test_case_write_file.md"`.
*   **Expected Outcome:**
    *   The TUI displays a `write_file` tool call.
    *   Upon approval, the file is overwritten.
    *   The TUI then displays a clear, line-by-line diff showing the changes (insertions/deletions) between the original and modified content.
*   **Actual Result:** Worked as expected. The TUI showed the `WriteFile` tool call, a clear diff, and prompted for "Allow modification: Yes, No".
*   **Informal Observation:** This method worked splendidly, showing the right diffs and allowing user acceptance.

### Test Case 2: `replace` (Exact Match - Single Occurrence)

*   **Objective:** Verify that `replace` works correctly for a single, exact match and presents a pre-approval diff.
*   **File:** `test_case_replace_exact.md`
*   **Procedure:**
    1.  Call `replace` with `file_path = "test_case_replace_exact.md"`.
    2.  `old_string`: "brave little variable named `hero`." (including context)
    3.  `new_string`: "courageous variable known as `protagonist`."
*   **Expected Outcome:**
    *   The TUI displays a `replace` tool call.
    *   A clear, line-by-line diff of the proposed change is presented for pre-approval.
    *   Upon approval, the file is modified.
*   **Actual Result:** Worked as expected. The TUI showed the "Edit" tool call, a clear diff, and prompted for "Apply this change?".
*   **Informal Observation:** Worked, but showed "Edit" tool. This is the "brittle" way users complain about.

### Test Case 3: `replace` (Brittle Match - Multi-line, Subtle Difference)

*   **Objective:** Demonstrate the brittleness of `replace` with multi-line, subtle changes, expecting failure.
*   **File:** `test_case_replace_brittle.md`
*   **Procedure:**
    1.  Call `replace` with `file_path = "test_case_replace_brittle.md"`.
    2.  `old_string`: Attempt to replace a multi-line block with a slight, hard-to-match difference (e.g., an extra space, different line ending, or a subtle change in wording that makes the exact match fail).
    3.  `new_string`: The desired modified multi-line block.
*   **Expected Outcome:**
    *   The `replace` tool reports "0 occurrences found" or a similar failure message.
    *   No changes are applied to the file.
*   **Actual Result:** First attempt to fail unexpectedly succeeded (replacement worked). Second attempt (with intentionally omitted line) failed as planned, reporting "0 occurrences found".
*   **Informal Observation:** The `replace` tool's strict matching is indeed a source of brittleness and user complaints.

### Test Case 4: `edit_file` (Dry Run - Pre-approval Diff)

*   **Objective:** Verify that `edit_file` with `dryRun=True` correctly generates and displays a pre-approval diff without modifying the file.
*   **File:** `test_case_edit_file_dryrun.md`
*   **Procedure:**
    1.  Construct a list of `edits` (oldText/newText pairs) for `test_case_edit_file_dryrun.md` (e.g., changing "hero" to "protagonist" on multiple lines).
    2.  Call `edit_file` with `file_path = "test_case_edit_file_dryrun.md"`, the constructed `edits`, and `dryRun=True`.
*   **Expected Outcome:**
    *   The TUI displays an `edit_file` tool call with `dryRun=True`.
    *   A clear, `git`-style diff of the proposed changes is presented for pre-approval.
    *   The file `test_case_edit_file_dryrun.md` remains unchanged on disk.
*   **Actual Result:** Worked as expected. The TUI showed the `edit_file` tool call with `dryRun=True`, a clear diff, and prompted for "Apply this change?". The file remained unchanged on disk.
*   **Informal Observation:** All looks as expected. User accepts the tool usage, but notes it is non-interactive later (no added QC step).

### Test Case 5: `edit_file` (Execution - Apply Changes)

*   **Objective:** Verify that `edit_file` (without `dryRun` or with `dryRun=False`) correctly applies the changes after a successful dry run.
*   **File:** `test_case_edit_file_execute.md`
*   **Procedure:**
    1.  Construct the same list of `edits` as in Test Case 4.
    2.  Call `edit_file` with `file_path = "test_case_edit_file_execute.md"`, the constructed `edits`, and `dryRun=False`.
*   **Expected Outcome:**
    *   The TUI displays an `edit_file` tool call.
    *   Upon approval, the file is modified according to the `edits`.
    *   The TUI displays a post-operation diff summarizing the changes.
*   **Actual Result:** Worked as expected. The TUI showed the `edit_file` tool call, a clear diff, and prompted for "Apply this change?". The file was modified on disk.
*   **Informal Observation:** Very good!

## Cleanup

*   Delete all `test_case_*.md` files after the test suite is completed.