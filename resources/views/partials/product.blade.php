<article class="card" data-id="{{ $product->id_product }}">
  <div class="productPage">
    <div class= "productImage">
      <img src="https://i.redd.it/j7md8j11n51a1.jpg">
    </div>
    <div class = "insideProductPage">
      <h2><a href="/products/{{ $product->id_product }}">{{ $product->name }}</a></h2>
      <h3><a href="/products/{{ $product->id_product }}">{{ $product->rating }} Stars</a></h2>
      <h3><a href="/products/{{ $product->id_product }}">{{ $product->price }} $</a></h2>
      <!--<a href="#" class="delete">&#10761;</a>-->
      <form class="add_to_cart">
        <!--<input type="button" name="addToCart" placeholder="Add to Cart">-->
        <button type="submit">Add to Cart</button>
      </form>
    </div>
  </div>
</article>
