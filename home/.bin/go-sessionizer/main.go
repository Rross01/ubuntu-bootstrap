// This code was vibecoded, no guarantees
package main

import (
	"bytes"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"regexp"
	"strings"
)

var (
	home       = os.Getenv("HOME")
	dirsToFind = []string{
		home,
		filepath.Join(home, ".config"),
		filepath.Join(home, "temp"),
		filepath.Join(home, "places/git/personal"),
		filepath.Join(home, "places/git/work"),
		filepath.Join(home, "places/git/work/launchpad"),
		filepath.Join(home, "places/sys"),
	}
)

type sessionItem struct {
	name     string
	path     string
	isDir    bool
	attached bool
	windows  int
}

func main() {
	items := getTmuxSessions()
	items = append(items, getDirectories()...)
	items = prioritizeCurrentSession(items)

	selected := runFzf(items)
	if selected == nil {
		return
	}

	handleSelection(selected)
}

func prioritizeCurrentSession(items []sessionItem) []sessionItem {
	currentSessionIndex := -1
	var currentSession sessionItem

	for i, item := range items {
		if item.attached {
			currentSessionIndex = i
			currentSession = item
			break
		}
	}

	if currentSessionIndex != -1 {
		items = append(items[:currentSessionIndex], items[currentSessionIndex+1:]...)
		items = append([]sessionItem{currentSession}, items...)
	}

	return items
}

func getTmuxSessions() []sessionItem {
	var sessions []sessionItem

	cmd := exec.Command("tmux", "list-sessions", "-F", "#{session_name}||#{session_windows}||#{session_attached}")
	output, err := cmd.Output()
	if err != nil {
		return sessions
	}

	lines := strings.Split(strings.TrimSpace(string(output)), "\n")
	for _, line := range lines {
		parts := strings.Split(line, "||")
		if len(parts) < 3 {
			continue
		}

		session := sessionItem{
			name:  parts[0],
			isDir: false,
		}

		fmt.Sscanf(parts[1], "%d", &session.windows)
		session.attached = parts[2] == "1"
		sessions = append(sessions, session)
	}

	return sessions
}

func getDirectories() []sessionItem {
	var dirs []sessionItem

	for _, dir := range dirsToFind {
		entries, err := os.ReadDir(dir)
		if err != nil {
			continue
		}

		for _, entry := range entries {
			if entry.IsDir() {
				fullPath := filepath.Join(dir, entry.Name())
				dirs = append(dirs, sessionItem{
					name:  entry.Name(),
					path:  fullPath,
					isDir: true,
				})
			}
		}
	}

	return dirs
}

func buildDisplayLines(items []sessionItem) []string {
	lines := make([]string, len(items))
	for i, item := range items {
		if item.isDir {
			lines[i] = fmt.Sprintf("%s", item.path)
		} else {
			if item.attached {
				lines[i] = fmt.Sprintf(">> %s", item.name)
			} else {
				lines[i] = fmt.Sprintf("> %s", item.name)
			}
		}
	}
	return lines
}

func runFzf(items []sessionItem) *sessionItem {
	var input bytes.Buffer
	lines := buildDisplayLines(items)

	for _, line := range lines {
		fmt.Fprintln(&input, line)
	}

	cmd := exec.Command("fzf", "--bind=alt-k:up,alt-j:down", "--reverse", "--style=minimal")
	cmd.Stdin = &input
	cmd.Stderr = os.Stderr

	output, err := cmd.Output()
	if err != nil || len(output) == 0 {
		return nil
	}

	selectedLine := strings.TrimSpace(string(output))
	for i, line := range lines {
		if line == selectedLine {
			return &items[i]
		}
	}

	return nil
}

func handleSelection(item *sessionItem) {
	sessionName := item.name
	if item.isDir {
		sessionName = sanitizeSessionName(item.name)
		if !tmuxHasSession(sessionName) {
			createTmuxSession(sessionName, item.path)
		}
	}

	switchTmuxSession(sessionName)
}

func sanitizeSessionName(name string) string {
	reg := regexp.MustCompile(`[ .:]`)
	return strings.ToLower(reg.ReplaceAllString(name, "-"))
}

func tmuxHasSession(name string) bool {
	cmd := exec.Command("tmux", "has-session", "-t", name)
	return cmd.Run() == nil
}

func createTmuxSession(name, path string) {
	cmd := exec.Command("tmux", "new-session", "-d", "-s", name, "-c", path)
	cmd.Run()
}

func switchTmuxSession(name string) {
	cmd := exec.Command("tmux", "switch-client", "-t", name)
	cmd.Run()
}
