@extends('layouts.app')

@section('title', 'Store')

@section('content')

<div class="d-flex flex-wrap flex-x1-row p-2">
  @each('partials.products', $products, 'product')
</div>

@endsection
