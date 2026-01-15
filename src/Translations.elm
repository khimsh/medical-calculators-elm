module Translations exposing (..)


type Language
    = English
    | Georgian


type alias Strings =
    { title : String
    , subtitle : String
    , pillDosage : String
    , liquidDosage : String
    , nutrition : String
    , peroralpill : String
    , prescribedAmount : String
    , pillStrength : String
    , calculate : String
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
    , disclaimer : String
    }


englishStrings : Strings
englishStrings =
    { title = "Medical Calculators"
    , subtitle = "Work in progress. Do not trust calculations"
    , pillDosage = "Pill Dosage"
    , liquidDosage = "Liquid Dosage"
    , nutrition = "Nutrition"
    , peroralpill = "Peroral Pill Dosage"
    , prescribedAmount = "Prescribed amount (mg)"
    , pillStrength = "Pill strength (mg)"
    , calculate = "Calculate"
    , result = "Result:"
    , tablets = "tablets"
    , peroralliquid = "Peroral Liquids Dosage"
    , amountAtHand = "Amount at hand (mg)"
    , volumeAtHand = "Volume at hand (mL)"
    , ml = "mL"
    , nutritionCalc = "Nutrition Calculator"
    , weight = "Weight (kg)"
    , height = "Height (cm)"
    , weightLoss = "Weight Loss (%)"
    , weightLossNone = "None"
    , critical = "Critical condition?"
    , dailyCalories = "Daily Calories:"
    , kcal = "kcal"
    , proteins = "Proteins: "
    , fats = "Fats: "
    , carbs = "Carbs: "
    , disclaimer = "⚠ TESTING PURPOSES ONLY - This application is currently in development and testing phase. Do not use for clinical decisions. Always consult with healthcare professionals."
    }


georgianStrings : Strings
georgianStrings =
    { title = "სამედიცინო კალკულატორები"
    , subtitle = "სატესტო რეჟიმი. არ ენდოთ კალკულაციებს"
    , pillDosage = "აბის დოზირება"
    , liquidDosage = "თხევადი მედიკამენტი"
    , nutrition = "კვება"
    , peroralpill = "პერორალური აბის დოზირება"
    , prescribedAmount = "გამოწერილი რაოდენობა (მგ)"
    , pillStrength = "აბის სიძლიერე (მგ)"
    , calculate = "გამოთვლა"
    , result = "შედეგი:"
    , tablets = "აბი"
    , peroralliquid = "პერორალური თხევადი მედიკამენტი"
    , amountAtHand = "ხელთ არსებული რაოდენობა (მგ)"
    , volumeAtHand = "ხელთ არსებული მოცულობა (მლ)"
    , ml = "მლ"
    , nutritionCalc = "კვების კალკულატორი"
    , weight = "წონა (კგ)"
    , height = "სიმაღლე (სმ)"
    , weightLoss = "წონის კლება (%)"
    , weightLossNone = "არა"
    , critical = "კრიტიკული მდგომარეობა?"
    , dailyCalories = "დღიური კალორიები:"
    , kcal = "kcal"
    , proteins = "პროტეინები: "
    , fats = "ცხიმები: "
    , disclaimer = "⚠ მხოლოდ ტესტირებისთვის - ეს აპლიკაცია ამჟამად განვითარებისა და ტესტირების ფაზაშია. არ გამოიყენოთ კლინიკური გადაწყვეტილებებისთვის. ყოველთვის კონსულტირდით ჯანდაცვის სპეციალისტებთან."
    , carbs = "ნახშირწყლები: "
    }


getStrings : Language -> Strings
getStrings language =
    case language of
        English ->
            englishStrings

        Georgian ->
            georgianStrings
