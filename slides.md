% RSpec Workshop

## Workshop Repo

`git clone https://github.com/Skipants/rspec-workshop/`

Run `bin/bootstrap` to download Ruby 2.7.2 and set up the project databases.

It should complete with RSpec running and having a warning.

## Unit Testing

- Follows "Arrange-Act-Assert". This just means, do the following steps

1. Setup the state and variables needed for your test
2. Run the code under test
3. Check that the code under test matches your expectations

## Example Unit Test File in RSpec

Docs @ https://relishapp.com/rspec/rspec-core/docs

```ruby
require "spec_helper"

RSpec.describe Game do
  describe "#score" do
    let(:game) { Game.new }

    it "returns 0 for an all gutter game" do
      20.times { game.roll(0) }
      expect(game.score).to eq(0)
    end
  end
end
```

## Breaking down each part of a unit test
```ruby
require "spec_helper"
```
This loads the "spec_helper" file, which is the conventional file for loading the Ruby and RSpec environment. For loading the whole Rails environment, "rails_helper" is used. In the financeit app, there is only a "rails_helper". This is generally bad practice as having separate files allows you to run spec files that don't need Rails more quickly. eg. Unit tests on plain Ruby objects.

```ruby
RSpec.describe Game do
```
RSpec's code block for putting tests in. The convention is to pass the class under test to "describe". This can be a string as well. For tests like integration or feature tests that don't map 1-to-1 to the tests, you would probably use a string that describes the feature under test instead.

```ruby
describe "#score" do
```
A nested describe block. You can nest as many as you'd like, but it generally gets messy if you are more than 3 describe's deep. Also aliased as `context`. The convention is that `describe` is used for classes and method names, `context` for descriptive text. eg.:

```ruby
describe "#score" do
  context "after 20 rolls" do
```

```ruby
let(:game) { Game.new }
```
Sets the `game` variable for each test in this describe block. `let` is lazy loaded on each test. Part of the "Arrange" step. It also has a variant `let!` that is called *once* at the beginning of that whole block for every test within. That's useful for expensive operations. When in doubt just use `let`.

```ruby
it "returns 0 for an all gutter game" do
```
The block for the test itself.

```ruby
  20.times { game.roll(0) }
```
The code under test. Part of the "Act" step.

```ruby
  expect(game.score).to eq(0)
```
`expect...to` is RSpec's way of making an assertion. Part of the "Assert" step.

## Unit Test Exercise

Fill out the spec in spec/lib/string_spec.rb

Goal: Just getting comfortable writing a test for something already written
Time: 10 minutes

Tips:
  - Don't overthink it
  - You probably don't need to do any setup

## File Conventions

Test files under `spec/` are usually 1-to-1 matches with files and their objects under the root folder or under `app/` with `_spec.rb` appended.

Examples:
  1. `app/models/loan.rb` => `spec/models/loan.rb`
  2. `app/controllers/loan.rb` => `spec/controllers/loans_controller.rb`
  3. `lib/helper.rb` => `spec/lib/helper_spec.rb`

Exceptions:
  - `spec/factories/`
    - Contains factory_bot factories (more on that later)

  - `spec/fixtures/`
    - Contain non-ruby files useful for testing, eg. images.
    - Not to be confused with test-unit's fixtures, which are yaml files. We replace that with factory_bot.

  - `spec/integration/`
    - Not actually the conventional place for integration tests for RSpec. These should be in `spec/requests/`

  - `spec/requests/`
    - https://relishapp.com/rspec/rspec-rails/v/4-0/docs/request-specs/request-spec
    - RSpec Rails' wrapper for integration tests
    - They tend to follow how multiple method calls work together. More on these later.

  - `spec/routing/`
    - RSpec tests for your routes
    - I've actually never written one of these in my life.
    - Probably useful if your routes are crazy and you are trying to refactor them.

  - `spec/support/`
    - Files that are included by tests that contain abstractions and reuseable pieces of code
    - The place every included file for specs gets dumped.

## Test Driven Development (TDD)

This just means writing tests before any code.

### Andrew's Opinions™

### Pros:
- It helps frame the problem and give you the big picture of how you can solve it
- You usually end up with cleaner code because you've analyzed how it should look from the start rather than incrementally making changes
- Gives you confidence your code works
- Much quicker than testing in the browser

### Cons:
- Difficult to do when adding code to something already untested. Often untested code wasn't written well for allowing tests and you'll need to get a full understanding of the code when writing tests for it (maybe that's a pro?)
- Writing tests requires you do know what your inputs and outputs will look like, but you might not understand what the code should look like until you've tried different things first
- It's a different way of thinking that needs to be practiced.

Overall I think it works great when fixing bugs or making new additions. It's much harder when starting a new application where the architecture isn't flushed out yet.

## Unit Test TDD Exercise

Given a class Months, implement a method that calculates the average amount of days of 3 months by name

Class is located in `lib/months.rb`

Constraints:
  - Write a test before even typing anything into `lib/months.rb`

Goal: To get comfortable with TDD
Time: 30+ minutes

Tips:
  - You will need to create a test file for class lib/months.rb given the convention we talked about
  - Use `Months::DAYS_IN_MONTH` to make this less about figuring out Rails' builtins and more just worrying about the problem
  - Don't worry about good code or the implementation. Just testing first.
  - The method may be a class or instance method. arguments may be passed to method or part of method signature
  - Run the spec file as often as possible with `bundle exec rspec filename`
  - Hardcode the values you in your expecation. Don't use `Months::DAYS_IN_MONTH` in your spec.

## Request (Integration) Specs
-- Here -- slides on how to integration test and how we are currently testing differently @ financeit
    - We don't do frontend tests in RSpec because we have Cucumber, but that's out of scope right now

## Request Spec TDD Exercise

Implement the following:
  - A user can ping people by name via `POST /ping` with a name, greeting, and company
  - The greeting must always be "hello" and the company must always be "financeit"
  - A user can only get help from `GET /help` if they have pinged `@skipants`. Otherwise the user gets a 404 response.

Constraints:
  - Write an integration test before doing any code
  - Write an invariant of the test -- if you ping someone who is NOT `@skipants`, then you should get a 404 from `GET /help`

Goal: To get more comfortable with TDD and integration tests
Time: 45 minutes

Tips:
  - Start with a file in `spec/requests/`. Don't sweat the filename -- they are more subjective than unit test files.
  - Use a base set of parameters named `valid_params` and use `Hash#merge` to highlight the difference in state between your base case and the invariant
  - You don't need to save `greeting` or `company` to the database. That constraint is just there to enforce and get you used to the usage of `valid_params`.
  - Delete any guard assertions in the middle of your test when you're finished. ie. If you wrote an `expect` between the two requests, get rid of it after. It makes tests harder to follow later on and is only really useful for debugging.

## Factory Bot

A gem used for organizing database fixtures. Instead of passing the same parameters over and over to `.create` a database record, you can use factory definitions and traits to abstract that stuff away.

-- link to factory_bot
-- examples here
-- breakdown a factory bot definition
-- anything else they will need for the exercises
-- talk about performance issues -- creating a database record is slow. when to use create vs build

## Controller Specs

Unit tests for controllers. RSpec Rails provides some helper methods to make these simpler.

-- link to controller specs
-- break down a controller spec
-- talk about provided helper methods
-- anything else they will need for the exercises

## Controller Spec + Factory Bot Exercise

Reimplement the previous integration test for pinging @skipants as a controller test with one new requirement: The user can only ping @skipants once per day.

-- talk about getting rid of /ping for factory bot

Constraints:
  - Set up the state of the test using Factory Bot.

Goal: To get comfortable with controller specs and Factory Bot
Time: 30+ minutes

Tips:
  - In the previous exercise, if you called the endpoint multiple times, you should instead save the pings straight to the database as part of your setup
  - You have to create both the factory and the file for this exercise
  - Try using a trait to automatically make a ping with a name of "@skipants". You probably wouldn't do this normally, but the point here is just to be familiar with factory_bot.


## Mocks and Stubs

-- link to rspec-mocks
-- just highlight instance_double, `allow...to receive`, and stub_const

## Controller Spec Stub Exercise

Reimplement the previous controller test for pinging @skipants as with one new requirement: The user can only ping @skipants 5 times per month.

Constraints:
  - Set up the state of the test using mocks and/or stubs.

Goal: To get comfortable with mocking and stubbing
Time: 15 minutes

Tips:
  - There's more than one way to do it. You will probably need stubs but it can definitely be done without mocks
  - Only your setup should change. Calling the controller method and

## Performance

-- talk about writing to database
-- factory_bot cascade creates

## Tips for Testing Real Code

- Avoid using several `let` statements. It ends up making code harder to follow.
  -- link to comment where I talk about it
