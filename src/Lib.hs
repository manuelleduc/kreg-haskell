module Lib
    ( someFunc
    ) where

import Registry.Client (auth)

someFunc :: IO ()
someFunc = putStrLn "someFunc"
