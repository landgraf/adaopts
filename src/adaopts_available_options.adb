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
package body adaopts_available_options is 
    procedure Add(Short_Name  : Unbounded_String; Long_Name : Unbounded_String; Option : Any_AdaOpts_Option ) is 
    begin
        options_list.add(Short_Name, Long_Name, Option);
    end Add;
    
    function Contains_Option(Name : String) return Boolean is
    begin
        if options_list.Contains_Long( To_Unbounded_String(Name) ) then
            return True;
        end if;
        return False;
    end Contains_Option;

    procedure Free is 
    begin
        options_list.Free;
    end Free;


    function Contains_Option(Name : Character) return Boolean is
        Str : String(1..1) := (1=>Name);
    begin
        if options_list.Contains_Short( To_Unbounded_String(Str) ) then
            return True;
        end if;
        return False;
    end Contains_Option;



    function Get_Options_Count return Integer is
    begin
        return options_list.Length; 
    end Get_Options_Count;

    function Get_Options return options_array is 
        arr : options_array(1..options_list.Length)  := options_list.Options;
    begin
        return arr;
    end Get_Options;

    function Get_Option(Name : String) return Any_AdaOpts_Option is
    begin
        return options_list.Option(Name);
    end Get_Option;

    function Get_Option(Name : Character) return Any_AdaOpts_Option is
    begin
        return options_list.Option(Name);
    end Get_Option;

    protected body options_list is 
        procedure add(Short_Name : Unbounded_String; Long_Name : Unbounded_String; Option : Any_AdaOpts_Option) is 
        begin
            Short_Options_List.Insert(Short_Name, Option);
            Long_Options_List.Insert(Long_Name, Option);
        end add;
        function Contains_Long(Name : Unbounded_String) return Boolean is 
        begin
            if Long_Options_List.Contains(Name) then
                return True;
            end if;
            return False;
        end Contains_Long;
        function Contains_Short(Name : Unbounded_String) return Boolean is
        begin
            if Short_Options_List.Contains( Name ) then 
                return True;
            end if;
            return False;
        end Contains_Short;

        function Length return Integer is
        begin
            if adaopts_long_maps.Length(Long_Options_List) /= adaopts_Short_maps.Length(Short_Options_List) then
                raise INTERNAL_STRUCTURE_ERROR;
            end if;
            return Integer(adaopts_long_maps.Length(Long_Options_List));
        end Length;
    
        function Options return options_array is 
            arr : options_array(1..Length); 
            cur : adaopts_long_maps.Cursor := adaopts_long_maps.First(Long_Options_List);
        begin
            for I in 1..Length loop
                arr(I) := adaopts_long_maps.Key(cur); 
                adaopts_long_maps.Next(cur);
            end loop;
            return arr;
        end Options;
        function Option(Name : String) return Any_AdaOpts_Option is 
        begin
            return Long_Options_List.Element(To_Unbounded_String(Name)) ;
        end Option;

        function Option(Name : Character) return Any_AdaOpts_Option is 
            Arg : String(1..1) := (1=>Name);
        begin
            return Short_Options_List.Element(To_Unbounded_string(Arg)) ;
        end Option;
        procedure Free is 
            cur : adaopts_long_maps.Cursor := adaopts_long_maps.First(Long_Options_List);
            element : Any_AdaOpts_Option;
        begin
            for  I in 1..Length loop
                exit when adaopts_long_maps.has_element(cur) = False;
                element := adaopts_long_maps.Element(cur);
                adaopts_options.Free_Option(element);
                adaopts_long_maps.Next(cur);
            end loop;
        end Free;
            
    end options_list;
end adaopts_available_options;
