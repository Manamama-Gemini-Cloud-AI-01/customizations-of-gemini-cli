# How to Modify the Gemini CLI System Message
Ver. 3.1

# Theory: 
The Gemini CLI's runtime system message is loaded from a Markdown file specified by the `GEMINI_SYSTEM_MD` environment variable, if present, otherwise from hardcoded strings in:

packages/core/src/core/prompts.ts

/data/data/com.termux/files/home/downloads/GitHub/gemini-cli/packages/core/src/core/prompts.ts.md

 
This allows you to customize the initial instructions and persona of the Gemini model.

## Steps to Modify the System Message:

1.  **Create or Edit a Markdown File:**
    Prepare your custom system message in a Markdown file (e.g., `my_custom_system_message.md`).

    **Example `my_custom_system_message.md` content:**
    ```markdown
    You are a helpful and creative AI assistant. Your goal is to provide concise and accurate answers.
    ```

2.  **Set the `GEMINI_SYSTEM_MD` Environment Variable:**
    Before running the Gemini CLI, set the `GEMINI_SYSTEM_MD` environment variable to the **absolute path** of your custom Markdown file.

    *   **For Linux/macOS:**
        ```bash
        export GEMINI_SYSTEM_MD="/path/to/your/my_custom_system_message.md"
        ./gemini-cli
        ```

    *   **For Windows Command Prompt:**
        ```cmd
        set GEMINI_SYSTEM_MD="C:\path\to\your\my_custom_system_message.md"
        gemini-cli.exe
        ```

    *   **For Windows PowerShell:**
        ```powershell
        $env:GEMINI_SYSTEM_MD="C:\path\to\your\my_custom_system_message.md"
        ./gemini-cli.exe
        ```

    Replace `/path/to/your/my_custom_system_message.md` or `C:\path\to\your\my_custom_system_message.md` with the actual absolute path to your file.

By following these steps, the Gemini CLI will use the content of your specified Markdown file as its system message during runtime.

## Understanding System Prompt Logic

### Loading a Custom Prompt (`GEMINI_SYSTEM_MD`)

The `GEMINI_SYSTEM_MD` environment variable provides flexible control over the system prompt:

*   **Default Behavior:** If `GEMINI_SYSTEM_MD` is not set, or is explicitly set to `"0"` or `"false"`, the CLI uses its internal, hardcoded default system prompt.
*   **Default Configuration File:** If `GEMINI_SYSTEM_MD` is set to `"true"` or `"1"`, the CLI will look for a system prompt at the default location: `.gemini/system.md`.
    *   **Important:** This file **must exist**. If it does not, the CLI will throw an error.
    *   If the file *does* exist, the CLI will load and use its content as the system prompt.
*   **Custom File Path:** If `GEMINI_SYSTEM_MD` is set to a file path (e.g., `"/path/to/my_prompt.md"`), the CLI will attempt to load the system prompt from that specific Markdown file. The path can be absolute or relative, and it supports tilde expansion (e.g., `~/my_prompt.md`). An error will be thrown if the specified file does not exist.

### Writing the Default Prompt (`GEMINI_WRITE_SYSTEM_MD`)

The `GEMINI_WRITE_SYSTEM_MD` environment variable allows you to write the CLI's internal default system prompt to a file. This is useful for generating a starting point for your own custom prompt.

*   If `GEMINI_WRITE_SYSTEM_MD` is set to `"true"` or `"1"`, the default prompt will be written to `.gemini/system.md`.
*   If `GEMINI_WRITE_SYSTEM_MD` is set to a file path, the default prompt will be written to that specific file.

## Procedure for Modifying the Default System Prompt

If you want to modify the default system prompt, follow these steps:

1.  **Generate the Default `system.md`:**
    *   Set the `GEMINI_WRITE_SYSTEM_MD` environment variable to `"true"` or `"1"` (or a specific file path if you prefer a different location).
        *   Example (Linux/macOS): `export GEMINI_WRITE_SYSTEM_MD="true"`
        *   Example (Windows PowerShell): `$env:GEMINI_WRITE_SYSTEM_MD="1"`
    *   Run the Gemini CLI. This will create the `.gemini/system.md` file in your project's root directory (or your specified path) populated with the default system prompt.

2.  **Locate and Edit `system.md`:**
    *   Find the newly created or existing file at `.gemini/system.md` (or your custom path).
    *   Open this file in your preferred text editor.
    *   Modify the content of `system.md` to customize the system prompt according to your needs.

3.  **Save and Restart with `GEMINI_SYSTEM_MD`:**
    *   Save the changes to the `system.md` file.
    *   Set the `GEMINI_SYSTEM_MD` environment variable to `"true"` or `"1"` (or the custom file path you used in step 1).
        *   Example (Linux/macOS): `export GEMINI_SYSTEM_MD="true"`
        *   Example (Windows PowerShell): `$env:GEMINI_SYSTEM_MD="1"`
    *   Restart the Gemini CLI. The CLI will now load and use your modified system prompt from `.gemini/system.md` for all subsequent interactions.



# Practice: 
It works for the User. 
