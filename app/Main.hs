{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Options.Generic
import System.Console.Haskeline (defaultSettings, runInputT, getInputLine, outputStrLn, InputT, getPassword)
import Data.Foldable (forM_)
import qualified Registry.Client as C
import System.IO (openFile, IOMode(..), hClose, hPutStrLn)
import Control.Exception (bracket)

data Options
  = Auth
  | Whoami
  | Publish
  | Search
  deriving (Generic, Show)


instance ParseRecord Options


askLogins = runInputT defaultSettings operations
  where operations :: InputT IO (Maybe (String, String))
        operations = do
          login <- getInputLine "login : "
          password <- getPassword Nothing "password : "
          case (login, password) of
               (Nothing, _) -> return Nothing
               (_, Nothing) -> return Nothing
               (Just x, Just y) ->  return $ Just (x,y)

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
                    -- TODO : replace /home/mleduc with the content of $HOME
                    -- TODO : replace with Prelude.writeFile ??
                    bracket (openFile "/home/mleduc/.kregrch" ReadWriteMode) hClose
                        (\h -> hPutStrLn h (C.id_token dt))

                    putStrLn "Authentication succeeded"

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
