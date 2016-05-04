{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Kreg.Options (auth, whoami)
import           Options.Generic

data Options
  = Auth
  | Whoami
  | Publish
  | Search
  deriving (Generic, Show)

instance ParseRecord Options


processOptions :: Options -> IO()
processOptions x = case x of
  Auth -> auth
  Whoami -> whoami
  Publish -> putStrLn "publish todo"
  Search -> putStrLn "search todo"


main :: IO ()
main = do
  x <- getRecord "kreg"
  processOptions x
