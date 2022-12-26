
<tr id="CartItem_{{$product->id_product}}">
  <td data-th="Product">
    <div class="row">
      <div class="col-md-3 text-left">
      @if ($product->url === null)
        <a href="/products/{{ $product->id_product }}"><img id="main-image" src="images/products/placeholder_product.png" alt="Generic placeholder image" class="img-fluid d-none d-md-block rounded mb-2 shadow "></a>
      @else
        <a href="/products/{{ $product->id_product }}"><img id="main-image" src="../{{ $product->url }}" alt="product image" class="img-fluid d-none d-md-block rounded mb-2 shadow "></a>
      @endif
      </div>
      <div class="col-md-9 text-left mt-sm-2">
        <a href="/products/{{ $product->id_product }}" class="text-decoration-none"><h4>{{ $product->name }}</h4></a>
      </div>
    </div>
  </td>
  <td data-th="Price">{{ $product->price }} $</td>
  <td data-th="Quantity">
    <input type="number" id="quantity_{{ $product->id_product }}" name="quantity" value="{{ $product->pivot->quantity }}" min="0" max="{{$product->pivot->quantity}}" class="form-control form-control-lg text-center">
  </td>
  <td class="actions" data-th="">
    <div class="insideCartItem">
      <input class="btn btn-danger text-uppercase mr-2 px-4" type="button" value="Update Quantity" onclick="return updateCartProduct( {{$product->id_product}})">
    </div> 
  </td>
</tr>


