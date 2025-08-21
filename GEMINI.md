## How to answer "what have been the new features in the updates"

To answer questions about new features in updates, I will use the following method:

1.  I will first attempt to locate a `CHANGELOG.md` or `RELEASES.md` file in the repository.
2.  If I cannot find a release file, I will use the `github.list_tags` tool to identify the most recent release tags.
3.  I will then use the `github.list_commits` tool to get the commits associated with each of the last two release tags.
4.  I will then summarize the changes for each release based on the commit messages between the two tags.
5.  If I cannot determine the releases from the tags, I will use `git log` to find the release commits and summarize the changes between them.
