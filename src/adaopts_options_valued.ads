------------------------------------------------------------------------------
--                              Ada OptParser                               --
--                                                                          --
--                     Copyright (C) 2012, Pavel Zhukov                     --
--                                                                          --
--  This is free software;  you can redistribute it  and/or modify it       --
--  under terms of the  GNU General Public License as published  by the     --
--  Free Software  Foundation;  either version 3,  or (at your option) any  --
--  later version.  This software is distributed in the hope  that it will  --
--  be useful, but WITHOUT ANY WARRANTY;  without even the implied warranty --
--  of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU     --
--  General Public License for  more details.                               --
--                                                                          --
--  You should have  received  a copy of the GNU General  Public  License   --
--  distributed  with  this  software;   see  file COPYING3.  If not, go    --
--  to http://www.gnu.org/licenses for a complete copy of the license.      --
------------------------------------------------------------------------------
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with AdaOpts_Options; use AdaOpts_Options;
package AdaOpts_Options_Valued is 
    type AdaOpts_Option_Valued is new AdaOpts_Option with private;
    type AdaOpts_Option_Valued_Access is access all AdaOpts_Option_Valued;
    procedure Set_Value(Self : in out  AdaOpts_Option_Valued; Value : String);
    function Value(Self : AdaOpts_Option_Valued) return String;

    private 
    type AdaOpts_Option_Valued is new AdaOpts_Option with record
        Value : Unbounded_String := Null_Unbounded_String;
    end record;

end AdaOpts_Options_Valued;
