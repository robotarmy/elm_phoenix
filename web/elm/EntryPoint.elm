module EntryPoint where
import Html exposing (..) -- .. is import everything
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

import StartApp.Simple


main : Signal Html
main =
  StartApp.Simple.start
  {
    model  = init
  , update = update
  , view   = view
  }

-- MODEL

type alias Motor =
  {
    id: Int,
    cc: Int,
    cylinders: Int,
    factory: String,
    running: Bool
  }

type alias MotorList =
  List Motor

init : MotorList
init =
  [ {id = 1, cc = 250,  cylinders = 1, factory = "Kawasaki", running = False }
  , {id = 2, cc = 250,  cylinders = 1, factory = "Yamaha"  , running = False }
  , {id = 3, cc = 1340, cylinders = 2, factory = "Tom's Harley Shop" , running = False}
  , {id = 4, cc = 690,  cylinders = 1, factory = "Husqvarna", running = False }
  ]


-- VIEW


view : Signal.Address Action -> MotorList -> Html
view address motor_list =
  ul [ class "motors" ] (List.map (modelItem address) motor_list)


modelItem : Signal.Address Action -> Motor -> Html
modelItem address motor =
  li [ class "motor"
     , onClick address (Toggle motor)
     ]
     [ div [class "factory"]    [text (toString motor.factory)]
     , div [class "cc"]         [text (toString motor.cc)]
     , div [class "cylinders"]  [text (toString motor.cylinders)]
     , div [class "running"]    [text (toString motor.running)]
     ]

-- UPDATE

type Action = Toggle Motor

update : Action ->  MotorList -> MotorList
update action motor_list =
  case action of
    Toggle motorToRun ->
      let
        updateMotor motor =
          if motor.id == motorToRun.id then
             { motor | running = not motor.running }
          else motor
      in
         List.map updateMotor motor_list

