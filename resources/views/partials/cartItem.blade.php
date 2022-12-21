<article class="cartItemPage" id="CartItem_{{$product->id_product}}">
  <div class="cartItem">
    <div class= "productImage">
      <img src="https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-product-4_large.png?format=jpg&quality=90&v=1530129360">
    </div>
    <div class = "insideCartItem">
      <h2><a href="/products/{{ $product->id_product }}">{{ $product->name }}</a></h2>
      <h3><a href="/products/{{ $product->id_product }}">{{ $product->price }} $</a></h2>

      <script>
        function getQuantity(){
          return document.getElementById('quantity').value;
        }
      </script>
      <label for="quantity">quantity:</label>
      <input type="number" id="quantity" name="quantity" value="{{ $product->pivot->quantity }}" min="0" max="{{$product->pivot->quantity}}">
      <input type="button" value="Update Quantity" onclick="return updateCartProduct( {{$product->id_product}},getQuantity() )">

  </div>
</article>