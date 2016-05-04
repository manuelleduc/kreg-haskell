module Kreg.UI.UserInput (askLogins) where

import           System.Console.Haskeline (InputT, defaultSettings,
                                           getInputLine, getPassword,
                                           outputStrLn, runInputT)

askLogins :: IO (Maybe (String, String))
askLogins = runInputT defaultSettings operations
  where operations :: InputT IO (Maybe (String, String))
        operations = do
          login <- getInputLine "login : "
          password <- getPassword Nothing "password : "
          case (login, password) of
               (Nothing, _) -> return Nothing
               (_, Nothing) -> return Nothing
               (Just x, Just y) ->  return $ Just (x,y)
