module Kreg.TokenFileManager (save, Kreg.TokenFileManager.read) where

import           System.FilePath.Posix ((</>))
import           System.Directory      (getHomeDirectory)
import qualified Registry.Client       as C

filePath = do
    homeDirectory <- getHomeDirectory
    return $ homeDirectory </> ".kregrch"

--save :: String -> IO ()
save token = do
    fp <- filePath
    writeFile fp (C.id_token token)

--read :: IO String
read = do
    fp <- filePath
    readFile fp