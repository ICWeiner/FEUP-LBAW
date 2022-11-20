@extends('layouts.app')

@section('title', 'Store')

@section('content')

<section id="shoes">
  @each('partials.shoe', $shoes, 'shoe')
  <article class="shpe">
  </article>
</section>

@endsection
