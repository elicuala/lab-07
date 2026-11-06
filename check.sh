# Eli Cuala CMPUT 201 Lab 7 ILC check.sh

# Eli Cuala CMPUT 201 Lab 7 ILC check.sh

failed=0

for testcaseNum in 1 2 3 4
do
    goodTestCase=1
    anyDifference=0
    for file in "Testcase${testcaseNum}"/*.1.txt
    do
        version1="${file}"
        version1Stem=${file%1.txt}
        version2="${version1Stem}2.txt"
        versionStrippedFront=${version1#Testcase${testcaseNum}/Version}
        versionNum=${versionStrippedFront%.1.txt}
        versionDiffFile="Testcase${testcaseNum}Diff/Version${versionNum}Diff.txt"
        if ! cmp -s "${version1}" "${version2}"
        then
            anyDifference=1
            if [ ! -d "Testcase${testcaseNum}Diff" ]
            then
                goodTestCase=0
            fi
            if [ ! -f "${versionDiffFile}" ]
            then
                goodTestCase=0
            else
                expected="$(diff -u "${version1}" "${version2}" | tail -n +3)"
                actual="$(tail -n +3 "${versionDiffFile}")"
                if [ "${expected}" != "${actual}" ]
                then
                    goodTestCase=0
                fi
            fi
        else
            if [ -f "${versionDiffFile}" ]
            then
                goodTestCase=0
            fi
        fi
    done
    if [ "${anyDifference}" -eq 0 ] && [ -d "Testcase${testcaseNum}Diff" ]
    then
        goodTestCase=0
    fi
    if [ "${goodTestCase}" -eq 1 ]
    then
        echo "Testcase${testcaseNum}: PASS"
    else
        echo "Testcase${testcaseNum}: FAIL"
        failed=1
    fi
done

exit "${failed}"