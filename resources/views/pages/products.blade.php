@extends('layouts.app')

@section('title', 'Store')

@section('content')

<section id="products">
  @each('partials.product', $products, 'product')
  <article class="product">
  </article>
</section>

@endsection
