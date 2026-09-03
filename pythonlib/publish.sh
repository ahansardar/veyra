rm -rf ./dist
rm -rf ./veyra/*.mmdb
rm -rf ./veyra/*.png

vermin . --eval-annotations --target=3.8  --violations veyra/ || exit 1

python -m build
twine check dist/*

read -p "Confirm publish? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    twine upload dist/*
fi
