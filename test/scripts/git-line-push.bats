#!/usr/bin/env bats

source 'test/test_helpers/bats-support/load.bash'
source 'test/test_helpers/bats-assert/load.bash'
source 'test/test_helpers/test_helper.bash'

setup() {
    setup_tests
    create_git_repo
    cd git_repo || exit
}

teardown() {
    clean_tests
}

@test "'git line push' sets an upstream and pushes current branch" {
    git checkout -b branch-without-remote

    touch new_file
    git add . && git commit -a -m "new file"

    run git line push

    assert_output --partial 'branch-without-remote -> branch-without-remote'
    assert_output --partial "Branch 'branch-without-remote' set up to track remote branch 'branch-without-remote' from 'origin'."
}
