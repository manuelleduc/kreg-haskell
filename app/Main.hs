{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Options.Generic
import System.Console.Haskeline (defaultSettings, runInputT, getInputLine, outputStrLn, InputT, getPassword)
import Data.Foldable (forM_)

data Options
  = Auth
  | Whoami
  | Publish
  | Search
  deriving (Generic, Show)


instance ParseRecord Options

auth :: IO ()
auth = runInputT defaultSettings operations
  where operations :: InputT IO ()
        operations = do
          login <- getInputLine "login : "
          password <- getPassword Nothing "password : "
          case (login, password) of
            (Nothing, _) -> return ()
            (_, Nothing) -> return ()
            (Just x, Just y) -> outputStrLn $ x ++ " - " ++ y

processOptions :: Options -> IO()
processOptions x = case x of
  Auth -> auth
  Whoami -> putStrLn "whoami todo"
  Publish -> putStrLn "publish todo"
  Search -> putStrLn "search todo"


main :: IO ()
main = do
  x <- getRecord "kreg"
  processOptions x
