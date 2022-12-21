@extends('layouts.app')

@section('content')
    <h1>Cart</h1>
    <section id="admin">
        @isset($products)
            @each('partials.cartItem', $products, 'product')
            <form method="POST" action="{{ route('createOrder') }}">
                {{csrf_field()}}
                <p id="cartTotal">Total : {{ $total }}$</p>
                <input type="submit" value="Checkout" />
            </form>
            @else
            <p>No products on cart</p>
        @endisset

    </section>
@endsection
