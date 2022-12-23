<article class="card" data-id="{{ $product->id_product }}">
  <div class="productPage">
    <div class= "productImage">
      <img src="https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-product-4_large.png?format=jpg&quality=90&v=1530129360">
    </div>
    <div class = "insideProductPage">
      <h2><a href="/products/{{ $product->id_product }}">{{ $product->name }}</a></h2>
      <h3><a href="/products/{{ $product->id_product }}">{{ $product->rating }} Stars</a></h2>
      <h3><a href="/products/{{ $product->id_product }}">{{ $product->price }} $</a></h2>
      <!--<a href="#" class="delete">&#10761;</a>-->

      @if($product->stock_quantity === 0)
      <p>Sorry, product is currently out of stock</p>
      @else
      <script>
        function getQuantity(){
          return document.getElementById('quantity').value;
        }
      </script>
      <label for="quantity">quantity:</label>
      <input type="number" id="quantity" name="quantity" value="1" min="1" max="{{$product->stock_quantity}}">
      <input type="button" value="Add to Cart" onclick="return addToCart( {{$product->id_product}},getQuantity() )">
      <input type="button" value="Add to Wishlist" onclick="return addToWishlist( {{$product->id_product}} )">
      @endif
      @if (Auth::check() && Auth::user()->user_is_admin === true)
        <form method="GET" action="{{ route('updateProduct') }}">
            <input id="id_product" name="id_product" value={{ $product->id_product }} required hidden/>

            <input type="submit" value="Update Product" />
            </form>

        <form method="POST" action="{{ route('deleteProduct') }}">
            {{ csrf_field() }}
            <input id="id_product" name="id_product" value={{ $product->id_product }} required hidden/>

            <input type="submit" value="Delete Product" />
            </form>
      @endif

    </div>
      <a><p>Curabitur finibus dui nisi, et auctor libero congue eu. Nulla facilisi. Aliquam eros nunc, hendrerit sed nibh 
        lobortis, dictum commodo nisi. Duis mattis, metus ac rutrum congue, metus nisl sagittis massa, eget laoreet odio 
        libero nec neque. Fusce fermentum ut leo tristique ultricies. Curabitur in ex a nunc interdum tempus. 
        Vestibulum vitae velit vestibulum, eleifend nulla eget, fringilla est. Praesent purus sem, convallis sit 
        amet neque ut, congue hendrerit neque. Phasellus elementum quam magna, id mattis velit auctor vitae. 
        Pellentesque faucibus ligula sed ex malesuada, nec posuere tellus varius. Interdum et malesuada fames ac 
        ante ipsum primis in faucibus. Phasellus nec cursus mauris, eu lobortis sem. 
      </p></a>
    </div>
    <h3>Some Reviews</h3>
    <li> @foreach($product->reviews as $review)
          <a> <p> {{$review->comment}} </p> </a>
          <a> <p> {{$review->rating}} </p> </a>
          <a> <p> {{$review->review_date}} </p> </a>
          <a> <p> {{$review->reviewOwner->name}} </p> </a>
        @endforeach </li>
    
    @if (Auth::check())
    <h4>Add a Review</h4>    
    <textarea id="confirmationText" class="text" cols="86" rows ="20" name="reviewText" form="reviewForm"></textarea>
    <form method="POST" class="add_review" id="reviewForm" name="reviewForm" action="{{ route('addReview') }}">
      {{ csrf_field() }}
      <label for="rating">Rating (between 1 and 5):</label>
      <input type="number" id="rating" name="rating" min="1" max="5">
      <input name="id_product" value="{{ $product->id_product }}" hidden required>
      <input type="submit" name="submitReview" value="Submit Review">
    </form>
    @else
    <h4>Login to post a review!</h4>  
    @endif
</article>
