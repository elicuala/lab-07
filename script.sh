# Eli Cuala CMPUT 201 Lab 7 ILC script.sh

for testcaseNum in 1 2 3 4
do 
    rm -rf "Testcase${testcaseNum}Diff"
    for file in "Testcase${testcaseNum}"/*.1.txt
    do
        version1="${file}"
        version1Stem=${file%1.txt}
        version2="${version1Stem}2.txt"
        if ! cmp -s $version1 $version2 
        then
            versionStrippedFront=${version1#Testcase${testcaseNum}/Version}
            versionNum=${versionStrippedFront%.1.txt}
            mkdir -p "Testcase${testcaseNum}Diff"
            diff -u $version1 $version2 > "Testcase${testcaseNum}Diff/Version${versionNum}Diff.txt"
        fi
    done
done
