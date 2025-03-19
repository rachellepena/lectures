{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_interactive (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "C:\\Users\\rmpen\\OneDrive - Drexel University\\2024-2025\\Winter Term\\CS 360\\lectures examples\\lecture15-interactive\\.stack-work\\install\\e7751717\\bin"
libdir     = "C:\\Users\\rmpen\\OneDrive - Drexel University\\2024-2025\\Winter Term\\CS 360\\lectures examples\\lecture15-interactive\\.stack-work\\install\\e7751717\\lib\\x86_64-windows-ghc-9.4.8\\interactive-0.1-KL1qYOhBDIn53jmVe7dlCX-interactive"
dynlibdir  = "C:\\Users\\rmpen\\OneDrive - Drexel University\\2024-2025\\Winter Term\\CS 360\\lectures examples\\lecture15-interactive\\.stack-work\\install\\e7751717\\lib\\x86_64-windows-ghc-9.4.8"
datadir    = "C:\\Users\\rmpen\\OneDrive - Drexel University\\2024-2025\\Winter Term\\CS 360\\lectures examples\\lecture15-interactive\\.stack-work\\install\\e7751717\\share\\x86_64-windows-ghc-9.4.8\\interactive-0.1"
libexecdir = "C:\\Users\\rmpen\\OneDrive - Drexel University\\2024-2025\\Winter Term\\CS 360\\lectures examples\\lecture15-interactive\\.stack-work\\install\\e7751717\\libexec\\x86_64-windows-ghc-9.4.8\\interactive-0.1"
sysconfdir = "C:\\Users\\rmpen\\OneDrive - Drexel University\\2024-2025\\Winter Term\\CS 360\\lectures examples\\lecture15-interactive\\.stack-work\\install\\e7751717\\etc"

getBinDir     = catchIO (getEnv "interactive_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "interactive_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "interactive_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "interactive_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "interactive_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "interactive_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '\\'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/' || c == '\\'
