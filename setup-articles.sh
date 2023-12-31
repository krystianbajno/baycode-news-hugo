rm -rf content/articles
git clone https://github.com/krystianbajno/articles.git content/articles

if [ -e "content/articles/README.md" ]; then
    rm content/articles/README.MD
    rm content/articles/.gitignore
fi

for dir in content/articles/*/; do
    dir_name="${dir%/}"

    if [ -e "$dir_name/README.md" ]; then
        echo "+++" >> "$dir_name/index.md"
        cat "$dir_name/frontmatter.toml" >> "$dir_name/index.md"
        echo "\n+++\n" >> "$dir_name/index.md"
        cat "$dir_name/README.md" >> "$dir_name/index.md"

        rm "$dir_name/README.md"
        rm "$dir_name/frontmatter.toml"
    fi

    if [ -e "$dir_name/src" ]; then
        rm -rf "$dir_name/src"
    fi
    
    echo "+ $dir_name"
done