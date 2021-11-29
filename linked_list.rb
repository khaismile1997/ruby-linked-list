require_relative 'node.rb'

class LinkedList
  attr_reader :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    new_node = Node.new(value, nil, @tail)
    @head ||= new_node
    if @tail
      @tail.next_node = new_node
      @tail = new_node
    else
      @tail = new_node
    end
    @size += 1
  end

  def prepend(value)
    new_node = Node.new(value, @head)
    old_head = @head
    @head = new_node
    return if old_head.nil?
    old_head.prev_node = @head
  end

  def at(index)
    return puts "Not exist node" unless @head
    count = 0
    current_node = @head
    until count == index
      current_node = current_node.next_node
      count += 1
    end
    puts current_node.nil? ? "Not exist node with index: #{index}" : current_node
  end

  def pop
    return puts "Not exist node" unless @tail
    node_remove = @tail
    @tail = @tail.prev_node
    @tail.next_node = nil
    puts node_remove
  end
  
  def contains?(value)
    return unless @head
    current_node = @head
    until current_node == @tail.next_node
      return true if current_node.value == value
      current_node = current_node.next_node
    end
    false
  end
  
  def find(value)
    return unless @head
    current_node = @head
    index = 0
    until current_node == @tail.next_node
      return index if current_node.value == value
      current_node = current_node.next_node
      index += 1
    end
    nil
  end
  
  def to_s
    return "Not exist node" unless @head
    current_node = @head
    list = Array.new
    until current_node == @tail.next_node
      list.push("(#{current_node.value})")
      current_node = current_node.next_node
    end
    list.push("nil")
    list.join(" -> ")
  end
  
  def insert_at(value, index)
    return puts "Not exist node" unless @head
    current_node = @head
    position = 0
    until position == index
      return puts "Index must between Linked list range" if current_node == @tail
      current_node = current_node.next_node
      position += 1
    end
    before_node = current_node.prev_node
    insert_node = Node.new(value, current_node, before_node)
    current_node.prev_node = insert_node
    if before_node.nil?
      @head = insert_node
      @head.prev_node = nil
    else
      before_node.next_node = insert_node
    end
  end
  
  def remove_at(index)
    return puts "Not exist node" unless @head
    current_node = @head
    position = 0
    until position == index
      return puts "Index must between Linked list range" if current_node == @tail
      current_node = current_node.next_node
      position += 1
    end
    before_node = current_node.prev_node
    if before_node.nil?
      @head = @head.next_node
      @head.prev_node = nil
      return
    end
    after_node = current_node.next_node
    if after_node.nil?
      @tail = @tail.prev_node
      @tail.next_node = nil
      return
    end
    before_node.next_node = after_node
    after_node.prev_node = before_node
  end
end
