import jsony

type
    MyType = object
        myKey: string

var s = """{"myKey":"my value"}"""
var o = s.fromJson(MyType)
doAssert o.myKey == "my value"

doAssertRaises Exception:
    var s = """{}"""
    discard s.fromJson(MyType)