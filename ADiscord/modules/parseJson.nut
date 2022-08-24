/*
    Author AroliSG
    Library is free of use
*/

function checkIsInteger (number) {
    try {
        number.tointeger ();
        return true;
    }
    catch (e) { return false; }
};

function checkIsBoolean (string) {
    if (string == "true") return true;
    if (string == "false") return false;
    if (string == "null") return null;
    if (string == "undefined") return null;
    return "negative";
};

class parseJson {
    countMembers = null;
    constructor( ) {
       countMembers = {}
    }

    function error (...) {
        local logs;
        foreach (values in vargv) {
            if (logs) logs += ", " + values;
            else logs = values;
        }
        throw logs;
    }

    function log (...) {
        local logs;
        foreach (values in vargv) {
            if (logs) logs += ", " + values;
            else logs = "" + values;
        }
        print ("--> " + logs)
    }

    function count (label) {
        local data = "--> <" + label + "> 1";
        if (this.countMembers.rawin (label)) {
            local counter = this.countMembers [label]+1;

            data = "--> <" + label +"> " + counter
            this.countMembers .rawset (label, counter);
        }
        else {
            this.countMembers .rawset (label, 1);
        }
        print (data);
    }

    function arrayToString (data) {
        local context = this;
        if (typeof data != "array") {
            throw "expected array input, got " + typeof(data);
        }
        local reducer = data.reduce(function (a, b) {
            local localA =  a ;
            if (typeof a  == "array") localA = context. arrayToString (a);
             if (typeof a == "table") localA = context. stringify (a);

            local localB = b ;
            if (typeof b == "array") localB = context. arrayToString (b);
            else if (typeof b == "table") localB = context. stringify (b);

            return localA + "," + localB;
        });
        return "[" + (reducer ? reducer : "") + "]";
    }

    static function tableStringToTable (tableString, compileArrayString = null) {
        local localTable = {}, tableStringFound = true, tableContainer, ArrayString;
        foreach (data in split (tableString ",")) {
            local tableFind     = split (data ":");
            local tableId       = strip (tableFind [0]).slice(1, -1);
            local tableData     = tableFind.len () >= 2 ? strip (tableFind [1]) : null;

            if (strip(data) .slice (-1) == "}") {
                local tableLen = tableId.len ()+3;
                localTable [tableId] <- this.tableStringToTable (strip (strip(data) .slice (tableLen)).slice (1,-1));
            }
            else {
                    // integer
                if (this.checkIsInteger (tableData)) localTable [tableId] <- tableData.tointeger ();
                else {
                        // strings - booleans - array
                    if (tableData && tableData.slice (0,1) == "[" && compileArrayString) {
                            // handling empty and single one elemenet arrays
                        local arraysWithOnlyOneElement = split (tableData ",");
                        if (arraysWithOnlyOneElement.len () == 1 && tableData.slice (0,1) == "[" && tableData.slice (-1) == "]") {
                                                        // empty arrays
                            if (tableData .len () >= 2 ) localTable [tableId] <- [];
                                // arrays with one element
                            local newSingleElement =  arraysWithOnlyOneElement [0].slice (1,-1);
                                // in case '"' was found let delete it!

                            localTable [tableId] <- [newSingleElement];
                        }
                            // rest of arrays
                        else localTable [tableId] <- this.arrayStringToArray (strip (tableData+","+compileArrayString). slice(1, -1));
                    }
                    else if (checkIsBoolean (tableData) != "negative") localTable [tableId] <- checkIsBoolean (tableData);
                    else {
                       localTable [tableId] <- tableData ? tableData .slice(1, -1) : tableData
                    }
                }
            }
        }
        return localTable;
    }

    function arrayStringToArray (arrayString) {
        local localArray = [], arrayStringFound = false, tableStringFound = false, arrayContainer, tableContainer;
        if (typeof arrayString != "string") {
            throw "expected array string input, got " + typeof (args);
        }

        foreach (data in split (arrayString ",")) {
                // table string found inside an array string

            if (strip(data) .slice (0,1) == "{" || tableStringFound) {
                    // adding table parts to table container
                if (tableContainer) tableContainer += "," + strip (data);
                else tableContainer = strip (data);

                if (strip(data) .slice (-1) == "}") {
                    localArray.push (this.tableStringToTable (strip (tableContainer).slice (1,-1)));
                    tableContainer = null;
                    tableStringFound = false;
                }
                tableStringFound = true;
            }
                // array string was found
            if (strip(data) .slice (0,1) == "[") arrayStringFound = true;
            if (arrayStringFound) {
                    // adding array elements to array container
                if (arrayContainer) arrayContainer += "," + strip (data);
                else arrayContainer = strip (data);

                    // array ends here
                if (strip(data) .slice (-1) == "]") {
                    localArray.push (this.arrayStringToArray (arrayContainer. slice(1, -1)));
                    arrayStringFound = false;
                }
                else {
                        // integer
                    if (this.checkIsInteger (strip(data))) localArray.push (strip(data).tointeger ());
                    else {
                            // clearing array strings value
                        local string = strip(data);
                        if (string.slice (0,1) == ('"').tochar () && string.slice (-1) == ('"').tochar ()) string = string.slice(1, -1);

                        localArray.push (string);
                    }
                }
            }
        }
        return localArray;
    }

    function stringify (obj) {
        local stringify = "{", comma = ('"').tochar ();
        if (typeof obj != "table") {
            throw "expected table input, got " + typeof (obj);
        }

        foreach (objName, objValue in obj) {
            local name  = comma + objName + comma, value;
            if (typeof objValue == "array" ) value = this.arrayToString (objValue);
            else if (typeof objValue == "table" ) value = this.stringify (objValue);
            else value = comma + objValue + comma;

            if (stringify.len () == 1) stringify += name + ":" +value
            else stringify += ", "+ name + ":" +value
        }

        return stringify += "}";
    }

    function parse (args) {
        args = args .slice (1,-1);
        local newobject = {}, compileArrayString, ArrayString, tableString, compileTableString;
        if (typeof args != "string") {
            throw "expected string input, got " + typeof (args);
        }

        foreach (obj in split (args ",") ) {
            local SplitParent = split (obj ":");
            if (SplitParent.len () == 1) {
                    // array starts here
                if (compileArrayString) compileArrayString += ", " + obj;
                else compileArrayString = obj;

                    // array ends here
                if (strip (obj).slice (-1) == "]" && ArrayString) {
                    local arrayStringId = (strip (ArrayString [1]) +","+ strip (compileArrayString)).slice(1,-1);
                    newobject [ArrayString [0]] <- this.arrayStringToArray (strip (arrayStringId));

                    ArrayString         = null;
                    compileArrayString  = null;
                }
            }
            else {
                local objName = strip (SplitParent [0]).slice (1,-1), objValue = strip (SplitParent [1]);

                    // table
                if (objValue.slice (0,1) == "{" || tableString) {
                    if (tableString) {
                            // array starts here
                        if (compileTableString) compileTableString += ", " + obj;
                        else compileTableString = obj;

                            // array ends here
                        if (strip (obj).slice (-1) == "}") {
                            local tableLen = tableString [0].len ()+3;

                            local tableStringId = (strip (tableString [1].slice (tableLen)) + "," + strip(compileTableString)).slice(1,-1);
                            newobject [tableString [0]] <- this.tableStringToTable (strip (tableStringId), compileArrayString);

                            tableString         = null;
                            compileTableString  = null;
                        }
                    }
                    else {
                        tableString = [objName, strip (obj)];
                    }
                }

                    // probably unused script or rarely used by json parse
                    // integer
                else if (this.checkIsInteger (objValue)) newobject [objName] <- objValue.tointeger ();

                    // array
                else if (objValue.len () >= 2 && objValue.slice (0,1) == "[") {
                    ArrayString = [objName, objValue];
                }
                    // string - booleans
                else {
                    if (checkIsBoolean (objValue) != "negative") newobject [objName] <- checkIsBoolean (objValue);
                    else newobject [objName] <- objValue.slice (1,-1);
                }
            }
        }

        return newobject;
    }
}

parseJson <- parseJson ();


//local test = "[{'name':'Yayash','id':'746317026196193341','ownerId':'608814507095097373','icon':'37636ff6e469755fbd92d8e63cccf8e4','features':['COMMUNITY','NEWS']},{'name':'American Roleplay 💦','id':'885192984461717516','ownerId':'459205837798375426','icon':'eb0d9e8911ae1e23608ba0ea547d7777','features':[]}]"
//parseJson .arrayStringToArray (test);