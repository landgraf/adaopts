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
with Ada.Unchecked_Deallocation;

package AdaOpts_Options is 
    type AdaOpts_Option is tagged limited private;
    type AdaOpts_Option_Access is access all AdaOpts_Option;
    type Any_AdaOpts_Option is access all AdaOpts_Option'Class;
    procedure Set_Doc(Self: in out AdaOpts_Option; Doc : String); 
    procedure Set_Dest(Self : in out AdaOpts_Option; Dest : String);
    function Doc(Self: AdaOpts_Option) return String;
    function Dest(Self : AdaOpts_Option) return String;
    function Dest(Self : AdaOpts_Option) return Unbounded_String;
    procedure Free_Option(This: in out Any_AdaOpts_Option);

    private 
    type AdaOpts_Option is tagged limited record
        Doc : Unbounded_String;
        Dest : Unbounded_String;
    end record;
    procedure Free is new Ada.Unchecked_Deallocation (AdaOpts_Option'Class, Any_AdaOpts_Option);

end AdaOpts_Options;
