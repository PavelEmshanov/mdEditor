//
//  DoubleLinkedList+CustomStringConverible
//
extension DoubleLinkedList.Node: CustomStringConvertible {
	public var description: String {
		"\(value)"
	}
}

extension DoubleLinkedList: CustomStringConvertible {
	public var description: String {
		var values = [String]()
		var current = head
		
		while current != nil {
			values.append("\(current!)")
			current = current?.next
		}
		
		return "size: \(count); values: " + values.joined(separator: " <-> ")
	}
}
