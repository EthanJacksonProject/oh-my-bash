# Minimal git prompt vars: branch name only, no status/stash/tracking/dirty check.
# Overrides oh-my-bash's git_prompt_vars (lib/omb-prompt-base.sh) which spawns
# 6-8 extra git/awk/grep/wc/tr subprocesses per prompt draw. Each spawn costs
# ~100-200ms on Windows/Git-Bash, so this trims well over a second off render.
# Respects theme-level color overrides (GIT_THEME_PROMPT_*) the same way the
# original function does, so formatting matches the active theme.
function git_prompt_vars {
  local ref
  ref=$(command git symbolic-ref --quiet --short HEAD 2>/dev/null) \
    || ref=$(command git rev-parse --short HEAD 2>/dev/null) \
    || return 1

  SCM_BRANCH="${SCM_THEME_BRANCH_PREFIX}${ref}"
  SCM_STATE=${GIT_THEME_PROMPT_CLEAN:-$SCM_THEME_PROMPT_CLEAN}
  SCM_DIRTY=0
  SCM_PREFIX=${GIT_THEME_PROMPT_PREFIX:-$SCM_THEME_PROMPT_PREFIX}
  SCM_SUFFIX=${GIT_THEME_PROMPT_SUFFIX:-$SCM_THEME_PROMPT_SUFFIX}
}