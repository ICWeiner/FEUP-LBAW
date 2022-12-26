<div class="card mx-auto mb-3" style="width: 18rem;" id="product_{{ $product->id_product }}" data-id="{{ $product->id_product }}">
  <div class="d-flex mx-auto align-items-center">  
    @if ($product->url === null)
      <a href="/products/{{ $product->id_product }}" class="card-link"><img src="https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-product-4_large.png?format=jpg&quality=90&v=1530129360" alt="Generic placeholder image" class="img-fluid img-thumbnail mt-4 mb-2" style="width: 150px; z-index: 1"></a>
    @else
      <a href="/products/{{ $product->id_product }}" class="card-link"><img src="{{ $product->url }}" alt="product image" class="img-fluid img-thumbnail mt-4 mb-2" style="width: 150px; z-index: 1"></a>
    @endif
  </div>
  <div class="d-flex card-body align-items-center">
    <h3 class="card-title">
      <a href="/products/{{ $product->id_product }}" class="card-link text-decoration-none">
        {{ $product->name }}
      </a>
    </h3>
    <p class="card-text text-truncate">{{ $product->description }}</p>
  </div>
  <div class="product p-4 pt-1">
    <div class=""> 
      <span class="text-uppercase text-muted brand text-inline text-truncate" href="/products/{{ $product->year }}">{{ $product->description }}</span>
      <div class="price d-flex flex-row align-items-center"> 
        <span class="act-price text-warning fw-bold">
          <h4 href="/products/{{ $product->id_product }}" class="fw-bold">{{ $product->price }} €</h4>
          <div class="align-items-center">
            <h4 href="/products/{{ $product->id_product }}">{{ $product->rating }} <i class="fa-solid fa-star"></i></h4>
          </div>
        </span>
      </div>
    </div>
  </div>
  <div class="cart mx-auto mb-3 align-items-center">
    <!--<a href="/products/{{ $product->id_product }}" class="card-link">More details</a>-->
    <div class="popup">
      <input class="btn btn-danger text-uppercase mr-2 px-4" type="button" value="Add to Cart" onclick="return addToCart( {{$product->id_product}},1 )">
      <span class="popuptext" id="cartAdded_{{ $product->id_product }}">Added to cart!</span>
      <span id="cart_login_{{ $product->id_product }}" class="popuptext">Please Login to use this feature</span>
    </div>

    <div class="popup">
      <button class="btn ms-3" type="button" value="Add to Wishlist" onclick="return addToWishlist( {{$product->id_product}} )">
        <i class="fa-regular fa-heart fa-xl text-danger ml-5"></i>
      </button>
      <span class="popuptext" id="watchMSG_{{ $product->id_product }}">Added to wishlist!</span>
      <span id="unwatchMSG_{{ $product->id_product }}" class="popuptext">Removed from Wishlist!</span>
      <span id="wish_login_{{ $product->id_product }}" class="popuptext">Please Login to use this feature</span>
    </div>
<!--
    <div class=""> 
      <input class="btn btn-danger text-uppercase mr-2 px-4" type="button" value="Add to Cart" onclick="return addToCart( {{$product->id_product}},getQuantity() )">
      <button class="btn ms-3" type="button" value="Add to Wishlist" onclick="return addToWishlist( {{$product->id_product}} )">
        <i class="fa fa-heart text-warning ml-5"></i>
      </button>
    </div>
-->
    <!--<span id="unwatchMSG_{{ $product->id_product }}" class="text-danger" style="display:none">Removed from Wishlist!</span>
    <span id="watchMSG_{{ $product->id_product }}"   class="text-danger" style="display:none">Added to Wishlist!</span>
    <span id="cartAdded_{{ $product->id_product }}" class="text-danger" style="display:none">Added to cart!</span>
    <span id="login_{{ $product->id_product }}" class="text-danger" style="display:none">Please Login to use this feature</span>-->
  </div>
</div>