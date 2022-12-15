require "takeaway"

RSpec.describe "takeaway solo project tests" do
    context "checking the list of dishes with prices" do
        it "returns dishes and the respective prices line by line" do
            takeaway = Takeaway.new
            expect(takeaway.menu).to eq "Crispy Aromatic Duck | 2.00\nFish and Chips | 0.15\nChicken Tikka Masala | 1.25\nMystery Jelly | 20.00\nSweet Potato Fries | 5.39\nPilau Rice | 10.00\nMonster Energy | 3.49\nOrange Juice | 100.00"
        end
    end

    context "ordering the meal I want, even if it involves multiple orders" do
        it "returns nothing when a meal is ordered" do
            takeaway = Takeaway.new
            expect(takeaway.order("Orange Juice")).to eq nil
        end

        it "denies the order if it is not entered correctly" do
            takeaway = Takeaway.new
            expect{takeaway.order("Orng Juice")}.to raise_error "Please enter the item name correctly"
        end

        it "denies the order if the receipt has been received" do
            takeaway = Takeaway.new
            takeaway.order("Pilau Rice")
            takeaway.receipt
            expect{takeaway.order("Monster Energy")}.to raise_error "The order has been processed"
        end
    end

    context "seeing receipt of order with total sum" do
        it "returns the order and the sum of the items" do
            takeaway = Takeaway.new
            takeaway.order("Orange Juice")
            expect(takeaway.receipt).to eq "Orange Juice       100.00\n#########################\n Total            100.00 "
        end

        it "returns the order and sum of multiple items" do
            takeaway = Takeaway.new
            takeaway.order("Orange Juice")
            takeaway.order("Crispy Aromatic Duck")
            takeaway.order("Mystery Jelly")
            takeaway.order("Sweet Potato Fries")
            takeaway.order("Monster Energy")
            expect(takeaway.receipt).to eq "Orange Juice       100.00\nCrispy Aromatic Duck 2.00\nMystery Jelly       20.00\nSweet Potato Fries   5.39\nMonster Energy       3.49\n#########################\n Total            130.88 "
        end

        it "returns the order and sum with multiple of the same item" do
            takeaway = Takeaway.new
            takeaway.order("Mystery Jelly")
            takeaway.order("Mystery Jelly")
            takeaway.order("Mystery Jelly")
            expect(takeaway.receipt).to eq "Mystery Jelly       20.00\nMystery Jelly       20.00\nMystery Jelly       20.00\n#########################\n Total             60.00 "
        end
    end
end

=begin
As a customer
So that I can check if I want to order something
I would like to see a list of dishes with prices.

As a customer
So that I can order the meal I want
I would like to be able to select some number of several available dishes.

As a customer
So that I can verify that my order is correct
I would like to see an itemised receipt with a grand total.

Use the twilio-ruby gem to implement this next one. You will need to use doubles too.

As a customer
So that I am reassured that my order will be delivered on time
I would like to receive a text such as "Thank you! Your order was placed and will be delivered before 18:52" after I have ordered.
=end