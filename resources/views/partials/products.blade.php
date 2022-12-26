<div class="card mx-auto mb-3" style="width: 18rem;" id="product_{{ $product->id_product }}" data-id="{{ $product->id_product }}">
    @if ($product->url === null)
      <a href="/products/{{ $product->id_product }}" class="card-link"><img src="https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-product-4_large.png?format=jpg&quality=90&v=1530129360" alt="Generic placeholder image" class="img-fluid img-thumbnail mt-4 mb-2" style="width: 150px; z-index: 1"></a>
    @else
      <a href="/products/{{ $product->id_product }}" class="card-link"><img src="{{ $product->url }}" alt="product image" class="img-fluid img-thumbnail mt-4 mb-2" style="width: 150px; z-index: 1"></a>
    @endif
  <div class="card-body">
    <h3 class="card-title"><a href="/products/{{ $product->id_product }}" class="card-link text-decoration-none">{{ $product->name }}</a></h3>
    <p class="card-text">{{ $product->description }}</p>
  </div>
  <ul class="list-group list-group-flush">
    <li class="list-group-item">Price = {{ $product->price }}</li>
    <li class="list-group-item">Year = {{ $product->year }}</li>
    <li class="list-group-item">Rating = {{ $product->rating }}</li>
  </ul>
  <div class="card-body">
    <!--<a href="/products/{{ $product->id_product }}" class="card-link">More details</a>-->
    <div class="popup">
      <input type="button" value="Add to Cart" onclick="return addToCart( {{$product->id_product}},1 )">
      <span class="popuptext" id="cartAdded_{{ $product->id_product }}">Added to cart!</span>
      <span id="cart_login_{{ $product->id_product }}" class="popuptext">Please Login to use this feature</span>
    </div>

    <div class="popup">
      <input type="button" value="Add to Wishlist" onclick="return addToWishlist( {{$product->id_product}} )">
      <span class="popuptext" id="watchMSG_{{ $product->id_product }}">Added to wishlist!</span>
      <span id="unwatchMSG_{{ $product->id_product }}" class="popuptext">Removed from Wishlist!</span>
      <span id="wish_login_{{ $product->id_product }}" class="popuptext">Please Login to use this feature</span>
    </div>
    
    <!--<span id="unwatchMSG_{{ $product->id_product }}" class="text-danger" style="display:none">Removed from Wishlist!</span>
    <span id="watchMSG_{{ $product->id_product }}"   class="text-danger" style="display:none">Added to Wishlist!</span>
    <span id="cartAdded_{{ $product->id_product }}" class="text-danger" style="display:none">Added to cart!</span>
    <span id="login_{{ $product->id_product }}" class="text-danger" style="display:none">Please Login to use this feature</span>-->
  </div>
</div>