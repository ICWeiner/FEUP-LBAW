@extends('layouts.app')

@section('title', 'Store')

@section('content')

<section id="products">
  @each('partials.products', $products, 'product')
  <article class="product">
  </article>
</section>

@endsection
