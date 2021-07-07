def find_item_by_name_in_collection(name, collection)
  i = 0 
  while i < collection.length do 
    if collection[i][:item] == name
      return collection[i]
    end
    i += 1
  end
end

def consolidate_cart(cart)
  new_array = []
  i = 0 
  while i < cart.length do 
    new_item = find_item_by_name_in_collection(cart[i][:item], new_array)
    if new_item != nil 
      new_item[:count] += 1 
    else 
      new_item = {
      :item => cart[i][:item], 
      :price => cart[i][:price],
      :clearance => cart[i][:clearance],
      :count => 1 
        }
        new_array.push(new_item)
      end
    i += 1 
  end 
  return new_array
end

def apply_coupons(cart, coupons)
  counter = 0 
  while counter < coupons.length 
  cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
  couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
  cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
  if cart_item && cart_item[:count] >= coupons[counter][:num]
    if cart_item_with_coupon
      cart_item_with_coupon[:count] += coupons[counter][:num]
      cart_item[:count] -= coupons[counter][:num]
    else 
      cart_item_with_coupon = {
        :item => couponed_item_name, 
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
 return cart
end

def apply_clearance(cart)
  i = 0 
  while i < cart.length do
  if cart[i][:clearance] 
   cart[i][:price] = (cart[i][:price] - (cart[i][:price] / 5)).round(2)
  end
  i += 1 
end
return cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  total = 0 
  i = 0 
  while i < final_cart.length do 
    total += final_cart[i][:price] * final_cart[i][:count]
    i += 1
end
if total > 100 
  total -= (total / 10)
end
return total
end
