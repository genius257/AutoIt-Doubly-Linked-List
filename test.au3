#include "doublyLinkedList.au3"

$tDoublyLinkedList = DllStructCreate($tagDoublyLinkedList)
_test_log($tDoublyLinkedList)
_doublyLinkedList_Append($tDoublyLinkedList, 0xF)
_doublyLinkedList_Append($tDoublyLinkedList, 0xFF)
_doublyLinkedList_Append($tDoublyLinkedList, 0xFFF)
_test_log($tDoublyLinkedList)
_doublyLinkedList_AppendAt($tDoublyLinkedList, 1, 0xABC)
_test_log($tDoublyLinkedList)
_doublyLinkedList_Remove($tDoublyLinkedList, 0xCBA)
_test_log($tDoublyLinkedList)
_doublyLinkedList_Remove($tDoublyLinkedList, 0xABC)
_test_log($tDoublyLinkedList)
_doublyLinkedList_RemoveAt($tDoublyLinkedList, 1)
_test_log($tDoublyLinkedList)
_doublyLinkedList_Reverse($tDoublyLinkedList)
_test_log($tDoublyLinkedList)
_doublyLinkedList_Swap($tDoublyLinkedList, 0, 1)
_test_log($tDoublyLinkedList)
ConsoleWrite(_doublyLinkedList_Length($tDoublyLinkedList)&@CRLF)
ConsoleWrite("-------------------------------Traverse test----------------------------------------"&@CRLF)
_doublyLinkedList_Traverse($tDoublyLinkedList, cb)
ConsoleWrite("-------------------------------TraverseReverse test---------------------------------"&@CRLF)
_doublyLinkedList_TraverseReverse($tDoublyLinkedList, cb)
ConsoleWrite("------------------------------------------------------------------------------------"&@CRLF)
ConsoleWrite(_doublyLinkedList_Search($tDoublyLinkedList, 0xFF)&@CRLF)
ConsoleWrite(_doublyLinkedList_Search($tDoublyLinkedList, 0xFFF)&@CRLF)

Func _test_log($tDoublyLinkedList)
    Local $hCurrent = $tDoublyLinkedList.head
    Local $iIndex = 0
    ConsoleWrite(StringFormat("doublyLinkedList: %s", DllStructGetPtr($tDoublyLinkedList))&@CRLF)
    while ($hCurrent)
        $tCurrent = __doublyLinkedList_Node($hCurrent)

        ConsoleWrite(StringFormat("    [%s]: %s", $iIndex, $tCurrent.data)&@crlf)

        $hCurrent = $tCurrent.next
        $iIndex += 1
    WEnd
EndFunc

Func cb($tNode)
    ConsoleWrite("cb: "&$tNode.data&@CRLF)
EndFunc
