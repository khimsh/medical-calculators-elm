module Translations exposing (..)


type Language
    = English
    | Georgian


type alias Strings =
    { title : String
    , pillDosage : String
    , liquidDosage : String
    , nutrition : String
    , peroralpill : String
    , prescribedAmount : String
    , pillStrength : String
    , calculate : String
    , reset : String
    , result : String
    , tablets : String
    , peroralliquid : String
    , amountAtHand : String
    , volumeAtHand : String
    , ml : String
    , nutritionCalc : String
    , weight : String
    , height : String
    , weightLoss : String
    , weightLossNone : String
    , critical : String
    , dailyCalories : String
    , kcal : String
    , proteins : String
    , fats : String
    , carbs : String
    , zeroNotAccepted : String
    , freeWaterDeficit : String
    , sodium : String
    , weightInput : String
    , sodiumInput : String
    , invalidInputs : String
    , sex : String
    , male : String
    , female : String
    , elderly : String
    , liters : String
    , grams : String
    , bmi : String
    , sodiumNotElevated : String
    , calculationResult : String
    , nutritionResults : String
    , switchLanguage : String
    , otherLanguage : String
    , resultHint : String
    , mg : String
    , kg : String
    , give : String
    , drawUp : String
    , waterToReplace : String
    , pillFormula : String
    , liquidFormula : String
    , nutritionFormula : String
    , freeWaterFormula : String
    , allCalculators : String
    , favorites : String
    , markFavorite : String -> String
    , noFavorites : String
    , medicationDosing : String
    , fluidsAndElectrolytes : String
    , nutritionCategory : String
    , ivInfusionRate : String
    , infusionVolume : String
    , infusionDuration : String
    , durationUnit : String
    , hours : String
    , minutes : String
    , dropFactor : String
    , pumpRate : String
    , dripRate : String
    , ivInfusionFormula : String
    , mlPerHour : String
    , dropsPerMinute : String
    , dropsPerMl : String
    , hoursShort : String
    , minutesShort : String
    , testingBanner : String
    , bodySurfaceArea : String
    , bsaFormula : String
    , bsaUnit : String
    , cm : String
    , weightBasedDose : String
    , dosePerKg : String
    , mgPerKg : String
    , dose : String
    , weightBasedDoseFormula : String
    }


englishStrings : Strings
englishStrings =
    { title = "Medical Calculators"
    , pillDosage = "Pill Dosage"
    , liquidDosage = "Liquid Dosage"
    , nutrition = "Nutrition"
    , peroralpill = "Peroral Pill Dosage"
    , prescribedAmount = "Prescribed amount (mg)"
    , pillStrength = "Pill strength (mg)"
    , calculate = "Calculate"
    , reset = "Reset"
    , result = "Result"
    , tablets = "tablets"
    , peroralliquid = "Peroral Liquids Dosage"
    , amountAtHand = "Amount at hand (mg)"
    , volumeAtHand = "Volume at hand (mL)"
    , ml = "mL"
    , nutritionCalc = "Nutrition Calculator"
    , weight = "Weight (kg)"
    , height = "Height (cm)"
    , weightLoss = "Weight loss in the last 3–6 months"
    , weightLossNone = "None"
    , critical = "Critically ill"
    , dailyCalories = "Daily energy"
    , kcal = "kcal"
    , proteins = "Protein"
    , fats = "Fat"
    , carbs = "Carbohydrate"
    , zeroNotAccepted = "All values must be greater than zero"
    , freeWaterDeficit = "Free Water Deficit"
    , sodium = "Sodium (mmol/L)"
    , weightInput = "Weight (kg)"
    , sodiumInput = "Sodium (mmol/L)"
    , invalidInputs = "Enter valid inputs"
    , sex = "Sex"
    , male = "Male"
    , female = "Female"
    , elderly = "Age 65 or older"
    , liters = "L"
    , grams = "g"
    , bmi = "BMI"
    , sodiumNotElevated = "Sodium is below 140 mmol/L — there is no free water deficit"
    , calculationResult = "Calculation result"
    , nutritionResults = "Nutrition calculation results"
    , switchLanguage = "Switch to Georgian"
    , otherLanguage = "ქართული"
    , resultHint = "Enter the values and press Calculate. The result and its working will appear here."
    , mg = "mg"
    , kg = "kg"
    , give = "Give"
    , drawUp = "Draw up"
    , waterToReplace = "Free water to replace"
    , pillFormula = "dose ÷ tablet strength"
    , liquidFormula = "dose ÷ amount at hand × volume"
    , nutritionFormula = "5–30 kcal/kg by risk score"
    , freeWaterFormula = "0.45–0.6 × weight × (Na ÷ 140 − 1)"
    , allCalculators = "All"
    , favorites = "Favorites"
    , markFavorite = \name -> "Mark " ++ name ++ " as favorite"
    , noFavorites = "No favorites yet. Press ☆ on a calculator to add it here."
    , medicationDosing = "Medication dosing"
    , fluidsAndElectrolytes = "Fluids & electrolytes"
    , nutritionCategory = "Nutrition"
    , ivInfusionRate = "IV infusion rate"
    , infusionVolume = "Volume (mL)"
    , infusionDuration = "Duration"
    , durationUnit = "Duration unit"
    , hours = "Hours"
    , minutes = "Minutes"
    , dropFactor = "Drop factor"
    , pumpRate = "Pump rate"
    , dripRate = "Drip rate"
    , ivInfusionFormula = "volume ÷ hours; volume × drop factor ÷ minutes"
    , mlPerHour = "mL/h"
    , dropsPerMinute = "drops/min"
    , dropsPerMl = "drops/mL"
    , hoursShort = "h"
    , minutesShort = "min"
    , bodySurfaceArea = "Body surface area"
    , bsaFormula = "√(height cm × weight kg ÷ 3600)"
    , bsaUnit = "m²"
    , cm = "cm"
    , weightBasedDose = "Weight-based dose"
    , dosePerKg = "Dose per kg (mg/kg)"
    , mgPerKg = "mg/kg"
    , dose = "Dose"
    , weightBasedDoseFormula = "dose per kg × weight"
    , testingBanner = "⚠ TESTING PURPOSES ONLY - This application is currently in development and testing phase. Do not use for clinical decisions."
    }


georgianStrings : Strings
georgianStrings =
    { title = "სამედიცინო კალკულატორები"
    , pillDosage = "აბის დოზირება"
    , liquidDosage = "თხევადი მედიკამენტი"
    , nutrition = "კვება"
    , peroralpill = "პერორალური აბის დოზირება"
    , prescribedAmount = "გამოწერილი რაოდენობა (მგ)"
    , pillStrength = "აბის სიძლიერე (მგ)"
    , calculate = "გამოთვლა"
    , reset = "გადატვირთვა"
    , result = "შედეგი"
    , tablets = "აბი"
    , peroralliquid = "პერორალური თხევადი მედიკამენტი"
    , amountAtHand = "ხელთ არსებული რაოდენობა (მგ)"
    , volumeAtHand = "ხელთ არსებული მოცულობა (მლ)"
    , ml = "მლ"
    , nutritionCalc = "კვების კალკულატორი"
    , weight = "წონა (კგ)"
    , height = "სიმაღლე (სმ)"
    , weightLoss = "წონის კლება ბოლო 3–6 თვეში"
    , weightLossNone = "არა"
    , critical = "კრიტიკულ მდგომარეობაში"
    , dailyCalories = "დღიური კალორიები"
    , kcal = "კკალ"
    , proteins = "ცილები"
    , fats = "ცხიმები"
    , carbs = "ნახშირწყლები"
    , zeroNotAccepted = "ყველა მნიშვნელობა უნდა იყოს ნულზე მეტი"
    , freeWaterDeficit = "თავისუფალი წყლის დეფიციტი"
    , sodium = "ნატრიუმი (მმოლ/ლ)"
    , weightInput = "წონა (კგ)"
    , sodiumInput = "ნატრიუმი (მმოლ/ლ)"
    , invalidInputs = "შეიყვანეთ ვალიდური მონაცემები"
    , sex = "სქესი"
    , male = "მამრობითი"
    , female = "მდედრობითი"
    , elderly = "65 წლის ან უფროსი"
    , liters = "ლ"
    , grams = "გ"
    , bmi = "სმი"
    , sodiumNotElevated = "ნატრიუმი 140 მმოლ/ლ-ზე დაბალია — თავისუფალი წყლის დეფიციტი არ არის"
    , calculationResult = "გამოთვლის შედეგი"
    , nutritionResults = "კვების გამოთვლის შედეგები"
    , switchLanguage = "ინგლისურზე გადართვა"
    , otherLanguage = "English"
    , resultHint = "შეიყვანეთ მონაცემები და დააჭირეთ „გამოთვლა“. შედეგი და გამოთვლა აქ გამოჩნდება."
    , mg = "მგ"
    , kg = "კგ"
    , give = "მიეცით"
    , drawUp = "აიღეთ შპრიცში"
    , waterToReplace = "შესავსები თავისუფალი წყალი"
    , pillFormula = "დოზა ÷ აბის სიძლიერე"
    , liquidFormula = "დოზა ÷ ხელთ არსებული რაოდენობა × მოცულობა"
    , nutritionFormula = "5–30 კკალ/კგ რისკის ქულის მიხედვით"
    , freeWaterFormula = "0.45–0.6 × წონა × (Na ÷ 140 − 1)"
    , allCalculators = "ყველა"
    , favorites = "რჩეულები"
    , markFavorite = \name -> "„" ++ name ++ "“ რჩეულად მონიშვნა"
    , noFavorites = "რჩეულები ჯერ არ გაქვთ. დააჭირეთ ☆-ს კალკულატორზე, რომ აქ დაამატოთ."
    , medicationDosing = "მედიკამენტების დოზირება"
    , fluidsAndElectrolytes = "სითხეები და ელექტროლიტები"
    , nutritionCategory = "კვება"
    , ivInfusionRate = "ინფუზიის სიჩქარე"
    , infusionVolume = "მოცულობა (მლ)"
    , infusionDuration = "ხანგრძლივობა"
    , durationUnit = "დროის ერთეული"
    , hours = "საათი"
    , minutes = "წუთი"
    , dropFactor = "წვეთის ფაქტორი"
    , pumpRate = "ინფუზომატის სიჩქარე"
    , dripRate = "წვეთის სიჩქარე"
    , ivInfusionFormula = "მოცულობა ÷ საათი; მოცულობა × წვეთის ფაქტორი ÷ წუთი"
    , mlPerHour = "მლ/სთ"
    , dropsPerMinute = "წვეთი/წთ"
    , dropsPerMl = "წვეთი/მლ"
    , hoursShort = "სთ"
    , minutesShort = "წთ"
    , bodySurfaceArea = "სხეულის ზედაპირის ფართობი"
    , bsaFormula = "√(სიმაღლე სმ × წონა კგ ÷ 3600)"
    , bsaUnit = "მ²"
    , cm = "სმ"
    , weightBasedDose = "წონაზე დაფუძნებული დოზა"
    , dosePerKg = "დოზა კგ-ზე (მგ/კგ)"
    , mgPerKg = "მგ/კგ"
    , dose = "დოზა"
    , weightBasedDoseFormula = "დოზა კგ-ზე × წონა"
    , testingBanner = "⚠ მხოლოდ ტესტირებისთვის - ეს აპლიკაცია ამჟამად განვითარებისა და ტესტირების ფაზაშია. არ გამოიყენოთ კლინიკური გადაწყვეტილებებისთვის."
    }


getStrings : Language -> Strings
getStrings language =
    case language of
        English ->
            englishStrings

        Georgian ->
            georgianStrings
