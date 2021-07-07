require 'pry'

def find_item_by_name_in_collection(name, collection)
 collection_index = 0 

 while collection_index < collection.length do 
     if collection[collection_index][:item] == name
     return  collection[collection_index]
   
  end
    collection_index +=1 
    
  end 

end

def consolidate_cart(cart)
  shopping_cart = []
  items_index = 0 
  
  while items_index < cart.length do 
cart_item = find_item_by_name_in_collection(cart[items_index][:item], shopping_cart)  

    if cart_item != nil
      cart_item[:count] +=1                                                   
      
 else 
   cart_item =  {
     
    :item => cart[items_index][:item],
    :price => cart[items_index][:price],
    :clearance => cart[items_index][:clearance],
    :count => 1 
   }
   
   shopping_cart << cart_item
  
end
  items_index +=1 
end
  
shopping_cart

end

def apply_coupons(cart, coupons)
counter = 0 
while counter < coupons.length do 
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    couponed_items = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_items, cart)
      if cart_item && cart_item[:count] >= coupons[counter][:num]
        if cart_item_with_coupon
          cart_item_with_coupon[:count] += coupons[counter][:num]
          cart_item[:count] -= coupons[counter][:num]
           
        else 
          cart_item_with_coupon = {
            :item => couponed_items,
            :price => coupons[counter][:cost] / coupons[counter][:num],
            :count => coupons[counter][:num],
            :clearance => cart_item[:clearance]
          }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[counter][:num]
      end
    end
  counter += 1 
end

cart

end

def apply_clearance(cart)
item_count = 0 

while item_count < cart.length do
  if cart[item_count][:clearance]
    cart[item_count][:price] = (cart[item_count][:price] -  (cart[item_count][:price] * 0.20))
  
end

item_count += 1 

end 

cart


end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  apply_coupons_cart = apply_coupons(consolidated_cart, coupons)
  total_cart = apply_clearance(apply_coupons_cart)
  
  total_index = 0 
  total = 0 
  
  while total_index < total_cart.length do 
    total += total_cart[total_index][:price] * total_cart[total_index][:count]
  
  total_index += 1
end 
if total > 100 
  total = total - (total * 0.10) 
end

total

end
