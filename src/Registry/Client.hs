{-# LANGUAGE DeriveGeneric       #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Registry.Client (auth, whoami, AuthResponseBody(..), AccountResponseBody(..)) where

import           Control.Exception   as E
import           Control.Lens        ((^?), (&), (.~))
import           Data.Aeson
import           GHC.Generics
import           Network.HTTP.Client (HttpException (StatusCodeException))
import qualified Network.Wreq        as R
import Data.ByteString.Char8 (pack)

data Auth = Auth {
    username   :: String,
    password   :: String,
    rememberMe :: Bool
} deriving (Generic)

data AuthResponseBody = AuthResponseBody {
    id_token :: String
} deriving (Generic, Show)


data AccountResponseBody = AccountResponseBody {
    activated :: Bool,
    authorities :: [String],
    email :: String,
    firstName :: String,
    langKey :: String,
    lastName :: String,
    login :: String
} deriving (Generic, Show)

instance ToJSON Auth
instance FromJSON AuthResponseBody
instance FromJSON AccountResponseBody

baseUrlServer = "http://localhost:8080/"
authenticateResource = baseUrlServer ++ "api/authenticate"
accountResource = baseUrlServer ++ "api/account"

auth login password =
    let handler e@(StatusCodeException{}) = return Nothing
        authObj = Auth login password False
        operations = do r <- R.post authenticateResource (toJSON authObj)
                        (body :: R.Response AuthResponseBody) <- R.asJSON r
                        return (body ^? R.responseBody)
    in operations `E.catch` handler


whoami :: String -> IO (Maybe AccountResponseBody)
whoami token =
    let handler e@(StatusCodeException{}) = return Nothing
        options = R.defaults & R.header "Authorization" .~ [pack ("Bearer " ++ token)]
        operations = do r <- R.getWith options accountResource
                        (body :: R.Response AccountResponseBody) <- R.asJSON r
                        return (body ^? R.responseBody)
    in operations `E.catch` handler