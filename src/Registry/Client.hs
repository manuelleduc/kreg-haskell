{-# LANGUAGE DeriveGeneric       #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Registry.Client (auth, AuthResponseBody(..)) where

import           Control.Exception   as E
import           Control.Lens        ((^?))
import           Data.Aeson
import           GHC.Generics
import           Network.HTTP.Client (HttpException (StatusCodeException))
import qualified Network.Wreq        as R

data Auth = Auth {
    username   :: String,
    password   :: String,
    rememberMe :: Bool
} deriving (Generic)

data AuthResponseBody = AuthResponseBody {
    id_token :: String
} deriving (Generic, Show)

instance ToJSON Auth
instance FromJSON AuthResponseBody

baseUrlServer = "http://localhost:8080/"
authenticateResource = baseUrlServer ++ "api/authenticate"

auth login password =
    let handler e@(StatusCodeException{}) = return Nothing
        authObj = Auth login password False
        operations = do r <- R.post authenticateResource (toJSON authObj)
                        (body :: R.Response AuthResponseBody) <- R.asJSON r
                        return (body ^? R.responseBody)
    in operations `E.catch` handler
