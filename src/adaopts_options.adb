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
package body AdaOpts_Options is 
    procedure Set_Doc(Self: in out AdaOpts_Option; Doc : String) is
    begin
        Self.Doc := To_Unbounded_String(Doc);
    end Set_Doc;

    procedure Set_Dest(Self : in out AdaOpts_Option; Dest : String) is
    begin
        Self.Dest := To_Unbounded_String(Dest);
    end Set_Dest;

    function Doc(Self: AdaOpts_Option) return String is
    begin
        return To_String(Self.Doc);
    end Doc;

    function Dest(Self : AdaOpts_Option) return String is 
    begin
        return To_String(Self.Dest); 
    end Dest;
    function Dest(Self : AdaOpts_Option) return Unbounded_String is 
    begin
        return Self.Dest; 
    end Dest;
    procedure Free_Option(This: in out Any_AdaOpts_Option) is 
    begin
        Free(This);
    end Free_Option;
end AdaOpts_Options;
