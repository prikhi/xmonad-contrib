-----------------------------------------------------------------------------
-- |
-- Module      :  XMonad.Actions.NoBorders
-- Copyright   :  (c) Lukas Mai
-- License     :  BSD3-style (see LICENSE)
--
-- Maintainer  :  Lukas Mai <l.mai@web.de>
-- Stability   :  stable
-- Portability :  unportable
--
-- This module provides helper functions for dealing with window borders.
--
-----------------------------------------------------------------------------

module XMonad.Actions.NoBorders (
    toggleBorder
) where

import XMonad
import XMonad.Util.XUtils (safeGetWindowAttributes)

-- | Toggle the border of the currently focused window. To use it, add a
-- keybinding like so:
--
-- > , ((modm,  xK_g ),   withFocused toggleBorder)
--
toggleBorder :: Window -> X ()
toggleBorder w = do
    bw <- asks (borderWidth . config)
    withDisplay $ \d -> io $ do
        cw <- maybe 0 wa_border_width <$> safeGetWindowAttributes d w
        if cw == 0
            then setWindowBorderWidth d w bw
            else setWindowBorderWidth d w 0
