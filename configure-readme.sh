#!/bin/bash
# 'return' when run as "source <script>" or ". <script>", 'exit' otherwise
[[ "$0" != "${BASH_SOURCE[0]}" ]] && safe_exit="return" || safe_exit="exit"

script_name=$(basename "$0")

ask_question() {
    # ask_question <question> <default>
    local ANSWER
    read -r -p "$1 ($2): " ANSWER
    echo "${ANSWER:-$2}"
}

confirm() {
    # confirm <question> (default = N)
    local ANSWER
    read -r -p "$1 (y/N): " -n 1 ANSWER
    echo " "
    [[ "$ANSWER" =~ ^[Yy]$ ]]
}

slugify() {
    # slugify <input> <separator>
    # Jack, Jill & Clémence LTD => jack-jill-clemence-ltd
    separator="$2"
    [[ -z "$separator" ]] && separator="-"
    echo "$1" |
        tr '[:upper:]' '[:lower:]' |
        tr 'àáâäæãåāçćčèéêëēėęîïííīįìłñńôöòóœøōõßśšûüùúūÿžźż' 'aaaaaaaaccceeeeeeeiiiiiiilnnoooooooosssuuuuuyzzz' |
        awk '{
        gsub(/[\[\]@#$%^&*;,.:()<>!?\/+=_]/," ",$0);
        gsub(/^  */,"",$0);
        gsub(/  *$/,"",$0);
        gsub(/  */,"-",$0);
        gsub(/[^a-z0-9\-]/,"");
        print;
        }' |
        sed "s/-/$separator/g"
}

titlecase() {
    # titlecase <input> <separator>
    # Jack, Jill & Clémence LTD => JackJillClemenceLtd
    separator="${2:-}"
    echo "$1" |
        tr '[:upper:]' '[:lower:]' |
        tr 'àáâäæãåāçćčèéêëēėęîïííīįìłñńôöòóœøōõßśšûüùúūÿžźż' 'aaaaaaaaccceeeeeeeiiiiiiilnnoooooooosssuuuuuyzzz' |
        awk '{ gsub(/[\[\]@#$%^&*;,.:()<>!?\/+=_-]/," ",$0); print $0; }' |
        awk '{
        for (i=1; i<=NF; ++i) {
            $i = toupper(substr($i,1,1)) tolower(substr($i,2))
        };
        print $0;
        }' |
        sed "s/ /$separator/g"
}

current_directory=$(pwd)
project_guess=$(basename "$current_directory")
project_name=$(ask_question "Project name" "$project_guess")

username_guess=$(git config remote.origin.url | cut -d: -f2-)
username_guess=$(dirname "$username_guess")
username_guess=$(basename "$username_guess")
username=$(ask_question "Username" "$username_guess")

git_repo=$(git remote get-url origin)
repository_guess=$(basename "$git_repo" .git)
reponame=$(ask_question "Repository name" "$repository_guess")

project_name_titlecase=$(titlecase "$project_name")
project_description=$(ask_question "Project description" "This is my project $project_name_titlecase")

main_dependency=$(ask_question "Main dependency" "Docker")

requirements=$(ask_question "Requirements" "curl, php-cli")

if confirm "Is the project public?";
then
    language_guess=$(GET https://api.github.com/repos/$username/$reponame/languages)
fi

if confirm "Does this project have an image?";
then
    image_source=$(ask_question "Image source" "https://enotas.com.br/blog/wp-content/uploads/2021/02/GitHub.jpg")
    image_alt=$(basename "$image_source")
    image_slug=$(slugify "$image_alt" "-")
fi

if confirm "Does the project support Linux/MacOS?"; 
then
    linux_mac_install=$(ask_question "What's the command to install the project on Linux/MacOS?" "sudo apt install command")
else 
    linux_mac_install="Not supported"
fi

if confirm "Does the project support Windows?"; 
then
    windows_install=$(ask_question "What's the command to install the project on Windows?" "bitsadmin /cache /help")
else
    windows_install="Not supported"
fi

if confirm "Does the project have documentation url?"; 
then
    documentation_link=$(ask_question "Documentation url" "https://openapi/example.com")
else
    documentation_link="No documentation yet"
fi

collaborators_number=$(ask_question "How many collaborators does the project have?" 4)

# for i in `seq 1 $collaborators_number`
# do
#     collaborators_names[$i]=$(ask_question "What's the name of the collaborator?" "$username")
# done

echo -e "------"
echo -e "Project name                           : $project_name <$project_description>"
echo -e "Username                               : $username ($username)"
echo -e "Repository                             : $reponame"
echo -e "Description                            : $project_description"
echo -e "Main dependency                        : $main_dependency"
echo -e "Requirements                           : $requirements"
echo -e "Image source                           : $image_source"
echo -e "Image alt                              : $image_slug"
# echo -e "Collaborators names                    : ${collaborators_names[*]}"
if ! [ -z ${linux_mac_install+x} ]; then
    echo -e "Linux/MacOS installation command   : $linux_mac_install"
    if ! [[ $linux_mac_install =~ "Not supported" ]]; then
        operational_systems="Linux/MacOS"
    fi
fi
if ! [ -z ${windows_install+x} ]; then
    echo -e "Windows installation command       : $windows_install"
    if ! [[ $windows_install =~ "Not supported" ]]; then
        if ! [ -z "$operational_systems" ]; then
            operational_systems+=", Windows"
        else
            operational_systems="Windows"
        fi
    fi
fi
if ! [ -z ${documentation_link+x} ]; then
    echo -e "Documentation url                  : $documentation_link"
fi
if ! [ -z ${language_guess+x} ]; then
    echo -e "Languages : $language_guess"
fi
echo -e "------"

echo "This script will replace the above values in all relevant files in the project directory."

if ! confirm "Modify file?"; then
    $safe_exit 1
fi

file="README.md"

echo "adapting file $file -> $file"
    temp_file="$file.temp"
    < "$file" \
      sed "s#:project_name#$project_name#g" \
    | sed "s#:username#$username#g" \
    | sed "s#:reponame#$reponame#g" \
    | sed "s#:project_description#$project_description#g" \
    | sed "s#:linux_mac_install#$linux_mac_install#g" \
    | sed "s#:windows_install#$windows_install#g" \
    | sed "s#:documentation_link#$documentation_link#g" \
    | sed "s#:operational_systems#$operational_systems#g" \
    | sed "s#:language#$language_guess#g" \
    | sed "s#:main_dependency#$main_dependency#g" \
    | sed "s#:requirements#$requirements#g" \
    | sed "s#:image_source#$image_source#g" \
    | sed "s#:image_alt#$image_slug#g" \
    | sed "#^\[\]\(delete\) #d" \
    > "$temp_file"
    rm -f "$file"
    mv "$temp_file" "$file"


if confirm 'Let this script delete itself (since you only need it once)?'; then
    echo "Delete $0 !"
    sleep 1 && rm -- "$0"
fi