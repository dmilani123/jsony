import options, jsony

type MyType = object
    myKey: string
    myOptionalKey: Option[string]

proc validationHook[T: object|ref object](t: var T, foundKeys: seq[string]) = 
    echo "----> entered validationHook"
    echo $foundKeys
    for k,v in t.fieldPairs:
        echo "k=" & k
        echo "v is Option = " & $(v is Option)

        # if v isnot Option:
        #     continue
        # if not foundKeys.contains(k):
        #     raise newException(ValueError, "Key not found: '" & k & "'")

        if v isnot Option and not foundKeys.contains(k):
            raise newException(ValueError, "Key not found: '" & k & "'")


var s = """{"myKey":"my value"}"""
var o = s.fromJson(MyType)
doAssert o.myKey == "my value"


doAssertRaises ValueError:
    s = """{}"""
    discard s.fromJson(MyType)


s = """[{"myKey":"my value"}]"""
var l = s.fromJson(seq[MyType])
doAssert l[0].myKey == "my value"

doAssertRaises ValueError:
    s = """[{}]"""
    discard s.fromJson(seq[MyType])
