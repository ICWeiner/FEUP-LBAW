@extends('layouts.app')

@section('content')
<section class="pt-5 pb-5">
  <div class="container">
    <div class="row w-100">
        <div class="col-lg-12 col-md-12 col-12">
            @if(count($products) > 0)
                <h3 class="display-5 mb-2 text-center">Shopping Cart</h3>
                    <form method="POST" action="{{ route('createOrder') }}">
                        {{csrf_field()}}
                        <p class="mb-5 text-center">
                        <table id="shoppingCart" class="table table-condensed table-responsive">
                            <thead>
                                <tr>
                                    <th style="width:60%">Product</th>
                                    <th style="width:12%">Price</th>
                                    <th style="width:10%">Quantity</th>
                                    <th style="width:16%"></th>
                                </tr>
                            </thead>
                            <tbody>
                            @each('partials.cartItem', $products, 'product')
                            </tbody>
                        </table>
                        <div class="float-right text-right">
                            <h4>Subtotal:</h4>
                            <h1 id="cartTotal">{{ $total }}$</h1>
                        </div>
                    </div>
                </div>
                <div class="row mt-4 d-flex align-items-center">
                    <div class="col-sm-6 order-md-2 text-right">
                        <input type="submit" class="btn btn-primary mb-4 btn-lg pl-5 pr-5" value="Checkout" />
                    </div>
                </div>
                </form>
            @else
                <p class="display-5 mb-2 text-center">No products on Shopping cart</p>
            @endisset
</div>
</section>
@endsection