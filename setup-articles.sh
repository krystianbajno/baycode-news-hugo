rm -rf content/articles
git clone https://github.com/krystianbajno/articles.git content/articles

if [ -e "content/articles/.gitignore" ]; then
    rm content/articles/.gitignore
fi

for dir in content/articles/*/; do
    dir_name="${dir%/}"

    if [ -e "$dir_name/README.md" ]; then
        echo "+++" >> "$dir_name/index.md"
        cat "$dir_name/frontmatter.toml" >> "$dir_name/index.md"
        echo -e "\n+++\n" >> "$dir_name/index.md"
        cat "$dir_name/README.md" >> "$dir_name/index.md"

        rm "$dir_name/README.md"
        rm "$dir_name/frontmatter.toml"

        cat "$dir_name/index.md" | head -c 420
    fi

    if [ -e "$dir_name/src" ]; then
        rm -rf "$dir_name/src"
    fi
    
    echo "+ $dir_name"
done