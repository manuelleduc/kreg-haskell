module Kreg.Options.Auth (auth) where

import           Kreg.UI.UserInput     (askLogins)
import qualified Registry.Client       as C
import Kreg.TokenFileManager (save)

auth :: IO ()
auth = do
    ids <- askLogins
    case ids of
        Nothing -> return ()
        Just (login, password) -> do
            res <- C.auth login password
            case res of
                Nothing -> putStrLn "Authentication failed"
                Just dt -> do
                    save dt
                    putStrLn "Authentication succeeded"
