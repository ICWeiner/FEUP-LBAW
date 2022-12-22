<div class="card" style="width: 18rem;" data-id="{{ $product->id_product }}">
  <img class="card-img-top" src="https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-product-4_large.png?format=jpg&quality=90&v=1530129360" alt="Card image cap">
  <div class="card-body">
    <h5 class="card-title">{{ $product->name }}</h5>
    <p class="card-text">{{ $product->description }}</p>
  </div>
  <ul class="list-group list-group-flush">
    <li class="list-group-item">Price = {{ $product->price }}</li>
    <li class="list-group-item">Year = {{ $product->year }}</li>
    <li class="list-group-item">Rating = {{ $product->rating }}</li>
  </ul>
  <div class="card-body">
    <a href="/products/{{ $product->id_product }}" class="card-link">More details</a>
    <input type="button" value="Add to Cart" onclick="return addToCart( {{$product->id_product}},1 )">
    <input type="button" value="Add to Wishlist" onclick="return addToWishlist( {{$product->id_product}} )">
  </div>
</div>