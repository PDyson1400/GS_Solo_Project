class Takeaway
    def initialize
        @menu = [{:item => "Crispy Aromatic Duck", :price => "2.00"}, 
        {:item => "Fish and Chips", :price => "0.15"}, 
        {:item => "Chicken Tikka Masala", :price => "1.25"}, 
        {:item => "Mystery Jelly", :price => "20.00"}, 
        {:item => "Sweet Potato Fries", :price => "5.39"}, 
        {:item => "Pilau Rice", :price => "10.00"}, 
        {:item => "Monster Energy", :price => "3.49"}, 
        {:item => "Orange Juice", :price => "100.00"}]
        @order = []
        @done = 0
    end

    def menu
        text = ""
        i = 0
        @menu.map{|hash| text += "#{hash[:item]} | #{hash[:price]}"
                    if i != @menu.length - 1
                        text += "\n"
                    end
                    i += 1}
        return text
    end

    def order(item)
        fail "Please enter the item name correctly" if @menu.find{|hash| hash[:item] == item} == nil
        fail "The order has been processed" if @done == 1
        @order.push(item)
        return nil
    end

    def receipt
        @done = 1
        sum = 0
        text = ""
        max = 0
        @order.map{|item|
                    if item.length > max
                        max = item.length
                    end}
        @order.map{|item|
                    p item
                hash = @menu.find{|hash| hash[:item] == item}
                    p hash
                text += "#{hash[:item]}" + (" " * (25 - hash[:item].length - hash[:price].length)) + "#{hash[:price]}"
                text += "\n"
                sum += hash[:price].to_f}
        
        text += "#" * 25 + "\n"
        sum = "%.2f" % sum
        text += " Total" + (" " * (18 - sum.length)) + "#{sum} "
        return text
    end
end