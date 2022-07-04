module Main where

import Lib
import Data.Char
import Data.List
import Data.List.Split
import Data.Foldable
import Text.Printf
import System.Random.Shuffle

-- License header
licenseHeader = "\
\/*****************************************************************************\n\
\ Copyright 2020 Broadcom Limited.  All rights reserved.\n\
\\n\
\ This program is the proprietary software of Broadcom Limited and/or its\n\
\ licensors, and may only be used, duplicated, modified or distributed pursuant\n\
\ to the terms and conditions of a separate, written license agreement executed\n\
\ between you and Broadcom (an \"Authorized License\").\n\
\\n\
\ Except as set forth in an Authorized License, Broadcom grants no license\n\
\ (express or implied), right to use, or waiver of any kind with respect to the\n\
\ Software, and Broadcom expressly reserves all rights in and to the Software\n\
\ and all intellectual property rights therein.  IF YOU HAVE NO AUTHORIZED\n\
\ LICENSE, THEN YOU HAVE NO RIGHT TO USE THIS SOFTWARE IN ANY WAY, AND SHOULD\n\
\ IMMEDIATELY NOTIFY BROADCOM AND DISCONTINUE ALL USE OF THE SOFTWARE.\n\
\\n\
\  Except as expressly set forth in the Authorized License,\n\
\ 1. This program, including its structure, sequence and organization,\n\
\    constitutes the valuable trade secrets of Broadcom, and you shall use all\n\
\    reasonable efforts to protect the confidentiality thereof, and to use this\n\
\    information only in connection with your use of Broadcom integrated\n\
\    circuit products.\n\
\\n\
\ 2. TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED \"AS IS\"\n\
\    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR\n\
\    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT\n\
\    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED\n\
\    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A\n\
\    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,\n\
\    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.\n\
\    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE\n\
\    SOFTWARE.\n\
\\n\
\ 3. TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS\n\
\    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,\n\
\    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO\n\
\    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN\n\
\    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS\n\
\    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER\n\
\    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF\n\
\    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.\n\
\******************************************************************************/\n\n"

-- Helper to determine the C strct name corresponding to
-- a given test entity
getTestCaseDeclName :: PkaTestEntity -> String
getTestCaseDeclName e = testEntityName e ++ "TestCaseType"

-- Helper to compute a field name in the PkaTestCase
-- union
getTestCaseFieldNameInUnion :: PkaTestCaseTag -> String
getTestCaseFieldNameInUnion e = fieldName where
    (x:xs) = show e
    fieldName = (toLower x) : xs

-- Helper to convert our return type representation to
-- the PKA's return type
getLibraryRet :: PkaExpectedResult -> String
getLibraryRet Ok = "BCM_ERR_OK"
getLibraryRet Again = "BCM_ERR_EAGAIN"
getLibraryRet InvalParams = "BCM_ERR_INVAL_PARAMS"
getLibraryRet AuthFailed = "BCM_ERR_AUTH_FAILED"

-- Convert a scalar parameter to a string
getLibraryScalarParam :: PkaParamType -> String
getLibraryScalarParam (RsaPadding PSS)      = "PKA_RSA_SIGNATURE_SCHEME_PSS"
getLibraryScalarParam (RsaPadding PKCSv15)  = "PKA_RSA_SIGNATURE_SCHEME_PKCS_V15"
getLibraryScalarParam (MsgDigestAlg Sha256) = "PKA_MSGDIGESTALG_SHA256"
getLibraryScalarParam (MsgDigestAlg Sha384) = "PKA_MSGDIGESTALG_SHA384"
getLibraryScalarParam (MsgDigestAlg Sha512) = "PKA_MSGDIGESTALG_SHA512"
getLibraryScalarParam (CurveName Secp256R1) = "PKA_ECGROUP_SECP_256R1"
getLibraryScalarParam (CurveName Secp384R1) = "PKA_ECGROUP_SECP_384R1"
getLibraryScalarParam (Octets w) = res where
    pre = "(const uint8_t[]) { "
    post = " }"
    dataVals = concat $ (printf "0x%02X, ") <$> w
    res = pre ++ dataVals ++ post

-- Helper to compute the test case tag used in the C file from
-- our PkaTestCaseTag type
getTestCaseTagMacro :: Bool -> PkaTestCaseTag -> String
getTestCaseTagMacro False RsaVerify        = "PKA_TEST_CASE_RSA_VERIFY       "
getTestCaseTagMacro False EcdsaSign        = "PKA_TEST_CASE_ECDSA_SIGN       "
getTestCaseTagMacro False EcdsaVerify      = "PKA_TEST_CASE_ECDSA_VERIFY     "
getTestCaseTagMacro False Ecdhe            = "PKA_TEST_CASE_ECDHE            "
getTestCaseTagMacro False Ecdh             = "PKA_TEST_CASE_ECDH             "
getTestCaseTagMacro True val = unwords $ words $ getTestCaseTagMacro False val

-- Helper to get a feature macro
getTestCaseFeatureMacro :: PkaNeededFeatures -> String
getTestCaseFeatureMacro FeatureRsaOps       = "PKA_FEATURE_FLAG_RSA_OPS"
getTestCaseFeatureMacro FeatureRsa2k        = "PKA_FEATURE_FLAG_RSA_MOD_2K"
getTestCaseFeatureMacro FeatureSecp256R1    = "PKA_FEATURE_FLAG_EC_SECP_256R1"
getTestCaseFeatureMacro FeatureSecp384R1    = "PKA_FEATURE_FLAG_EC_SECP_384R1"
getTestCaseFeatureMacro FeatureEcdsaSign    = "PKA_FEATURE_FLAG_ECDSA_SIGN"
getTestCaseFeatureMacro FeatureEcdsaVerify  = "PKA_FEATURE_FLAG_ECDSA_VERIFY"
getTestCaseFeatureMacro FeatureEcdhe        = "PKA_FEATURE_FLAG_ECDHE"

-- Function to generate the C struct declaration for a given
-- test entity
computeTestCaseStruct :: PkaTestEntity -> String
computeTestCaseStruct e = "typedef struct _" ++ structName ++ " {\n" ++ structFields ++ "} " ++ structName ++ ";\n\n" where
    -- Helper to convert the type names in this program
    -- to the PKA library type names
    getLibraryTypeName :: PkaParamType -> String
    getLibraryTypeName (RsaPadding _) = "PKA_RsaSignatureSchemeType"
    getLibraryTypeName (BigNum _) = "SECUTILS_ConstBigUintType"
    getLibraryTypeName (MsgDigestAlg _) = "PKA_MsgDigestAlgType"
    getLibraryTypeName (CurveName _) = "uint32_t"
    getLibraryTypeName (Octets _) = "uint8_t*"

    -- Helper to derive a field declaratin
    getFieldDecl :: (PkaParamName, PkaParamType) -> String
    getFieldDecl (pname, ptype) = "    const " ++ getLibraryTypeName ptype ++ " " ++ getParamName pname ++ ";\n"

    structName = getTestCaseDeclName e
    structFields = foldl (++) "" (map getFieldDecl (params $ getDummyTest e))

-- Function to generate the C union encapsulating all the different
-- test case types
computeTestCaseDiscriminatedUnion :: [PkaTestEntity] -> String
computeTestCaseDiscriminatedUnion a = structHeader ++ unionTag ++ testName ++ expectedRet ++ unionHeader ++  variants ++ unionFooter ++ structFooter where
    -- Helper to compute a variant declaration
    getVariantDecl :: PkaTestEntity -> String
    getVariantDecl e = "        const " ++ getTestCaseDeclName e ++ " " ++ getTestCaseFieldNameInUnion (testEntityTag e) ++ ";\n"

    structHeader = "typedef struct _" ++ "PkaTestCaseType" ++ " {\n"
    unionTag     = "    const uint32_t tag;\n"
    testName     = "    const char *const testName;\n"
    expectedRet  = "    const int32_t expectedRet;\n"
    unionHeader  = "    union {\n"
    unionFooter  = "    };\n"
    structFooter = "} PkaTestCaseType;\n\n"
    variants = foldl (++) "" (map getVariantDecl a)

-- Function to generate tag macros for the various test cases
generateTestCaseTags :: [PkaTestEntity] -> String
generateTestCaseTags a = tagDefs ++ "\n" where
    -- Helper to generate a C tag macro definition
    getTagMacroDef :: (String, Int) -> String
    getTagMacroDef (name, id) = "#define " ++ name ++ " (" ++ show id ++ "UL)\n"

    cTags = map (getTestCaseTagMacro False) (map testEntityTag a)
    cTagDefs = map getTagMacroDef $ zip cTags [0..]
    tagDefs = foldl (++) "" cTagDefs

-- Helper to convert BigNum to a sequence of limbs
getLimbsString :: PkaParamType -> (Int, String)
getLimbsString (BigNum a) = (len, resNewline) where
    hex = printf "%X" a
    padNibs = (8 - ((length hex) `rem` 8)) `rem` 8
    hexNew = (take padNibs (repeat '0')) ++ hex
    limbs = reverse $ map (\x -> " 0x" ++ x ++ ",") (chunksOf 8 hexNew)
    limbsWithNewLine = map (\(idx, elt) -> if ((idx `rem` 8) == 0) then elt ++ "\n" else elt) (zip [1..] limbs)
    res = concat limbsWithNewLine
    len = length limbs
    resNewline = if (len `rem` 8 == 0) then res else res ++ "\n"

-- Generate the header guards
getTestCaseGuard :: PkaTestCase -> String
getTestCaseGuard testCase = res ++ "\n" where
    (x:xs) = testCaseNeededFeatures testCase
    headerGuard1 = "#if defined(" ++ (getTestCaseFeatureMacro x) ++ ")"
    res = headerGuard1 ++ (foldMap (\x -> " && defined(" ++ (getTestCaseFeatureMacro x) ++ ")") xs)

-- Helper to generate C definitions for one test case
generateTestCase :: String -> (Int, PkaTestCase) -> (String, String)
generateTestCase testCaseType (idx, testCase) = (bigNumLimbs, testCaseArrayElt) where
    guard = getTestCaseGuard testCase
    paramQualifier = getTestCaseFieldNameInUnion $ testCaseTag testCase

    -- Helper to generate the BigNum limb arrays
    getBigNumLimbs :: [(String, (PkaParamName, PkaParamType), (Int, String))] -> String
    getBigNumLimbs bigNumParams = res where
        bigNumLimbsDecl (name, (_, pType), (_, limbs)) = "const uint32_t " ++ name ++ "[] = {\n" ++ limbs ++ "};\n"
        res = guard ++ (concat $ map bigNumLimbsDecl bigNumParams) ++ "#endif\n\n"

    -- Helper to generate the scalar field declarations
    getScalarParamDecl :: [(PkaParamName, PkaParamType)] -> String
    getScalarParamDecl scalarParams = res where
        getDecl (paramName, paramType) = "        ." ++ paramQualifier ++ "." ++ getParamName paramName ++ " = " ++ getLibraryScalarParam paramType ++ ",\n"
        res = concat $ map getDecl scalarParams

    -- Helper to generate the BigNum field declarations
    getBigNumParamDecl :: [(String, (PkaParamName, PkaParamType), (Int, String))] -> String
    getBigNumParamDecl bigNumParams = res where
        bigNumDecl (name, (paramName, _), (numLimbs, limbs)) = "        ." ++ paramQualifier ++ "." ++ getParamName paramName ++ " = " ++ "{ .numLimbs = " ++ show numLimbs ++ "UL, .limbs = " ++ name ++ " },\n"
        res = concat $ map bigNumDecl bigNumParams

    -- Helper to get the BigNum limb array name
    getBigNumArrName :: String -> (PkaParamName, PkaParamType) -> String
    getBigNumArrName testName (paramName, _) = map toUpper testName ++ "_" ++ map toUpper (getParamName paramName) ++ "_LIMBS"

    -- Helper to check if the param is of BigNum type
    isBigNumParam :: (PkaParamName, PkaParamType) -> Bool
    isBigNumParam (_, (BigNum _)) = True
    isBigNumParam _ = False

    testCaseEltDeclHeader = [ guard
                            , "    {\n"
                            , "        .tag = " ++ getTestCaseTagMacro True (testCaseTag testCase) ++ ",\n"
                            , "        .testName = \"" ++ testName testCase ++ "\",\n"
                            , "        .expectedRet = " ++ getLibraryRet (expectedResult testCase) ++ ",\n"
                            ]

    testCaseEltDeclFooter = [ "    },\n"
                            , "#endif\n"
                            ]

    p = params testCase
    bigNumParams = filter (isBigNumParam) p
    scalarParams = filter (not.isBigNumParam) p

    bigNumArrNames = map (getBigNumArrName $ testName testCase) bigNumParams
    bigNumArrLimbs = map getLimbsString [y | (x, y) <- bigNumParams]
    bigNumDesc = zip3 bigNumArrNames bigNumParams bigNumArrLimbs

    testCaseEltDeclScalars = getScalarParamDecl scalarParams
    testCaseEltDeclBigNums = getBigNumParamDecl bigNumDesc

    bigNumLimbs = getBigNumLimbs bigNumDesc
    testCaseArrayElt = concat testCaseEltDeclHeader ++ testCaseEltDeclScalars ++ testCaseEltDeclBigNums ++ concat testCaseEltDeclFooter

-- Write out test cases
generateTestCaseSequence :: String -> [PkaTestCase] -> (String, String)
generateTestCaseSequence seqName testCases = (bigNumLimbs, testCaseArray ++ testCaseNumElts) where
    testCasesWithIdx = zip [0..] testCases
    intComputation = map (generateTestCase seqName) testCasesWithIdx
    (bigNumLimbs, testCaseArrayElts) = foldl (\(x0, y0) (x1, y1) -> (x0 ++ x1, y0 ++ y1)) ("", "") intComputation
    testCaseArrayName = "PKA_" ++ seqName ++ "CASES"
    testCaseArray= "const PkaTestCaseType " ++ testCaseArrayName ++ "[] = {\n" ++ testCaseArrayElts ++ "};\n"
    testCaseNumElts = "#define PKA_" ++ seqName ++ "CASES_NUM_ELTS (sizeof(" ++ testCaseArrayName ++  ") / sizeof(PkaTestCaseType))\n\n"

-- Helper to write the header file
writeTestHeader :: String -> [PkaTestEntity] -> String -> String -> String -> String -> IO ()
writeTestHeader fileName testEntities funcTestBigNums profTestBigNums funcTestArray profTestArray = writeFile fileName headerContent where
    testCaseTags = generateTestCaseTags testEntities
    testCaseStructs = foldl (++) "" (map computeTestCaseStruct testEntities)
    testCaseDescUnion = computeTestCaseDiscriminatedUnion testEntities
    headerContent = licenseHeader ++ testCaseTags ++ testCaseStructs ++ testCaseDescUnion ++ funcTestBigNums ++ profTestBigNums ++ funcTestArray ++ profTestArray

-- Program entry point
main :: IO ()
main = do
    funcTests <- fmap concat $ sequence $ map getFuncTests testEntities
    profTests <- fmap concat $ sequence $ map getProfTests testEntities
    funcTestsRand <- shuffleM funcTests
    (funcTestBigNums, funcTestArray) <- pure $ generateTestCaseSequence "FUNC_TEST" funcTestsRand
    (profTestBigNums, profTestArray) <- pure $ generateTestCaseSequence "PROF_TEST" profTests
    writeTestHeader "../g_pka_qt_test_data.h" testEntities funcTestBigNums profTestBigNums funcTestArray profTestArray


