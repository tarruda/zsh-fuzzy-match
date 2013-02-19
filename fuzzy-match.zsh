### this plugin contains snippets/ideas taken from zaw (github.com/zsh-users/zaw)
function () {

zmodload zsh/parameter
autoload -U is-at-least

local this_file="${funcsourcetrace[1]%:*}"
if is-at-least 4.3.10; then
    # "A" flag (turn a file name into an absolute path with symlink
    # resolution) is only available on 4.3.10 and latter
    local cur_dir="${this_file:A:h}"
else
    local cur_dir="${this_file:h}"
fi
fpath+=("${cur_dir}/functions")

local file
for file in "$cur_dir/functions/"*(.); do
	autoload -U ${file:t}
	${file:t}
done

local default_keys='^T' map

for map in emacs viins vicmd; do
	bindkey -M $map | grep -q 'fuzzy-match' || bindkey -M $map $default_keys fuzzy-match
done

}
