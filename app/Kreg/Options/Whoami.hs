module Kreg.Options.Whoami (whoami) where

import qualified Kreg.TokenFileManager as TMF (read)
import qualified Registry.Client as C (whoami)

{-
uri : /api/account
prerequisites :
   * token stored in ~/.kregrch
-}
whoami :: IO ()
whoami = do
    token <- TMF.read
    res <- C.whoami token
    putStrLn (show res)


-- TODO : JWT libs too young to works on jhipster particular configuration. We'll need to query the json api to have more details.
