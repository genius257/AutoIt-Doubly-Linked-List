#include <Memory.au3>

$tagDoublyLinkedList = "PTR head;PTR tail;"
$tagDoublyLinkedListNode = "PTR previous;PTR data;PTR next;"

;_MemGlobalAlloc
;_MemVirtualAllocEx
;_WinAPI_CoTaskMemAlloc

#cs
# Append item to the list
#
# @param struct|handle $vDoublyLinkedList A reference to a doubly linked list
# @param struct|handle $vItem             A reference to a value, either by structure or by handle
#ce
Func _doublyLinkedList_Append($vDoublyLinkedList, $vItem)
    Local $tDoublyLinkedList = IsDllStruct($vDoublyLinkedList) ? $vDoublyLinkedList : DllStructCreate($tagDoublyLinkedList, $vDoublyLinkedList)
    Local $hItem = IsDllStruct($vItem) ? __doublyLinkedList_StructToMem($vItem) : $vItem
    Local $hNode = __doublyLinkedList_StructToMem(DllStructCreate($tagDoublyLinkedListNode))
    Local $tNode = DllStructCreate($tagDoublyLinkedListNode, $hNode)
        $tNode.data = $hItem
    If $tDoublyLinkedList.head = 0 Then
        $tDoublyLinkedList.head = $hNode
        $tDoublyLinkedList.tail = $hNode
    Else
        $tNode.previous = $tDoublyLinkedList.tail
        $tTailNode = DllStructCreate($tagDoublyLinkedListNode, $tDoublyLinkedList.tail)
        $tTailNode.next = $hNode
        $tDoublyLinkedList.tail = $hNode
    EndIf
EndFunc

#cs
# Append item to the list, at a requested position
#
# @param struct|handle $vDoublyLinkedList A reference to a doubly linked list
# @param int           $pos               The position the item will be inserted
# @param struct|handle $vItem             A reference to a value, either by structure or by handle
#ce
Func _doublyLinkedList_AppendAt($vDoublyLinkedList, $pos, $vItem)
    Local $tDoublyLinkedList = IsDllStruct($vDoublyLinkedList) ? $vDoublyLinkedList : DllStructCreate($tagDoublyLinkedList, $vDoublyLinkedList)
    Local $current = $tDoublyLinkedList.head
    Local $counter = 1
    Local $hItem = IsDllStruct($vItem) ? __doublyLinkedList_StructToMem($vItem) : $vItem
    Local $hNode = __doublyLinkedList_StructToMem(DllStructCreate($tagDoublyLinkedListNode))
    Local $tNode = DllStructCreate($tagDoublyLinkedListNode, $hNode)
        $tNode.data = $hItem
    If $pos = 0 Then
        $tTailNode = DllStructCreate($tagDoublyLinkedListNode, $tDoublyLinkedList.tail)
        $tTailNode.next = $hNode
EndFunc

Func __doublyLinkedList_StructToMem($tStruct)
    Local $hBytes = _MemGlobalAlloc(DllStructGetSize($tStruct), $GPTR)
    _MemMoveMemory(DllStructGetPtr($tStruct), $hBytes, DllStructGetSize($tStruct))
    Return $hBytes
EndFunc