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
with AdaOpts_Options; use AdaOpts_Options;
with Ada.Unchecked_Deallocation;
with Ada.Command_Line; use Ada.Command_Line;
with AdaOpts_Options_Valued; use AdaOpts_Options_Valued;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
package CMD_Options is 
    type CMD_Option is tagged limited private;
    type Any_CMD_Option is access all CMD_Option'Class;
    function Value( This : in CMD_Option) return String;
    function Name( This : in CMD_Option) return String;
    function Name( This : in CMD_Option) return Unbounded_String;
    function Option( This : in CMD_Option) return Any_AdaOpts_Option;
    procedure Free_Option(This : in out Any_CMD_Option);
    function Init(Arg : in Integer; Pos : in Integer) return Any_CMD_Option;
    function Init(N : in Integer; Eq : in Boolean := False; Eq_Pos : Natural := 0) return Any_CMD_Option;
    INCORRECT_OPTION : exception;
    MAILFORMED_OPTION : exception;
    private 
    type CMD_Option is tagged limited  record
        Name : Unbounded_String;
        Option : Any_AdaOpts_Option; 
        Value  : Unbounded_String := Null_Unbounded_String;
    end record;
    procedure Free is new Ada.Unchecked_Deallocation (CMD_Option'Class, Any_CMD_Option);
end CMD_Options; 
