@extends('layouts.app')

@section('content')
    <h1>Cart</h1>
    <section id="admin">
      @each('partials.cartItem', $products, 'product')
      <form method="POST" action="{{ route('createOrder') }}">
        <input type="submit" value="Checkout" />
      </form>
    </section>
@endsection
