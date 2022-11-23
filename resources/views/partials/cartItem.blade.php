<article class="cartItemPage">
  <div class="cartItem">
    <div class= "productImage">
      <img src="https://i.redd.it/j7md8j11n51a1.jpg">
    </div>
    <div class = "insideCartItem">
      <h2><a href="/products/{{ $product->id_product }}">{{ $product->name }}</a></h2>
      <h3><a href="/products/{{ $product->id_product }}">{{ $product->price }} $</a></h2>
      <form class="add_to_cart">
        <a class="button button-outline" href="{{ route('cart') }}">Checkout</a>
      </form>
  </div>
</article>