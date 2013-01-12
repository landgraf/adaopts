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
with Ada.Containers.Ordered_Maps;  use Ada.Containers;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with AdaOpts_Options; use AdaOpts_Options;

package adaopts_available_options is 
    -- Package for all available options

    type Options_type is private;
    type options_array is array (Positive range <> ) of Unbounded_String;

    procedure Free;
    -- Free all ponters 

    procedure Add(Short_Name  : Unbounded_String; Long_Name : Unbounded_String; Option : Any_AdaOpts_Option );
    -- Add new option
    
    function Contains_Option(Name : String) return Boolean;
    -- return Boolean if long option is in the list
    
    function Contains_Option(Name : Character) return Boolean;
    -- return Boolean if short option is in the list
    
    function Get_Options_Count return Integer;
    -- Get number of options (TODO check)
    
    function Get_Options return options_array;
    -- Get array of available options
    
    function Get_Option(Name : String) return Any_AdaOpts_Option;
    -- Get option by name
    
    function Get_Option(Name : Character) return Any_AdaOpts_Option;
    -- Get short option by Name

    private
    INTERNAL_STRUCTURE_ERROR : exception;
    -- raised then number of short options is not equals to number of longs ones
    type Options_type is (long, short);
    type options_array_access is access all options_array;
    package adaopts_long_maps is new Ada.Containers.Ordered_Maps(
        Key_Type => Unbounded_String,
        Element_Type => Any_AdaOpts_Option
    );
    subtype AdaOpts_Long is adaopts_long_maps.Map;

    package adaopts_Short_maps is new Ada.Containers.Ordered_Maps(
        Key_Type => Unbounded_String,
        Element_Type => Any_AdaOpts_Option
    );
    subtype AdaOpts_Short is adaopts_Short_maps.Map;

    protected options_list is 
        procedure add(Short_Name : Unbounded_String; Long_Name : Unbounded_String; Option : Any_AdaOpts_Option);
        function Contains_Short(Name : Unbounded_String) return Boolean;
        function Contains_Long(Name : Unbounded_String) return Boolean;
        function Length return Integer;
        function Options return options_array;
        function Option(Name : String) return Any_AdaOpts_Option;
        function Option(Name : Character) return Any_AdaOpts_Option;
        procedure Free;
        private
        Short_Options_List :  AdaOpts_Short;
        Long_Options_List : AdaOpts_Long;
    end options_list;
end adaopts_available_options;
