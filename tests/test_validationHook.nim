import options, jsony


proc raiseOnMissingKey[T: object|ref object](t: T, foundKeys: seq[string]) = 
    for k,v in t.fieldPairs:
        if v isnot Option and not foundKeys.contains(k):
            raise newException(ValueError, "Key not found: '" & k & "'")

type MyType = object
    myKey: string
    myOptionalKey: Option[string]

proc validationHook[T: object|ref object](t: T, foundKeys: seq[string]) = 
    raiseOnMissingKey(t, foundKeys)





var s = """{"myKey":"my value"}"""
var o = s.fromJson(MyType)
doAssert o.myKey == "my value"
doAssert o.myOptionalKey == none(string)


s = """{"myKey":"my value", "myOptionalKey": "my optional value"}"""
o = s.fromJson(MyType)
doAssert o.myKey == "my value"
doAssert o.myOptionalKey == some("my optional value")


doAssertRaises ValueError:
    s = """{}"""
    discard s.fromJson(MyType)


s = """[{"myKey":"my value"}]"""
var l = s.fromJson(seq[MyType])
doAssert l[0].myKey == "my value"
doAssert l[0].myOptionalKey == none(string)


doAssertRaises ValueError:
    s = """[{}]"""
    discard s.fromJson(seq[MyType])
