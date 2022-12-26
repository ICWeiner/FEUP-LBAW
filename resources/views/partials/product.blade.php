<article data-id="{{ $product->id_product }}">
  <section class="h-100 gradient-custom-2">
    <div class="container py-5 h-100">
      <div class="row d-flex justify-content-center align-items-center h-100">
        <div class="col col-lg-9 col-xl-7">

          <div class="card py-5 rounded-top">
            <div class="row">
              <div class="col-md-6">
                <div class="images p-3">
                  <div class="text-center p-4"> 
                    @if ($product->url === null)
                      <img id="main-image" width="250" src="https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-product-4_large.png?format=jpg&quality=90&v=1530129360" alt="Generic placeholder image" class="img-fluid img-thumbnail mt-4 mb-2" style="width: 150px; z-index: 1">
                    @else
                      <img id="main-image" width="250" src="../{{ $product->url }}" alt="product image" class="img-fluid img-thumbnail mt-4 mb-2" >
                    @endif
                  </div>
                </div>
              </div>
              <div class="col-md-6">
                <div class="product p-4">
                  <div class="mt-4 mb-3"> 
                    <span class="text-uppercase text-muted brand">SKU:{{ $product->sku }}</span>
                    <h5 class="text-uppercase" href="/products/{{ $product->id_product }}">{{ $product->name }}</h5>
                    <div class="price d-flex flex-row align-items-center"> 
                      <span class="act-price text-warning fw-bold">
                        <h4 href="/products/{{ $product->id_product }}" class="fw-bold">{{ $product->price }}€</h4>
                        <div class="align-items-center">
                          <h3 href="/products/{{ $product->id_product }}">{{ $product->rating }} <i class="fa-solid  fa-star"></i></h2>
                        </div>
                      </span>
                    </div>
                  </div>
                  <p class="about">
                    Curabitur finibus dui nisi, et auctor libero congue eu. Nulla facilisi. Aliquam eros nunc, hendrerit sed nibh 
                    lobortis, dictum commodo nisi. Duis mattis, metus ac rutrum congue, metus nisl sagittis massa, eget laoreet odio 
                    libero nec neque. Fusce fermentum ut leo tristique ultricies. Curabitur in ex a nunc interdum tempus. 
                    Vestibulum vitae velit vestibulum, eleifend nulla eget, fringilla est.
                  </p>
                  <span id="unwatchMSG_{{ $product->id_product }}" class="text-danger" style="display:none">Removed from Wishlist!</span>
                  <span id="watchMSG_{{ $product->id_product }}"   class="text-danger" style="display:none">Added to Wishlist!</span>
                  <span id="cartAdded_{{ $product->id_product }}" class="text-danger" style="display:none">Added to cart!</span>
                  <span id="login_{{ $product->id_product }}" class="text-danger" style="display:none">Please Login to use this feature</span>
                  @if($product->stock_quantity === 0)
                  <p>Sorry, product is currently out of stock</p>
                  @else
                  <script>
                  function getQuantity(){
                    return document.getElementById('quantity').value;
                  }
                  </script>
                  <div class="d-flex flex-row align-items-center">
                    <label for="quantity">Quantity:</label>
                    <div class="input-group d-flex flex-row mt-2 justify-content-center">
                      <div class="input-group-btn">
                        <button id="down" class="btn btn-default" onclick=" down('1')">
                        <span class="fa-solid fa-minus text-warning"></span>
                      </button>
                    </div>
                    <input size="6" style="border-radius: 4px;" type="text" id="quantity" name="quantity" value="1" min="1" class="btn btn-primary input-number mr-2 px4" value="1" max="{{$product->stock_quantity}}">
                    <div class="input-group-btn align-items-center">
                      <button id="up" class="btn btn-default" onclick="up('{{$product->stock_quantity}}')">
                        <span class="fa-solid fa-plus text-warning"></span>
                      </button>
                    </div>
                  </div>
                </div>
                @endif
                <div class="cart mt-4 align-items-center"> 
                  <input class="btn btn-danger text-uppercase mr-2 px-4" type="button" value="Add to Cart" onclick="return addToCart( {{$product->id_product}},getQuantity() )">
                  <button class="btn ms-3" type="button" value="Add to Wishlist" onclick="return addToWishlist( {{$product->id_product}} )">
                    <i class="fa-regular fa-heart fa-xl text-danger ml-5"></i>
                  </button>
                </div>
              </div>
            </div>
            
            <div class="">
              <div class="p-4" style="background-color: #f8f9fa;">    
                <div class="mx-auto">
                  @if (Auth::check() && Auth::user()->user_is_admin === true)
                  <p class="lead fw-normal mb-3">Administrative Actions</p>
                  <div class="d-grid">
                    <form method="GET" style="margin-bottom:1.5em" action="{{ route('updateProduct') }}">
                      <input id="id_product" name="id_product" value={{ $product->id_product }} required hidden/>

                      <input class="btn btn-primary" type="submit" value="Update Product">
                    </form>
                  </div>
                  <div class="d-grid">
                    <form method="POST" action="{{ route('deleteProduct') }}">
                    {{ csrf_field() }}
                      <input id="id_product" name="id_product" value={{ $product->id_product }} required hidden/>
                      <input class="btn btn-primary" type="submit" value="Delete Product">
                    </form>
                  </div>
                  @endif
                </div>
              </div>
            </div>

            <div class="">
              <div class="p-4" style="background-color: #ffffff;">
              <p class="lead fw-normal mb-3">Some Reviews</p>
                <div class="mx-auto">
                  <ul class="" style="list-style-type: none; padding-left: 0px;">
                    @foreach($product->reviews as $review)
                      <li class="mb-3">
                          <div class="d-grid p-2 rounded-top rounded-bottom" style="background-color: #f8f9fa;">
                            <div class="d-felx flex-row flex-wrap">
                              <p class="d-inline fw-bold"> {{$review->reviewOwner->name}} </p>
                              <p class="d-inline"> {{$review->review_date}} </p>
                            </div>
                            <div>
                              <p> {{$review->comment}}</p>
                            </div>
                            <p> {{$review->rating}} <i class="fa-regular  fa-star"></i></p>
                          </div>
                      </li>
                    @endforeach 
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="">
              <div class="p-4" style="background-color: #ffffff;">
              <p class="lead fw-normal mb-3">Post a Review</p>
              @if (Auth::check()) 
                <div class="mx-auto">
                  <ul class="" style="list-style-type: none; padding-left: 0px;">
                      <li class="mb-3">
                          <div class="d-grid p-2 rounded-top rounded-bottom" style="background-color: #f8f9fa;">
                            <textarea id="confirmationText" class="text form-control mb-3" cols="86" rows ="3" name="reviewText" form="reviewForm"></textarea>
                            <form method="POST" class="add_review align-items-center" id="reviewForm" name="reviewForm" action="{{ route('addReview') }}">
                              {{ csrf_field() }}
                              <label for="rating">Rating (between 1 and 5):</label>
                              <input style="margin-right: 2em;" type="number" id="rating" name="rating" min="1" max="5">
                              <input name="id_product" value="{{ $product->id_product }}" hidden required>
                              <input  class="btn btn-primary" type="submit" name="submitReview" value="Submit Review">
                            </form>
                            @else
                            <h4>Login to post a review!</h4>  
                            @endif
                          </div>
                      </li>
                  </ul>
                </div>
              </div>
            </div>
            
          
          </div>
        </div>
      </div>
    </div>
  </section>
</article>