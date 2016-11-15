{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

-- | Defines the endpoints listed in the
-- <http://developer.oanda.com/rest-live/transaction-history/ Transaction
-- History> section of the API.

module OANDA.Transactions
  ( Transaction (..)
  , transactionHistory
  ) where

import qualified Data.Vector as V

import OANDA.Internal

-- data TransactionArgs = TransactionArgs
--   { transactionsMaxID      :: Maybe Integer
--   , transactionsMinID      :: Maybe Integer
--   , transactionsCount      :: Maybe Integer
--   , transactionsInstrument :: Maybe InstrumentText
--   , transactionsIds        :: [Integer]
--   } deriving (Show)

-- | Get a list of transactions for the account.
transactionHistory :: OandaEnv -> AccountID -> IO (V.Vector Transaction)
transactionHistory od (AccountID aid) =
  do let url = "GET " ++ baseURL od ++ "/v1/accounts/" ++ show aid ++ "/transactions"
     request <- constructRequest od url []
     jsonResponseArray request "transactions"


data Transaction = Transaction
  { transactionId                       :: Integer
  , transactionAccountId                :: Integer
  , transactionTime                     :: ZonedTime
  , transactionType                     :: String  -- Can be an enum type in the future
  , transactionInstrument               :: Maybe InstrumentText
  , transactionSide                     :: Maybe Side
  , transactionUnits                    :: Maybe Decimal
  , transactionPrice                    :: Maybe Decimal
  , transactionLowerBound               :: Maybe Decimal
  , transactionUpperBound               :: Maybe Decimal
  , transactionTakeProfitPrice          :: Maybe Decimal
  , transactionStopLossPrice            :: Maybe Decimal
  , transactionTrailingStopLossDistance :: Maybe Decimal
  , transactionPL                       :: Maybe Decimal
  , transactionInterest                 :: Maybe Decimal
  , transactionAccountBalance           :: Maybe Decimal
  } deriving (Show, Generic)


instance FromJSON Transaction where
  parseJSON = genericParseJSON $ jsonOpts "transaction"
