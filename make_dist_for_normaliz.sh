#!/bin/bash

# This script needs a github shell access token in the file ~/.github_shell_token
# It also needs the gap remote of the gh-pages repo to be the gap-system repository

current_dir=$(pwd)

function jsonval {
    temp=`echo $release_response | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w id`
    echo ${temp##*|}
}

curl -X GET https://api.github.com/repos/gap-packages/NormalizInterface/releases > json_data

echo $(cat json_data)

mkdir -p tmp
git archive --format=tar --output=tmp/NormalizInterface.tar --prefix=NormalizInterface/ HEAD
cd tmp
tar xf NormalizInterface.tar
cd NormalizInterface

version=$(cat VERSION)

gap -A <<GAPInput
SetPackagePath("NormalizInterface", ".");
Read("makedoc.g");
GAPInput

echo "Deleting unnecessary stuff"

rm -rf .git*
rm -f doc/*.{aux,bbl,blg,brf,idx,ilg,ind,lab,log,out,pnr,tex,toc,tst}
rm -rf bin/
rm -rf public_html

echo "Going back"

cd ..


oauth_token=$(cat ~/.github_shell_token)

tag_response=$(curl -X GET https://api.github.com/repos/gap-packages/NormalizInterface/releases/tags/v${version}?access_token=${oauth_token} | grep "Not Found")
echo "Tag response: ${tag_response}"
if [ -n "$tag_response" ]; then
    
    release_response=$(curl -H "Content-Type: application/json" -X POST --data \
    '{ "tag_name": "'v${version}'", "target_commitish": "master", "name": "'v${version}'", "body": "Release for 'NormalizInterface'", "draft": false, "prerelease": false }' \
    https://api.github.com/repos/gap-packages/NormalizInterface/releases?access_token=${oauth_token})
    
    echo "Release response: ${release_response}"
    
    release_id=$(jsonval | sed "s/id:/\n/g" | sed -n 2p | sed "s| ||g")
    
    tar czvf NormalizInterface-${version}.tar.gz NormalizInterface
    curl --fail -s -S -X POST https://uploads.github.com/repos/gap-packages/NormalizInterface/releases/${release_id}/assets?name=NormalizInterface-${version}.tar.gz \
        -H "Accept: application/vnd.github.v3+json" \
        -H "Authorization: token ${oauth_token}" \
        -H "Content-Type: application/tgz" \
        --data-binary @"NormalizInterface-${version}.tar.gz"
    
    rm NormalizInterface-${version}.tar.gz
    
    zip -r NormalizInterface-${version}.zip NormalizInterface
    curl --fail -s -S -X POST https://uploads.github.com/repos/gap-packages/NormalizInterface/releases/${release_id}/assets?name=NormalizInterface-${version}.zip \
        -H "Accept: application/vnd.github.v3+json" \
        -H "Authorization: token ${oauth_token}" \
        -H "Content-Type: application/zip" \
        --data-binary @"NormalizInterface-${version}.zip"
    
    rm NormalizInterface-${version}.zip
    
fi

echo "Updating website"

cd ${current_dir}
rm -rf tmp

rm json_data

cd gh-pages
git add *tar.gz
cp -f ../PackageInfo.g README.md .

cp -f ../doc/*.{css,html,js,txt} doc/
gap update.g
git add PackageInfo.g README.md doc/ _data/package.yml
git commit -m "New version of website"
git push --set-upstream gap gh-pages
