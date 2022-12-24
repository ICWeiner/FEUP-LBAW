<div class="card" style="width: 18rem;" id="product_{{ $product->id_product }}" data-id="{{ $product->id_product }}">
@if ($product->url === null)
      <img src="https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-product-4_large.png?format=jpg&quality=90&v=1530129360" alt="Generic placeholder image" class="img-fluid img-thumbnail mt-4 mb-2" style="width: 150px; z-index: 1">
    @else
      <img src="{{ $product->url }}" alt="Generic placeholder image" class="img-fluid img-thumbnail mt-4 mb-2" style="width: 150px; z-index: 1">
    @endif
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
    <span id="unwatchMSG_{{ $product->id_product }}" class="text-danger" style="display:none">Removed from Wishlist!</span>
    <span id="watchMSG_{{ $product->id_product }}"   class="text-danger" style="display:none">Added to Wishlist!</span>
    <span id="cartAdded_{{ $product->id_product }}" class="text-danger" style="display:none">Added to cart!</span>
    <span id="login_{{ $product->id_product }}" class="text-danger" style="display:none">Please Login to use this feature</span>
  </div>
</div>