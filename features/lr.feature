#@announce-stdout @announce-stderr
Feature: Ruby Version Control

  Background:
    Given a directory named "test_repo"
    When I cd to "test_repo"

  Scenario: Log should fail if it isn't a repo
    When I run lr log
    And the output should contain "Not an LR repository."

  Scenario: Log should succeed but be empty if there are no commits
    When I run lr init
    And I run lr log
    And the output should contain "No commits."

  Scenario: Commit should print usage if the arguments are wrong
    Given a file named "test_repo/example.rb" with:
      """
      puts "hello world"
      """
    When I run lr init
    And I run lr commit "Hello world implemented."
    Then the output should contain exactly:
      """
      usage: lr commit USERNAME MESSAGE

      """

  Scenario: Commit should create a commit in the log
    Given a file named "test_repo/example.rb" with:
      """
      puts "hello world"
      """
    When I run lr init
    And I run lr commit randsina "Hello world implemented."
    And I run lr log
    Then the output should contain:
      """
      Hello world implemented.
      """

  Scenario: Should be able to checkout old versions
    Given a file named "test_repo/example.rb" with:
      """
      puts "hello world"
      """
    When I run lr init
    And I run lr commit randsina "Initial commit."
    Given a file named "test_repo/example.rb" with:
      """
      puts "hello world"
      YOYOYO
      """
    And I run lr commit randsina "Modified."
    And I run lr checkout HEAD^
    And the file "test_repo/example.rb" should not contain "YOYOYO"

  Scenario: Should be able to restore newer versions
    Given a file named "test_repo/example.rb" with:
      """
      puts "hello world"
      """
    When I run lr init
    And I run lr commit randsina "Initial commit."
    Given a file named "test_repo/example.rb" with:
      """
      puts "hello world"
      YOYOYO
      """
    And I run lr commit randsina "Modified."
    And I run lr checkout HEAD^
    And the file "test_repo/example.rb" should not contain "YOYOYO"
    And I run lr checkout HEAD
    And the file "test_repo/example.rb" should contain "YOYOYO"

  Scenario: Should be able to look at old versions
    Given a file named "test_repo/example.rb" with:
      """
      puts "hello world"
      """
    When I run lr init
    And I run lr commit randsina "Initial commit."
    Given a file named "test_repo/example.rb" with:
      """
      puts "hello world"
      YOYOYO
      """
    And I run lr commit randsina "2nd commit."
    And I run lr show HEAD^:test_repo/example.rb
    Then the output should contain exactly:
      """
      puts "hello world"

      """
