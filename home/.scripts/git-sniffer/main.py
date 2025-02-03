import argparse
import logging
import os
import subprocess
from pathlib import Path

from plyer import notification


def find_git_repos(path: Path) -> list[Path]:
    git_repos = []
    for root, dirs, _files in os.walk(path):
        if ".git" in dirs:
            git_repos.append(Path(root))
            dirs[:] = []  # Не углубляемся дальше в подкаталоги
    return git_repos


def get_git_stdout(repo_path: Path) -> str:
    status = subprocess.run(
        ["/usr/bin/git", "status"],
        env={"LANG": "en_EN.UTF-8"},
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        check=True,
        cwd=repo_path,
    )
    return status.stdout


def has_uncommitted_changes(status_output: str) -> bool:
    return (
        "Changes not staged for commit" in status_output
        or "Untracked files" in status_output
    )


def has_unpushed_commits(status_output: str) -> bool:
    return "Your branch is ahead of" in status_output


def main(paths: list[Path]):
    repos_with_changes: list[Path] = []

    for path in paths:
        if not path.exists():
            logging.error("Путь не существует: %", path)
            continue

        git_repos = find_git_repos(path)
        for repo in git_repos:
            status_output = get_git_stdout(repo)
            if has_uncommitted_changes(status_output) or has_unpushed_commits(
                status_output,
            ):
                repos_with_changes.append(repo)

    if repos_with_changes:
        message = ",\n".join([repo.name for repo in repos_with_changes])
        notification.notify(
            title="GitSniffer: Найдены изменения",
            message=message,
            app_name="GitSniffer",
        )


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="GitSniffer: Утилита для поиска изменений в Git-репозиториях.",
    )
    parser.add_argument(
        "paths",
        nargs="+",
        help="Пути для сканирования (один или несколько)",
    )
    args = parser.parse_args()

    main([Path(path) for path in args.paths])
