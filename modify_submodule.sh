#!/bin/bash

submodules=($(git config --file .gitmodules --get-regexp path . | cut -d " " -f 2))

mkdir _locale_tmp
for submodule in ${submodules[@]}; do
    if [[ ${submodule} = *locale* ]]; then
        mv ${submodule} _locale_tmp/
        git submodule deinit ${submodule}
        git rm -r --cached ${submodule}
        rm -rf ${submodule}
        mv ${submodule/locale/locale_tmp} ${submodule}
        rm -rf ${submodule}/.git
        git add ${submodule}
        git add -f ${submodule}/_episodes
    fi
done

git commit -m "adds ${#submodules[@]} submodules within the repository: ${submodules[@]}"
rm -rf _locale_tmp
