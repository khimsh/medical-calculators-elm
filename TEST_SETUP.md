# Test Setup Instructions

## Current Status

The test files are correctly written, but the test dependencies need to be installed before they can run.

## Errors Found and Fixed

✅ **Fixed**: Main module now exposes `Model`, `Msg`, and `init` for testing
✅ **Fixed**: Removed unused imports from test files
⚠️ **Needs Action**: Test dependencies need to be installed

## Installation Steps

1. **Install test dependencies**:

   ```bash
   elm install elm-explorations/test
   ```

   When prompted, answer **"n"** (no) to keep it in test-dependencies (not move to dependencies).

2. **Verify installation**:
   After installation, check that `elm-stuff/packages/elm-explorations/test/` exists.

3. **Run tests**:

   ```bash
   elm-test
   ```

   Or if you have npm scripts:

   ```bash
   npm test
   ```

## Test File Structure

All test files are correctly structured:

- ✅ `tests/FunctionsTests.elm` - Tests utility functions
- ✅ `tests/MainTests.elm` - Tests calculator logic
- ✅ `tests/FreeWaterDeficitTests.elm` - Tests Free Water Deficit calculator

## Expected Behavior After Installation

Once dependencies are installed, all linting errors should disappear and tests should run successfully.
