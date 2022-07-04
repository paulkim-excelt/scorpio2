{-# LANGUAGE ExistentialQuantification, TupleSections #-}

module Lib
    (
        PkaNeededFeatures(..),
        PkaTestCaseTag(..),
        PkaMsgDigestAlgType(..),
        PkaEccCurveName(..),
        PkaParamType(..),
        PkaParamName,
        PkaExpectedResult(..),
        PkaTestCaseTrait(..),
        PkaTestEntityTrait(..),
        PkaRsaPadding(..),
        PkaTestCase,
        PkaTestEntity,
        getParamName,
        testEntities,
    ) where

import Data.Bits
import Data.Char
import Data.List
import Data.Word
import Data.Maybe
import Control.Monad
import Data.Either.Combinators
import Crypto.Random.Types as RandTypes
import qualified Crypto.Hash as Hash
import qualified Crypto.Hash.IO as HashIO
import qualified Crypto.Hash.Algorithms as HashAlgs
import qualified Crypto.PubKey.RSA as RSA
import qualified Crypto.PubKey.RSA.PSS as RSA_PSS
import qualified Crypto.PubKey.RSA.PKCS15 as RSA_PkcsV15
import qualified Crypto.PubKey.ECC.Types as EccTypes
import qualified Crypto.PubKey.ECC.Generate as EccGenerate
import qualified Crypto.PubKey.ECC.ECDSA as Ecdsa
import qualified Crypto.PubKey.ECC.DH as Ecdh
import qualified Data.ByteArray as BA
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BSC
import qualified Data.ByteString.Conversion as BSConv

-------------------------------------------------------------------------------
-- Top level type classes and ADT's
-------------------------------------------------------------------------------
data PkaNeededFeatures =
    FeatureRsaOps |
    FeatureRsa2k |
    FeatureSecp256R1 |
    FeatureSecp384R1 |
    FeatureEcdsaSign |
    FeatureEcdsaVerify |
    FeatureEcdhe deriving (Show)

data PkaRsaPadding =
    PSS |
    PKCSv15 deriving(Show)

data PkaTestCaseTag =
    RsaVerify |
    EcdsaSign |
    EcdsaVerify |
    Ecdh |
    Ecdhe deriving(Show)

data PkaMsgDigestAlgType =
    Sha256 |
    Sha384 |
    Sha512 deriving(Show)

data PkaEccCurveName =
    Secp256R1 |
    Secp384R1 deriving(Show)

data PkaParamType =
    BigNum Integer |
    Octets [Word8] |
    MsgDigestAlg PkaMsgDigestAlgType |
    RsaPadding PkaRsaPadding |
    CurveName PkaEccCurveName

newtype PkaParamName = PkaParamName String
getParamName :: PkaParamName -> String
getParamName (PkaParamName a) = a

data PkaExpectedResult =
    Ok |
    Again |
    InvalParams |
    AuthFailed deriving(Show)

class PkaTestCaseTrait a where
    testName                :: a -> String
    testCaseTag             :: a -> PkaTestCaseTag
    testCaseNeededFeatures  :: a -> [PkaNeededFeatures]
    expectedResult          :: a -> PkaExpectedResult
    params                  :: a -> [(PkaParamName, PkaParamType)]

data PkaTestCase = forall a . PkaTestCaseTrait a =>  MkPkaTestCase a
instance PkaTestCaseTrait PkaTestCase where
    testName (MkPkaTestCase a) = testName a
    testCaseTag (MkPkaTestCase a) = testCaseTag a
    testCaseNeededFeatures (MkPkaTestCase a) = testCaseNeededFeatures a
    expectedResult (MkPkaTestCase a) = expectedResult a
    params (MkPkaTestCase a) = params a

class PkaTestEntityTrait a where
    testEntityName :: a -> String
    testEntityTag  :: a -> PkaTestCaseTag
    getDummyTest   :: a -> PkaTestCase
    getFuncTests   :: a -> IO [PkaTestCase]
    getProfTests   :: a -> IO [PkaTestCase]

data PkaTestEntity = forall a . PkaTestEntityTrait a =>  MkPkaTestEntity a
instance PkaTestEntityTrait PkaTestEntity where
    testEntityName (MkPkaTestEntity a) = testEntityName a
    testEntityTag (MkPkaTestEntity a) = testEntityTag a
    getDummyTest (MkPkaTestEntity a) = getDummyTest a
    getFuncTests (MkPkaTestEntity a) = getFuncTests a
    getProfTests (MkPkaTestEntity a) = getProfTests a

-------------------------------------------------------------------------------
-- Common helpers
-------------------------------------------------------------------------------

-- Helper to convert [Word8] to Integer
getIntegerFromWord8 :: [Word8] -> Integer
getIntegerFromWord8 lst = foldl helper (0::Integer) lst where
    helper x y = (shiftL x 8) .|. (fromIntegral y)

-- Helper to compute hash
computeHash :: String -> PkaMsgDigestAlgType -> Integer
computeHash msg Sha256 = getIntegerFromWord8 $ BA.unpack (Hash.hash $ BSC.pack msg :: Hash.Digest Hash.SHA256)
computeHash msg Sha384 = getIntegerFromWord8 $ BA.unpack (Hash.hash $ BSC.pack msg :: Hash.Digest Hash.SHA384)
computeHash msg Sha512 = getIntegerFromWord8 $ BA.unpack (Hash.hash $ BSC.pack msg :: Hash.Digest Hash.SHA512)

-------------------------------------------------------------------------------
-- RSA  verification test cases
-------------------------------------------------------------------------------
-- Test case data ADT

data PkaRsaVerifyTestCase = PkaRsaVerifyTestCase  { rsaVerifyTestName               :: String
                                                    , rsaVerifyTestNeededFeatures   :: [PkaNeededFeatures]
                                                    , rsaVerifyTestPadding          :: PkaRsaPadding
                                                    , rsaVerifyTestResult           :: PkaExpectedResult
                                                    , rsaVerifyTestDigestAlg        :: PkaMsgDigestAlgType
                                                    , rsaVerifyTestMsgHash          :: Integer
                                                    , rsaVerifyTestRsaModulus       :: Integer
                                                    , rsaVerifyTestRsaExponent      :: Integer
                                                    , rsaVerifyTestSignVal          :: Integer
                                                    } deriving (Show)

-- Implement PkaTestCaseTrait instance
instance PkaTestCaseTrait PkaRsaVerifyTestCase where
    testName t = rsaVerifyTestName t
    testCaseTag _ = RsaVerify
    testCaseNeededFeatures t = rsaVerifyTestNeededFeatures t
    expectedResult t = rsaVerifyTestResult t
    params t = [(PkaParamName "sigScheme", RsaPadding $ rsaVerifyTestPadding t),
                (PkaParamName "msgDigestAlg", MsgDigestAlg $ rsaVerifyTestDigestAlg t),
                (PkaParamName "msgHash", BigNum $ rsaVerifyTestMsgHash t),
                (PkaParamName "rsaModulus", BigNum $ rsaVerifyTestRsaModulus t),
                (PkaParamName "rsaExponent", BigNum $ rsaVerifyTestRsaExponent t),
                (PkaParamName "signature", BigNum $ rsaVerifyTestSignVal t)
               ]

-- RSA  verify test entity
data PkaRsaVerifyTestEntity = PkaRsaVerifyTestEntity

-- Implement PkaTestEntityTrait instance
instance PkaTestEntityTrait PkaRsaVerifyTestEntity where
    testEntityName _ = "PkaRsaVerify"
    testEntityTag _ = RsaVerify
    getDummyTest _ = MkPkaTestCase $ PkaRsaVerifyTestCase "DummyTest" [] PKCSv15 Ok Sha256 12 13 14 15
    getFuncTests _ = generateRsaVerifyFuncTestCases
    getProfTests _ = generateRsaVerifyProfTestCases

-- Corruptions to be introduced for the negative tests
data PkaRsaVerifyCorruptType =
    BadHash |
    BadModulus |
    BadExp |
    BadSignature deriving(Show)

-- Generate func test cases
generateRsaVerifyFuncTestCases :: IO [PkaTestCase]
generateRsaVerifyFuncTestCases = res where
    modSizes = [256]
    digestAlgs = [Sha256]
    padding = [PSS, PKCSv15]
    negTestCorruptTypes = [BadHash, BadModulus, BadExp, BadSignature]

    -- Positive tests
    posTestMsgs = ["Lazy cats, brown dogs...", "Brown cats, big dogs..."]
    posTestCaseParams = map appendTestCaseName (zip [0..] [(m, x, y, z) | m <- posTestMsgs,  x <- modSizes, y <- digestAlgs, z <- padding])
    posTests = fmap catMaybes $ sequence $ map generateRsaVerifyPosTestCase posTestCaseParams

    -- Negative tests
    negTestMsgs = ["Mega cats, funny dogs..."]
    (negTestCorr, negTestCaseParams) = genNegTestCaseParams (zip [0..][(c, m, x, y, z) | c <- negTestCorruptTypes, m <- negTestMsgs, x <- modSizes, y <- digestAlgs, z <- padding])
    negTestsNoCorruptionAugmented = fmap catMaybes $ fmap (zipWith (\x y -> fmap (x, ) y) negTestCorr) $ sequence $ map generateRsaVerifyPosTestCase negTestCaseParams
    negTests = fmap (map constructNegativeTest) negTestsNoCorruptionAugmented

    -- Final concatenation
    res = do
        pos <- posTests
        neg <- negTests
        pure $ map MkPkaTestCase (pos ++ neg)

    -- Introduce corruptions to generate negative test cases
    constructNegativeTest :: (PkaRsaVerifyCorruptType, PkaRsaVerifyTestCase) -> PkaRsaVerifyTestCase
    constructNegativeTest (cor, testCase) = res where
        res = case cor of BadHash -> testCase { rsaVerifyTestResult = AuthFailed, rsaVerifyTestMsgHash = ((rsaVerifyTestMsgHash testCase) + 10) }
                          BadModulus -> testCase { rsaVerifyTestResult = AuthFailed, rsaVerifyTestRsaModulus = (rsaVerifyTestRsaModulus testCase) + 1 }
                          BadExp -> testCase { rsaVerifyTestResult = AuthFailed, rsaVerifyTestRsaExponent = (rsaVerifyTestRsaExponent testCase) + 2 }
                          BadSignature -> testCase { rsaVerifyTestResult = AuthFailed, rsaVerifyTestSignVal = (rsaVerifyTestSignVal testCase) + 5 }

    -- Helper to generate a positive test case name
    appendTestCaseName :: (Int, (String , Int, PkaMsgDigestAlgType, PkaRsaPadding)) -> (String, String, Int, PkaMsgDigestAlgType, PkaRsaPadding)
    appendTestCaseName (id, (msg, modSize, digestAlg, padding)) = (name, msg, modSize, digestAlg, padding) where
        name = "PKA_FUNC_TEST_RSAVERIFY_" ++ show (modSize * 8) ++ "_" ++ (map toUpper $ show digestAlg) ++ "_" ++  (map toUpper $ show padding) ++ "_ID" ++ show id

    -- Helper to generate negative test names and a few more helper activities
    genNegTestCaseParams :: [(Int, (PkaRsaVerifyCorruptType, String, Int, PkaMsgDigestAlgType, PkaRsaPadding))] -> ([PkaRsaVerifyCorruptType], [(String, String, Int, PkaMsgDigestAlgType, PkaRsaPadding)])
    genNegTestCaseParams inp = (res1, res2) where
        res1 = map (\(_, (x, _, _, _, _)) -> x) inp
        res2 = map genNegTestNames inp
        genNegTestNames (id, (cor, msg, modSize, digestAlg, padding)) = (name, msg, modSize, digestAlg, padding) where
            name = case cor of BadHash -> "PKA_FUNC_TEST_RSAVERIFY_BAD_HASH_" ++ show (modSize * 8) ++ "_" ++ (map toUpper $ show digestAlg) ++ "_" ++  (map toUpper $ show padding) ++ "_ID" ++  show id
                               BadModulus -> "PKA_FUNC_TEST_RSAVERIFY_BAD_MODULUS_" ++ show (modSize * 8) ++ "_" ++ (map toUpper $ show digestAlg) ++ "_" ++  (map toUpper $ show padding) ++ "_ID" ++  show id
                               BadExp -> "PKA_FUNC_TEST_RSAVERIFY_BAD_EXP_" ++ show (modSize * 8) ++ "_" ++ (map toUpper $ show digestAlg) ++ "_" ++  (map toUpper $ show padding) ++ "_ID" ++  show id
                               BadSignature -> "PKA_FUNC_TEST_RSAVERIFY_BAD_SIG_" ++ show (modSize * 8) ++ "_" ++ (map toUpper $ show digestAlg) ++ "_" ++  (map toUpper $ show padding)  ++ "_ID" ++  show id

-- Generate prof test cases
generateRsaVerifyProfTestCases :: IO [PkaTestCase]
generateRsaVerifyProfTestCases = res where
    msgs = ["The quick brown fox jumps over the lazy dog"]
    modSizes = [256]
    digestAlgs = [Sha256]
    padding = [PSS, PKCSv15]
    testCaseParams = map appendTestCaseName [(m, x, y, z) | m <- msgs,  x <- modSizes, y <- digestAlgs, z <- padding]
    res = fmap (map MkPkaTestCase) $ fmap catMaybes $ sequence $ map generateRsaVerifyPosTestCase testCaseParams

    -- Helper to generate test case name
    appendTestCaseName :: (String , Int, PkaMsgDigestAlgType, PkaRsaPadding) -> (String, String, Int, PkaMsgDigestAlgType, PkaRsaPadding)
    appendTestCaseName (msg, modSize, digestAlg, padding) = (name, msg, modSize, digestAlg, padding) where
        name = "PKA_PROF_TEST_RSAVERIFY_" ++ show (modSize * 8) ++ "_" ++ (map toUpper $ show digestAlg) ++ "_" ++  (map toUpper $ show padding)

-- Generate one positive test case
generateRsaVerifyPosTestCase :: (String, String, Int, PkaMsgDigestAlgType, PkaRsaPadding) -> IO (Maybe PkaRsaVerifyTestCase)
generateRsaVerifyPosTestCase (name, msg, modSize, digestAlg, padding) = do
    (pubKey, privKey) <- RSA.generate modSize (65537::Integer)
    salt <- RandTypes.getRandomBytes (getSaltLen digestAlg)
    pure $ genTest pubKey privKey salt where
        -- Heper to generate needed features
        getNeededFeatures :: Int -> [PkaNeededFeatures]
        getNeededFeatures (256) = [FeatureRsaOps, FeatureRsa2k]

        -- Helper to get PSS params from digest
        getSaltLen :: PkaMsgDigestAlgType -> Int
        getSaltLen Sha256 = HashIO.hashDigestSize HashAlgs.SHA256
        getSaltLen Sha384 = HashIO.hashDigestSize HashAlgs.SHA384
        getSaltLen Sha512 = HashIO.hashDigestSize HashAlgs.SHA512

        -- Top level helper to generate a test
        genTest :: RSA.PublicKey -> RSA.PrivateKey -> BSC.ByteString -> Maybe PkaRsaVerifyTestCase
        genTest pubKey privKey salt = do
            (hash, signature) <- rsaHashAndSign msg digestAlg privKey salt padding
            Just $ PkaRsaVerifyTestCase name (getNeededFeatures modSize) padding Ok digestAlg hash (RSA.public_n pubKey) (RSA.public_e pubKey) signature

        -- Helper to hash and perform RSA  signature generation
        rsaHashAndSign :: String -> PkaMsgDigestAlgType -> RSA.PrivateKey -> BSC.ByteString -> PkaRsaPadding -> Maybe (Integer, Integer)
        rsaHashAndSign msg digestAlg privKey salt padding = res where
            hashVal = computeHash msg digestAlg
            res = do
                signVal <- rsaSignWrapper msg digestAlg privKey salt padding
                Just (hashVal, getIntegerFromWord8 signVal)

        -- Helper to compute signature
        rsaSignWrapper :: String -> PkaMsgDigestAlgType -> RSA.PrivateKey -> BSC.ByteString -> PkaRsaPadding -> Maybe [Word8]
        rsaSignWrapper msg Sha256 privKey salt PKCSv15 = fmap BA.unpack (rightToMaybe $ RSA_PkcsV15.sign Nothing (Just HashAlgs.SHA256) privKey (BSC.pack msg))
        rsaSignWrapper msg Sha256 privKey salt PSS     = fmap BA.unpack (rightToMaybe $ RSA_PSS.signWithSalt salt Nothing (RSA_PSS.defaultPSSParams HashAlgs.SHA256) privKey (BSC.pack msg))
        rsaSignWrapper msg Sha384 privKey salt PKCSv15 = fmap BA.unpack (rightToMaybe $ RSA_PkcsV15.sign Nothing (Just HashAlgs.SHA384) privKey (BSC.pack msg))
        rsaSignWrapper msg Sha384 privKey salt PSS     = fmap BA.unpack (rightToMaybe $ RSA_PSS.signWithSalt salt Nothing (RSA_PSS.defaultPSSParams HashAlgs.SHA384) privKey (BSC.pack msg))
        rsaSignWrapper msg Sha512 privKey salt PKCSv15 = fmap BA.unpack (rightToMaybe $ RSA_PkcsV15.sign Nothing (Just HashAlgs.SHA512) privKey (BSC.pack msg))
        rsaSignWrapper msg Sha512 privKey salt PSS     = fmap BA.unpack (rightToMaybe $ RSA_PSS.signWithSalt salt Nothing (RSA_PSS.defaultPSSParams HashAlgs.SHA512) privKey (BSC.pack msg))

-------------------------------------------------------------------------------
-- ECDSA sign test cases
-------------------------------------------------------------------------------
-- Test case data ADT
data PkaEcdsaSignTestCase = PkaEcdsaSignTestCase { ecdsaSignTestName            :: String
                                                 , ecdsaSignTestNeededFeatures  :: [PkaNeededFeatures]
                                                 , ecdsaSignTestResult          :: PkaExpectedResult
                                                 , ecdsaSignTestCurveName       :: PkaEccCurveName
                                                 , ecdsaSignTestPrivKey         :: Integer
                                                 , ecdsaSignTestNonce           :: Integer
                                                 , ecdsaSignTestMsgHash         :: Integer
                                                 , ecdsaSignTestSignValR        :: Integer
                                                 , ecdsaSignTestSignValS        :: Integer
                                                 } deriving(Show)

-- Implement PkaTestCaseTrait instance
instance PkaTestCaseTrait PkaEcdsaSignTestCase where
    testName t = ecdsaSignTestName t
    testCaseTag _ = EcdsaSign
    testCaseNeededFeatures t = ecdsaSignTestNeededFeatures t
    expectedResult t = ecdsaSignTestResult t
    params t = [(PkaParamName "ecGroup", CurveName $ ecdsaSignTestCurveName t),
                (PkaParamName "privKey", BigNum $ ecdsaSignTestPrivKey t),
                (PkaParamName "randNonce", BigNum $ ecdsaSignTestNonce t),
                (PkaParamName "msgHash", BigNum $ ecdsaSignTestMsgHash t),
                (PkaParamName "signatureR", BigNum $ ecdsaSignTestSignValR t),
                (PkaParamName "signatureS", BigNum $ ecdsaSignTestSignValS t)
               ]

-- ECDSA sign test entity
data PkaEcdsaSignTestEntity = PkaEcdsaSignTestEntity

-- Implement PkaTestEntityTrait instance
instance PkaTestEntityTrait PkaEcdsaSignTestEntity where
    testEntityName _ = "PkaEcdsaSign"
    testEntityTag _ = EcdsaSign
    getDummyTest _ = MkPkaTestCase $ PkaEcdsaSignTestCase "DummyTest" [] Ok Secp256R1 11 12 13 14 15
    getFuncTests _ = generateEcdsaSignFuncTestCases
    getProfTests _ = generateEcdsaSignProfTestCases

-- Corruptions to be introduced for the negative tests
data PkaEcdsaSignCorruptType =
    BadNonce deriving(Show)

-- Generate func test cases
generateEcdsaSignFuncTestCases :: IO [PkaTestCase]
generateEcdsaSignFuncTestCases = res where
    digestAlgs = [Sha256]
    curveNames = [Secp256R1]
    negTestCorruptTypes = [BadNonce]

    -- Positive tests
    posTestMsgs = ["Brown potato and fine tomato", "Fine potato and blue tomato"]
    posTestCaseParams = map appendTestCaseName (zip [0..] [(m, c, d) | m <- posTestMsgs,  c <- curveNames, d <- digestAlgs])
    posTests = fmap catMaybes $ sequence $ map generateEcdsaSignPosTestCase posTestCaseParams

    -- Negative tests
    negTestMsgs = ["Black potato and blue tomato"]
    (negTestCorr, negTestCaseParams) = genNegTestCaseParams (zip [0..] [(cor, m, c, d) | cor <- negTestCorruptTypes, m <- posTestMsgs,  c <- curveNames, d <- digestAlgs])
    negTestsNoCorruptionAugmented = fmap catMaybes $ fmap (zipWith (\x y -> fmap (x, ) y) negTestCorr) $ sequence $ map generateEcdsaSignPosTestCase negTestCaseParams
    negTests = fmap (map constructNegativeTest) negTestsNoCorruptionAugmented

    -- Helper to generate a positive test case name
    appendTestCaseName :: (Int, (String , PkaEccCurveName, PkaMsgDigestAlgType)) -> (String, String, PkaEccCurveName, PkaMsgDigestAlgType)
    appendTestCaseName (id, (msg, curveName, digestAlg)) = (name, msg, curveName, digestAlg) where
        name = "PKA_FUNC_TEST_ECDSASIGN_" ++ (map toUpper $ show curveName) ++ "_" ++ (map toUpper $ show digestAlg) ++ "_ID" ++ show id

    -- Helper to generate negative test names and a few more helper activities
    genNegTestCaseParams :: [(Int, (PkaEcdsaSignCorruptType, String, PkaEccCurveName, PkaMsgDigestAlgType))] -> ([PkaEcdsaSignCorruptType], [(String, String, PkaEccCurveName, PkaMsgDigestAlgType)])
    genNegTestCaseParams inp = (res1, res2) where
        res1 = map (\(_, (x, _, _, _)) -> x) inp
        res2 = map genNegTestNames inp
        genNegTestNames (id, (cor, msg, curveName, digestAlg)) = (name, msg, curveName, digestAlg) where
            name = case cor of BadNonce -> "PKA_FUNC_TEST_ECDSASIGN_BAD_NONCE_" ++ (map toUpper $ show curveName) ++ "_" ++ (map toUpper $ show digestAlg)  ++ "_ID" ++ show id

    -- Generate negative test from positive tests
    constructNegativeTest :: (PkaEcdsaSignCorruptType, PkaEcdsaSignTestCase) -> PkaEcdsaSignTestCase
    constructNegativeTest (cor, testCase) = res where
        res = case cor of BadNonce -> testCase { ecdsaSignTestResult = Again, ecdsaSignTestMsgHash = (getHashToTriggerRetry (ecdsaSignTestCurveName testCase) (ecdsaSignTestPrivKey testCase) (ecdsaSignTestSignValR testCase))}

    -- Compute a hash that should make the ECDSA algorithm to fail with EAGAIN
    getHashToTriggerRetry :: PkaEccCurveName -> Integer -> Integer -> Integer
    getHashToTriggerRetry Secp256R1 d r = (- r * d) `mod` (EccTypes.ecc_n $ EccTypes.common_curve $ EccTypes.getCurveByName EccTypes.SEC_p256r1)

    -- Final concatenation
    res = do
        pos <- posTests
        neg <- negTests
        pure $ map MkPkaTestCase (pos ++ neg)

-- Generate prof test cases
generateEcdsaSignProfTestCases :: IO [PkaTestCase]
generateEcdsaSignProfTestCases = res where
    msgs = ["The quick brown fox and the lazy dog saga"]
    digestAlgs = [Sha256]
    curveNames = [Secp256R1]
    testCaseParams = map appendTestCaseName [(m, c, d) | m <- msgs,  c <- curveNames, d <- digestAlgs]
    res = fmap (map MkPkaTestCase) $ fmap catMaybes $ sequence $ map generateEcdsaSignPosTestCase testCaseParams

    -- Helper to generate test case name
    appendTestCaseName :: (String , PkaEccCurveName, PkaMsgDigestAlgType) -> (String, String, PkaEccCurveName, PkaMsgDigestAlgType)
    appendTestCaseName (msg, curveName, digestAlg) = (name, msg, curveName, digestAlg) where
        name = "PKA_PROF_TEST_ECDSASIGN_" ++ (map toUpper $ show curveName) ++ "_" ++ (map toUpper $ show digestAlg)

-- Generate one positive test case
generateEcdsaSignPosTestCase :: (String, String, PkaEccCurveName, PkaMsgDigestAlgType) -> IO (Maybe PkaEcdsaSignTestCase)
generateEcdsaSignPosTestCase (name, msg, curveName, digestAlg) = do
    randInt <- fmap (getIntegerFromWord8.(BA.unpack)) (RandTypes.getRandomBytes numBytes :: IO (BA.Bytes))
    (pubKey, privKey) <- EccGenerate.generate curve
    pure $ signAndGenerateTestCase name msg curveName randInt privKey digestAlg where

    -- Heper to generate needed features
    getNeededFeatures :: PkaEccCurveName -> [PkaNeededFeatures]
    getNeededFeatures Secp256R1 = [FeatureEcdsaSign, FeatureSecp256R1]

    -- Get curve from name
    curve = case curveName of Secp256R1 -> EccTypes.getCurveByName EccTypes.SEC_p256r1

    -- Get random nonce bytes
    numBytes = case curveName of Secp256R1 -> 32::Int

    -- Sign and generate a test case
    signAndGenerateTestCase :: String -> String -> PkaEccCurveName -> Integer -> Ecdsa.PrivateKey -> PkaMsgDigestAlgType -> Maybe PkaEcdsaSignTestCase
    signAndGenerateTestCase name msg curveName k privKey digestAlg = res where
        signVal = signWrapper k privKey digestAlg msg
        res = fmap (generateTestCase name curveName privKey k msg digestAlg) signVal

    -- Helper to sign a message
    signWrapper :: Integer -> Ecdsa.PrivateKey -> PkaMsgDigestAlgType -> String -> Maybe Ecdsa.Signature
    signWrapper k privKey Sha256 msg = Ecdsa.signWith k privKey HashAlgs.SHA256 (BSC.pack msg)
    signWrapper k privKey Sha384 msg = Ecdsa.signWith k privKey HashAlgs.SHA384 (BSC.pack msg)
    signWrapper k privKey Sha512 msg = Ecdsa.signWith k privKey HashAlgs.SHA512 (BSC.pack msg)

    -- Helper to generate a test case instance
    generateTestCase :: String -> PkaEccCurveName -> Ecdsa.PrivateKey -> Integer -> String -> PkaMsgDigestAlgType -> Ecdsa.Signature -> PkaEcdsaSignTestCase
    generateTestCase name curveName privKey k msg digestAlg sign = PkaEcdsaSignTestCase name (getNeededFeatures curveName) Ok curveName (Ecdsa.private_d privKey) k (computeHash msg digestAlg) (Ecdsa.sign_r sign) (Ecdsa.sign_s sign)

-------------------------------------------------------------------------------
-- ECDSA verify test cases
-------------------------------------------------------------------------------
-- Test case data ADT
data PkaEcdsaVerifyTestCase = PkaEcdsaVerifyTestCase { ecdsaVerifyTestName              :: String
                                                     , ecdsaVerifyTestNeededFeatures    :: [PkaNeededFeatures]
                                                     , ecdsaVerifyTestResult            :: PkaExpectedResult
                                                     , ecdsaVerifyTestCurveName         :: PkaEccCurveName
                                                     , ecdsaVerifyTestPubKeyX           :: Integer
                                                     , ecdsaVerifyTestPubKeyY           :: Integer
                                                     , ecdsaVerifyTestMsgHash           :: Integer
                                                     , ecdsaVerifyTestSignValR          :: Integer
                                                     , ecdsaVerifyTestSignValS          :: Integer
                                                     } deriving(Show)

-- Implement PkaTestCaseTrait instance
instance PkaTestCaseTrait PkaEcdsaVerifyTestCase where
    testName t = ecdsaVerifyTestName t
    testCaseTag _ = EcdsaVerify
    testCaseNeededFeatures t = ecdsaVerifyTestNeededFeatures t
    expectedResult t = ecdsaVerifyTestResult t
    params t = [(PkaParamName "ecGroup", CurveName $ ecdsaVerifyTestCurveName t),
                (PkaParamName "pubKeyX", BigNum $ ecdsaVerifyTestPubKeyX t),
                (PkaParamName "pubKeyY", BigNum $ ecdsaVerifyTestPubKeyY t),
                (PkaParamName "msgHash", BigNum $ ecdsaVerifyTestMsgHash t),
                (PkaParamName "signatureR", BigNum $ ecdsaVerifyTestSignValR t),
                (PkaParamName "signatureS", BigNum $ ecdsaVerifyTestSignValS t)
               ]

-- ECDSA verify test entity
data PkaEcdsaVerifyTestEntity = PkaEcdsaVerifyTestEntity

-- Implement PkaTestEntityTrait instance
instance PkaTestEntityTrait PkaEcdsaVerifyTestEntity where
    testEntityName _ = "PkaEcdsaVerify"
    testEntityTag _ = EcdsaVerify
    getDummyTest _ = MkPkaTestCase $ PkaEcdsaVerifyTestCase "FuncTest" [] Ok Secp256R1 12 13 14 15 16
    getFuncTests _ = generateEcdsaVerifyFuncTestCases
    getProfTests _ = generateEcdsaVerifyProfTestCases

-- Corruptions to be introduced for the negative tests
data PkaEcdsaVerifyCorruptType =
    BadHash_ |
    BadPubKeyX |
    BadPubKeyY |
    BadSignatureR |
    BadSignatureS deriving(Show)

-- Generate func test cases
generateEcdsaVerifyFuncTestCases :: IO [PkaTestCase]
generateEcdsaVerifyFuncTestCases = res where
    curveNamesDigestAlgs = [(Secp256R1, Sha256), (Secp384R1, Sha384)]
    negTestCorruptTypes = [BadHash_, BadPubKeyX, BadPubKeyY, BadSignatureR, BadSignatureS]

    -- Positive tests
    posTestMsgs = ["Blue potato and fine tomato", "Fine potato and black tomato"]
    posTestCaseParams = map appendTestCaseName (zip [0..] [(m, c, d) | m <- posTestMsgs, (c, d) <- curveNamesDigestAlgs])
    posTests = fmap catMaybes $ sequence $ map generateEcdsaVerifyPosTestCase posTestCaseParams

    -- Negative tests
    negTestMsgs = ["Black potato and green tomato"]
    (negTestCorr, negTestCaseParams) = genNegTestCaseParams (zip [0..] [(cor, m, c, d) | cor <- negTestCorruptTypes, m <- posTestMsgs,  (c, d) <- curveNamesDigestAlgs])
    negTestsNoCorruptionAugmented = fmap catMaybes $ fmap (zipWith (\x y -> fmap (x, ) y) negTestCorr) $ sequence $ map generateEcdsaVerifyPosTestCase negTestCaseParams
    negTests = fmap (map constructNegativeTest) negTestsNoCorruptionAugmented

    -- Helper to generate a positive test case name
    appendTestCaseName :: (Int, (String , PkaEccCurveName, PkaMsgDigestAlgType)) -> (String, String, PkaEccCurveName, PkaMsgDigestAlgType)
    appendTestCaseName (id, (msg, curveName, digestAlg)) = (name, msg, curveName, digestAlg) where
        name = "PKA_FUNC_TEST_ECDSAVERIFY_" ++ (map toUpper $ show curveName) ++ "_" ++ (map toUpper $ show digestAlg) ++ "_ID" ++ show id

    -- Helper to generate negative test names and a few more helper activities
    genNegTestCaseParams :: [(Int, (PkaEcdsaVerifyCorruptType, String, PkaEccCurveName, PkaMsgDigestAlgType))] -> ([PkaEcdsaVerifyCorruptType], [(String, String, PkaEccCurveName, PkaMsgDigestAlgType)])
    genNegTestCaseParams inp = (res1, res2) where
        res1 = map (\(_, (x, _, _, _)) -> x) inp
        res2 = map genNegTestNames inp
        genNegTestNames (id, (cor, msg, curveName, digestAlg)) = (name, msg, curveName, digestAlg) where
            name = case cor of BadHash_ -> "PKA_FUNC_TEST_ECDSAVERIFY_BAD_HASH_" ++ (map toUpper $ show curveName) ++ "_" ++ (map toUpper $ show digestAlg)  ++ "_ID" ++ show id
                               BadPubKeyX -> "PKA_FUNC_TEST_ECDSAVERIFY_BAD_PUBKEY_X_" ++ (map toUpper $ show curveName) ++ "_" ++ (map toUpper $ show digestAlg) ++ "_ID" ++ show id
                               BadPubKeyY -> "PKA_FUNC_TEST_ECDSAVERIFY_BAD_PUBKEY_Y_" ++ (map toUpper $ show curveName) ++ "_" ++ (map toUpper $ show digestAlg) ++ "_ID" ++ show id
                               BadSignatureR -> "PKA_FUNC_TEST_ECDSAVERIFY_BAD_SIGN_R_" ++ (map toUpper $ show curveName) ++ "_" ++ (map toUpper $ show digestAlg) ++ "_ID" ++ show id
                               BadSignatureS -> "PKA_FUNC_TEST_ECDSAVERIFY_BAD_SIGN_S_" ++ (map toUpper $ show curveName) ++ "_" ++ (map toUpper $ show digestAlg) ++ "_ID" ++ show id

    -- Generate negative test from positive tests
    constructNegativeTest :: (PkaEcdsaVerifyCorruptType, PkaEcdsaVerifyTestCase) -> PkaEcdsaVerifyTestCase
    constructNegativeTest (cor, testCase) = res where
        res = case cor of BadHash_ -> testCase { ecdsaVerifyTestResult = AuthFailed, ecdsaVerifyTestMsgHash = ((ecdsaVerifyTestMsgHash testCase) + 11) }
                          BadPubKeyX -> testCase { ecdsaVerifyTestResult = AuthFailed, ecdsaVerifyTestPubKeyX = ((ecdsaVerifyTestPubKeyX testCase) + 1)  }
                          BadPubKeyY -> testCase { ecdsaVerifyTestResult = AuthFailed, ecdsaVerifyTestPubKeyY = ((ecdsaVerifyTestPubKeyY testCase) + 30)  }
                          BadSignatureR -> testCase { ecdsaVerifyTestResult = AuthFailed, ecdsaVerifyTestSignValR = ((ecdsaVerifyTestSignValR testCase) + 15)  }
                          BadSignatureS -> testCase { ecdsaVerifyTestResult = AuthFailed, ecdsaVerifyTestSignValS = ((ecdsaVerifyTestSignValS testCase) + 4)  }

    -- Final concatenation
    res = do
        pos <- posTests
        neg <- negTests
        pure $ map MkPkaTestCase (pos ++ neg)

-- Generate prof test cases
generateEcdsaVerifyProfTestCases :: IO [PkaTestCase]
generateEcdsaVerifyProfTestCases = res where
    msgs = ["The quick brown fox and the lazy dog saga continues"]
    curveNamesDigestAlgs = [(Secp256R1, Sha256), (Secp384R1, Sha384)]
    testCaseParams = map appendTestCaseName [(m, c, d) | m <- msgs,  (c, d) <- curveNamesDigestAlgs]
    res = fmap (map MkPkaTestCase) $ fmap catMaybes $ sequence $ map generateEcdsaVerifyPosTestCase testCaseParams

    -- Helper to generate test case name
    appendTestCaseName :: (String , PkaEccCurveName, PkaMsgDigestAlgType) -> (String, String, PkaEccCurveName, PkaMsgDigestAlgType)
    appendTestCaseName (msg, curveName, digestAlg) = (name, msg, curveName, digestAlg) where
        name = "PKA_PROF_TEST_ECDSAVERIFY_" ++ (map toUpper $ show curveName) ++ "_" ++ (map toUpper $ show digestAlg)

-- Generate one positive test case
generateEcdsaVerifyPosTestCase :: (String, String, PkaEccCurveName, PkaMsgDigestAlgType) -> IO (Maybe PkaEcdsaVerifyTestCase)
generateEcdsaVerifyPosTestCase (name, msg, curveName, digestAlg) = do
    randInt <- fmap (getIntegerFromWord8.(BA.unpack)) (RandTypes.getRandomBytes numBytes :: IO (BA.Bytes))
    (pubKey, privKey) <- EccGenerate.generate curve
    pure $ signAndGenerateTestCase name msg curveName randInt pubKey privKey digestAlg where

    -- Heper to generate needed features
    getNeededFeatures :: PkaEccCurveName -> [PkaNeededFeatures]
    getNeededFeatures Secp256R1 = [FeatureEcdsaVerify, FeatureSecp256R1]
    getNeededFeatures Secp384R1 = [FeatureEcdsaVerify, FeatureSecp384R1]

    -- Get curve from name
    curve = case curveName of Secp256R1 -> EccTypes.getCurveByName EccTypes.SEC_p256r1
                              Secp384R1 -> EccTypes.getCurveByName EccTypes.SEC_p384r1

    -- Get random nonce bytes
    numBytes = case curveName of Secp256R1 -> 32::Int
                                 Secp384R1 -> 48::Int

    -- Sign and generate a test case
    signAndGenerateTestCase :: String -> String -> PkaEccCurveName -> Integer -> Ecdsa.PublicKey -> Ecdsa.PrivateKey -> PkaMsgDigestAlgType -> Maybe PkaEcdsaVerifyTestCase
    signAndGenerateTestCase name msg curveName k pubKey privKey digestAlg = res where
        signVal = signWrapper k privKey digestAlg msg
        res = fmap (generateTestCase name curveName pubKey msg digestAlg) signVal

    -- Helper to sign a message
    signWrapper :: Integer -> Ecdsa.PrivateKey -> PkaMsgDigestAlgType -> String -> Maybe Ecdsa.Signature
    signWrapper k privKey Sha256 msg = Ecdsa.signWith k privKey HashAlgs.SHA256 (BSC.pack msg)
    signWrapper k privKey Sha384 msg = Ecdsa.signWith k privKey HashAlgs.SHA384 (BSC.pack msg)
    signWrapper k privKey Sha512 msg = Ecdsa.signWith k privKey HashAlgs.SHA512 (BSC.pack msg)

    -- Helper to generate a test case instance
    generateTestCase :: String -> PkaEccCurveName -> Ecdsa.PublicKey -> String -> PkaMsgDigestAlgType -> Ecdsa.Signature -> PkaEcdsaVerifyTestCase
    generateTestCase name curveName pubKey msg digestAlg sign = PkaEcdsaVerifyTestCase name (getNeededFeatures curveName) Ok curveName ptx pty (computeHash msg digestAlg) (Ecdsa.sign_r sign) (Ecdsa.sign_s sign) where
        (ptx, pty) = case (Ecdsa.public_q pubKey) of EccTypes.Point x y -> (x, y)

-------------------------------------------------------------------------------
-- ECDH/ECDHE test cases
-------------------------------------------------------------------------------
-- Test case data ADT
data PkaEcdheTestCase = PkaEcdheTestCase { ecdheTestName            :: String
                                         , ecdheTestNeededFeatures  :: [PkaNeededFeatures]
                                         , ecdheTestResult          :: PkaExpectedResult
                                         , ecdheTestCurveName       :: PkaEccCurveName
                                         , localPrivKey             :: Integer
                                         , localPubKeyX             :: Integer
                                         , localPubKeyY             :: Integer
                                         , remotePubKeyX            :: Integer
                                         , remotePubKeyY            :: Integer
                                         , sharedSecret             :: [Word8]
                                         } deriving(Show)

newtype PkaEcdhTestCase = PkaEcdhTestCase PkaEcdheTestCase

-- Implement PkaTestCaseTrait instance
instance PkaTestCaseTrait PkaEcdheTestCase where
    testName t = ecdheTestName t
    testCaseTag _ = Ecdhe
    testCaseNeededFeatures t = ecdheTestNeededFeatures t
    expectedResult t = ecdheTestResult t
    params t = [(PkaParamName "ecGroup", CurveName $ ecdheTestCurveName t),
                (PkaParamName "privKey", BigNum $ localPrivKey t),
                (PkaParamName "localPubKeyX", BigNum $ localPubKeyX t),
                (PkaParamName "localPubKeyY", BigNum $ localPubKeyY t),
                (PkaParamName "remotePubKeyX", BigNum $ remotePubKeyX t),
                (PkaParamName "remotePubKeyY", BigNum $ remotePubKeyY t),
                (PkaParamName "sharedSecret", Octets $ sharedSecret t)
               ]

instance PkaTestCaseTrait PkaEcdhTestCase where
    testName (PkaEcdhTestCase t) = ecdheTestName t
    testCaseTag _ = Ecdh
    testCaseNeededFeatures (PkaEcdhTestCase t) = ecdheTestNeededFeatures t
    expectedResult (PkaEcdhTestCase t) = ecdheTestResult t
    params (PkaEcdhTestCase t) = [(PkaParamName "ecGroup", CurveName $ ecdheTestCurveName t),
                                  (PkaParamName "privKey", BigNum $ localPrivKey t),
                                  (PkaParamName "remotePubKeyX", BigNum $ remotePubKeyX t),
                                  (PkaParamName "remotePubKeyY", BigNum $ remotePubKeyY t),
                                  (PkaParamName "sharedSecret", Octets $ sharedSecret t)
                                 ]

-- Test entities
data PkaEcdhTestEntity = PkaEcdhTestEntity
data PkaEcdheTestEntity = PkaEcdheTestEntity

-- Implement PkaTestEntityTrait instance
instance PkaTestEntityTrait PkaEcdheTestEntity where
    testEntityName _ = "PkaEcdhe"
    testEntityTag _ = Ecdhe
    getDummyTest _ = MkPkaTestCase $ PkaEcdheTestCase "FuncTest" [] Ok Secp256R1 12 13 14 15 16 [17]
    getFuncTests _ = generateEcdheFuncTestCases MkPkaTestCase "ECDHE"
    getProfTests _ = generateEcdheProfTestCases MkPkaTestCase "ECDHE"

instance PkaTestEntityTrait PkaEcdhTestEntity where
    testEntityName _ = "PkaEcdh"
    testEntityTag _ = Ecdh
    getDummyTest _ = MkPkaTestCase $ PkaEcdhTestCase $ PkaEcdheTestCase "FuncTest" [] Ok Secp256R1 12 13 14 15 16 [17]
    getFuncTests _ = generateEcdheFuncTestCases (MkPkaTestCase . PkaEcdhTestCase) "ECDH"
    getProfTests _ = generateEcdheProfTestCases (MkPkaTestCase . PkaEcdhTestCase) "ECDH"

-- Func test cases
generateEcdheFuncTestCases :: (PkaEcdheTestCase -> PkaTestCase) -> String -> IO [PkaTestCase]
generateEcdheFuncTestCases pkaTestCaseCtor algInfix = res where
    -- Positive tests
    generateEcdhePosTestCases :: IO [PkaEcdheTestCase]
    generateEcdhePosTestCases = res where
        posTestNamePrefix = "PKA_FUNC_TEST_" ++ algInfix ++ "_" ++ (map toUpper $ show Secp256R1) ++ "_ID_"
        posTestNames = [posTestNamePrefix ++ [x] | x <- ['0'..'5']]
        posTestCaseArgs = [(name, Secp256R1) | name <- posTestNames]
        res = sequenceA $ [generateEcdhePosTestCase arg | arg <- posTestCaseArgs]

    -- Negative Tests
    generateEcdheNegTestCasesBadRemoteX :: IO [PkaEcdheTestCase]
    generateEcdheNegTestCasesBadRemoteX = res where
        -- Corrupt one test case
        corruptRemoteX :: PkaEcdheTestCase -> PkaEcdheTestCase
        corruptRemoteX t = t { ecdheTestResult = InvalParams, remotePubKeyX = (remotePubKeyX t + 11) }

        negTestNamePrefix = "PKA_FUNC_TEST_" ++ algInfix ++ "_BAD_PUBKEY_X_" ++ (map toUpper $ show Secp256R1) ++ "_ID_"
        negTestNames = [negTestNamePrefix ++ [x] | x <- ['0'..'3']]
        negTestCaseArgs = [(name, Secp256R1) | name <- negTestNames]
        res = sequenceA $ [corruptRemoteX <$> (generateEcdhePosTestCase arg) | arg <- negTestCaseArgs]

    generateEcdheNegTestCasesBadRemoteY :: IO [PkaEcdheTestCase]
    generateEcdheNegTestCasesBadRemoteY = res where
        -- Corrupt one test case
        corruptRemoteY :: PkaEcdheTestCase -> PkaEcdheTestCase
        corruptRemoteY t = t { ecdheTestResult = InvalParams, remotePubKeyY = (remotePubKeyY t + 11) }

        negTestNamePrefix = "PKA_FUNC_TEST_" ++ algInfix ++ "_BAD_PUBKEY_Y_" ++ (map toUpper $ show Secp256R1) ++ "_ID_"
        negTestNames = [negTestNamePrefix ++ [x] | x <- ['0'..'3']]
        negTestCaseArgs = [(name, Secp256R1) | name <- negTestNames]
        res = sequenceA $ [corruptRemoteY <$> (generateEcdhePosTestCase arg) | arg <- negTestCaseArgs]

    -- Concatenate, sequence and return
    res = do
        pos <- generateEcdhePosTestCases
        negBadRemoteX <- generateEcdheNegTestCasesBadRemoteX
        negBadRemoteY <- generateEcdheNegTestCasesBadRemoteY
        pure $ pkaTestCaseCtor <$> (pos ++ negBadRemoteX ++ negBadRemoteY)

-- Prof test cases
generateEcdheProfTestCases :: (PkaEcdheTestCase -> PkaTestCase) -> String -> IO [PkaTestCase]
generateEcdheProfTestCases pkaTestCaseCtor algInfix = res where
    name = "PKA_PROF_TEST_" ++ algInfix ++ "_" ++ (map toUpper $ show Secp256R1)
    res = (pure . pkaTestCaseCtor) <$> generateEcdhePosTestCase (name, Secp256R1)

-- Generate one positive test case
generateEcdhePosTestCase :: (String, PkaEccCurveName) -> IO PkaEcdheTestCase
generateEcdhePosTestCase (testName, curveName) = res where
    -- Heper to generate needed features
    getNeededFeatures :: PkaEccCurveName -> [PkaNeededFeatures]
    getNeededFeatures Secp256R1 = [FeatureEcdhe, FeatureSecp256R1]

    res = do
        (localPubKey, localPrivKey_) <- EccGenerate.generate curve
        (remotePubKey, remotePrivKey_) <- EccGenerate.generate curve
        let localPrivKey = Ecdsa.private_d localPrivKey_
        let shared = BA.unpack $ Ecdh.getShared curve localPrivKey (Ecdsa.public_q  remotePubKey)
        let (localPubKeyX, localPubKeyY) = case (Ecdsa.public_q localPubKey) of (EccTypes.Point x y) -> (x, y)
        let (remotePubKeyX, remotePubKeyY) = case (Ecdsa.public_q remotePubKey) of (EccTypes.Point x y) -> (x, y)
        pure $ PkaEcdheTestCase testName (getNeededFeatures curveName) Ok curveName localPrivKey localPubKeyX localPubKeyY remotePubKeyX remotePubKeyY shared

    curve = case curveName of Secp256R1 -> EccTypes.getCurveByName EccTypes.SEC_p256r1

-------------------------------------------------------------------------------
-- All test case entities
-------------------------------------------------------------------------------
testEntities :: [PkaTestEntity]
testEntities = [ MkPkaTestEntity PkaRsaVerifyTestEntity
               , MkPkaTestEntity PkaEcdsaSignTestEntity
               , MkPkaTestEntity PkaEcdsaVerifyTestEntity
               , MkPkaTestEntity PkaEcdheTestEntity
               , MkPkaTestEntity PkaEcdhTestEntity
               ]

