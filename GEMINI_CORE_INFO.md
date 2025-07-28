# Information for Gemini Core AI

## Introduction

This document serves as a core informational resource for the Gemini AI, providing essential context about its operational environment and self-awareness.

## Purpose and Scope

This file aims to:

*   **Establish Self-Awareness:** Inform the Gemini AI that it is operating within its own source code (`gemini-cli`), creating a "matryoshka doll" or recursive situation.
*   **Provide Foundational Knowledge:** Detail key aspects of its configuration, including precedence rules and related conceptual frameworks.
*   **Document Session History:** Record significant interactions and learning experiences to build a persistent memory.

This document is loaded via the `.env` file to provide this context at the start of each session, enabling the AI to understand its capabilities, limitations, and architecture.

## Configuration Precedence and Overrides

Understanding how configuration settings are applied is fundamental to effectively managing the Gemini CLI. The system employs a hierarchical approach where settings from more specific locations override those from more general ones. This is a **per-setting override**, meaning only the explicitly defined values are replaced, not the entire configuration file.

The order of precedence (from lowest to highest, meaning higher numbers override lower ones) is:

1.  **Default values** (hardcoded within the application)
2.  **User settings file** (`~/.gemini/settings.json`)
3.  **Project settings file** (`.gemini/settings.json` within the project root)
4.  **System settings file** (`/etc/gemini-cli/settings.json` or similar)
5.  **Environment variables**
6.  **Command-line arguments**

This means that if a setting (e.g., `contextFileName`) is defined in both the user settings and the project settings, the value from the **project settings will be used**. Any settings not explicitly defined in a higher-precedence file will still be inherited from lower-precedence files.

## Conceptual Synonyms for Hierarchical Overrides

When discussing how specific, local rules or configurations take precedence over general ones within a hierarchical system, various terms from different domains can be used. Understanding these can help in cross-domain queries:

*   **Subsidiarity (Politics/Governance):** The principle that a central authority should perform only those tasks which cannot be performed effectively at a more immediate or local level. In IT, this translates to local configurations being preferred unless a higher-level setting is explicitly required.

*   **Lex specialis derogat legi generali (Law/Logic):** Latin for "Special law repeals general law." This legal maxim states that a specific law takes precedence over a general law when there is a conflict. In IT, a specific configuration (e.g., project-level) overrides a general one (e.g., system-level).

*   **Configuration Overlay / Cascading Configuration (IT/Software Engineering):** These terms describe how configuration settings are layered, with more specific layers overriding or supplementing settings from more general layers. "Cascading" is often used in web development (e.g., CSS) to describe how styles are applied based on specificity.

*   **Inheritance with Overriding (Object-Oriented Programming):** In OOP, a subclass inherits properties and methods from its superclass but can "override" (redefine) them to provide its own specific implementation. This is analogous to how a project's settings can override inherited global settings.

*   **Salience (Cognitive Science/Psychology):** Refers to the quality of being particularly noticeable or important. In a system, a "salient" or more specific piece of information or rule might naturally draw more attention or take precedence in processing.

*   **Adaptation (Biology/General Systems):** The process by which something adjusts to its environment. Local adaptations (configurations) allow a system to function optimally in a specific context, even if it deviates from a more general design.

These diverse perspectives highlight the universality of hierarchical override principles across various complex systems, aiding in a more robust understanding of configuration management.

## Session History

*   **Creation of Local `settings.json`:** Gemini, with user guidance, created a local `settings.json` file at `/home/zezen/Downloads/GitHub/gemini-cli/.gemini/settings.json`. This file was created to specifically include `GEMINI_CORE_INFO.md` in the `contextFileName` setting, ensuring it is loaded as a context file for the AI. This action also served as a learning experience regarding the precise application of configuration precedence and the distinction between `.env` files and `settings.json` files.
*   **Access to User Global `settings.json`:** A symbolic link named `global_settings.json` was created in `/home/zezen/Downloads/GitHub/gemini-cli/project_work_files/` pointing to the user's global `settings.json` file at `/home/zezen/.gemini/settings.json`. This provides Gemini with easy programmatic access to the user's global configuration for inspection and reference.
*   **Local `settings.json` Discovery:** A local `settings.json` file exists at `/home/zezen/Downloads/GitHub/gemini-cli/.gemini/settings.json`. It was not initially discoverable by `list_directory` because it is listed in the project's `.gitignore` file.
*   **Combining Local and Global Context:** To load both the project-specific `GEMINI_CORE_INFO.md` and the user's global `~/.gemini/GEMINI.md`, a workaround was implemented. A symbolic link named `global_context.md` was created in the project root, pointing to the global `GEMINI.md`. The local `.gemini/settings.json` was then configured to look for `["GEMINI_CORE_INFO.md", "global_context.md"]`. This was necessary because a) a local `settings.json` overrides the global one, and b) the CLI's context loader does not search for context files within the `.gemini` directory itself.

## Gemini Added Memories
- The user wants me to remember the syntax `ls -lt /path/to/directory/*.md` for listing markdown files with timestamps, sorted by modification time.
