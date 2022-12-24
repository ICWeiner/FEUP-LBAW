<article class="cartItemPage" id="CartItem_{{$product->id_product}}">
  <tr>
    <td data-th="Product">
      <div class="row">
        <div class="col-md-3 text-left">
          <img src="https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-product-4_large.png?format=jpg&quality=90&v=1530129360" alt="" class="img-fluid d-none d-md-block rounded mb-2 shadow ">
        </div>
        <div class="col-md-9 text-left mt-sm-2">
          <h4>{{ $product->name }}</h4>
        </div>
      </div>
    </td>
    <td data-th="Price">{{ $product->price }} $</td>
    <td data-th="Quantity">
      <input type="number" class="form-control form-control-lg text-center" value="{{ $product->pivot->quantity }}">
    </td>
    <td class="actions" data-th="">
      <div class="insideCartItem">
        <input type="button" value="Update Quantity" onclick="return updateCartProduct( {{$product->id_product}})">
      </div>
    </td>
  </tr>
</article>