module Text.Parsing.StringParser.String where

import Data.String (charAt, length, take, indexOf')
import Text.Parsing.StringParser

eof :: Parser Unit
eof = Parser (\s fc sc -> case s of
  { str = str, pos = i } | i < length str -> fc i (ParseError "Expected EOF")
  _ -> sc unit s)

anyChar :: Parser String
anyChar = Parser (\s fc sc -> case s of
  { str = str, pos = i } | i < length str -> sc (charAt i str) { str: str, pos: i + 1 }
  { pos = i } -> fc i (ParseError "Unexpected EOF"))

string :: String -> Parser String
string nt = Parser (\s fc sc -> case s of
  { str = str, pos = i } | indexOf' nt i str == i -> sc nt { str: str, pos: i + length nt }
  { pos = i } -> fc i (ParseError $ "Expected '" ++ nt ++ "'."))
