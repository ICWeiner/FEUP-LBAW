@extends('layouts.app')

@section('content')
    <h1>Cart</h1>
    <section id="content">
        @each('partials.cartItem', $products, 'product')
    </section>
@endsection
