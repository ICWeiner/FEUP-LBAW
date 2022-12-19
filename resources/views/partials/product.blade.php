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
      <form method="POST" class="add_to_cart" action="{{ route('addToCart') }}">
        {{ csrf_field() }}
        <input type="submit" name="addToCart" value="Add to Cart">
        <input name="id_product" value="{{ $product->id_product }}" hidden required>
      </form>
    </div>
    <a><p>Curabitur finibus dui nisi, et auctor libero congue eu. Nulla facilisi. Aliquam eros nunc, hendrerit sed nibh 
      lobortis, dictum commodo nisi. Duis mattis, metus ac rutrum congue, metus nisl sagittis massa, eget laoreet odio 
      libero nec neque. Fusce fermentum ut leo tristique ultricies. Curabitur in ex a nunc interdum tempus. 
      Vestibulum vitae velit vestibulum, eleifend nulla eget, fringilla est. Praesent purus sem, convallis sit 
      amet neque ut, congue hendrerit neque. Phasellus elementum quam magna, id mattis velit auctor vitae. 
      Pellentesque faucibus ligula sed ex malesuada, nec posuere tellus varius. Interdum et malesuada fames ac 
      ante ipsum primis in faucibus. Phasellus nec cursus mauris, eu lobortis sem. 
    </p></a>

    <h3>Some Reviews</h3>
    <li> @foreach($product->reviews as $review)
          <a> <p> {{$review->comment}} </p> </a>
          <a> <p> {{$review->rating}} </p> </a>
          <a> <p> {{$review->review_date}} </p> </a>
          <a> <p> {{$review->reviewOwner->name}} </p> </a>

          <h3>Comments</h3>
          @foreach($review->comments as $comment)
            <a> <p>{{$comment->content}} </p> </a>
            <a> <p>{{$comment->rating}} </p> </a>
            <a> <p>{{$comment->usersOwner->name}} </p> </a>
          @endforeach
        @endforeach </li>

  </div>
</article>
