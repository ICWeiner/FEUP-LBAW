@extends('layouts.app')

@section('title', 'Store')

@section('content')

<div class="d-flex flex-wrap flex-row p-2 ms-2">
  @each('partials.products', $products, 'product')
</div>

@endsection
