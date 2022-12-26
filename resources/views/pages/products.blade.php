@extends('layouts.app')

@section('title', 'Store')

@section('content')
<div class="d-flex flex-wrap flex-row p-2 ms-2">
  @if(count($products) > 0)
  @each('partials.products', $products, 'product')
  @else
    <div class="container h-100">
      <div class="col-lg-12 col-md-12 col-12 mt-5 mb-5">
        <p class="display-5 mx-auto mb-2 text-center">No products to display</p>
      </div>
    </div>
  @endisset
</div>

@endsection
